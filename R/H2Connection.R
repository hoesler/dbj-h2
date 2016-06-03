#' @include H2Object.R
#' @importFrom methods callNextMethod
NULL

#' Class H2Connection
#'
#' @keywords internal
#' @export
H2Connection <- setClass("H2Connection", contains = c("JDBCConnection", "H2Object"))
