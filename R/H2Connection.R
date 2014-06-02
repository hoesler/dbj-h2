#' @include H2Object.R
NULL

#' Class H2Connection
#'
#' @export
setClass("H2Connection", contains = c("JDBCConnection", "H2Object"))

#' Execute a SQL statement on a database connection.
#'
#' @param conn An existing \code{\linkS4class{H2Connection}}
#' @param statement the statement to send over the connection
#' @param parameters a list of statment parameters
#' @param ... Ignored. Needed for compatiblity with generic.
#' @export
setMethod("dbSendQuery", signature(conn = "H2Connection", statement = "character"),
  function(conn, statement, parameters = list(), ...) {
    jdbc_result <- callNextMethod(conn = conn, statement = statement, parameters = parameters, ...)
    H2Result(jdbc_result)
  },
  valueClass = "H2Result"
)

#' Get metadata about a H2Connection object.
#'
#' @param dbObj An object of class \code{\linkS4class{H2Connection}}
#' @param ... Ignored. Included for compatibility with generic.
#' @export
setMethod("dbGetInfo", signature(dbObj = "H2Connection"),
  function(dbObj, ...) {
    .jcheck()
    meta_data <- .jcall(dbObj@j_connection, "Ljava/sql/DatabaseMetaData;", "getMetaData")
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
  }
)
