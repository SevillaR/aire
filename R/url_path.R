url_path <- function(fecha, provincia){

  meses <- c("ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic")

  provincias <- c("al", "ca", "co", "gr", "hu", "ja", "ma", "se")

  mes <- lubridate::month(fecha)

  cat("http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/",
      meses[mes], format(as.Date(fecha), "%y"), "/n", provincia,
      format(as.Date(fecha), "%y%m%d"),
      sep = ""
  )



}