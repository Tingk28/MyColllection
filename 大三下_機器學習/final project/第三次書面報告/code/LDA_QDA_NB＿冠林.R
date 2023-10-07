library(MLmetrics)
library(MASS)
library(car)
library(caret)
library(e1071)
library(class)
library(Hmisc)
library(astsa)
library(ROCR)

###read data
setwd("D:/成功大學/機器學習/0514")
COGgerneration2013 <- read.csv('D:/成功大學/機器學習/0514/COGgeneration2013_useknn2.csv')
seasonality_training <- read.csv('D:/成功大學/機器學習/0514/seasonality_training.csv')
COGgerneration2013_day_week <- read.csv("D:/成功大學/機器學習/0514/COGgerneration2013_useknn7.csv")
COGgerneration2013_day_week <-COGgerneration2013_day_week[-44643,]
COGgerneration2013_day_week <-COGgerneration2013_day_week[-89283,]
COGgerneration2013_day_week <-COGgerneration2013_day_week[-132483,]
COGgerneration2013_day_week <-COGgerneration2013_day_week[-177123,]
COGgerneration2013_day_week <-COGgerneration2013_day_week[-220323,]
COGuser2013 <- read.csv("D:/成功大學/機器學習/0514/COGuser2013.csv")
for (i in 1:ncol(COGuser2013)) {
  COGuser2013[,i] <- as.numeric(COGuser2013[,i])
}
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
catorgory_H2_up_down <- ifelse((Holder2-Lag(Holder2,1))[-1]>0,'up','down')
catorgory_H2_up_down <-c(NA,catorgory_H2_up_down)
catorgory_H2_normal <- ifelse(sapply(Holder2,function(x) return(x<80 && x>20)),'normal','abnormal')
COGuser_sum <- apply(COGuser2013[,-1],1,function(x) sum(x,na.rm = T))

## function lag
lag_t <- function(lag_time){
  alldata=ts.intersect(Holder2=ts(Holder2),
                       H1lag1=ts(Lag(Holder1,lag_time)),
                       H1lag2=ts(Lag(Holder1,lag_time+1)), 
                       H1lag3=ts(Lag(Holder1,lag_time+2)),
                       H1lag4=ts(Lag(Holder1,lag_time+3)), 
                       H1lag5=ts(Lag(Holder1,lag_time+4)), 
                       H2lag1=ts(Lag(Holder2,lag_time)),
                       H2lag2=ts(Lag(Holder2,lag_time+1)),
                       H2lag3=ts(Lag(Holder2,lag_time+2)),
                       H2lag4=ts(Lag(Holder2,lag_time+3)),
                       H2lag5=ts(Lag(Holder2,lag_time+4)),
                       Gener1lag=ts(Lag(Gener1,lag_time)),
                       Gener1lag2=ts(Lag(Gener1,lag_time+1)),
                       Gener1lag3=ts(Lag(Gener1,lag_time+2)),
                       Gener1lag4=ts(Lag(Gener1,lag_time+3)),
                       Gener1lag5=ts(Lag(Gener1,lag_time+4)),
                       Gener2lag1=ts(Lag(Gener2,lag_time)),
                       Gener2lag2=ts(Lag(Gener2,lag_time+1)),
                       Gener2lag3=ts(Lag(Gener2,lag_time+2)),
                       Gener2lag4=ts(Lag(Gener2,lag_time+3)),
                       Gener2lag5=ts(Lag(Gener2,lag_time+4)),
                       Press1lag1=ts(Lag(Press1,lag_time)),
                       Press1lag2=ts(Lag(Press1,lag_time+1)),
                       Press1lag3=ts(Lag(Press1,lag_time+2)),
                       Press1lag4=ts(Lag(Press1,lag_time+3)),
                       Press1lag5=ts(Lag(Press1,lag_time+4)),
                       Press2lag1=ts(Lag(Press2,lag_time)),
                       Press2lag2=ts(Lag(Press2,lag_time+1)),
                       Press2lag3=ts(Lag(Press2,lag_time+2)),
                       Press2lag4=ts(Lag(Press2,lag_time+3)),
                       Press2lag5=ts(Lag(Press2,lag_time+4)),
                       Temp1lag1 =ts(Lag(Temp1,lag_time)),
                       Temp1lag2 =ts(Lag(Temp1,lag_time+1)),
                       Temp1lag3 =ts(Lag(Temp1,lag_time+2)),
                       Temp1lag4 =ts(Lag(Temp1,lag_time+3)),
                       Temp1lag5 =ts(Lag(Temp1,lag_time+4)),
                       Temp2lag1 =ts(Lag(Temp2,lag_time)),
                       Temp2lag2 =ts(Lag(Temp2,lag_time+1)),
                       Temp2lag3 =ts(Lag(Temp2,lag_time+2)),
                       Temp2lag4 =ts(Lag(Temp2,lag_time+3)),
                       Temp2lag5 =ts(Lag(Temp2,lag_time+4)),
                       df_holder2_day = ts(df_holder2_day),
                       df_holder2_week = ts(df_holder2_week),
                       H2_sean_day = ts(H2_sean_day),
                       H2_sean_week = ts(H2_sean_week),
                       COGuser_sumlag1 = ts(Lag(COGuser_sum,lag_time)),
                       COGuser_sumlag2 = ts(Lag(COGuser_sum,lag_time+1)),
                       COGuser_sumlag3 = ts(Lag(COGuser_sum,lag_time+2)),
                       COGuser_sumlag4 = ts(Lag(COGuser_sum,lag_time+3)),
                       COGuser_sumlag5 = ts(Lag(COGuser_sum,lag_time+4))
  )
  return(alldata)
}
#OLS
##lag1 lm
lag_1 <- lag_t(1)
train <- as.data.frame(lag_1[1:220321,])
test <- as.data.frame(lag_1[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##lag5 lm
lag_5 <- lag_t(5)
train <- as.data.frame(lag_5[1:220321,])
test <- as.data.frame(lag_5[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##lag10 lm
lag_10 <- lag_t(10)
train <- as.data.frame(lag_10[1:220321,])
test <- as.data.frame(lag_10[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##lag30
lag_30 <- lag_t(30)
train <- as.data.frame(lag_30[1:220321,])
test <- as.data.frame(lag_30[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##lag60
lag_60 <- lag_t(60)
train <- as.data.frame(lag_60[1:220321,])
test <- as.data.frame(lag_60[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##lag120
lag_120 <- lag_t(120)
train <- as.data.frame(lag_120[1:220321,])
test <- as.data.frame(lag_120[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)
##lag180
lag_180 <- lag_t(180)
train <- as.data.frame(lag_180[1:220321,])
test <- as.data.frame(lag_180[220322:264961,])
fit1 <- lm(Holder2~.,train)
summary(fit1)
pre1<-predict(fit1,test)
MAPE(pre1,test$Holder2)

#LDA up_down
lag_1 <- lag_t(1)
train <- data.frame(lag_1[1:220321,-1],catorgory_H2_up_down=catorgory_H2_up_down[1:220321])
test <- data.frame(lag_1[220322:246961,-1],catorgory_H2_up_down=catorgory_H2_up_down[220322:246961])
train.full <- train[complete.cases(train),]
train.full$catorgory_H2_up_down <- as.factor(train.full$catorgory_H2_up_down)
lda_model <-  lda(catorgory_H2_up_down~., data = train.full)
lda_pred<-predict(lda_model,test)
names(lda_pred)
table(lda_pred$class,test$catorgory_H2_up_down)
confusionMatrix(factor(test$catorgory_H2_up_down),factor(lda_pred$class))
##pred <- prediction(lda_pred, test$catorgory_H2_up_down)
##perf <- performance(pred, measure = "tpr", x.measure = "fpr")
##auc <- performance(pred, "auc")
##plot(perf, col = rainbow(7), main = "ROC curve", xlab = "Specificity", ylab = "Sensitivity")
##abline(0, 1)
##text(0.7, 0.4 ,paste('auc is ',as.character(round(auc@y.values[[1]],4))))
#QDA up_down
qda_model <-  qda(catorgory_H2_up_down~., data = train.full)
qda_pred<-predict(qda_model,test)
names(qda_pred)
confusionMatrix(factor(test$catorgory_H2_up_down),factor(qda_pred$class))
#naiveBayes up_down
nb_model <-  naiveBayes(catorgory_H2_up_down~., data = train.full)
nb_pred<-predict(nb_model,test)
confusionMatrix(factor(test$catorgory_H2_up_down),factor(nb_pred))

#LDA normal
lag_1 <- lag_t(1)
train <- data.frame(lag_1[1:220321,-1],catorgory_H2_normal=catorgory_H2_normal[1:220321])
test <- data.frame(lag_1[220322:246961,-1],catorgory_H2_normal=catorgory_H2_normal[220322:246961])
train.full <- train[complete.cases(train),]
train.full$catorgory_H2_normal <- as.factor(train.full$catorgory_H2_normal)
lda_model <-  lda(catorgory_H2_normal~., data = train.full)
lda_pred<-predict(lda_model,test)
names(lda_pred)
confusionMatrix(factor(test$catorgory_H2_normal),factor(lda_pred$class))
#QDA up_down
qda_model <-  qda(catorgory_H2_normal~., data = train.full)
qda_pred<-predict(qda_model,test)
names(qda_pred)
confusionMatrix(factor(test$catorgory_H2_normal),factor(qda_pred$class))
#naiveBayes up_down
nb_model <-  naiveBayes(catorgory_H2_normal~., data = train.full)
nb_pred<-predict(nb_model,test)
confusionMatrix(factor(test$catorgory_H2_normal),factor(nb_pred))
