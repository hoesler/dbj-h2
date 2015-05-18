#' A DBI implementation for H2 which extends RJDBC.
#'
#' @docType package
#' @import RJDBC methods rJava DBI
#' @name RH2
NULL

.onLoad <- function(libname, pkgname) {
  .jpackage(pkgname, lib.loc = libname)
}