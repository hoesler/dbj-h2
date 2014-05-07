#' @include H2Object.R
NULL

#' Class H2Connection
#'
#' @name H2Connection-class
#' @rdname H2Connection-class
#' @exportClass H2Connection
setClass("H2Connection", contains = c("JDBCConnection", "H2Object"))

#' @rdname H2Connection-class
#' @aliases dbSendQuery,H2Connection-method
#' @param list a list of statement parameters
setMethod("dbSendQuery", signature(conn = "H2Connection", statement = "character"),
  function(conn, statement, ..., list = NULL) {
    new("H2Result", callNextMethod(conn = conn, statement = statement, ..., list = list))
  },
  valueClass = "H2Result"
)

#' @rdname H2Connection-class
#' @aliases dbGetInfo,H2Connection-method
setMethod("dbGetInfo", signature(dbObj = "H2Connection"),
  function(dbObj, ...) {
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
  }
)
