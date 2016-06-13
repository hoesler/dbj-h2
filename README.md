# dbj.h2

[![Build Status](https://travis-ci.org/hoesler/dbj-h2.svg?branch=master)](https://travis-ci.org/hoesler/dbj-h2)

This package is a [dbj](https://github.com/hoesler/dbj) extension to conveniently access H2 data stores.

It ships with the latest stable version of H2 (1.3.x). See usage section, if you want a different version.

## Installation
```R
devtools::install_github("hoesler/dbj.h2")
```

## Usage
```R
library(DBI)

con <- dbConnect(dbj.h2::driver(), "mem:")
con <- dbConnect(dbj.h2::driver(), "~/database.h2.db", user = 'me', password = 'some')
```

To use a different H2 driver version, make sure to add the H2 jar to the classpath before loading dbj.h2:
```R
library(DBI)
library(dbj)

jdbc_register_driver(
  'org.h2.Driver',
  resolve(
    module('com.h2database:h2:1.4.192'),
    repositories = list(maven_local, maven_central)
  )
)

con <- dbConnect(dbj.h2::driver(), url = "mem:")
dbGetInfo(con)$jdbc_driver_version
# [1] "1.4.192 (2016-05-26)"
```

## Acknowledgements
The development of dbj.h2 was hugely inspired by the [RH2](https://github.com/dmkaplan2000/RH2) package.