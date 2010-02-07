\name{H2}
\alias{H2}
\title{
  H2 engine
}
\description{
  \code{H2} creates a new DBI driver that can be used to start connections.
}
\usage{ H2(driverClass='org.h2.Driver', 
	identifier.quote="\"", parameters = "-Dh2.identifiersToUpper=false")
}
\arguments{
  \item{driverClass}{name of the Java class of the driver to
    load. If empty, it is assumed that corresponding drivers were
    loaded by other means.}
  \item{identifier.quote}{character to use for quoting identifiers in
    automatically generated SQL statements or \code{NA} for no
    quoted identifiers.}    
  \item{parameters}{Java virtual machine parameters.}
}
\value{
  Returns a \code{H2Driver} object that can be used in calls to
  \code{\link[DBI]{dbConnect}}.
}
\details{
  The \code{H2} function initializes the Java VM, loads the H2 driver 
  and creates a proxy R object which can be used to a
  call \code{\link[DBI]{dbConnect}} which actually creates a connection.

}
\seealso{
  \code{\link[DBI]{dbConnect}}
}
\examples{
\dontrun{
# problem creating tables with lower case in the column names
library(RJDBC)

con <- dbConnect(H2(), "jdbc:h2:~/test", "sa", "")

# create table, populate it and display it
s <- 'create table tt("id" int primary key, "name" varchar(255))'
dbSendUpdate(con, s)
dbSendUpdate(con, "insert into tt values(1, 'Hello')")
dbSendUpdate(con, "insert into tt values(2, 'World')")
dbGetQuery(con, "select * from tt")

# transfer a data frame to H2 and then display it from the database
dbWriteTable(con, "BOD", BOD)
dbGetQuery(con, "select * from BOD")

dbDisconnect(con)
}
}
\keyword{interface}
