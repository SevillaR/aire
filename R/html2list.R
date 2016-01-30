#' html2list
#'
#' @param query
#'
#' @return A list of lists (each element being a station).
#' @export
#' @import rvest

html2list<-function(query){
#query<-"http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/ene15/nse150129.htm"
air.dat <- read_html(query)
n_estaciones<-(length(html_nodes(air.dat, "table"))-1)/2
air.list<-rep(list(NULL),n_estaciones)
for (i in 1:n_estaciones){
  air.list[[i]]$id  <-html_table(html_nodes(air.dat, "table")[i*2], fill = T, header = T)[[1]]
  df <-html_table(html_nodes(air.dat, "table")[i*2+1], fill = T, header = T)[[1]]
  df <- df[,!sapply(df, function (e) {all(is.na(e))} )]
  df<-df[!apply(df[,-1],1,function (e) {all(is.na(e))}),]
  air.list[[i]]$dat <-df
    }
return(air.list)
}