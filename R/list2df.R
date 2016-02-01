#' list2df
#' Toma una lista de lecturas de parámetros de calidad del aire
#' para un dia determinado para cada estación provincial y
#' lecturas de cas
#'
#' @param list.est
#'
#' @return data.frame
#' @export
#' @importFrom reshape2 melt
#'
#' @examples
#'  list.dia<-  html2list("http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/ene15/nse150129.htm")
#'  df.dia  <- list2df(list.dia)
#'
list2df  <- function(list.est) {
  ## Creamos estructura de data.frame receptor
  resu <- data.frame(provincia=as.character(),
                     municipio=as.character(),
                     estacion=as.character(),
                     fecha.hora=as.character(),
                     parametro=as.character() ,
                     medida=as.integer() )
  #---------------------------------------------------------
  ## El uso de rbind para rellena tabla es sencillo pero
  ##  lento e ineficiente. Seria mejor usar otra estrategia:
  ## 1º Calcular el tamaño de la tabla receptora
  ## 2º Rellenar recepto con NA
  ## 3º Ir rellenado dia a dia en la posicion correspondiente
  ## ------------------------------------------------------------
  for (i in list.est) {
      id  <- i[[1]]
      dat <- i[[2]]
      names(dat)[1] <- 'fecha.hora'
      dat <-  melt(dat, id.var = 'fecha.hora',
                 variable.name  = 'parametro',
                 value.name     = 'medida')
      dat$provincia   <- id[1]
      dat$municipio   <- id[2]
      dat$estacion    <- id[3]
      dat <-  dat[,c(4:6,1:3)]
      resu<-rbind(resu,dat)
  }
  return (resu)
}

