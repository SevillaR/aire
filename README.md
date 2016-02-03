# aire: grab data on air pollution in Andalusia (Spain)

[![Build Status](https://travis-ci.org/SevillaR/aire.svg?branch=master)](https://travis-ci.org/SevillaR/aire)
[![Coverage Status](https://img.shields.io/codecov/c/github/SevillaR/aire/master.svg)](https://codecov.io/github/SevillaR/aire?branch=master)

A project from [SevillaR](http://sevillarusers.wordpress.com).

This package can download and retrieve daily data on air quality in Andalusia (Spain), from any of the stations maintained by 'Consejeria de Medio Ambiente' (http://bit.ly/airedata). The data are formatted to be directly analysed with the [openair](https://cran.r-project.org/web/packages/openair/index.html) package. Note these data are collected automatically and *not validated*. Check out Consejeria de Medio Ambiente website for monthly and annual reports based on validated data.


## Installation

```
library(devtools)
install_github("SevillaR/aire")
```


## Examples

```
mydata <- get_daily_data("2015-01-29", province = "se")

mydata <- get_daily_data(c("2015-01-29", "2015-01-30"), "se")

mydata <- get_daily_data(province = "se", from = "2015-01-20", to = "2015-01-25")

```


See vignette here.
