#' @include H2Object.R
#' @include H2Connection.R
#' @include H2Result.R
#' @importFrom dbj sql_dialect create_table_template create_jdbc_driver
#' @importFrom methods callNextMethod
#' @importFrom utils packageName
NULL

H2_DRIVER_CLASS <- 'org.h2.Driver'

#' Class H2Driver and factory method H2.
#'
#' @keywords internal
#' @export
H2Driver <- setClass("H2Driver", contains = c("JDBCDriver", "H2Object"))

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

create_new_h2_query_result <- function(j_result_set, conn, statement)
  H2QueryResult(j_result_set = j_result_set, connection = conn, statement = statement)
create_new_h2_update_result <- function(update_count, conn, statement)
  H2UpdateResult(update_count = update_count, connection = conn, statement = statement)
create_new_h2_connection <- function(j_con, drv) {
  H2Connection(j_connection = j_con, driver = drv,
    create_new_query_result = create_new_h2_query_result,
    create_new_update_result = create_new_h2_update_result)
}

#' @param ... Additional arguments to \code{\link[dbj]{driver}}.
#' @rdname H2Driver-class
#' @export
driver <- function(sql_dialect = h2_dialect, classpath = NULL,
  read_conversions = default_read_conversions,
  write_conversions = default_write_conversions,
  create_new_connection = create_new_h2_connection, ...) {
  
  if (is.null(classpath)) {
    classpath = dir(system.file("java", package = packageName(), lib.loc = NULL), pattern = "*.jar", full.names = TRUE)
  }

  j_drv = create_jdbc_driver(H2_DRIVER_CLASS, classpath)

  H2Driver(
    driverClass = H2_DRIVER_CLASS,
    j_drv = j_drv,
    read_conversions = read_conversions,
    write_conversions = write_conversions,
    dialect = sql_dialect,
    create_new_connection = create_new_connection
  )
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
    callNextMethod(drv, url, user, password, ...)
  }
)
