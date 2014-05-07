\docType{class}
\name{H2Connection-class}
\alias{H2Connection-class}
\alias{dbGetInfo,H2Connection-method}
\alias{dbSendQuery,H2Connection,character-method}
\alias{dbSendQuery,H2Connection-method}
\title{Class H2Connection}
\usage{
\S4method{dbSendQuery}{H2Connection,character}(conn, statement, ...,
  list = NULL)

\S4method{dbGetInfo}{H2Connection}(dbObj, ...)
}
\arguments{
  \item{list}{a list of statement parameters}

  \item{conn}{ a connection object. }

  \item{statement}{ a character vector of length 1 with the
  SQL statement. }

  \item{...}{ database-specific parameters may be
  specified. }

  \item{dbObj}{ any object that implements some
  functionality in the R/Splus interface to databases (a
  driver, a connection or a result set). }
}
\description{
Class H2Connection
}

