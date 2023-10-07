library(forecast)
library(tseries)

#reading data
all_user<-read.csv("COGuser2013_rawdata.csv")
#all_user[3:71]<-as.numeric(unlist(all_user[3:71]))
total_usage<-all_user[,72]


start <-sample(1:100000,1)
freq <- 15
traing_len <- 120
testing_len <- 60

training_data<-ts(total_usage[start:(start+traing_len-1)],frequency = freq)
testing_data<-ts(total_usage[(start+traing_len):(start+traing_len+testing_len-1)],frequency = freq)
#time_data <- ts(total_usage,frequency = 1440*7)
plot(decompose(training_data))
plot(decompose(testing_data))
##轉換
training_data_df <- diff(training_data, differences = 1)
training_data_lamba <- BoxCox(training_data,lambda = "auto")
BoxCox.lambda(training_data)
##假設檢定
adf.test(training_data)
adf.test(training_data_df)
adf.test(training_data_lamba)

##ARIMA
a<- auto.arima(training_data_df,stepwise=F,trace=T,stationary=T,ic=c("aic"))
##Best model  ARIMA(5,0,0)     with non-zero mean 
fit <- arima(training_data,order = c(3,1,0),include.mean = F)
fit <- arima(training_data,order = c(0,0,2),seasonal = list(order=c(2,0,0),period=freq),include.mean = F)
tsdisplay(residuals(fit))
shapiro.test(fit$residuals)
Box.test(fit$residuals,lag = 60)

#forecast
p <- forecast(fit,60,lambda = 1)
plot(p)
lines(y=testing_data[1:60],x=1+traing_len/freq+(((0:59)/freq)),col='red')
predit.frame <- as.data.frame(p)
analysis <- cbind(predit.frame,testing_data[1:60])
mae=abs(testing_data[1:60]-analysis$`Point Forecast`) 
mape=abs(testing_data[1:60]-analysis$`Point Forecast`)/testing_data[1:60]
mean(mape)
