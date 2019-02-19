ts()
ts(1, start=c(5,1), end=c(8,31), frequency = 1)
day(1)
?day
library(lubridate)
as.Date("2000-05-01")
?airquality
require(graphics)
pairs(airquality, panel = panel.smooth, main = "airquality data")
??nearZerovar
library(caret)
nearZeroVar(df[,-5])

df <- airquality
df$Ozone[is.na(df$Ozone)] <- 0
df$Solar.R[is.na(df$Solar.R)] <- 0

fit <- train()

validation <- airquality[is.na(airquality$Ozone) | is.na(airquality$Solar.R),]
df <- airquality[!is.na(airquality$Ozone) & !is.na(airquality$Solar.R),]


set.seed(1999)
inTrain<-createDataPartition(y=df$Ozone, p=0.75, list=FALSE);
training<- df[inTrain,];
testing<-df[-inTrain,];

modelFit=train(Ozone ~., data=training, method="glm")
modelFit
modelFit$finalModel

predictions<- predict(modelFit,newdata=testing)
predictions
confusionMatrix(predictions,testing$Ozone)
featurePlot(x=training[,c("Temp")], y=training$Ozone, plot="pairs")

val<- predict(modelFit,newdata=validation)
val
plot(airquality$Solar.R, airquality$Ozone)
plot(airquality$Temp, airquality$Ozone)
plot(airquality$Wind, airquality$Ozone)
plot(airquality$Month, airquality$Ozone)
points(airquality$Temp[as.numeric(names(val))], val, col="red")
points(as.numeric(names(predictions)), predictions, col="green")
points(as.numeric(names(predictions)), predictions, col="green")
abline(lm(Ozone ~ Temp, data = training, col=2))
abline(lm(Ozone ~ Solar.R, data = testing, col="grey60"))

library(ggplot2)
library(plotly)
g <- ggplot(airquality, aes(x=Temp, y=Ozone)) + geom_point()
g

g <- ggplot(airquality, aes(x=Temp, y=Ozone)) + geom_point() + 
	geom_point(data = airquality[as.numeric(names(val)),], aes(x=airquality$Temp[as.numeric(names(val))], y = val,
							   col = "red"))
g
ggplotly(g)

class(val)
which(val)
val
names(val)


install.packages('rsconnect')
library(rsconnect)
rsconnect::setAccountInfo(name='prfaleiros', token='394244480A8E185338198DE03303E167', secret='7huY39KUe+bTp+elOnfxqD3H0D6StcTlHcbTrHRT')
getwd()
dir()
rsconnect::deployApp('ddpwk4')

install.packages("slidify")

install.packages("devtools")

require(devtools)
install_github('ramnathv/slidify')
install_github('ramnathv/slidifyLibraries')
library(slidify)
author("ddpwk4")
slidify("index.Rmd")
publish(user = "prfaleiros", repo = "ddp")
getwd()
setwd("C:/Users/paulo.faleiros/Google Drive/Coursera/courses/JHU-DS/ddp")
