#### url_path: Get http address of daily reports ####

url_path <- function(date, province){

  meses <- c("ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic")

  mes <- lubridate::month(date)

  paste0("http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/",
         meses[mes], format(as.Date(date), "%y"), "/n", tolower(province),
         format(as.Date(date), "%y%m%d"), ".htm")

}




#### Read html of specified url #####

get_html <- function(url){

  if (!is.character(url) | length(url) != 1)
    stop("http address must be a character")

  if (!http_error(url)) return(xml2::read_html(url, encoding = "ISO-8859-1")) else return(NULL)

}



##### Scrape data from html tables #####

scrape_html <- function(html_obj){

  if (!is.null(html_obj)){

    n_estaciones <- (length(rvest::html_nodes(html_obj, "table"))-1)/2

    air.list <- rep(list(NULL), n_estaciones)

    for (i in 1:n_estaciones) {

      ## read station info
      id <- html_table(html_nodes(html_obj, "table")[i*2], fill = TRUE, header = FALSE)[[1]]
      id2 <- data.frame(substring(t(id[,2]), 2), stringsAsFactors = FALSE)  ## eliminar espacios al comienzo
      names(id2) <- id[, 1]  # use english names?

      ## read station data
      df <- html_table(html_nodes(html_obj, "table")[i*2+1], fill = TRUE, header = TRUE)[[1]]
      df <- df[-nrow(df), ]  # last row is always text
      df <- df[, c(TRUE, sapply(df[, -1], function(x) all(!is.na(x))))]  # delete columns without data

      ## Hay estaciones sin ninguna medición en el dia: e.g. Campillos (Malaga:27-1-2015)

      if (is.numeric(nrow(df))) {

        vars <- c("FECHA-HORA", "SO2", "PART", "NO2", "CO", "O3", "SH2")
        df[ , vars[!vars%in%names(df)]] <- NA
        df <- df[, vars]

        df <- data.frame(id2, df)
        air.list[[i]] <- df

      }

    }

    dat <- do.call(rbind.data.frame, air.list)

    # making output suitable for openair pkg:
    names(dat)[names(dat) == "Estacion"] <- "site"
    dat$site <- as.factor(dat$site)
    names(dat)[names(dat) == "FECHA.HORA"] <- "date"
    dat$date <- as.POSIXct(strptime(dat$date, format = "%d/%m/%y-%H:%M", tz = "Etc/GMT-1"),
                           tz = "Etc/GMT-1")

    return(dat)

  }


}




#### Wrapper function for single date and province ####

process_report <- function(date, prov){

  url <- url_path(date, prov)

  html_obj <- get_html(url)

  dat <- scrape_html(html_obj)

  dat
}


