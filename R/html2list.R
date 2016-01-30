library(rvest)
air.dat <- read_html(query)
html2list<-(html_table(html_nodes(air.dat, "table")[25], fill = T, header = T)[[1]])
