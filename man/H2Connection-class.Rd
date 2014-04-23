\docType{class}
\name{H2Connection-class}
\alias{H2Connection-class}
\alias{dbDataType,H2Connection-method}
\alias{dbDisconnect,H2Connection-method}
\alias{dbGetInfo,H2Connection-method}
\alias{dbGetQuery,H2Connection,character-method}
\alias{dbGetQuery,H2Connection-method}
\alias{dbSendQuery,H2Connection,character-method}
\alias{dbSendQuery,H2Connection-method}
\alias{dbWriteTable,H2Connection-method}
\title{Class H2Connection}
\usage{
\S4method{dbDisconnect}{H2Connection}(conn, ...)

\S4method{dbWriteTable}{H2Connection}(conn, name, value, overwrite = TRUE,
  ...)

\S4method{dbDataType}{H2Connection}(dbObj, obj, ...)

\S4method{dbSendQuery}{H2Connection,character}(conn, statement, ...,
  list = NULL)

\S4method{dbGetQuery}{H2Connection,character}(conn, statement, ...)

\S4method{dbGetInfo}{H2Connection}(dbObj, ...)
}
\arguments{
  \item{overwrite}{set to \code{TRUE} if the table should
  be removed if it exists}

  \item{list}{a list of statement parameters}

  \item{conn}{ a connection object as produced by
  \code{dbConnect}.  }

  \item{...}{ authorization arguments needed by the DBMS
  instance; these typically include \code{user},
  \code{password}, \code{dbname}, \code{host}, \code{port},
  etc.  For details see the appropriate \code{DBIDriver}.
  }

  \item{name}{ a character string specifying a DBMS table
  name.  }

  \item{value}{ a data.frame (or coercible to data.frame).
  }

  \item{dbObj}{ a \code{DBIDriver} object, e.g.,
  \code{ODBCDriver}, \code{OracleDriver}. }

  \item{obj}{ R/Splus object whose SQL type we want to
  determine. }

  \item{statement}{ a character vector of length 1 with the
  SQL statement. }
}
\description{
Class H2Connection
}

