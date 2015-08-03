# RH2

[![Build Status](https://travis-ci.org/hoesler/RH2.svg?branch=master)](https://travis-ci.org/hoesler/RH2)

RJDBC extension to access H2 data stores.

This fork is build against [hoesler/RJDBC](https://github.com/hoesler/RJDBC).

The master branch uses the latest stable version of H2 (1.3.x), the [h2-1.4 branch](https://github.com/hoesler/RH2/tree/h2-1.4) uses the latest beta version (1.4.x).

## Installation
```R
devtools::install_github("hoesler/RJDBC")
devtools::install_github("hoesler/RH2")
```

## Usage
```R
con <- dbConnect(H2(), url = "mem:", user = 'sa', password = '')
```
