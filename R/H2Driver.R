#' @include H2Object.R
NULL

#' Class H2Driver and factory method H2.
#'
#' @export
setClass("H2Driver", contains = c("JDBCDriver", "H2Object"))

#' @param ... arguments to \code{\link[RJDBC]{JDBC}}
#' @name H2
#' @rdname H2Driver-class
#' @export
H2 <- function(...) {
  jdbc_driver <- JDBC('org.h2.Driver', ...)
  new("H2Driver", jdbc_driver)
}

#' Connect to a h2 database.
#' 
#' @param drv the database driver (\code{\link{H2}})
#' @param url the url to connect to (Visit \url{http://h2database.com/html/features.html#database_url} for a reference).
#'   If the url is a path to a local file the '.h2.db' suffix is stripped off automatically if present.
#' @param user the user to log in
#' @param password the users password
#' @param ... further arguments passed to \code{\linkS4class{JDBCConnection}}.
#' @export
setMethod("dbConnect", signature(drv = "H2Driver"),
	function(drv, url = "mem:", user = 'sa', password = '', ...) {
    url <- sprintf("jdbc:h2:%s", sub("^(.*)\\.h2\\.db$", "\\1", url))
    new("H2Connection", callNextMethod(drv = drv, url = url, user = user, password = password, ...))
  },
  valueClass = "H2Connection"
)