#' @include H2Object.R
NULL

#' Class H2Result.
#'
#' @export
setClass("H2Result", contains = c("JDBCResult", "H2Object"))