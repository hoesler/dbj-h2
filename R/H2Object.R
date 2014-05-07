#' @import RJDBC
#' @import chron
#' @import methods
NULL

#' Class H2Object
#'
#' @name H2Object-class
#' @rdname H2Object-class
#' @exportClass H2Object
setClass("H2Object", contains = c("DBIObject", "VIRTUAL"))

.verify.JDBC.result <- RJDBC:::.verify.JDBC.result
.fillStatementParameters <- RJDBC:::.fillStatementParameters
.sql.qescape <- RJDBC:::.sql.qescape