# dbj.h2

[![Build Status](https://travis-ci.org/hoesler/dbj-h2.svg?branch=master)](https://travis-ci.org/hoesler/dbj-h2)

This package is a [dbj](https://github.com/hoesler/dbj) extension to conveniently access H2 data stores.

The master branch uses the latest stable version of H2 (1.3.x), the [h2-1.4 branch](https://github.com/hoesler/dbj-h2/tree/h2-1.4) the latest beta version (1.4.x).

## Installation
```R
devtools::install_github("hoesler/dbj")
devtools::install_github("hoesler/dbj.h2")
```

## Usage
```R
con <- dbConnect(dbj.h2::driver(), url = "mem:", user = 'sa', password = '')
```
