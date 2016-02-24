## ----echo=FALSE----------------------------------------------------------
library(knitr)
opts_knit$set(root.dir=normalizePath('../'))
opts_chunk$set(warning = FALSE, message = FALSE)
opts_chunk$set(fig.path = "Sevilla_2015_figuras/", fig.show="hide")

## ------------------------------------------------------------------------
library(aire)

## ----eval=FALSE----------------------------------------------------------
#  se2015 <- get_daily_data(province = "se", from = "2015-01-01", to = "2015-12-31")
#  # NB: downloading a whole year takes a while... ca. 20 minutes
#  
#  save(se2015, file = "data/se2015.rda")
#  

## ------------------------------------------------------------------------
load("data/se2015.rda")
head(se2015)

## ------------------------------------------------------------------------
library(openair)

## ----summaryPlot_SO2-----------------------------------------------------

summaryPlot(se2015, pollutant = "SO2")

## ----summaryPlot_O3------------------------------------------------------
summaryPlot(se2015, pollutant = "O3")

## ----summaryPlot_Torneo--------------------------------------------------
summaryPlot(se2015[se2015$site == "TORNEO", ])

## ----timePlot------------------------------------------------------------
timePlot(se2015[se2015$site == "TORNEO", ], pollutant = c("SO2", "NO2", "O3"))

## ----calendarPlot--------------------------------------------------------
calendarPlot(se2015[se2015$site == "TORNEO", ], pollutant = "O3")

## ------------------------------------------------------------------------
may8 <- get_daily_data("2015-05-08", province = "se")
data(stations)
may8sp <- merge(may8, stations[, "site"], by = "site", all.x = TRUE)

## ----map-----------------------------------------------------------------
GoogleMapsPlot(may8sp, pollutant = "NO2")  # experimental yet, may give problems

