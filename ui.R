#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
require(miniUI)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
	
	# Application title
	titlePanel("Air quality data"),
	
	# Sidebar with a slider input for number of bins 
	sidebarLayout(
		sidebarPanel(
			selectInput("select", label = h5("Select predictor"), 
						choices = list("Select..." = 0, "Solar Radiation" = 1, "Wind" = 2, "Temperature" = 3),
						selected = 0),
			checkboxInput("checkbox", label = "Show predicted values", value = FALSE)
		),
		
		# Show a plot of the generated distribution
		mainPanel(
			plotOutput("distPlot")
		)
	)
))
