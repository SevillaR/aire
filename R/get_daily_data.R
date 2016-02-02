#### url_path: Get http address of daily reports ####

url_path <- function(date, province){

  meses <- c("ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic")

  mes <- lubridate::month(date)

  paste0("http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/",
         meses[mes], format(as.Date(date), "%y"), "/n", tolower(province),
         format(as.Date(date), "%y%m%d", ".htm")
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
get_daily_data <- Vectorize(url_path, vectorize.args = c("date"),
                            SIMPLIFY = FALSE, USE.NAMES = FALSE)







