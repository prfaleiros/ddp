#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(miniUI)
library(datasets)
library(ggplot2)
library(plotly)
library(caret)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
	
	validation <- airquality[is.na(airquality$Ozone) | is.na(airquality$Solar.R),]
	df <- airquality[!is.na(airquality$Ozone) & !is.na(airquality$Solar.R),]
	
	set.seed(1999)
	inTrain<-createDataPartition(y=df$Ozone, p=0.75, list=FALSE);
	training<- df[inTrain,];
	testing<-df[-inTrain,];
	
	modelFit=train(Ozone ~., data=training, method="glm")
	
	predictions<- predict(modelFit,newdata=testing)
	
	val<- predict(modelFit,newdata=validation)
	
	output$distPlot <- renderPlot({
		
		if (input$select == 1) {
			g1 <- ggplot(airquality, aes(x=Solar.R, y=Ozone)) + 
				ylim(-25, 175) +
				geom_point(col="darkblue")
			if (input$checkbox == TRUE) {
				g1 <- g1 + geom_point(data = airquality[as.numeric(names(val)),], 
									  aes(x=airquality$Solar.R[as.numeric(names(val))], y = val),
									  col="green")
			}
			g1
		} else if (input$select == 2) {
			g2 <- ggplot(airquality, aes(x=Wind, y=Ozone)) + 
				ylim(-25, 175) +
				geom_point(col="darkblue")
			if (input$checkbox == TRUE) {
				g2 <- g2 + geom_point(data = airquality[as.numeric(names(val)),], 
									  aes(x=airquality$Wind[as.numeric(names(val))], y = val),
									  col = "red")
			}
			g2
		} else if (input$select == 3) {
			g3 <- ggplot(airquality, aes(x=Temp, y=Ozone)) + 
				ylim(-25, 175) +
				geom_point(col="darkblue")
			if (input$checkbox == TRUE) {
				g3 <- g3 + geom_point(data = airquality[as.numeric(names(val)),], 
									  aes(x=airquality$Temp[as.numeric(names(val))], y = val),
									  col = "blue")
			}
			g3
		}
	})
	
})
