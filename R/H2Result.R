#' @include H2Object.R
NULL

#' Class H2QueryResult.
#'
#' @export
setClass("H2QueryResult", contains = c("JDBCQueryResult", "H2Object"))

#' Class H2UpdateResult.
#'
#' @export
setClass("H2UpdateResult", contains = c("JDBCUpdateResult", "H2Object"))

#' Class H2Result.
#'
#' @export
setClassUnion("H2Result", c("H2QueryResult", "H2UpdateResult"))

H2Result <- function(jdbc_result) {
  if (is(jdbc_result, "JDBCQueryResult")) {
    new("H2QueryResult", jdbc_result)
  } else if (is(jdbc_result, "JDBCUpdateResult")) {
    new("H2UpdateResult", jdbc_result)
  } else {
    stop("Unexpected class")
  }
}