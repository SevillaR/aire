#' Conseguir rutas URL
#'
#' @param mes Dame las tres primeras letras del mes.
#' @param dia Dia juliano.
#' @author Paco
#' @import lubridate
#'
#' @return
#' @export
#'
#' @examples
url_finder <- function(mes, dia){
  cat("http://www.juntadeandalucia.es/medioambiente/site/rediam/", mes, "/", dia, ".htm")
}