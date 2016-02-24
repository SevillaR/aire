## ----echo=FALSE----------------------------------------------------------
library(knitr)
opts_knit$set(root.dir=normalizePath('../'))
opts_chunk$set(warning = FALSE, message = FALSE)
opts_chunk$set(fig.path = "nubepolvo_figuras/", fig.show="hide")

## ------------------------------------------------------------------------
library(aire)

## ------------------------------------------------------------------------
datos <- get_daily_data(province = "se", from = "2016-02-15", to = "2016-02-23")

## ------------------------------------------------------------------------
library(openair)

## ----summaryPlot, fig.width=8--------------------------------------------
summaryPlot(datos, pollutant = "PART", period = "months")

## ----timePlot------------------------------------------------------------
timePlot(datos, pollutant = "PART", type = "site")

## ----calendarPlot--------------------------------------------------------
calendarPlot(datos, pollutant = "PART")

## ------------------------------------------------------------------------
datos.21 <- get_daily_data("2016-02-21", "se")
data(stations)
datos.21.sp <- merge(datos.21, stations[, "site"], by = "site", all.x = TRUE)

## ----map, eval=FALSE-----------------------------------------------------
#  GoogleMapsPlot(datos.21.sp, pollutant = "PART")

