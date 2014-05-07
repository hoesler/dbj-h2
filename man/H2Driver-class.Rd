\docType{class}
\name{H2Driver-class}
\alias{H2}
\alias{H2Driver-class}
\alias{dbConnect,H2Driver-method}
\title{Class H2Driver}
\usage{
H2(...)

\S4method{dbConnect}{H2Driver}(drv, url = "jdbc:h2:mem:", user = "sa",
  password = "", ...)
}
\arguments{
  \item{...}{other arguments to pass to \link[RJDBC]{JDBC}}

  \item{url}{the url to connect to}

  \item{user}{the user to log in}

  \item{password}{the users password}

  \item{drv}{ an object that inherits from
  \code{DBIDriver}, a character string specifying the DBMS
  driver, e.g., "RPgSQL", "ROracle", "Informix", or
  possibly another \code{dbConnect} object.  }
}
\description{
Class H2Driver

Create a H2 Database Driver object.
}

