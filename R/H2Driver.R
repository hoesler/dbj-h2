#' @include H2Object.R
NULL

#' Class H2Driver
#'
#' @name H2Driver-class
#' @rdname H2Driver-class
#' @exportClass H2Driver
setClass("H2Driver", contains = c("JDBCDriver", "H2Object"))

#' Create a H2 Database Driver object.
#'
#' @param ... other arguments to pass to \link[RJDBC]{JDBC} 
#' @name H2
#' @rdname H2Driver-class
#' @export
H2 <- function(...) {
  .jpackage("RH2")
  jdbc_driver <- JDBC('org.h2.Driver', ...)
  new("H2Driver", jdbc_driver)
}

#' @rdname H2Driver-class
#' @aliases dbConnect,H2Driver-method
#' @param url the url to connect to
#' @param user the user to log in
#' @param password the users password
setMethod("dbConnect", signature(drv = "H2Driver"),
	function(drv, url = "jdbc:h2:mem:", user = 'sa', password = '', ...) {
    new("H2Connection", callNextMethod(drv=drv, url=url, user = user, password = password, ...))
  },
  valueClass = "H2Connection"
)