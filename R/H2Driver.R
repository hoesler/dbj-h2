#' @include H2Object.R
#' @include H2Connection.R
#' @include H2Result.R
#' @importFrom dbj sql_dialect create_table_template create_jdbc_driver
#' @importFrom methods callNextMethod
#' @importFrom utils packageName
NULL

#' Class H2Driver and factory method H2.
#'
#' @keywords internal
#' @export
H2Driver <- setClass("H2Driver", contains = c("JDBCDriver", "H2Object"))

create_new_h2_query_result <- function(j_result_set, conn, statement)
  H2QueryResult(j_result_set = j_result_set, connection = conn, statement = statement)
create_new_h2_update_result <- function(update_count, conn, statement)
  H2UpdateResult(update_count = update_count, connection = conn, statement = statement)
create_new_h2_connection <- function(j_con, drv, sql_dialect) {
  H2Connection(j_connection = j_con, driver = drv, sql_dialect = sql_dialect,
    create_new_query_result = create_new_h2_query_result,
    create_new_update_result = create_new_h2_update_result)
}

#' @param ... Additional arguments to \code{\link[dbj]{driver}}.
#' @rdname H2Driver-class
#' @export
#' @examples
#' library(DBI)
#' dbConnect(dbj.h2::driver(), 'mem:')
driver <- function(sql_dialect = dbj::h2_dialect, classpath = NULL,
  read_conversions = default_read_conversions,
  write_conversions = default_write_conversions,
  create_new_connection = create_new_h2_connection, ...) {

  H2Driver(
    read_conversions = read_conversions,
    write_conversions = write_conversions,
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
#' @param url the url to connect to (Visit \url{http://h2database.com/html/features.html#database_url} for a reference).
#'   If the url is a path to a local file the '.h2.db' suffix is stripped off automatically if present.
#' @inheritParams dbj::"dbConnect,JDBCDriver-method"
#' @export
setMethod("dbConnect", signature(drv = "H2Driver"),
	function(drv, url = "mem:", user = 'sa', password = '', sql_dialect = dbj::h2_dialect, ...) {
    url <- sprintf("jdbc:h2:%s", sub("^(?:jdbc:h2:)?(.*)", "\\1", url, perl = TRUE))
    url <- sprintf("%s", sub("^(.+)\\.h2\\.db$", "\\1", url))
    callNextMethod(drv, url, user, password, sql_dialect = sql_dialect, ...)
  }
)
