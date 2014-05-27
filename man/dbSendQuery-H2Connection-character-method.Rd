\docType{methods}
\name{dbSendQuery,H2Connection,character-method}
\alias{dbSendQuery,H2Connection,character-method}
\title{Execute a SQL statement on a database connection.}
\usage{
\S4method{dbSendQuery}{H2Connection,character}(conn, statement, list = list(),
  ...)
}
\arguments{
  \item{conn}{An existing
  \code{\linkS4class{H2Connection}}}

  \item{statement}{the statement to send over the
  connection}

  \item{parameters}{a list of statment parameters}

  \item{...}{Ignored. Needed for compatiblity with
  generic.}
}
\description{
Execute a SQL statement on a database connection.
}

