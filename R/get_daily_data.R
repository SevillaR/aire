#' Get daily air pollution data for given dates and province
#'
#' @param dates Character vector with one or multiple dates formatted as "yyyy-mm-dd" (see examples). Alternatively, use \code{from} and \code{to}.
#' @param from Character. Starting date, with format "yyyy-mm-dd".
#' @param to Character. Last date required, with same format as above.
#' @param province Character. The first two letters of province name.
#'
#' @return A dataframe, suitable to be used directly in \code{\link[openair]} package.
#' @export
#' @importFrom lubridate month
#' @import rvest
#' @importFrom httr http_error
#' @importFrom xml2 read_html
#'
#'
#' @examples
#' \dontrun{
#' dataset <- get_daily_data("2015-01-28", province = "gr")
#'
#' dataset <- get_daily_data("2015-01-03", "MA")
#'
#' dataset <- get_daily_data("2015-01-03", "Se")
#'
#' dataset <- get_daily_data(c("2015-01-28", "2015-01-29"), "se")
#'
#' dataset <- get_daily_data(province = "se", from = "2015-01-10", to = "2015-01-15")
#' }

get_daily_data <- function(dates, province, from, to){

  if (missing(dates)) {
    dates <- seq(as.Date(from), as.Date(to), by = 1)
  }

  data.list <- lapply(dates, process_report, prov = province)
  data.df <- do.call(rbind.data.frame, data.list)

  if (!nrow(data.df) > 0) stop ("There is no available data for the specified dates and province.")

  return(data.df)

}







