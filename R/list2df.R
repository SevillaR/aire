#' list2df
#' Toma una lista de lecturas de parámetros de calidad del aire
#' para un dia determinado para cada estación provincial y
#' lecturas de cas
#'
#' @param list.est
#'
#' @return
#' @export
#'
#' @examples
list2df  <- function(list.est) {
  for (i in list.est) {
      id  <- i[[1]]
      dat <- i[[2]]
  }
  return (df.est)
}

