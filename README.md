# dbj.h2

[![Build Status](https://travis-ci.org/hoesler/dbj-h2.svg?branch=master)](https://travis-ci.org/hoesler/dbj-h2)

This package is a [dbj](https://github.com/hoesler/dbj) extension to conveniently access H2 data stores.

It ships with the latest stable version of H2 (1.3.x).

## Installation
```R
devtools::install_github("hoesler/dbj")
devtools::install_github("hoesler/dbj.h2")
```

## Usage
```R
con <- dbConnect(dbj.h2::driver(), "mem:")
con <- dbConnect(dbj.h2::driver(), "~/database.h2.db", user = 'me', password = 'some')

# To use a different h2 version, use the classpath argument:
con <- dbConnect(dbj.h2::driver(classpath = "h2.jar"), url = "mem:")

h2_classpath <- resolve(
  module('com.h2database:h2:1.4.192'),
  repositories = list(maven_local, maven_central)
)
con <- dbConnect(dbj.h2::driver(classpath = h2_classpath), url = "mem:")
```

## Thanks
The development of dbj.h2 was hugely inspired by the [RH2](https://github.com/dmkaplan2000/RH2) package.