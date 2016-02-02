# get_html <- function(url){
#
# }

#' @title html2list  Get
#'
#' @param url Character. Http address of the daily report
#'
#' @return A list of lists (each element being a station).
#' @export
#' @author Francisco Viciana & Francisco Balao
#' @import rvest
#' @examples
#' \dontrun{
#' query<-"http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/ene15/nse150129.htm"
#' dat29.1.15<-html2list(query)
#' }
#' @seealso list2df

html2list <- function(query){

  if (is.character(query) == FALSE | length(query) != 1)
    stop("http address must be a character")

  air.dat <- rvest::read_html(query)
  n_estaciones<-(length(html_nodes(air.dat, "table"))-1)/2
  air.list<-rep(list(NULL),n_estaciones)
  ii <- 0L # contador auxiliar estaciones con datos
  for (i in 1:n_estaciones){
    id<-html_table(html_nodes(air.dat, "table")[i*2], fill = T, header = F)[[1]]
    id <- structure(id[,2],names =id[,1])
    id<- sub('[^[:alnum:] ]','',id)  #  eliminar espacios al comienzo
    df <-html_table(html_nodes(air.dat, "table")[i*2+1], fill = T, header = T)[[1]]
    row.all.NA <- !sapply(df, function (e) {all(is.na(e))} )
    if (sum(row.all.NA)== length(df[,1])) {
      ## Hay estaciones sin medición en el dia: Campillos (i.e. Malaga:27-1-2015)
      ## en este caso hay que borrar ultimo  elemento de la lista aun no rellenado
      air.list[[length(air.list)]] <- NULL
    } else {
      df <- df[,row.all.NA]
      df<-df[!apply(df[,-1,drop=F],1,function (e) {all(is.na(e))}),]  # drop=F, hay estaciones con un solo parametro
      ii <- ii + 1   ## incrementa el contador auxiliar de estaciones con datos
      air.list[[ii]]$id<-id
      air.list[[ii]]$dat <-df
    }
  }
  return(air.list)
}

# rm(air.dat,air.list,id,df,ii,i)
# query <- "http://www.juntadeandalucia.es/medioambiente/atmosfera/informes_siva/ene15/nma150127.htm"
