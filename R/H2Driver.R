#' @include H2Object.R
NULL

#' Class H2Driver and factory method H2.
#'
#' @name H2Driver-class
#' @docType class
#' @export
setClass("H2Driver", contains = c("JDBCDriver", "H2Object"))

#' @param ... arguments to \link[RJDBC]{JDBC} 
#' @name H2
#' @rdname H2Driver-class
#' @export
H2 <- function(...) {
  jdbc_driver <- JDBC('org.h2.Driver', ...)
  new("H2Driver", jdbc_driver)
}

#' Connect to a h2 database.
#' 
#' @param url the jdbc url to connect to. If the url does not start with "jdbc:"
#'   it is treated as a file path and automatically converted to an url.
#' @param user the user to log in
#' @param password the users password
#' @export
setMethod("dbConnect", signature(drv = "H2Driver"),
	function(drv, url = "jdbc:h2:mem:", user = 'sa', password = '', ...) {

    if (!any(grepl("^jdbc:", url))) {
      url <- paste("jdbc:h2:", sub("^(.*)\\.h2\\.db$", "\\1", url), sep="")
    }

    if (!any(grepl("^jdbc:h2:", url))) {
      stop("URL must start with jdbc:h2:")
    }

    new("H2Connection", callNextMethod(drv=drv, url=url, user = user, password = password, ...))
  },
  valueClass = "H2Connection"
)