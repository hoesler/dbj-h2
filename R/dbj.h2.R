#' A DBI implementation for H2 which extends dbj.
#'
#' @docType package
#' @import dbj methods rJava DBI
#' @name dbj.h2
NULL

H2_DRIVER_CLASS <- 'org.h2.Driver'

.onLoad <- function(libname, pkgname) {
  .jinit()
  driver_not_registered <- is.null(.jfindClass(H2_DRIVER_CLASS, silent = TRUE))
  if (driver_not_registered) {
    classpath = dir(system.file("java", package = packageName(), lib.loc = NULL), pattern = "*.jar", full.names = TRUE)
    .jaddClassPath(classpath)
  }
}
