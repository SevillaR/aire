require(aire)
require(reshape2)
require(rvest)

rm(list = ls())

## ------------------------------
##  Ejemplo de descarga de datos
## ------------------------------
range.date <- as.Date(c('2004-01-01','2004-01-03'),'%Y-%d-%m')
seq.days   <- seq(from=range.date[1], to=range.date[2], by=1)

# seq.days
list.url <- get_daily_data(seq.days,
                            c("al", "ca", "co", "gr","hu","ja","ma","se"))
list.url <- unlist(list.url)
list.url <- paste0(list.url,'.htm')

## prueba una
pp<-html2list(list.url[1])

ldata <- list()
downloaded <- as.logical()
system.time(
  for(i in list.url)
  {
    res <- try(html2list(i))
    if(inherits(res, "try-error"))
    {
      # Si error de lectura
      downloaded <- c(downloaded,F)
    } else {
      # download OK
      downloaded <- c(downloaded,T)
      ldata <- c(ldata,res)
    }
  }
) -> run.time

#--- RESULTADOS ...
table(downloaded) -> kk
# No leidos:
list.url[!downloaded]
### Solo en Cadiz funcionaron los sensores el 29 de febrero
# [1] "http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/feb04/nal040229.htm"
# [2] "http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/feb04/nco040229.htm"
# [3] "http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/feb04/ngr040229.htm"
# [4] "http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/feb04/nhu040229.htm"
# [5] "http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/feb04/nja040229.htm"
# [6] "http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/feb04/nma040229.htm"
# [7] "http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/feb04/nse040229.htm"
vel.med <- kk[2]/run.time[3]
kk
# FALSE  TRUE
#    7   481
run.time
#  user  system elapsed
# 708.309  19.974 729.837
paste0("Velocidad media carga x 100 paginas: ", round(100*vel.med,1),' seg.')
# [1] "Velocidad media carga x 100 paginas: 65.9 seg."

# Estimacion del  tiempo de descarga de la serie completa

range.date <- as.Date(c('2004-01-01','2016-29-01'),'%Y-%d-%m')
seq.days   <- seq(from=range.date[1], to=range.date[2], by=1)

paste0('Serie 2004 a 2016 tardaria ', round(length(seq.days)*8*vel.med/3600,1), ' horas')
# [1] "Serie 2004 a 2016 tardaria 6.5 horas"


# save(ldata,file='TODO/aire.dat.2004en&feb.Rdata')

##----------------------------
## Transforma en data.frame
##----------------------------
df.data <- list2df(ldata)

str(df.data)

## optimizar tipos de datos para almacenamiento
df.data$provincia <- factor(df.data$provincia)
df.data$estacion <- factor(df.data$estacion)
df.data$municipio <- factor(df.data$municipio)

df.data$medida <-  as.integer(df.data$medida)  ## Hay blancos pasan NA
table(is.na(df.data$medida))


df.data$fecha.hora <- as.POSIXct( strptime( df.data$fecha.hora,'%d/%m/%y-%H:%M', tz= "Europe/Madrid" ) )

# save(ldata,df.data,file='TODO/aire.dat.2004en&feb.Rdata')


