#' A DBI implementation for H2 which extends dbj.
#'
#' @docType package
#' @import dbj methods rJava DBI
#' @name dbj.h2
NULL

.onLoad <- function(libname, pkgname) {
  .jpackage(pkgname, lib.loc = libname)
}