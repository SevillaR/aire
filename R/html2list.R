#' @title html2list  Get
#'
#' @param query
#'
#' @return A list of lists (each element being a station).
#' @export
#' @author Francisco Viciana & Francisco Balao
#' @import rvest
#' @example
#' query<-"http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/ene15/nse150129.htm"
#' dat29.1.15<-html2list(query)
#' @seealso list2df
#' @details

html2list<-function(query){
if  (is.character(query)==FALSE | length(query)!=1)
  stop("query not character")
air.dat <- read_html(query)
n_estaciones<-(length(html_nodes(air.dat, "table"))-1)/2
air.list<-rep(list(NULL),n_estaciones)
for (i in 1:n_estaciones){
  id<-html_table(html_nodes(air.dat, "table")[i*2], fill = T, header = F)[[1]]
  id <- structure(id[,2],names =id[,1])
  #id<-sub(' ','' ,id) Hay que hacer funcion trim para eliminar espacios
  air.list[[i]]$id<-id
  df <-html_table(html_nodes(air.dat, "table")[i*2+1], fill = T, header = T)[[1]]
  df <- df[,!sapply(df, function (e) {all(is.na(e))} )]
  df<-df[!apply(df[,-1],1,function (e) {all(is.na(e))}),]
  air.list[[i]]$dat <-df
    }
return(air.list)
}