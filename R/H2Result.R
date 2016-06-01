#' @include H2Object.R
NULL

#' Class H2Result.
#'
#' @keywords internal
#' @export
setClass("H2Result", contains = c("JDBCResult", "H2Object", "VIRTUAL"))

#' @rdname H2Result-class
#' @export
H2QueryResult <- setRefClass("H2QueryResult", contains = c("JDBCQueryResult", "H2Result"))

#' @rdname H2Result-class
#' @export
setClass("H2UpdateResult", contains = c("JDBCUpdateResult", "H2Result"))

H2Result <- function(jdbc_result) UseMethod("H2Result")
H2Result.JDBCQueryResult <- function(jdbc_result) H2QueryResult(jdbc_result)
H2Result.JDBCUpdateResult <- function(jdbc_result) new("H2UpdateResult", jdbc_result)
