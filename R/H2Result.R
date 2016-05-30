#' @include H2Object.R
NULL

#' Class H2Result.
#'
#' @keywords internal
#' @export
setClass("H2Result", contains = c("JDBCResult", "H2Object", "VIRTUAL"))

#' @rdname H2Result-class
#' @export
setRefClass("H2QueryResult", contains = c("JDBCQueryResult", "H2Result"))

#' @rdname H2Result-class
#' @export
setClass("H2UpdateResult", contains = c("JDBCUpdateResult", "H2Result"))

H2Result <- function(jdbc_result) {
  if (is(jdbc_result, "JDBCQueryResult")) {
    new("H2QueryResult", jdbc_result)
  } else if (is(jdbc_result, "JDBCUpdateResult")) {
    new("H2UpdateResult", jdbc_result)
  } else {
    stop("Unexpected class")
  }
}