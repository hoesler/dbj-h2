\docType{methods}
\name{dbConnect,H2Driver-method}
\alias{dbConnect,H2Driver-method}
\title{Connect to a h2 database.}
\usage{
\S4method{dbConnect}{H2Driver}(drv, url = "jdbc:h2:mem:", user = "sa",
  password = "", ...)
}
\arguments{
  \item{url}{the jdbc url to connect to. If the url does
  not start with "jdbc:" it is treated as a file path and
  automatically converted to an url.}

  \item{user}{the user to log in}

  \item{password}{the users password}

  \item{drv}{ an object that inherits from
  \code{DBIDriver}, a character string specifying the DBMS
  driver, e.g., "RPgSQL", "ROracle", "Informix", or
  possibly another \code{dbConnect} object.  }

  \item{...}{ authorization arguments needed by the DBMS
  instance; these typically include \code{user},
  \code{password}, \code{dbname}, \code{host}, \code{port},
  etc.  For details see the appropriate \code{DBIDriver}.
  }
}
\description{
Connect to a h2 database.
}

