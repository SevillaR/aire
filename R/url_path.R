#' Get http address of daily report
#'
#' @param fecha Character vector with date in formart "yyyy-mm-dd" (see examples).
#' @param provincia Character. Two first letters of province name.
#'
#' @return Character vector with the http address.
#' @export
#' @importFrom lubridate month
#' @author F. Rodriguez-Sanchez, V. Luque
#'
#' @examples
#'
#' url_path ("2015-01-28", "gr")
#'
#' url_path ("2015-01-03", "MA")
#'
#' url_path ("2015-01-03", "Se")
#'
url_path <- function(fecha, provincia){

  meses <- c("ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic")

  provincias <- c("al", "ca", "co", "gr", "hu", "ja", "ma", "se")

  mes <- lubridate::month(fecha)

  cat("http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/",
      meses[mes], format(as.Date(fecha), "%y"), "/n", tolower(provincia),
      format(as.Date(fecha), "%y%m%d"),
      sep = ""
  )



}