setwd("~/Desktop/machinelearning/力綱")
library(MLmetrics)
library(MASS)
library('car')
library(caret)
library(e1071)
library(class)
library(tseries)
library(forecast)#AUTO-ARIMA
library(dplyr)# mutate %>%
library(ggplot2) #作图
library(astsa)
library("ROCR")
library(glmnet)

###read data
COGgerneration2013 <- read.csv('COGgeneration2013_useknn2.csv')
seasonality_training <- read.csv('seasonality_training.csv')
COGgerneration2013_day_week <- read.csv("COGgerneration2013_day,week.csv")
COGgerneration2013_day_week <-COGgerneration2013_day_week[-44643,]
COGgerneration2013_day_week <-COGgerneration2013_day_week[-89283,]
COGgerneration2013_day_week <-COGgerneration2013_day_week[-132483,]
COGgerneration2013_day_week <-COGgerneration2013_day_week[-177123,]
COGgerneration2013_day_week <-COGgerneration2013_day_week[-220323,]
COGuser_sum <- read.csv('COGusersum')
COGuser_sum <- COGuser_sum$x
Holder1 <- COGgerneration2013$W51_LX.152.1.OV
Holder2 <- COGgerneration2013$W51_LX.152.2.OV
Gener1 <- COGgerneration2013$W51_FT.101D.OV
Gener2 <- COGgerneration2013$W51_FX.153.OV
Press1 <- COGgerneration2013$W51_PT.101.OV
Press2 <- COGgerneration2013$W51_PX.153.OV
Temp1 <- COGgerneration2013$W51_TT.101.OV
Temp2 <- COGgerneration2013$W51_TX.153.OV
df_holder1_day <- COGgerneration2013_day_week$lastday_1
df_holder2_day <- COGgerneration2013_day_week$lastday_2
df_holder1_week <- COGgerneration2013_day_week$lastweek_1
df_holder2_week <- COGgerneration2013_day_week$lastweek_2
H2_sean_day <- seasonality_training$daily_holder2
H2_sean_week <- seasonality_training$weekly_holder2
catorgory_H2_up_down <- ifelse((Holder2-lag(Holder2,1))[-1]>0,'up','down')
catorgory_H2_up_down <-c(NA,catorgory_H2_up_down)
catorgory_H2_normal <- ifelse(sapply(Holder2,function(x) return(x<80 && x>20)),'normal','abnormal')
COGuser_sum <- apply(COGuser2013[,-1],1,function(x) sum(x,na.rm = T))
table(catorgory_H2_normal)

## function lag
lag_t <- function(lag_time){
  alldata=ts.intersect(Holder2=ts(Holder2),
                       H1lag1=ts(lag(Holder1,lag_time)),
                       H1lag2=ts(lag(Holder1,lag_time+1)), 
                       H1lag3=ts(lag(Holder1,lag_time+2)),
                       H1lag4=ts(lag(Holder1,lag_time+3)), 
                       H1lag5=ts(lag(Holder1,lag_time+4)), 
                       H2lag1=ts(lag(Holder2,lag_time)),
                       H2lag2=ts(lag(Holder2,lag_time+1)),
                       H2lag3=ts(lag(Holder2,lag_time+2)),
                       H2lag4=ts(lag(Holder2,lag_time+3)),
                       H2lag5=ts(lag(Holder2,lag_time+4)),
                       Gener1lag=ts(lag(Gener1,lag_time)),
                       Gener1lag2=ts(lag(Gener1,lag_time+1)),
                       Gener1lag3=ts(lag(Gener1,lag_time+2)),
                       Gener1lag4=ts(lag(Gener1,lag_time+3)),
                       Gener1lag5=ts(lag(Gener1,lag_time+4)),
                       Gener2lag1=ts(lag(Gener2,lag_time)),
                       Gener2lag2=ts(lag(Gener2,lag_time+1)),
                       Gener2lag3=ts(lag(Gener2,lag_time+2)),
                       Gener2lag4=ts(lag(Gener2,lag_time+3)),
                       Gener2lag5=ts(lag(Gener2,lag_time+4)),
                       Press1lag1=ts(lag(Press1,lag_time)),
                       Press1lag2=ts(lag(Press1,lag_time+1)),
                       Press1lag3=ts(lag(Press1,lag_time+2)),
                       Press1lag4=ts(lag(Press1,lag_time+3)),
                       Press1lag5=ts(lag(Press1,lag_time+4)),
                       Press2lag1=ts(lag(Press2,lag_time)),
                       Press2lag2=ts(lag(Press2,lag_time+1)),
                       Press2lag3=ts(lag(Press2,lag_time+2)),
                       Press2lag4=ts(lag(Press2,lag_time+3)),
                       Press2lag5=ts(lag(Press2,lag_time+4)),
                       Temp1lag1 =ts(lag(Temp1,lag_time)),
                       Temp1lag2 =ts(lag(Temp1,lag_time+1)),
                       Temp1lag3 =ts(lag(Temp1,lag_time+2)),
                       Temp1lag4 =ts(lag(Temp1,lag_time+3)),
                       Temp1lag5 =ts(lag(Temp1,lag_time+4)),
                       Temp2lag1 =ts(lag(Temp2,lag_time)),
                       Temp2lag2 =ts(lag(Temp2,lag_time+1)),
                       Temp2lag3 =ts(lag(Temp2,lag_time+2)),
                       Temp2lag4 =ts(lag(Temp2,lag_time+3)),
                       Temp2lag5 =ts(lag(Temp2,lag_time+4)),
                       df_holder2_day = ts(df_holder2_day),
                       df_holder2_week = ts(df_holder2_week),
                       H2_sean_day = ts(H2_sean_day),
                       H2_sean_week = ts(H2_sean_week),
                       COGuser_sumlag1 = ts(lag(COGuser_sum,lag_time)),
                       COGuser_sumlag2 = ts(lag(COGuser_sum,lag_time+1)),
                       COGuser_sumlag3 = ts(lag(COGuser_sum,lag_time+2)),
                       COGuser_sumlag4 = ts(lag(COGuser_sum,lag_time+3)),
                       COGuser_sumlag5 = ts(lag(COGuser_sum,lag_time+4))
  )
  return(alldata)
}
#logistic
##after 1 min logistic
###up_down
lag_1 <- lag_t(1)
train <- data.frame(lag_1[1:220321,-1],catorgory_H2_up_down=catorgory_H2_up_down[1:220321])
test <- data.frame(lag_1[220322:246961,-1],catorgory_H2_up_down=catorgory_H2_up_down[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_up_down)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"up","down")
confusionMatrix(factor(train$catorgory_H2_up_down),factor(predict_logistic1_train))
predict_logistic1_test <- predict(logistic1,test,type = "response")
predict_logistic1_test_c <- ifelse(predict_logistic1_test>0.5,"up","down")
confusionMatrix(factor(test$catorgory_H2_up_down),factor(predict_logistic1_test_c))
pred <- prediction(predict_logistic1_test, test$catorgory_H2_up_down)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
auc <- performance(pred, "auc")
plot(perf, col = rainbow(7), main = "ROC curve for predict 1 min later data", xlab = "Specificity", ylab = "Sensitivity")
abline(0, 1)
text(0.7, 0.4 ,paste('auc is ',as.character(round(auc@y.values[[1]],4))))
### nomarl abnormal
train <- data.frame(lag_1[1:220321,-1],catorgory_H2_normal=catorgory_H2_normal[1:220321])
test <- data.frame(lag_1[220322:246961,-1],catorgory_H2_normal=catorgory_H2_normal[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_normal)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"normal","abnormal")
confusionMatrix(factor(train$catorgory_H2_normal),factor(predict_logistic1_train))
predict_logistic1_test <- predict(logistic1,test,type = "response")
predict_logistic1_test <- ifelse(predict_logistic1_test>0.5,"normal","abnormal")
confusionMatrix(factor(test$catorgory_H2_normal),factor(predict_logistic1_test))

##after 5 min logistic
###up_down
lag_5 <- lag_t(5)
train <- data.frame(lag_5[1:220321,-1],catorgory_H2_up_down=catorgory_H2_up_down[1:220321])
test <- data.frame(lag_5[220322:246961,-1],catorgory_H2_up_down=catorgory_H2_up_down[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_up_down)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"up","down")
confusionMatrix(factor(train$catorgory_H2_up_down),factor(predict_logistic1_train))
predict_logistic1_test <- predict(logistic1,test,type = "response")
predict_logistic1_test_c <- ifelse(predict_logistic1_test>0.5,"up","down")
confusionMatrix(factor(test$catorgory_H2_up_down),factor(predict_logistic1_test_c))
pred <- prediction(predict_logistic1_test, test$catorgory_H2_up_down)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
auc <- performance(pred, "auc")
plot(perf, col = rainbow(7), main = "ROC curve for predict 5 min later data", xlab = "Specificity", ylab = "Sensitivity")
abline(0, 1)
text(0.7, 0.4 ,paste('auc is ',as.character(round(auc@y.values[[1]],4))))

### nomarl abnormal
train <- data.frame(lag_5[1:220321,-1],catorgory_H2_normal=catorgory_H2_normal[1:220321])
test <- data.frame(lag_5[220322:246961,-1],catorgory_H2_normal=catorgory_H2_normal[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_normal)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"normal","abnormal")
confusionMatrix(factor(train$catorgory_H2_normal),factor(predict_logistic1_train))

##after 10 min logitstic
###up_down
lag_10 <- lag_t(10)
train <- data.frame(lag_10[1:220321,-1],catorgory_H2_up_down=catorgory_H2_up_down[1:220321])
test <- data.frame(lag_10[220322:246961,-1],catorgory_H2_up_down=catorgory_H2_up_down[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_up_down)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"up","down")
confusionMatrix(factor(train$catorgory_H2_up_down),factor(predict_logistic1_train))
predict_logistic1_test <- predict(logistic1,test,type = "response")
predict_logistic1_test_c <- ifelse(predict_logistic1_test>0.5,"up","down")
confusionMatrix(factor(test$catorgory_H2_up_down),factor(predict_logistic1_test_c))
pred <- prediction(predict_logistic1_test, test$catorgory_H2_up_down)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
auc <- performance(pred, "auc")
plot(perf, col = rainbow(7), main = "ROC curve for predict 10 min later data", xlab = "Specificity", ylab = "Sensitivity")
abline(0, 1)
text(0.7, 0.4 ,paste('auc is ',as.character(round(auc@y.values[[1]],4))))

##after 30 min logistic
###up_down
lag_30 <- lag_t(30)
train <- data.frame(lag_30[1:220321,-1],catorgory_H2_up_down=catorgory_H2_up_down[1:220321])
test <- data.frame(lag_30[220322:246961,-1],catorgory_H2_up_down=catorgory_H2_up_down[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_up_down)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"up","down")
confusionMatrix(factor(train$catorgory_H2_up_down),factor(predict_logistic1_train))
predict_logistic1_test <- predict(logistic1,test,type = "response")
predict_logistic1_test_c <- ifelse(predict_logistic1_test>0.5,"up","down")
confusionMatrix(factor(test$catorgory_H2_up_down),factor(predict_logistic1_test_c))
pred <- prediction(predict_logistic1_test, test$catorgory_H2_up_down)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
auc <- performance(pred, "auc")
plot(perf, col = rainbow(7), main = "ROC curve for predict 30 min later data", xlab = "Specificity", ylab = "Sensitivity")
abline(0, 1)
text(0.7, 0.4 ,paste('auc is ',as.character(round(auc@y.values[[1]],4))))
### nomarl abnormal
train <- data.frame(lag_30[1:220321,-1],catorgory_H2_normal=catorgory_H2_normal[1:220321])
test <- data.frame(lag_30[220322:246961,-1],catorgory_H2_normal=catorgory_H2_normal[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_normal)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"normal","abnormal")
confusionMatrix(factor(train$catorgory_H2_normal),factor(predict_logistic1_train))

##after 60 min logistic
###up_down
lag_60 <- lag_t(60)
train <- data.frame(lag_60[1:220321,-1],catorgory_H2_up_down=catorgory_H2_up_down[1:220321])
test <- data.frame(lag_60[220322:246961,-1],catorgory_H2_up_down=catorgory_H2_up_down[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_up_down)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"up","down")
confusionMatrix(factor(train$catorgory_H2_up_down),factor(predict_logistic1_train))
predict_logistic1_test <- predict(logistic1,test,type = "response")
predict_logistic1_test_c <- ifelse(predict_logistic1_test>0.5,"up","down")
confusionMatrix(factor(test$catorgory_H2_up_down),factor(predict_logistic1_test_c))
pred <- prediction(predict_logistic1_test, test$catorgory_H2_up_down)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
auc <- performance(pred, "auc")
plot(perf, col = rainbow(7), main = "ROC curve for predict 1 hr later data", xlab = "Specificity", ylab = "Sensitivity")
abline(0, 1)
text(0.7, 0.4 ,paste('auc is ',as.character(round(auc@y.values[[1]],4))))

##after 120 min logistic
###up_down
lag_120 <- lag_t(120)
train <- data.frame(lag_120[1:220321,-1],catorgory_H2_up_down=catorgory_H2_up_down[1:220321])
test <- data.frame(lag_120[220322:246961,-1],catorgory_H2_up_down=catorgory_H2_up_down[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_up_down)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"up","down")
confusionMatrix(factor(train$catorgory_H2_up_down),factor(predict_logistic1_train))
predict_logistic1_test <- predict(logistic1,test,type = "response")
predict_logistic1_test_c <- ifelse(predict_logistic1_test>0.5,"up","down")
confusionMatrix(factor(test$catorgory_H2_up_down),factor(predict_logistic1_test_c))
pred <- prediction(predict_logistic1_test, test$catorgory_H2_up_down)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
auc <- performance(pred, "auc")
plot(perf, col = rainbow(7), main = "ROC curve for predict 2 hr later data", xlab = "Specificity", ylab = "Sensitivity")
abline(0, 1)
text(0.7, 0.4 ,paste('auc is ',as.character(round(auc@y.values[[1]],4))))

##after 180 min logistic
###up_down
lag_180 <- lag_t(180)
train <- data.frame(lag_180[1:220321,-1],catorgory_H2_up_down=catorgory_H2_up_down[1:220321])
test <- data.frame(lag_180[220322:246961,-1],catorgory_H2_up_down=catorgory_H2_up_down[220322:246961])
logistic1 <- glm(as.factor(catorgory_H2_up_down)~.,train,family = 'binomial')
predict_logistic1_train <- predict(logistic1,train,type = "response")
predict_logistic1_train <- ifelse(predict_logistic1_train>0.5,"up","down")
confusionMatrix(factor(train$catorgory_H2_up_down),factor(predict_logistic1_train))
predict_logistic1_test <- predict(logistic1,test,type = "response")
predict_logistic1_test_c <- ifelse(predict_logistic1_test>0.5,"up","down")
confusionMatrix(factor(test$catorgory_H2_up_down),factor(predict_logistic1_test_c))
pred <- prediction(predict_logistic1_test, test$catorgory_H2_up_down)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
auc <- performance(pred, "auc")
plot(perf, col = rainbow(7), main = "ROC curve for predict 3 hr later data", xlab = "Specificity", ylab = "Sensitivity")
abline(0, 1)
text(0.7, 0.4 ,paste('auc is ',as.character(round(auc@y.values[[1]],4))))



#OLS
##after 1 min OLS
lag_1 <- lag_t(1)
train <- as.data.frame(lag_1[1:220321,])
test <- as.data.frame(lag_1[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##after 5 min lm
lag_5 <- lag_t(5)
train <- as.data.frame(lag_5[1:220321,])
test <- as.data.frame(lag_5[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##after 10 min lm
lag_10 <- lag_t(10)
train <- as.data.frame(lag_10[1:220321,])
test <- as.data.frame(lag_10[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##after 30 min
lag_30 <- lag_t(30)
train <- as.data.frame(lag_30[1:220321,])
test <- as.data.frame(lag_30[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##after 60 min
lag_60 <- lag_t(60)
train <- as.data.frame(lag_60[1:220321,])
test <- as.data.frame(lag_60[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##after 120 min
lag_120 <- lag_t(120)
train <- as.data.frame(lag_120[1:220321,])
test <- as.data.frame(lag_120[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##after 180 min
lag_180 <- lag_t(180)
train <- as.data.frame(lag_180[1:220321,])
test <- as.data.frame(lag_180[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)

#Lasso
grid <- 10^seq(10,-2,length=100)
##after 1 min Lasso
lag_1 <- lag_t(1)
lag_1 <- as.data.frame(lag_1)
train <- c(1:210240)
test <- c(210241:254880)
x <- model.matrix(Holder2~.,lag_1)[,-1]
y <- as.vector(lag_1[,1])
lasso_model <- glmnet(x[train,] , y[train] , alpha = 1,lambda = grid)
cv.out <- cv.glmnet(x[train,] , y[train] , alpha = 1)
bestlam <- cv.out$lambda.min
lasso.pred <- predict(lasso_model,s=bestlam,newx = x[test,])
MAPE(lasso.pred,y[test])
lasso_cof <- predict(lasso_model,type = "coefficients",s=bestlam)
lasso_cof

##after 5 min lasso
lag_5 <- lag_t(5)
lag_5 <- as.data.frame(lag_5)
train <- c(1:210240)
test <- c(210241:254880)
x <- model.matrix(Holder2~.,lag_5)[,-1]
y <- as.vector(lag_5[,1])
lasso_model <- glmnet(x[train,] , y[train] , alpha = 1,lambda = grid)
cv.out <- cv.glmnet(x[train,] , y[train] , alpha = 1)
bestlam <- cv.out$lambda.min
lasso.pred <- predict(lasso_model,s=bestlam,newx = x[test,])
MAPE(lasso.pred,y[test])
lasso_cof <- predict(lasso_model,type = "coefficients",s=bestlam)
lasso_cof

##after 10 min lasso
lag_10 <- lag_t(10)
lag_10 <- as.data.frame(lag_10)
train <- c(1:210240)
test <- c(210241:254880)
x <- model.matrix(Holder2~.,lag_10)[,-1]
y <- as.vector(lag_10[,1])
lasso_model <- glmnet(x[train,] , y[train] , alpha = 1,lambda = grid)
cv.out <- cv.glmnet(x[train,] , y[train] , alpha = 1)
bestlam <- cv.out$lambda.min
lasso.pred <- predict(lasso_model,s=bestlam,newx = x[test,])
MAPE(lasso.pred,y[test])
lasso_cof <- predict(lasso_model,type = "coefficients",s=bestlam)
lasso_cof

##after 30 min lasso
lag_30 <- lag_t(30)
lag_30 <- as.data.frame(lag_30)
train <- c(1:210240)
test <- c(210241:254880)
x <- model.matrix(Holder2~.,lag_30)[,-1]
y <- as.vector(lag_30[,1])
lasso_model <- glmnet(x[train,] , y[train] , alpha = 1,lambda = grid)
cv.out <- cv.glmnet(x[train,] , y[train] , alpha = 1)
bestlam <- cv.out$lambda.min
lasso.pred <- predict(lasso_model,s=bestlam,newx = x[test,])
MAPE(lasso.pred,y[test])
lasso_cof <- predict(lasso_model,type = "coefficients",s=bestlam)
lasso_cof
##after 60 min lasso
lag_60 <- lag_t(60)
lag_60 <- as.data.frame(lag_60)
train <- c(1:210240)
test <- c(210241:254880)
x <- model.matrix(Holder2~.,lag_60)[,-1]
y <- as.vector(lag_60[,1])
lasso_model <- glmnet(x[train,] , y[train] , alpha = 1,lambda = grid)
cv.out <- cv.glmnet(x[train,] , y[train] , alpha = 1)
bestlam <- cv.out$lambda.min
lasso.pred <- predict(lasso_model,s=bestlam,newx = x[test,])
MAPE(lasso.pred,y[test])
lasso_cof <- predict(lasso_model,type = "coefficients",s=bestlam)
lasso_cof
##after 120 min lasso
lag_120 <- lag_t(120)
lag_120 <- as.data.frame(lag_120)
train <- c(1:210240)
test <- c(210241:254880)
x <- model.matrix(Holder2~.,lag_120)[,-1]
y <- as.vector(lag_120[,1])
lasso_model <- glmnet(x[train,] , y[train] , alpha = 1,lambda = grid)
cv.out <- cv.glmnet(x[train,] , y[train] , alpha = 1)
bestlam <- cv.out$lambda.min
lasso.pred <- predict(lasso_model,s=bestlam,newx = x[test,])
MAPE(lasso.pred,y[test])
lasso_cof <- predict(lasso_model,type = "coefficients",s=bestlam)
lasso_cof
##after 180 min lasso
lag_180 <- lag_t(180)
lag_180 <- as.data.frame(lag_180)
train <- c(1:210240)
test <- c(210241:254880)
x <- model.matrix(Holder2~.,lag_180)[,-1]
y <- as.vector(lag_180[,1])
lasso_model <- glmnet(x[train,] , y[train] , alpha = 1,lambda = grid)
cv.out <- cv.glmnet(x[train,] , y[train] , alpha = 1)
bestlam <- cv.out$lambda.min
lasso.pred <- predict(lasso_model,s=bestlam,newx = x[test,])
MAPE(lasso.pred,y[test])
lasso_cof <- predict(lasso_model,type = "coefficients",s=bestlam)
lasso_cof


#LDA up_down
lag_1 <- lag_t(1)
train <- data.frame(lag_1[1:220321,-1],catorgory_H2_up_down=catorgory_H2_up_down[1:220321])
test <- data.frame(lag_1[220322:246961,-1],catorgory_H2_up_down=catorgory_H2_up_down[220322:246961])
lda_model <-  lda(catorgory_H2_up_down~ ., data = train[complete.cases(train),])
lda_pred<-predict(lda_model,test)
names(lda_pred)
table(lda_pred$class,test$catorgory_H2_up_down)
mean(lda_pred$class == test$catorgory_H2_up_down)
confusionMatrix(factor(test$catorgory_H2_up_down),factor(lda_pred$class))


###try svm
datasvm <- data.frame(Gener1,Gener2,Press1,Press2,Temp1,Temp2,df_holder2_day,df_holder2_week,catorgory_H2_normal=as.factor(catorgory_H2_normal))
train <- datasvm[1:220321,]
test <- datasvm[220322:246961,]
tune.out <- tune (svm , catorgory_H2_normal ~ ., data = train[complete.cases(train),],
                  kernel = "radial",
                  ranges = list (
                    cost = c(0.1, 1),
                    gamma = c(0.5, 1)
                  )
)
