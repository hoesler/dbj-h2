NULL

#' Class H2Object.
#'
#' @export
setClass("H2Object", contains = c("JDBCObject", "VIRTUAL"))

#' Determine the SQL Data Type of an R object.
#'
#' @docType methods
#' @param dbObj a \code{\linkS4class{H2Object}} object.
#' @param obj an R object whose SQL type we want to determine.
#' @param ... Needed for compatibility with generic. Otherwise ignored.
#' @export
setMethod("dbDataType", signature(dbObj = "H2Object"),
  function(dbObj, obj, ...) {
    if (is.integer(obj)) "INTEGER"
    else if (inherits(obj, "Date")) "DATE"
    else if (identical(class(obj), "times")) "TIME"
    else if (inherits(obj, "POSIXct")) "TIMESTAMP"
    else if (is.numeric(obj)) "DOUBLE PRECISION"
    else "VARCHAR(255)"
  },
  valueClass = "character"
)