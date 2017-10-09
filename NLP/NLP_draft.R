library(stringr)                              # to easy handle strings 
library(tm)                                   # to read easy folders of documents 
#devtools::install_github("kbenoit/quanteda") # install 'quanteda' run more quick than 'tm' working with text 
library(quanteda)                             # text analysis written in C languaje
setwd("C:\\Users\\fou-f\\Desktop\\final\\en_US")
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
#Corpus[[3]]$content[grep("A computer once beat me at chess, but it was no match for me at kickboxing",  Corpus[[3]]$content)]
t <- Sys.time()
Corpus.maps <- tm_map(Corpus, stripWhitespace)                     #quitamos espacios en blanco y simbolos
Corpus.maps <- tm_map(Corpus.maps, removePunctuation)
Corpus.maps <- tm_map(Corpus.maps, removeNumbers)
encoding <- function(x) iconv(x, "latin1", "ASCII", sub="")
f <- content_transformer(function(x, pattern) gsub(pattern, "", x))
Corpus.maps <- tm_map(Corpus.maps, content_transformer(encoding))
Corpus.maps <- tm_map(Corpus.maps, f, "[!\"#$%&'*+,!¡../)(:;<=>?@][^`{|}~]")
Corpus.maps <- tm_map(Corpus.maps, content_transformer(tolower))                     #todo a minusculas
Corpus.maps <- tm_map(Corpus.maps, removeWords, stopwords("english"))   #stopwords
Corpus.maps <- tm_map(Corpus.maps, content_transformer(tolower))
(t <- Sys.time() - t)

rm(list="Corpus")
gc()
save.image(file = 'C:\\Users\\fou-f\\Desktop\\final\\rSessionNLP.Rdata')













load('C:\\Users\\fou-f\\Desktop\\final\\rSessionNLP.Rdata')
library(quanteda)
library(tm)
#rm(Corpus.steam)
#gc()
Corpus.stem <- Corpus.maps
Corpus.maps <- corpus(Corpus.maps)
t1 <- Sys.time()
M.sinStem <- dfm(Corpus.maps) 
save(M.sinStem, file = 'C:\\Users\\fou-f\\Desktop\\final\\matrices\\matriz_Q_DFM.Rdata')
(t1 <- Sys.time() - t1)


suma <- sum(apply(M.sinStem, 1, sum)) #suma de todos los terminos
word.freq <- apply(M.sinStem, 2, sum)
Words.freq <- data.frame(freq = word.freq)
Words.freq2 <- data.frame(freq = Words.freq$freq[order(Words.freq$freq, decreasing = TRUE)])
row.names(Words.freq2) <- row.names(Words.freq)[order(Words.freq$freq, decreasing = TRUE)]
head(Words.freq)
head(Words.freq2)

Words.freq2$f.rel <- Words.freq2$freq / suma
Words.freq2$f.acum <- cumsum(Words.freq2$f.rel)
Words.freq2$word <- row.names(Words.freq2)
perc.50 <- subset(Words.freq2, f.acum <= .5)
library(ggplot2)
#distribuion de las palabras 
ggplot(perc.50) +geom_bar( aes(x = word, weight = freq ), position = position_stack(reverse = TRUE))
perc.90 <- subset(Words.freq2, f.acum <= .9)
cloud <- subset(Words.freq2, f.acum <= .5)
library(wordcloud2)
cloud$f.rel <- NULL
cloud$f.acum <- NULL
cloud$word <- factor(cloud$word)
cloud2 <- cloud
cloud2$freq <- NULL
cloud2$freq <- cloud$freq
wordcloud2(data = cloud2)
str(demoFreq)
str(cloud2)











Corpus.steam <- tm_map(Corpus.stem, stemDocument)
Corpus.steam <- corpus(Corpus.steam)
rm("Corpus.stem")
gc()
M.Stem <- dfm(Corpus.steam) 
save(M.Stem, file = 'C:\\Users\\fou-f\\Desktop\\final\\matrices\\matriz_Q_DFM_stem.Rdata')
suma <- sum(apply(M.Stem, 1, sum)) #suma de todos los terminos
word.freq.stem <- apply(M.Stem, 2, sum)
Words.freq.stem <- data.frame(freq = word.freq.stem)
Words.freq2.stem <- data.frame(freq = Words.freq.stem$freq[order(Words.freq.stem$freq, decreasing = TRUE)])
row.names(Words.freq2.stem) <- row.names(Words.freq.stem)[order(Words.freq.stem$freq, decreasing = TRUE)]
head(Words.freq.stem)
head(Words.freq2.stem)

Words.freq2.stem$f.rel <- Words.freq2.stem$freq / suma
Words.freq2.stem$f.acum <- cumsum(Words.freq2.stem$f.rel)
Words.freq2.stem$word <- row.names(Words.freq2.stem)
perc.50.stem <- subset(Words.freq2.stem, f.acum <= .5)
library(ggplot2)
#distribuion de las palabras 
ggplot(perc.50.stem) +geom_bar( aes(x = word, weight = freq ), position = position_stack(reverse = TRUE))
perc.90 <- subset(Words.freq2.stem, f.acum <= .9)
cloud.stem <- subset(Words.freq2.stem, f.acum <= .5)
library(wordcloud2)
cloud.stem$f.rel <- NULL
cloud.stem$f.acum <- NULL
cloud.stem$word <- factor(cloud.stem$word)
cloud2.stem <- cloud.stem
cloud2.stem$freq <- NULL
cloud2.stem$freq <- cloud.stem$freq
wordcloud2(data = cloud2.stem)



#decidimos ir por el stem 

distri <- subset(Words.freq2.stem, f.acum <= .1)
library(ggplot2)
ggplot(data = distri, aes(x = factor(word), y = freq, fill = freq)) +
  geom_bar(stat="identity") +   # se construyen las barras
  scale_fill_distiller(palette = 'Accent')+ # la magia de poder escoger facíl el color de la escala 'continua' o discreta
  xlab('cambiando color por escala') + theme_minimal() +  ggtitle('Gráfica colorida')+  #demas cosas
  guides(fill=FALSE) + #quitar leyenda 
  coord_flip()



# train and test 
muestra_100 <- function(x){
    n1 <- length(Corpus.maps[[x]]$content)
    Corpus.maps[[x]]$content[sample(1:n1, floor(n1*.001))]
}
muestra <- lapply(c(1, 2, 3), muestra_100)
muestra <- as.VCorpus(muestra)
inspect(muestra)
str(muestra[[1]])

