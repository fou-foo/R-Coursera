# ui.R
library(ggvis)
shinyUI(fluidPage(
	

    mainPanel(
      
      ggvisOutput('ggvis'))
    )
)