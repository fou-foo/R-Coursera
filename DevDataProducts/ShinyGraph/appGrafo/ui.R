library(shiny)
library(networkD3)
ui <- shinyUI(fluidPage(
	titlePanel("EcoBici (Shared bicycles in Mexico) "),
	
	sidebarLayout(
		sidebarPanel(
			sliderInput("ins", "Threshold for number of travels received from station", value = 50, min = 50,
						max = 500, step = 10),
			sliderInput("out", "Threshold for number of trips departing from station", value = 50, min = 50,
						max = 500, step = 10),
			checkboxGroupInput("check", label = h3("Different color for nodes?"), 
							   choices = list("Yes" = 1, "No" = 2),
							   selected = 1), 
			h6("Only select a option 'Yes' or 'No' for change color in nodes")
		),
		mainPanel(
			tabsetPanel(
				tabPanel("Doc", h6("The following tab shows a display of stations of a bicycle loan service in Mexico City,
								   each node represents a station in the city."),
						        h6("The edges represent very popular travel routes, on the left side you can choose the 
						           threshold from which routes are drawn in which $ n > 50$ travels arrive and you can 
						           also draw the routes in which they leave more than $ m > 50 $ trips per service station."),
								h6("The service API also provides information about the inflow of the stations, that information
									is what determines in node size."),
						 		h6("Finally an option to draw different colors of the nodes is given at the user's choice."),
						 		h6("Also on the graph you can zoom to see it better.")
						 ),
				tabPanel("Network", forceNetworkOutput("force"))
			)
		)
	)
))