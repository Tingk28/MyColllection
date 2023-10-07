setwd("~/Desktop/machinelearning/力綱/time lag")
library(forecast)#AUTO-ARIMA
library(tseries) #adf kpss test
library(dplyr)# mutate %>%
library(ggplot2) #作图
library(astsa)
## read data
COGgerneration2013_useknn2 <- read.csv("COGgerneration2013_useknn2.csv")
COGgerneration2013 <- read.csv("COGgerneration2013.csv")
COGgerneration2013_useknn2$time <- COGgerneration2013$time
colnames(COGgerneration2013_useknn2)[1] <- 'time'
COGgerneration2013_useknn2$time<-as.POSIXct(COGgerneration2013_useknn2$time)
##ACF Holder1
Holder1 <- COGgerneration2013_useknn2$W51_LX.152.1.OV
acf(Holder1)
Holder1_hr <-ts(Holder1,frequency  = 60)
Holder1_hr_acf<-acf(Holder1_hr,lag.max = 2880)
plot(x=c(0:2880),Holder1_hr_acf$acf,'l',xlab = 'lag(min)',ylab = 'ACF',main = 'Holder1_level acf plot')
##ACF Holder2
Holder2 <- COGgerneration2013_useknn2$W51_LX.152.2.OV
acf(Holder2)
Holder2_hr <-ts(Holder2,frequency  = 60)
Holder2_hr_acf<-acf(Holder2_hr,lag.max = 2880)
plot(x=c(0:2880),Holder2_hr_acf$acf,'l',xlab = 'lag(min)',ylab = 'ACF',main = 'Holder2_level acf plot')
###
H1 = ts (Holder1)
H2 = ts(Holder2)
ccfvalues =ccf (H1, H2)
ccfvalues
alldata=ts.intersect(H2,H1lag1=ts(lag(Holder1,1)), H1lag2=ts(lag(Holder1,2)), H1lag3 = ts(lag(Holder1,3)),
                     H1lag4=ts(lag(Holder1,4)), H1lag5=ts(lag(Holder1,5)), H1lag6=ts(lag(Holder1,6)), H1lag7=ts(lag(Holder1,7)),
                     H1lag8=ts(lag(Holder1,8)),H2lag1=ts(lag(Holder2,1)),H2lag2=ts(lag(Holder2,2)))
tryit <-  lm(H2~., data = alldata)
summary (tryit)
acf(residuals(tryit))
tryit2  <- lm(H2~H1lag1+H1lag2+H2lag1+H2lag2,data = alldata)
summary (tryit2)

###Arima
Holder1 <- COGgerneration2013_useknn2$W51_LX.152.1.OV
Holder2 <- COGgerneration2013_useknn2$W51_LX.152.2.OV
train1 <- ts(Holder1[1:1200],frequency = 15)
test1 <- ts(Holder1[1201:1260],frequency = 15)
auto.arima(train ,stepwise = F,d = 1,trace = T,  max.p = 10 ,  max.order = 15,
           stationary = T,ic=c("aic"))##ic也可用bic,aicc
fit.arima <- arima(train ,order=c(5,0,0),include.mean=T)
tsdisplay(residuals(fit.arima), lag.max=5, main='residuals')
shapiro.test(fit.arima$residuals) # 常態分布
Box.test(train, lag=5, type="Ljung-Box") #獨立
