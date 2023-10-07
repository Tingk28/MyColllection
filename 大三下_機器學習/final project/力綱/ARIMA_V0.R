cog <- read.csv("C:/Users/88693/Documents/All Lecture/ML/Project/Data/COGvariables.csv")

install.packages("forecast")
install.packages("tseries")
install.packages("dplyr")
library(forecast)
library(tseries)
library(dplyr)

#obserate the data
train <- ts(cog$holder2_V0[1:220320] , frequency = 1440, start = 1)
test <- cog$holder2_V0[220321:264961]
decompose.ts <- decompose(ts)
plot(decompose.ts)
adf.test(ts) #p-value < 0.05, stationary ts

#fit the data
fit <- auto.arima(train ,stepwise =F ,trace = T,stationary = T,ic = c("aic"), max.p = 60, max.order = 70,nmodels = 5)
fit <- auto.arima(train ,order=c(0,0,0),include.mean=FALSE)


tsdisplay(residuals(fit), lag.max=5, main='residuals')
shapiro.test(fit$residuals[1:5000]) 
Box.test(fit$residuals, lag=10, type="Ljung-Box") 


p<-forecast(fit,60,lambda = 1,biasadj=FALSE) 
p
plot(p,xlim=c(1,10))
forecast <- as.data.frame(p)
evaluate <- cbind(forecast,compared.data)
mape <- sum(abs((evaluate$compared.data-evaluate$`Point Forecast`)/evaluate$compared.data))/60412
mape
mean(mape)

(break_point <- breakpoints(ts.form ~ 1))
summary(break_point) 

diff <- diff(ts.form, differences = 1)
adf.test(diff)  

