#' @include H2Object.R
#' @importFrom dbj sql_dialect create_table_template
#' @importFrom utils packageName
NULL

#' Class H2Driver and factory method H2.
#'
#' @keywords internal
#' @export
setClass("H2Driver", contains = c("JDBCDriver", "H2Object"))

#' @rdname H2Driver-class
#' @export 
h2_dialect <- sql_dialect(name = 'H2', sql_create_table = create_table_template(
  # LOCAL TEMPORARY makes it DBItest conform
  function(table_name, field_names, field_types, temporary) {
    paste0(
      "CREATE ", if (temporary) "LOCAL TEMPORARY ", "TABLE ", table_name, " (\n",
      "  ", paste(paste0(field_names, " ", field_types), collapse = ",\n  "), "\n)\n"
    )
  })
)

#' @param ... Additional arguments to \code{\link[dbj]{driver}}.
#' @rdname H2Driver-class
#' @export
driver <- function(sql_dialect = h2_dialect, classpath = NULL, ...) {
  if (is.null(classpath)) {
    classpath = dir(system.file("java", package = packageName(), lib.loc = NULL), pattern = "*.jar", full.names = TRUE)
  }
  jdbc_driver <- dbj::driver('org.h2.Driver', classpath, dialect = sql_dialect, ...)
  new("H2Driver", jdbc_driver)
}

#' Deprecated. Use dbj.h2::driver()
#' @param ... arguments to \code{\link[dbj]{driver}}
#' @rdname H2Driver-class
#' @export
H2 <- function(...) {
  driver(...)
}

#' Connect to an H2 database.
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
    new("H2Connection", dbj::dbConnect(drv = drv, url = url, user = user, password = password, ...))
  },
  valueClass = "H2Connection"
)