NULL

setMethod("dbDataType", signature(dbObj = "H2Connection"),
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