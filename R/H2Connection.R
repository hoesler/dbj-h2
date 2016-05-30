#' @include H2Object.R
NULL

#' Class H2Connection
#'
#' @keywords internal
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
    jdbc_result <- dbj::dbSendQuery(conn = conn, statement = statement, parameters = parameters, ...)
    H2Result(jdbc_result)
  },
  valueClass = "H2Result"
)
