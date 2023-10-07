install.packages("forecast")
install.packages("tseries")
install.packages("dplyr")
install.packages("Pandas")
library(forecast)#AUTO-ARIMA
library(tseries) #adf kpss test
library(dplyr)# mutate %>%
data <- read.csv(file="C:/Users/88693/Documents/All Lecture/機器學習/Project/Data/COGgeneration2013.csv",header=TRUE,sep=",")

data1 <- na.omit(data)
c <- cbind(data1$W51_FT.101D.OV,data1$W51_FX.153.OV)
historical.data <- ts(c[1:120],frequency = 15)
compared.data <- ts(c[121:180],frequency = 15)

#資料觀察
ts.form <- ts(historical.data, frequency=15, start=1)
decompose.ts <- decompose(ts.form)
plot(decompose.ts)#每15分鐘

#穩定檢測
adf.test(ts.form) ##p<0.05故推斷此為穩定之ts

#建模
auto.arima(ts.form ,stepwise = F,d = 1,trace = T,stationary = T,ic=c("aic"))##ic也可用bic,aicc
fit <- arima(ts.form ,order=c(1,0,1),include.mean=FALSE)
##order中的三個數c(x1,x2,x3):
#三個數都有=ARIMA
#只有x1,x3=ARMA
#只有x1=AR 
#只有x3=MA

#模型檢查
tsdisplay(residuals(fit), lag.max=5, main='residuals')
shapiro.test(fit$residuals[1:5000]) # 常態分布
Box.test(fit$residuals, lag=10, type="Ljung-Box") #獨立
#非季節性lag=10 季節性lag=period*2

p<-forecast(fit,60,lambda = 1,biasadj=FALSE) #因為沒經過轉換，故lambda = 1。
p
plot(p,xlim=c(1,10))
forecast <- as.data.frame(p)
evaluate <- cbind(forecast,compared.data)
mape <- sum(abs((evaluate$compared.data-evaluate$`Point Forecast`)/evaluate$compared.data))/60412
mape
mean(mape)


library(strucchange)
library(forecast)
library(tseries)
library(dplyr)

#1.找斷點
(break_point <- breakpoints(ts.form ~ 1))
summary(break_point) #找BIC最小

#2. to 穩定: 轉換法、差分&檢定
diff <- diff(ts.form, differences = 1)
adf.test(diff)  #< 穩定

#3. 建模&診斷
fitted.ts <- fitted(break_point, breaks = 3)
auto.arima(時序格式,stepwise = F,d=1,trace = T,xreg = fitted.ts,
               stationary = T,ic=c("aic")) #小好
fit <- Arima(時序格式, order = c(1,1,3), xreg = fitted.ts, 
                 include.mean = F)
tsdisplay(residuals(fit), lag.max=50, main='殘差大全')
shapiro.test(fit$residuals) #殘差>a 常態
Box.test(fit$residuals, lag=10, type="Ljung-Box") 

#4.預測誤差與檢討空間
p<-forecast(fit,3,xreg = fitted.ts[1:3])
p
plot(p)
預測 <- as.data.frame(p)
評估 <- cbind(預測,對照組)
評估 <- 評估 %>% 
  mutate(mae=abs(加權股價-評估$`Point Forecast`)) %>% 
  mutate(mape=abs(加權股價-評估$`Point Forecast`)/加權股價)
mean(評估$mape)
