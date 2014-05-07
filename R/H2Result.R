#' @include H2Object.R
NULL

#' Class H2Result
#'
#' @name H2Result-class
#' @rdname H2Result-class
#' @exportClass H2Result
setClass("H2Result", contains = c("JDBCResult", "H2Object"))

#' @rdname H2Result-class
#' @aliases dbHasCompleted,H2Result-method
setMethod("dbHasCompleted", signature(res = "H2Result"),
  function(res, ...) {
    .jcheck()
    isBeforeFirst <- .jcall(res@jr, "Z", "isBeforeFirst")
    isAfterLast <- .jcall(res@jr, "Z", "isAfterLast")
    if(.jcheck()) stop("Java Exception")
    !isBeforeFirst && isAfterLast
  },
  valueClass = "logical"
)