## Say something brief here
url_path <- function(fecha, provincia){

  meses <- c("ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic")

  provincias <- c("al", "ca", "co", "gr", "hu", "ja", "ma", "se")

  mes <- lubridate::month(fecha)

  paste0("http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/",
         meses[mes], format(as.Date(fecha), "%y"), "/n", tolower(provincia),
         format(as.Date(fecha), "%y%m%d")
  )

}

#' Get daily data for given dates and province(s)
#'
#' @param fecha Character vector with date in formart "yyyy-mm-dd" (see examples).
#' @param provincia Character. Two first letters of province name.
#'
#' @return List of characters with http addresses.
#' @export
#' @importFrom lubridate month
#' @author F. Rodriguez-Sanchez, V. Luque
#'
#' @examples
#'
#' get_daily_data("2015-01-28", "gr")
#'
#' get_daily_data("2015-01-03", "MA")
#'
#' get_daily_data("2015-01-03", "Se")
#'
#' get_daily_data(c("2015-01-28", "2015-01-29"), c("se", "gr"))
#'
get_daily_data <- Vectorize(url_path, vectorize.args = c("fecha"),
                            SIMPLIFY = FALSE, USE.NAMES = FALSE)







