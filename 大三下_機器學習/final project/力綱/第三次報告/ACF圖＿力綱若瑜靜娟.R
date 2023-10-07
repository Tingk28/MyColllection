setwd("~/Desktop/machinelearning/力綱")
library(forecast)#AUTO-ARIMA
library(tseries) #adf kpss test
library(dplyr)# mutate %>%
library(ggplot2) #作图
library(astsa)
## read data
COGgerneration2013_useknn2 <- read.csv("~/Desktop/machinelearning/力綱/COGgeneration2013_useknn2.csv")
COGgerneration2013_useknn2$time <- COGgerneration2013$time
colnames(COGgerneration2013_useknn2)[1] <- 'time'
COGgerneration2013_useknn2$time<-as.POSIXct(COGgerneration2013_useknn2$time)
##dplR package
COGg_sum <- summary(COGgerneration2013_useknn2)
COGHolder <-subset(COGgerneration2013_useknn2,select=c('time','W51_LX.152.1.OV','W51_LX.152.2.OV'))
plot(COGHolder, plot.type="spag")
##ACF Holder1
Holder1m <- COGgerneration2013_useknn2$W51_LX.152.1.OV
acf(Holder1m,lag.max = 60,xlab = 'lag(min)',main = 'ACF Holder1 level(min)')
Holder1h <- COGgerneration2013_useknn2$W51_LX.152.1.OV[1:264961%%60==1]
acf(Holder1h,lag.max = 24,xlab = 'lag(hr)',main = 'ACF Holder1 level(hr)')
Holder1d <- COGgerneration2013_useknn2$W51_LX.152.1.OV[1:264961%%1440==1]
acf(Holder1d,lag.max = 7,xlab = 'lag(day)',main = 'ACF Holder1 level(day)')

##ACF Holder2
Holder2m <- COGgerneration2013_useknn2$W51_LX.152.2.OV
acf(Holder2m,lag.max = 60,xlab = 'lag(min)',main = 'ACF Holder2 level(min)')
Holder2h <- COGgerneration2013_useknn2$W51_LX.152.2.OV[1:264961%%60==1]
acf(Holder2h,lag.max = 24,xlab = 'lag(hr)',main = 'ACF Holder2 level(hr)')
Holder2d <- COGgerneration2013_useknn2$W51_LX.152.2.OV[1:264961%%1440==1]
acf(Holder2d,lag.max = 7,xlab = 'lag(day)',main = 'ACF Holder2 level(day)')
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
###預估半小時後資料
alldata2=ts.intersect(H2,H1lag30=ts(lag(Holder1,30)), H1lag31=ts(lag(Holder1,31)), H1lag32 = ts(lag(Holder1,32)),
                      H1lag33=ts(lag(Holder1,33)), H1lag34=ts(lag(Holder1,34)), H1lag35=ts(lag(Holder1,35)), H2lag30=ts(lag(Holder2,30)),
                      H2lag31=ts(lag(Holder2,31)),H2lag32=ts(lag(Holder2,32)),H2lag33=ts(lag(Holder2,33)),H2lag34=ts(lag(Holder2,34)),H2lag35=ts(lag(Holder2,35)))
tryit3 <-  lm(H2~., data = alldata2)
summary (tryit3)
acf(tryit3$residuals)


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
