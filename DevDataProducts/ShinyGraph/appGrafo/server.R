library(shiny)
library(networkD3)
#setwd("/home/fou/Desktop/Online/RCoursera/R-Coursera/DevDataProducts/ShinyGraph")
#oct <- read.csv('2016-10.csv', sep = ',')
#save(oct, file= "oct.Rdata")

server <- function(input, output) {
	load(file= "oct.Rdata")
	library(dplyr)
	flujo_neg <- oct %>% select(Ciclo_Estacion_Retiro, Ciclo_Estacion_Arribo) %>%
		arrange(Ciclo_Estacion_Retiro, Ciclo_Estacion_Arribo) %>%
		group_by(Ciclo_Estacion_Retiro) %>% summarise(w = n()) #viajes que salen de estacion
	flujo_neg$tipo <- "Salida" 
	names(flujo_neg) <- c('Estacion',"wins", "tipo")
	
	flujo_pos <- oct %>% select(Ciclo_Estacion_Retiro, Ciclo_Estacion_Arribo) %>%
		arrange( Ciclo_Estacion_Arribo, Ciclo_Estacion_Retiro) %>%
		group_by(Ciclo_Estacion_Arribo) %>% summarise(dentro = n()) %>% arrange(desc(dentro))
	
	flujo_pos$tipo <- "Entrada"
	names(flujo_pos) <- c('Estacion',"w","tipo")
	
	output$force <- renderForceNetwork({
		edges_in <- oct %>% select(Ciclo_Estacion_Retiro, Ciclo_Estacion_Arribo) %>%
			group_by(Ciclo_Estacion_Retiro, Ciclo_Estacion_Arribo) %>% summarise(w = n()) %>%
			arrange(desc(w))
		mean(edges_in$w)
		ins <- subset(edges_in, w > input$ins)
		edges_out <- oct %>% select( Ciclo_Estacion_Arribo, Ciclo_Estacion_Retiro) %>%
			group_by( Ciclo_Estacion_Arribo, Ciclo_Estacion_Retiro) %>% summarise(w = n()) %>%
			arrange(desc(w))
		out <- subset(edges_out, w > input$out)
		aristas <- rbind(ins, out)
		aristas <- as.data.frame(aristas)
		nodos <- as.data.frame(flujo_pos)
		names(aristas) <- c("source", "target", "value" )
		names(nodos) <- c("id", "w", "tipo")
		aristas$source <- aristas$source - 1
		aristas$target <- aristas$target - 1
		nodos$id <- nodos$id -1 
		s <- ""
		ifelse(input$check == 1, s <- "w", s <- "tipo")
		aristas$value <- scale(aristas$value, scale = FALSE)
		forceNetwork(Links = aristas, Nodes = nodos,
					 Source = 'source', Target = 'target',
					 Value = "value", opacity = 0.8,
					 NodeID = 'id', Group = s,
					 radiusCalculation = "Math.pow(Math.log(d.nodesize), 1.5)",
					 Nodesize  = "w", 
					 zoom = TRUE
					 #legend = TRUE
		)
	})
	
}