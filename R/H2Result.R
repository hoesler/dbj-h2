#' @include H2Object.R
#' @importFrom assertthat assert_that
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
H2UpdateResult <- setClass("H2UpdateResult", contains = c("JDBCUpdateResult", "H2Result"))
