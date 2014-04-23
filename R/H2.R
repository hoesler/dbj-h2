#' @import chron
#' @import methods
#' @import RJDBC
NULL

#' Class H2Driver
#'
#' @name H2Driver-class
#' @rdname H2Driver-class
#' @exportClass H2Driver
setClass("H2Driver", contains = "JDBCDriver")

#' Class H2Connection
#'
#' @name H2Connection-class
#' @rdname H2Connection-class
#' @exportClass H2Connection
setClass("H2Connection", contains = "JDBCConnection")

#' Class H2Result
#'
#' @name H2Result-class
#' @rdname H2Result-class
#' @exportClass H2Result
setClass("H2Result", contains = "JDBCResult")

#' Create a H2 Database Driver object.
#'
#' @param driverClass the java driver class to use
#' @param identifier.quote the character to surround itendifiers with 
#' @param jars Java archives in the java directory of the package that should be added to the class path.
#'  The default value is \code{getOption("RH2.jars")}.
#'  \code{NULL} will be replace with \code{"*"}.
#'  See \code{\link[rJava]{.jpackage}} for more details.
#' @param ... other arguments to pass to \link[rJava]{.jpackage} 
#' @name H2
#' @rdname H2Driver-class
#' @export
H2 <- function(driverClass = 'org.h2.Driver', 
  identifier.quote = "\"", jars = getOption("RH2.jars"), ...) {
  if (is.null(jars)) {
    jars <- "*"
  }
  .jpackage("RH2", jars = jars, ...)
  if (nchar(driverClass) && is.jnull(.jfindClass(as.character(driverClass)[1]))) {
    stop("Cannot find H2 driver class ",driverClass)
  }
  jdrv <- .jnew(driverClass, check = FALSE)
  .jcheck(TRUE)
  if (is.jnull(jdrv)) {
    jdrv <- .jnull()
  }
  new("H2Driver", identifier.quote = as.character(identifier.quote), jdrv = jdrv)
}

#' @rdname H2Driver-class
#' @aliases dbConnect,H2Driver-method
#' @param url the url to connect to
#' @param user the user to log in
#' @param password the users password
#' @param database_to_upper the value for DATABASE_TO_UPPER appended to the url
setMethod("dbConnect", "H2Driver", def = function(drv, url = "jdbc:h2:mem:", 
  user = 'sa', password = '', database_to_upper = getOption("RH2.DATABASE_TO_UPPER"), ...) {
  if (is.null(database_to_upper) ||
		(is.logical(database_to_upper) && !database_to_upper) ||
		(is.character(database_to_upper) && database_to_upper == "FALSE"))
			url <- paste(url, "DATABASE_TO_UPPER = FALSE", sep = ";")
  jc <- .jcall("java/sql/DriverManager","Ljava/sql/Connection;","getConnection", as.character(url)[1], as.character(user)[1], as.character(password)[1], check = FALSE)
  if (is.jnull(jc) || !is.jnull(drv@jdrv)) {
    # ok one reason for this to fail is its interaction with rJava's
    # class loader. In that case we try to load the driver directly.
    oex <- .jgetEx(TRUE)
    p <- .jnew("java/util/Properties")
    if (length(user)== 1 && nchar(user)) .jcall(p,"Ljava/lang/Object;","setProperty","user",user)
    if (length(password)== 1 && nchar(password)) .jcall(p,"Ljava/lang/Object;","setProperty","password",password)
    jc <- .jcall(drv@jdrv, "Ljava/sql/Connection;", "connect", as.character(url)[1], p)
  }
  .verify.JDBC.result(jc, "Unable to connect JDBC to ",url)
  new("H2Connection", jc = jc, identifier.quote = drv@identifier.quote)},
          valueClass = "H2Connection")

#' @rdname H2Connection-class
#' @aliases dbDisconnect,H2Connection-method
setMethod("dbDisconnect", signature(conn = "H2Connection"), def = function(conn, ...) {
  .jcheck()
  .jcall(conn@jc, "V", "close", check = FALSE)
  !.jcheck()
})

#' @rdname H2Connection-class
#' @aliases dbWriteTable,H2Connection-method
#' @param overwrite set to \code{TRUE} if the table should be removed if it exists
setMethod("dbWriteTable", "H2Connection", def = function(conn, name, value, overwrite = TRUE, ...) {
  dots <- list(...)
  temporary <- "temporary" %in% names(dots) && dots$temporary
  ac <- .jcall(conn@jc, "Z", "getAutoCommit")
  if (is.vector(value) && !is.list(value)) value <- data.frame(x = value)
  if (length(value)<1) stop("value must have at least one column")
  if (is.null(names(value))) names(value) <- paste("V",1:length(value),sep = '')
  if (length(value[[1]])>0) {
    if (!is.data.frame(value)) value <- as.data.frame(value, row.names = 1:length(value[[1]]))
  } else {
    if (!is.data.frame(value)) value <- as.data.frame(value)
  }
  fts <- sapply(value, dbDataType, dbObj = conn)
  if (dbExistsTable(conn, name)) {
    if (overwrite) dbRemoveTable(conn, name)
    else stop("Table `",name,"' already exists")
  }
  fdef <- paste(.sql.qescape(names(value), FALSE, conn@identifier.quote),fts,collapse = ',')
  # qname <- .sql.qescape(name, TRUE, conn@identifier.quote)
  # cat("conn@identifier.quote:", conn@identifier.quote, "\n")
  qname <- .sql.qescape(name, FALSE, conn@identifier.quote)
  ct <- paste(if (temporary) "CREATE TEMPORARY TABLE" else "CREATE TABLE ",
	      qname," (",fdef,")",sep= '')
  # cat("ct:", ct, "\n")
  if (ac) {
    .jcall(conn@jc, "V", "setAutoCommit", FALSE)
    on.exit(.jcall(conn@jc, "V", "setAutoCommit", ac))
  }
  dbSendUpdate(conn, ct)
  if (length(value[[1]])) {
    inss <- paste("INSERT INTO ",qname," VALUES(", paste(rep("?",length(value)),collapse=','),")",sep = '')
	# send Date variables as character strings
	is.Date <- sapply(value, inherits, what = "Date")
	for(i in which(is.Date)) {
		value[[i]] <- as.character(value[[i]])
	}
	# send times variables as character strings
	is.times <- sapply(value, function(x) identical(class(x), "times"))
	for(i in which(is.times)) {
		value[[i]] <- as.character(value[[i]])
	}
	if (NCOL(value) > 0) {
		for (j in seq_along(value[[1]]))
		  dbSendUpdate(conn, inss, list = as.list(value[j,]))
	}
  }
  if (ac) dbCommit(conn)            
})

#' @rdname H2Connection-class
#' @aliases dbDataType,H2Connection-method
setMethod("dbDataType", signature(dbObj = "H2Connection", obj = "ANY"),
          def = function(dbObj, obj, ...) {
            if (is.integer(obj)) "INTEGER"
            else if (inherits(obj, "Date")) "DATE"
            else if (identical(class(obj), "times")) "TIME"
			else if (inherits(obj, "POSIXct")) "TIMESTAMP"
            else if (is.numeric(obj)) "DOUBLE PRECISION"
            else "VARCHAR(255)"
          }, valueClass = "character")

#' @rdname H2Result-class
#' @aliases fetch,H2Result-method
setMethod("fetch", signature(res = "H2Result", n = "numeric"), def = function(res, n, ...) {
  cols <- .jcall(res@md, "I", "getColumnCount")
  if (cols < 1) return(NULL)

  rowsExpected <- if (n>-1) n else 1e4
  l <- list()
  for (i in 1:cols) {
    ct <- .jcall(res@md, "I", "getColumnType", i)
    l[[i]] <- if (ct == -5 | ct == -6 | (ct >= 2 & ct <= 8)) { 
           numeric(rowsExpected)
       } else if (ct == 91) { 
           structure(numeric(rowsExpected), class = "Date")
       } else if (ct == 92) { 
           structure(numeric(rowsExpected), class = "times")
       } else if (ct == 93) { 
           structure(numeric(rowsExpected), class = class(Sys.time()))
       } else {
           character(rowsExpected)
       }
    names(l)[i] <- .jcall(res@md, "S", "getColumnLabel", i)
  }
  
  j <- 0
  while (.jcall(res@jr, "Z", "next")) {
    j <- j + 1
    for (i in 1:cols) {
      if (inherits(l[[i]], "Date")) {
        # browser() ##
        val <- .jcall(res@jr, "S", "getString", i)
        wn <- .jcall(res@jr, "Z", "wasNull")
        l[[i]][j] <- if (wn | is.null(val)) NA else as.Date(val)
      } else if (inherits(l[[i]], "times")) {
        val <- .jcall(res@jr, "S", "getString", i)
        wn <- .jcall(res@jr, "Z", "wasNull")
        l[[i]][j] <- if (wn | is.null(val)) NA else times(val)
      } else if (inherits(l[[i]], "POSIXct")) {
        val <- .jcall(res@jr, "S", "getString", i)
        wn <- .jcall(res@jr, "Z", "wasNull")
        l[[i]][j] <- if (wn | is.null(val)) NA else as.POSIXct(val)
      } else if (is.numeric(l[[i]])) { 
        val <- .jcall(res@jr, "D", "getDouble", i)
        wn <- .jcall(res@jr, "Z", "wasNull")
        l[[i]][j] <- if (wn | is.null(val)) NA else val
      } else {
        val <- .jcall(res@jr, "S", "getString", i)
        wn <- .jcall(res@jr, "Z", "wasNull")
        l[[i]][j] <- if (wn | is.null(val)) NA else val
      }
    }
    if (n > 0 && j >= n) break
  }

  if (rowsExpected > j) {
    for (i in 1:cols) {
      l[[i]] <- l[[i]][1:j]
    }
  }
  
  if (j)
    as.data.frame(l, row.names = 1:j)
  else
    as.data.frame(l)
})

#' @rdname H2Connection-class
#' @aliases dbSendQuery,H2Connection-method
#' @param list a list of statement parameters
setMethod("dbSendQuery", signature(conn = "H2Connection", statement = "character"),  def = function(conn, statement, ..., list = NULL) {
  s <- .jcall(conn@jc, "Ljava/sql/PreparedStatement;", "prepareStatement", as.character(statement)[1], check = FALSE)
  .verify.JDBC.result(s, "Unable to execute JDBC statement ",statement)
  if (length(list(...))) .fillStatementParameters(s, list(...))
  if (!is.null(list)) .fillStatementParameters(s, list)
  r <- .jcall(s, "Ljava/sql/ResultSet;", "executeQuery", check = FALSE)
  .verify.JDBC.result(r, "Unable to retrieve JDBC result set for ",statement)
  md <- .jcall(r, "Ljava/sql/ResultSetMetaData;", "getMetaData", check = FALSE)
  .verify.JDBC.result(md, "Unable to retrieve JDBC result set meta data for ",statement, " in dbSendQuery")
  new("H2Result", jr = r, md = md)
})

#' @rdname H2Connection-class
#' @aliases dbGetQuery,H2Connection-method
setMethod("dbGetQuery", signature(conn = "H2Connection", statement = "character"),  def = function(conn, statement, ...) {
  r <- dbSendQuery(conn, statement, ...)
  fetch(r, -1)
})

#' @rdname H2Result-class
#' @aliases dbHasCompleted,H2Result-method
setMethod("dbHasCompleted", signature(res = "H2Result"), def = function(res, ...) {
  .jcheck()
  isBeforeFirst <- .jcall(res@jr, "Z", "isBeforeFirst")
  isAfterLast <- .jcall(res@jr, "Z", "isAfterLast")
  if(.jcheck()) stop("Java Exception")
  !isBeforeFirst && isAfterLast
})

#' @rdname H2Result-class
#' @aliases dbClearResult,H2Result-method
setMethod("dbClearResult", signature(res = "H2Result"), def = function(res, ...) {
  .jcheck()
  .jcall(res@jr, "V", "close", check = FALSE)
  !.jcheck()
})

#' @rdname H2Connection-class
#' @aliases dbGetInfo,H2Connection-method
setMethod("dbGetInfo", signature(dbObj = "H2Connection"), def = function(dbObj, ...) {
  .jcheck()
  meta_data <- .jcall(dbObj@jc, "Ljava/sql/DatabaseMetaData;", "getMetaData")
  info <- list()
  if(!is.null(meta_data)) {
    info <- c(info,
      url = .jcall(meta_data, "S", "getURL"),
      user_name = .jcall(meta_data, "S", "getUserName"),
      database_product_version = .jcall(meta_data, "S", "getDatabaseProductVersion"),
      driver_name = .jcall(meta_data, "S", "getDriverName"),
      driver_version = .jcall(meta_data, "S", "getDriverVersion"))
  } else {
    warning("Java call to getMetaData() returned null")
  }
  !.jcheck()
  return(info)
})

.verify.JDBC.result <- RJDBC:::.verify.JDBC.result
.fillStatementParameters <- RJDBC:::.fillStatementParameters
.sql.qescape <- RJDBC:::.sql.qescape

