cog <- read.csv("C:/Users/88693/Documents/All Lecture/ML/Project/Data/COGvariables.csv")

install.packages("forecast")
install.packages("tseries")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("lubridate")
library(forecast)
library(tseries)
library(dplyr)
library(ggplot2)
library(lubridate)

MAPE <- function(true, pred){
  dif <- abs(pred - true)
  return(round(mean(dif/true)*100,3))
}

#search the best model with different training point and 1 day before  
train <- ts(cog$holder2_V0[(235432-1439):235432])
test <- cog$holder2_V0[235432+1:(235432+2880)]
fit <- auto.arima(train ,stepwise = F ,trace = T,stationary = T,
                                          ic = c("aic"), max.p = 30, max.order = 40,
                                          seasonal = T )

#fit the best model to ARIMA
#ARIMA function: X[t] = a[1]X[t-1] + … + a[p]X[t-p] + e[t] + b[1]e[t-1] + … + b[q]e[t-q]
fit_arima <- arima(train, order = c(21,0,5), include.mean = TRUE)

#forecast the V0 over next 100 minutes
test_result <- forecast(fit_arima , 100)

#calculate the mape
mape_result <- data.frame(
  data = rep(NA , 5),
  best_model = rep(NA , 5),
  mape = rep(NA , 5)
)

mape_result[,1] <- c(235432,228645,230674,247682,263522)
mape_result[,2] <- c("(21,0,5)" , "(19,0,1)" , "(21,0,3)" , "(30,0,0)" , "(0,0,5)")

mape_result[1,3] <- MAPE(cog$holder2_V0[235433:(235433+99)] , test_result$mean[1:100])
mape_result[2,3] <- MAPE(cog$holder2_V0[228646:(228646+99)] , test_result$mean[1:100])
mape_result[3,3] <- MAPE(cog$holder2_V0[230675:(230675+99)] , test_result$mean[1:100])
mape_result[4,3] <- MAPE(cog$holder2_V0[247683:(247683+99)] , test_result$mean[1:100])
mape_result[5,3] <- MAPE(cog$holder2_V0[263523:(263523+99)] , test_result$mean[1:100])

mape_result[1,3] <- 4.151 
mape_result[2,3] <- 10.733
mape_result[3,3] <- 16.870
mape_result[4,3] <- 9.384
mape_result[5,3] <- 65.796

#training #best model # mape_result
#235432 #(21,0,5) #4.151 
#228645 #(19,0,1) #10.733
#230674 #(21,0,3) #16.870
#247682 #(30,0,0) #9.384
#263522 #(0,0,5) #65.796


#calculate the mape for each training point with p = 1~21 and q = 0~5
mape_result_1 <- matrix(nrow = 21, ncol = 6)
mape_result_2 <- matrix(nrow = 21, ncol = 6)
mape_result_3 <- matrix(nrow = 21, ncol = 6)
mape_result_4 <- matrix(nrow = 21, ncol = 6)
mape_result_5 <- matrix(nrow = 21, ncol = 6)

##mape_result_1
#fit the best model to ARIMA
train <- ts(cog$holder2_V0[(235432-1439):235432])
test <- cog$holder2_V0[235432+1:(235432+2880)]
fit_arima <- arima(train, order = c(21,0,5), include.mean = TRUE)

#forecast the V0 over next 100 minutes
test_result <- forecast(fit_arima , 100)

#calculate the mape_result_1
for (i in 1:21) {
  fit_arima <- arima(train , order = c(i,0,5) , include.mean = TRUE)
  test_result <- forecast(fit_arima , 100)
  mape_result_1[i,6] <- MAPE(cog$holder2_V0[235433:(235433+99)] , test_result$mean[1:100])
}


##mape_result_2
#fit the best model to ARIMA
train <- ts(cog$holder2_V0[(228645-1439):228645])
test <- cog$holder2_V0[228645+1:(228645+2880)]
fit_arima <- arima(train, order = c(19,0,1), include.mean = TRUE)

#forecast the V0 over next 100 minutes
test_result <- forecast(fit_arima , 100)

#calculate the mape_result_2
for (i in 1:21) {
  fit_arima <- arima(train , order = c(i,0,5) , include.mean = TRUE)
  test_result <- forecast(fit_arima , 100)
  mape_result_2[i,6] <- MAPE(cog$holder2_V0[228646:(228646+99)] , test_result$mean[1:100])
}

##mape_result_3
#fit the best model to ARIMA
train <- ts(cog$holder2_V0[(230674-1439):230674])
test <- cog$holder2_V0[230674+1:(230674+2880)]
fit_arima <- arima(train, order = c(21,0,3), include.mean = TRUE)

#forecast the V0 over next 100 minutes
test_result <- forecast(fit_arima , 100)

#calculate the mape_result_3
for (i in 1:21) {
  fit_arima <- arima(train , order = c(i,0,5) , include.mean = TRUE)
  test_result <- forecast(fit_arima , 100)
  mape_result_3[i,6] <- MAPE(cog$holder2_V0[230675:(230675+99)] , test_result$mean[1:100])
}

##mape_result_4
#fit the best model to ARIMA
train <- ts(cog$holder2_V0[(247682-1439):247682])
test <- cog$holder2_V0[247682+1:(247682+2880)]
fit_arima <- arima(train, order = c(30,0,0), include.mean = TRUE)

#forecast the V0 over next 100 minutes
test_result <- forecast(fit_arima , 100)

#calculate the mape_result_4
for (i in 1:21) {
  fit_arima <- arima(train , order = c(i,0,4) , include.mean = TRUE)
  test_result <- forecast(fit_arima , 100)
  mape_result_4[i,5] <- MAPE(cog$holder2_V0[247683:(247683+99)] , test_result$mean[1:100])
}

##mape_result_5
#fit the best model to ARIMA
train <- ts(cog$holder2_V0[(263522-1439):263522])
test <- cog$holder2_V0[263522+1:(263522+2880)]
fit_arima <- arima(train, order = c(0,0,5), include.mean = TRUE)

#forecast the V0 over next 100 minutes
test_result <- forecast(fit_arima , 100)

#calculate the mape_result_5
for (i in 1:21) {
  fit_arima <- arima(train , order = c(i,0,5) , include.mean = TRUE)
  test_result <- forecast(fit_arima , 100)
  mape_result_5[i,6] <- MAPE(cog$holder2_V0[263523:(263523+99)] , test_result$mean[1:100])
}



#rename the rows and the cols
dimnames(mape_result_1) <- list(c("lag=1", "lag=2","lag=3","lag=4","lag=5","lag=6","lag=7","lag=8","lag=9","lag=10","lag=11","lag=12","lag=13","lag=14","lag=15","lag=16","lag=17","lag=18","lag=19","lag=20","lag=21"),
                        c("q=0", "q=1", "q=2","q=3","q=4","q=5"))
dimnames(mape_result_2) <- list(c("lag=1", "lag=2","lag=3","lag=4","lag=5","lag=6","lag=7","lag=8","lag=9","lag=10","lag=11","lag=12","lag=13","lag=14","lag=15","lag=16","lag=17","lag=18","lag=19","lag=20","lag=21"),
                                c("q=0", "q=1", "q=2","q=3","q=4","q=5"))
dimnames(mape_result_3) <- list(c("lag=1", "lag=2","lag=3","lag=4","lag=5","lag=6","lag=7","lag=8","lag=9","lag=10","lag=11","lag=12","lag=13","lag=14","lag=15","lag=16","lag=17","lag=18","lag=19","lag=20","lag=21"),
                                c("q=0", "q=1", "q=2","q=3","q=4","q=5"))
dimnames(mape_result_4) <- list(c("lag=1", "lag=2","lag=3","lag=4","lag=5","lag=6","lag=7","lag=8","lag=9","lag=10","lag=11","lag=12","lag=13","lag=14","lag=15","lag=16","lag=17","lag=18","lag=19","lag=20","lag=21"),
                                c("q=0", "q=1", "q=2","q=3","q=4","q=5"))
dimnames(mape_result_5) <- list(c("lag=1", "lag=2","lag=3","lag=4","lag=5","lag=6","lag=7","lag=8","lag=9","lag=10","lag=11","lag=12","lag=13","lag=14","lag=15","lag=16","lag=17","lag=18","lag=19","lag=20","lag=21"),
                                c("q=0", "q=1", "q=2","q=3","q=4","q=5"))

write.csv(mape_result,"C:/Users/88693/Documents/All Lecture/ML/Project//mape_result.csv")
write.csv(mape_result_1,"C:/Users/88693/Documents/All Lecture/ML/Project//mape_result_1.csv")
write.csv(mape_result_2,"C:/Users/88693/Documents/All Lecture/ML/Project//mape_result_2.csv")
write.csv(mape_result_3,"C:/Users/88693/Documents/All Lecture/ML/Project//mape_result_3.csv")
write.csv(mape_result_4,"C:/Users/88693/Documents/All Lecture/ML/Project//mape_result_4.csv")
write.csv(mape_result_5,"C:/Users/88693/Documents/All Lecture/ML/Project//mape_result_5.csv")

train <- ts(cog$holder2_V0[(235432-1439):235432])
test <- cog$holder2_V0[235432+1:(235432+2880)]

fit_arima_lag21q0 <-  arima(train , order = c(21,0,0) , include.mean = TRUE)
test_result_lag21q0 <-  forecast(fit_arima_lag21q0 , 100)
test_result_lag21q0 <- data.frame(
    test_result = test_result_lag21q0$mean
)

fit_arima_lag21q2 <-  arima(train , order = c(21,0,2) , include.mean = TRUE)
test_result_lag21q2 <-  forecast(fit_arima_lag21q2 , 100)
test_result_lag21q2 <- data.frame(
  test_result = test_result_lag21q2$mean
)    

fit_arima_lag21q3 <-  arima(train , order = c(21,0,3) , include.mean = TRUE)
test_result_lag21q3 <-  forecast(fit_arima_lag21q3 , 100)
test_result_lag21q3 <- data.frame(
  test_result = test_result_lag21q3$mean
)   

fit_arima_lag21q4 <-  arima(train , order = c(21,0,4) , include.mean = TRUE)
test_result_lag21q4 <-  forecast(fit_arima_lag21q4 , 100)
test_result_lag21q4 <- data.frame(
  test_result = test_result_lag21q4$mean
)  

fit_arima_lag21q5 <-  arima(train , order = c(21,0,5) , include.mean = TRUE)
test_result_lag21q5 <-  forecast(fit_arima_lag21q5 , 100)
test_result_lag21q5 <- data.frame(
  test_result = test_result_lag21q5$mean
)   

test_result_data1_lag21 <- cbind.data.frame(test_result_lag21q0,test_result_lag21q2,
                 test_result_lag21q3,test_result_lag21q4,test_result_lag21q5)

names(test_result_data1_lag21)[1] <- "q=0"
names(test_result_data1_lag21)[2] <- "q=2"
names(test_result_data1_lag21)[3] <- "q=3"
names(test_result_data1_lag21)[4] <- "q=4"
names(test_result_data1_lag21)[5] <- "q=5"

write.csv(test_result_data1_lag21,"C:/Users/88693/Documents/All Lecture/ML/Project//test_result_data1_lag21.csv")




#1 #3,0,0
#2 #9,0,0
#3 #3,0,0
#4 #6,0,2
#5 #3,0,4

#1 #3,0,0
train <- ts(cog$holder2_V0[(235432-1439):235432])
fit_arima_1 <-  arima(train , order = c(21,0,5) , include.mean = TRUE)
test_result_1 <-  forecast(fit_arima_1 , 100)
test_result_1 <- data.frame(
  test_result = test_result_1$mean
)  

#3 #3,0,0
train <- ts(cog$holder2_V0[(230674-1439):230674])
fit_arima_3 <-  arima(train , order = c(21,0,3) , include.mean = TRUE)
test_result_3 <-  forecast(fit_arima_3 , 100)
test_result_3 <- data.frame(
  test_result = test_result_3$mean
)  


#cbind each test_result
test_result_final <- cbind.data.frame(test_result_1,
                                      test_result_3)


names(test_result_final)[1] <- "235432"
names(test_result_final)[3] <- "230674"


write.csv(test_result_final,"C:/Users/88693/Documents/All Lecture/ML/Project//test_result_final.csv")


#1 #3,0,0
train <- ts(cog$holder2_V0[(235432-1439):235432])
fit_arima_1 <-  arima(train , order = c(3,0,0) , include.mean = TRUE)
test_result_1 <-  forecast(fit_arima_1 , 30)
test_result_1 <- data.frame(
  test_result = test_result_1$mean
)  

#3 #3,0,0
train <- ts(cog$holder2_V0[(230674-1439):230674])
fit_arima_3 <-  arima(train , order = c(3,0,0) , include.mean = TRUE)
test_result_3 <-  forecast(fit_arima_3 , 30)
test_result_3 <- data.frame(
  test_result = test_result_3$mean
)

test_result_final_30 <- cbind.data.frame(test_result_1,
                                      test_result_3)


names(test_result_final_30)[1] <- "235432"
names(test_result_final_30)[3] <- "230674"

write.csv(test_result_final_30,"C:/Users/88693/Documents/All Lecture/ML/Project//test_result_final_30.csv")

#1 #3,0,0
train <- ts(cog$holder2_V0[(235432-1439):235432])
fit_arima_1 <-  arima(train , order = c(3,0,0) , include.mean = TRUE)
test_result_1 <-  forecast(fit_arima_1 , 5)
test_result_1 <- data.frame(
  test_result = test_result_1$mean
)  

#3 #3,0,0
train <- ts(cog$holder2_V0[(230674-1439):230674])
fit_arima_3 <-  arima(train , order = c(3,0,0) , include.mean = TRUE)
test_result_3 <-  forecast(fit_arima_3 , 5)
test_result_3 <- data.frame(
  test_result = test_result_3$mean
)

test_result_final_5 <- cbind.data.frame(test_result_1,
                                         test_result_3)


names(test_result_final_5)[1] <- "2013/12/11 11:50"
names(test_result_final_5)[3] <- "2013/12/8 04:32"

write.csv(test_result_final_5,"C:/Users/88693/Documents/All Lecture/ML/Project//test_result_final_5.csv")

#1 #3,0,0
train <- ts(cog$holder2_V0[(235432-1439):235432])
fit_arima_1 <-  arima(train , order = c(3,0,0) , include.mean = TRUE)
test_result_1 <-  forecast(fit_arima_1 , 10)
test_result_1 <- data.frame(
  test_result = test_result_1$mean
)  

#3 #3,0,0
train <- ts(cog$holder2_V0[(230674-1439):230674])
fit_arima_3 <-  arima(train , order = c(3,0,0) , include.mean = TRUE)
test_result_3 <-  forecast(fit_arima_3 , 10)
test_result_3 <- data.frame(
  test_result = test_result_3$mean
)

test_result_final_10 <- cbind.data.frame(test_result_1,
                                        test_result_3)


names(test_result_final_10)[1] <- "2013/12/11 11:50"
names(test_result_final_10)[2] <- "2013/12/8 04:32"

write.csv(test_result_final_10,"C:/Users/88693/Documents/All Lecture/ML/Project//test_result_final_10.csv")

#MAPE FOR 5 MIN
train <- ts(cog$holder2_V0[(235432-1439):235432])
fit_arima_1 <-  arima(train , order = c(21,0,5) , include.mean = TRUE)
test_result_1 <-  forecast(fit_arima_1 , 5)
test_result_1 <- data.frame(
  test_result = test_result_1$mean
)  

mape_result_1 <- MAPE(cog$holder2_V0[235433:(235433+4)] , test_result$mean[1:5])
mape_result_1

train <- ts(cog$holder2_V0[(230674-1439):230674])
fit_arima_3 <-  arima(train , order = c(21,0,3) , include.mean = TRUE)
test_result_3 <-  forecast(fit_arima_3 , 5)
test_result_3 <- data.frame(
  test_result = test_result_3$mean
)
mape_result_3 <- MAPE(cog$holder2_V0[230675:(230675+4)] , test_result$mean[1:5])
mape_result_3

#MAPE FOR 10 MIN
train <- ts(cog$holder2_V0[(235432-1439):235432])
fit_arima_1 <-  arima(train , order = c(21,0,5) , include.mean = TRUE)
test_result_1 <-  forecast(fit_arima_1 , 10)
test_result_1 <- data.frame(
  test_result = test_result_1$mean
)  

mape_result_1 <- MAPE(cog$holder2_V0[235433:(235433+9)] , test_result$mean[1:10])
mape_result_1

train <- ts(cog$holder2_V0[(230674-1439):230674])
fit_arima_3 <-  arima(train , order = c(21,0,3) , include.mean = TRUE)
test_result_3 <-  forecast(fit_arima_3 , 10)
test_result_3 <- data.frame(
  test_result = test_result_3$mean
)
mape_result_3 <- MAPE(cog$holder2_V0[230675:(230675+9)] , test_result$mean[1:10])
mape_result_3

#MAPE FOR 30 MIN
train <- ts(cog$holder2_V0[(235432-1439):235432])
fit_arima_1 <-  arima(train , order = c(21,0,5) , include.mean = TRUE)
test_result_1 <-  forecast(fit_arima_1 , 30)
test_result_1 <- data.frame(
  test_result = test_result_1$mean
)  

mape_result_1 <- MAPE(cog$holder2_V0[235433:(235433+29)] , test_result$mean[1:30])
mape_result_1

train <- ts(cog$holder2_V0[(230674-1439):230674])
fit_arima_3 <-  arima(train , order = c(21,0,3) , include.mean = TRUE)
test_result_3 <-  forecast(fit_arima_3 , 30)
test_result_3 <- data.frame(
  test_result = test_result_3$mean
)
mape_result_3 <- MAPE(cog$holder2_V0[230675:(230675+29)] , test_result$mean[1:30])
mape_result_3

#MAPE FOR 100 MIN
train <- ts(cog$holder2_V0[(235432-1439):235432])
fit_arima_1 <-  arima(train , order = c(21,0,5) , include.mean = TRUE)
test_result_1 <-  forecast(fit_arima_1 , 100)
test_result_1 <- data.frame(
  test_result = test_result_1$mean
)  

mape_result_1 <- MAPE(cog$holder2_V0[235433:(235433+99)] , test_result$mean[1:100])
mape_result_1

train <- ts(cog$holder2_V0[(230674-1439):230674])
fit_arima_3 <-  arima(train , order = c(21,0,3) , include.mean = TRUE)
test_result_3 <-  forecast(fit_arima_3 , 100)
test_result_3 <- data.frame(
  test_result = test_result_3$mean
)
mape_result_3 <- MAPE(cog$holder2_V0[230675:(230675+99)] , test_result$mean[1:100])
mape_result_3


