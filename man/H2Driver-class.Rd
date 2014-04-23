\docType{class}
\name{H2Driver-class}
\alias{H2}
\alias{H2Driver-class}
\alias{dbConnect,H2Driver-method}
\title{Class H2Driver}
\usage{
H2(driverClass = "org.h2.Driver",
  identifier.quote = "\\"", jars = getOption("RH2.jars"), ...)

\S4method{dbConnect}{H2Driver}(drv, url = "jdbc:h2:mem:", user = "sa",
  password = "", database_to_upper = getOption("RH2.DATABASE_TO_UPPER"),
  ...)
}
\arguments{
  \item{driverClass}{the java driver class to use}

  \item{identifier.quote}{the character to surround
  itendifiers with}

  \item{jars}{Java archives in the java directory of the
  package that should be added to the class path.  The
  default value is \code{getOption("RH2.jars")}.
  \code{NULL} will be replace with \code{"*"}.  See
  \code{\link[rJava]{.jpackage}} for more details.}

  \item{...}{other arguments to pass to
  \link[rJava]{.jpackage}}

  \item{url}{the url to connect to}

  \item{user}{the user to log in}

  \item{password}{the users password}

  \item{database_to_upper}{the value for DATABASE_TO_UPPER
  appended to the url}

  \item{drv}{ an object that inherits from
  \code{DBIDriver}, a character string specifying the DBMS
  driver, e.g., "RPgSQL", "ROracle", "Informix", or
  possibly another \code{dbConnect} object.  }
}
\description{
Class H2Driver

Create a H2 Database Driver object.
}

