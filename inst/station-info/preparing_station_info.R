library(sp)

stations <- read.csv("inst/doc/station_info.csv")

names(stations)[names(stations) == c("UTMx", "UTMy")] <- c("longitude", "latitude")

coordinates(stations) <- c("longitude", "latitude")

projection(stations) <- CRS("+proj=utm +zone=30 +ellps=GRS80 +units=m +no_defs")

stations <- spTransform(stations, CRSobj = CRS("+proj=longlat +datum=WGS84"))

stations$site <- stations$ESTACION

save(stations, file = "data/stations.rda")

