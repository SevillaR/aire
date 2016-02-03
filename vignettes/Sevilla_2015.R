## ----echo=FALSE----------------------------------------------------------
library(knitr)
opts_knit$set(root.dir=normalizePath('../'))
opts_chunk$set(warning = FALSE, message = FALSE)

## ------------------------------------------------------------------------
library(aire)

## ----eval=FALSE----------------------------------------------------------
#  se2015 <- get_daily_data(province = "se", from = "2015-01-01", to = "2015-12-31")
#  # NB: downloading a whole year takes a while... ca. 20 minutes
#  
#  save(se2015, file = "data/se2015.rda")
#  

## ------------------------------------------------------------------------
data(se2015)
head(se2015)

## ------------------------------------------------------------------------
library(openair)

## ------------------------------------------------------------------------

summaryPlot(se2015, pollutant = "SO2")

summaryPlot(se2015, pollutant = "O3")

summaryPlot(se2015[se2015$site == "TORNEO", ])


## ------------------------------------------------------------------------
timePlot(se2015[se2015$site == "TORNEO", ], pollutant = c("SO2", "NO2", "O3"))

## ------------------------------------------------------------------------
calendarPlot(se2015[se2015$site == "TORNEO", ], pollutant = "O3")

## ------------------------------------------------------------------------
data(stations)
head(stations)

se2015 <- merge(se2015, stations[,"site"], by = "site", all.x = TRUE)

## ----eval=FALSE----------------------------------------------------------
#  GoogleMapsPlot(se2015, pollutant = "NO2")
#  # experimental yet, may give problems

