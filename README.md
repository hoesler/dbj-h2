# dbj.h2

[![Build Status](https://travis-ci.org/hoesler/dbj-h2.svg?branch=master)](https://travis-ci.org/hoesler/dbj-h2)

dbj extension to access H2 data stores.

This fork is build against [hoesler/dbj](https://github.com/hoesler/dbj).

The master branch uses the latest stable version of H2 (1.3.x), the [h2-1.4 branch](https://github.com/hoesler/dbj-h2/tree/h2-1.4) uses the latest beta version (1.4.x).

## Installation
```R
devtools::install_github("hoesler/dbj")
devtools::install_github("hoesler/dbj.h2")
```

## Usage
```R
con <- dbConnect(dbj.h2::driver(), url = "mem:", user = 'sa', password = '')
```
