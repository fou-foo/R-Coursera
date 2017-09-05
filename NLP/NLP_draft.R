#install.packages("tm")
library(tm)
setwd("/home/fou/Desktop/R-Coursera/NLP/en_US")
Corpus <- VCorpus(DirSource(getwd(), encoding = "UTF-8"), readerControl = list(language = "en"))

#n <- length(Corpus[[3]]$content)       #el mas largo de los strings
#max(mapply(function(x){
 #   nchar(Corpus[[3]]$content[x])  
  #  }, 1:n))
#n <- length(Corpus[[3]]$content)
#sum(unlist(mapply(function(x){
 #  grep("love", Corpus[[3]]$content[x])  
 # }, 1:n)))/sum(unlist(mapply(function(x){
  #    grep("hate", Corpus[[3]]$content[x])  
 # }, 1:n)))
#Corpus[[3]]$content[grep("biostats", Corpus[[3]]$content)]
library(stringr)
#Corpus[[3]]$content[grep("A computer once beat me at chess, but it was no match for me at kickboxing",  Corpus[[3]]$content)]
Corpus.maps <- tm_map(Corpus, stripWhitespace)                     #quitamos espacios en blanco
Corpus.maps <- tm_map(Corpus.maps, content_transformer(tolower))                     #todo a minusculas
Corpus.maps <- tm_map(Corpus.maps, removeWords, stopwords("english"))   #stopwords
#Corpus.str <- tm_map(Corpus.maps, stemDocument)
M <- DocumentTermMatrix(Corpus.maps)
#writeCorpus(Corpus, path = '/home/fou/Desktop/R-Coursera/NLP' )


# train and test 
muestra_100 <- function(x){
    n1 <- length(Corpus.maps[[x]]$content)
    Corpus.maps[[x]]$content[sample(1:n1, floor(n1*.001))]
}
muestra <- lapply(c(1, 2, 3), muestra_100)
muestra <- as.VCorpus(muestra)
inspect(muestra)
str(muestra[[1]])

