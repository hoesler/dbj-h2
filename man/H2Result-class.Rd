\docType{class}
\name{H2Result-class}
\alias{H2Result-class}
\alias{dbClearResult,H2Result-method}
\alias{dbHasCompleted,H2Result-method}
\alias{fetch,H2Result,numeric-method}
\alias{fetch,H2Result-method}
\title{Class H2Result}
\usage{
\S4method{fetch}{H2Result,numeric}(res, n, ...)

\S4method{dbHasCompleted}{H2Result}(res, ...)

\S4method{dbClearResult}{H2Result}(res, ...)
}
\arguments{
  \item{res}{ a result set object (one whose class extends
  \code{DBIResult}).  This object needs to be the result of
  a statement that produces output, such as SQL's
  \code{SELECT} or \code{SELECT}-like statement, this
  object \code{res} is typically produced by a call to or
  \code{dbSendQuery}.  }

  \item{n}{ maximum number of records to retrieve per
  fetch.  Use \code{n = -1} to retrieve all pending
  records.  Some implementations may recognize other
  special values.  }

  \item{...}{ any other database-engine specific arguments.
  }
}
\description{
Class H2Result
}

