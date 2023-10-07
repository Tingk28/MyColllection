setwd('~/Desktop/machinelearning/力綱')
library(dplyr)# lag in this
library(glmnet)
library(olsrr)
library(rpart)       # performing regression trees
library(rpart.plot)  # plotting regression trees
library(ipred)       # bagging
library(caret)       # bagging
library(tree)
library(randomForest)
library(e1071)

##read data
COGg <- read.csv("COGvariables.csv")
timedata <- data.frame(time=as.POSIXct(COGg$time))
Holder1_V0 <-COGg$holder1_V0
Holder2_V0 <-COGg$holder2_V0
Holder2_day <- COGg$daily_holder2_V0 
Holder2_week <- COGg$weekly_holder2_V0
Holder2_diff_day <- COGg$lastday_2
Holder2_diff_week <- COGg$lastweek_2
Gern12 <- COGg$W51_FT.101D.OV
Gern34 <- COGg$W51_FX.153.OV
G_use <-COGg$total_user
pred_data <- data.frame(
  Holder1_V0=Holder1_V0,
  Holder2_V0=Holder2_V0,
  Gern12 = Gern12,
  Gern34 = Gern34,
  G_use = G_use
)
season_data <-data.frame(
  Holder2_day=Holder2_day,
  Holder2_week=Holder2_week
)
response_data <- data.frame(Holder2_V0=Holder2_V0)

train_sample <- c(1:220321)
testing_sample <- c(220321:264961)

time_lag_data <- function(response=NA,predictor_data,season_data=NA,times=NA,lag_time =c(0:10),predict_time=1){
  return_data <- cbind(response,season_data)
  time_pre <- lag(times,predict_time)
  return_data <-cbind(time_pre,return_data)
  for (i in lag_time) {
    for ( var in colnames(predictor_data)) {
      name1 <- paste0(var,'lag',i)
      data1 <- lag(predictor_data[,var],i+predict_time-1)
      return_data <- cbind(return_data,data1)
      colnames(return_data)[ncol(return_data)] <- name1
    }
  }
  return(return_data)
}
time_lag <- function(vector,lag_time){ ##lag_time is number
  return_data <- vector
  for (i in c(1:(lag_time-1)) ) {
    return_data <- cbind(return_data, lag(vector,i))
  }
  return(return_data)
}
distance1 <- function(a,b){
  (sum((a-b)^2))^0.5
}
##local model
local_model_sample <- function(number_sample,test_datav,train_datav,times=timedata){ ##test data train data is vector
  lag_time <- length(test_datav)
  train_lag <- time_lag(train_datav,lag_time)
  train_lag <- train_lag[complete.cases(train_lag),]
  dis <- apply(train_lag,1,function(x,test_data1=test_datav) distance1(x,test_datav))
  dis <- c(rep(NA,lag_time),dis)
  time_rank <- times$time[order(dis)]
  return(time_rank[1:number_sample])
}
##error esitmate
MAPE <- function(true, pred){
  dif <- abs(pred - true)
  return(mean(dif/true))
}
MSPE <-function(true, pred){
  dif <- (pred - true)^2
  return(mean(dif))
}
## tree pre function
get_cp <- function(x){
  min <- which.min(x$cptable[,"xerror"]) # 回傳發生最小xerror的列index
  cp <- x$cptable[min, "CP"]
}

get_min_error <- function(x){
  min <- which.min(x$cptable[,"xerror"])
  xerror <- x$cptable[min, "xerror"]
}

## Big_function
### Note that train_sample is numbers, test_sample is a POXIct data, predict_time is vector of time we want to predict
Pred_reg <- function(response,predictor_data,season_data=NA,times=NA,lag_time =c(1:10),predict_time=c(1:30),k_number_local_sample=500,test_sample,pre_time_data=100){
  train_sample <-1:test_sample
  objective_time <- times$time[test_sample]
  objective_sample <- which(times$time==objective_time)
  test_datav <- response$Holder2_V0[(objective_sample-length(lag_time)):(objective_sample-1)]
  train_datav <- response$Holder2_V0[train_sample]
  response_name <- colnames(response)
  pred_value <- rep(NA,length(predict_time)+pre_time_data)
  return_data <- data.frame(time=times$time[(objective_sample-pre_time_data):(objective_sample+length(predict_time)-1)],
                            true_value=response$Holder2_V0[(objective_sample-pre_time_data):(objective_sample+length(predict_time)-1)],
                            lasso=pred_value,
                            forward = pred_value,
                            tree=pred_value,
                            Random_Forest=pred_value,
                            SVR_L=pred_value)
  response_name <- colnames(response)
  local_sample  <- local_model_sample(k_number_local_sample,test_datav,train_datav,times)
  for (i in predict_time) {
    full_data <- time_lag_data(response,predictor_data,season_data,times,lag_time,i)
    local_model_sampling <- full_data[which(full_data$time==local_sample[1]),]
    for(j in 2:length(local_sample)){
      local_model_sampling <- rbind(local_model_sampling,full_data[which(full_data$time==local_sample[j]),])
    }
    ###lasso
    X <- as.matrix(local_model_sampling[,-c(1,2)])
    y <- local_model_sampling[,2]
    grid <- 10^seq(-3,5,lengh = 10000)
    lasso_model <- glmnet(X, y, family = "gaussian", alpha = 1,lambda = grid)
    cv.lasso <- cv.glmnet(x = X, y = y, alpha = 1, nfolds = 5, family = "gaussian")
    bestlam <- cv.lasso$lambda.min
    pr_lasso <- predict(lasso_model,s=bestlam,newx=as.matrix(full_data[which(full_data$time == objective_time),-c(1,2)]))
    return_data[i+pre_time_data,3] <- pr_lasso
    
    ##forward
    lm_data <- local_model_sampling[,-1]
    null = lm(Holder2_V0 ~ 1, data = lm_data)  
    full = lm(Holder2_V0 ~ ., data = lm_data)
    forward.lm_local = step(null,
                            scope=list(lower=null, upper=full),
                            direction="forward",
                            trace =0 )
    pr_forward <- predict(forward.lm_local,full_data[which(full_data$time == objective_time),-1])
    return_data[i+pre_time_data,4] <- pr_forward
    
    ###tree
    tree_data <- local_model_sampling[,-1]
    hyper_grid <- expand.grid(
      minsplit = seq(5,20,1),
      maxdepth = seq(8,15,1)
    )
    models <- list()
    for(k in 1:nrow(hyper_grid)){
      minsplit <- hyper_grid$minsplit[k]
      maxdepth <- hyper_grid$maxdepth[k]
      
      models[[k]] <- rpart(
        formula = Holder2_V0 ~., 
        data = tree_data, 
        method = "anova",
        control = list(minsplit = minsplit, maxdepth = maxdepth)
      )
    }
    min_er <- hyper_grid %>% 
      mutate(
        cp = purrr::map_dbl(models,get_cp),
        error = purrr::map_dbl(models,get_min_error)
      )  %>% 
      arrange(error)%>% 
      top_n(-1, wt = error)
    optimal_tree <- rpart(
      formula = Holder2_V0 ~ .,
      data = tree_data,
      method = "anova",
      control = list(minsplit = min_er[1,1], maxdepth = min_er[1,2], cp = min_er[1,3])
    )
    pr_tree <- predict(optimal_tree, newdata = full_data[which(full_data$time == objective_time),-1])
    return_data[i+pre_time_data,5] <- as.numeric(as.data.frame(t(pr_tree))[1,1])
    ###random forest
    rf_data <- local_model_sampling[,-1]
    rf_fit <- randomForest(Holder2_V0~.,data=rf_data)
    pr_rf <- predict(rf_fit, newdata = full_data[which(full_data$time == objective_time),-1])
    return_data[i+pre_time_data,6] <- pr_rf
    ###SVR
    SVR_data <- local_model_sampling[,-1]
    SVR_l.fit <- svm(Holder2_V0~.,data=SVR_data,kernel = 'linear',cost=10)
    pr_SVR_l <- predict(SVR_l.fit, newdata = full_data[which(full_data$time == objective_time),-1])
    return_data[i+pre_time_data,7] <- pr_SVR_l
    print(i)
  }
  return(return_data)
}
### non-local
Pred_reg_non_local <- function(response,predictor_data,season_data=NA,times=NA,lag_time =c(1:10),predict_time=c(1:30),test_sample,pre_time_data=100){
  train_sample <-(test_sample-2880):test_sample
  objective_time <- times$time[test_sample]
  objective_sample <- which(times$time==objective_time)
  test_datav <- response$Holder2_V0[(objective_sample-length(lag_time)):(objective_sample-1)]
  train_datav <- response$Holder2_V0[train_sample]
  response_name <- colnames(response)
  pred_value <- rep(NA,length(predict_time)+pre_time_data)
  return_data <- data.frame(time=times$time[(objective_sample-pre_time_data):(objective_sample+length(predict_time)-1)],
                            true_value=response$Holder2_V0[(objective_sample-pre_time_data):(objective_sample+length(predict_time)-1)],
                            lasso=pred_value,
                            forward = pred_value,
                            tree=pred_value,
                            Random_Forest=pred_value,
                            SVR_L=pred_value)
  response_name <- colnames(response)
  for (i in predict_time) {
    full_data <- time_lag_data(response,predictor_data,season_data,times,lag_time,i)
    train_data <- full_data[train_sample,]
    ###lasso
    X <- as.matrix(train_data[complete.cases(train_data),-c(1,2)])
    y <- train_data[complete.cases(train_data),2]
    grid <- 10^seq(-3,5,lengh = 10000)
    lasso_model <- glmnet(X, y, family = "gaussian", alpha = 1,lambda = grid)
    cv.lasso <- cv.glmnet(x = X, y = y, alpha = 1, nfolds = 5, family = "gaussian")
    bestlam <- cv.lasso$lambda.min
    pr_lasso <- predict(lasso_model,s=bestlam,newx=as.matrix(full_data[which(full_data$time == objective_time),-c(1,2)]))
    return_data[i+pre_time_data,3] <- pr_lasso
    print('lasso')
    ##forward
    lm_data <- train_data[complete.cases(train_data),-1]
    null = lm(Holder2_V0 ~ 1, data = lm_data)  
    full = lm(Holder2_V0 ~ ., data = lm_data)
    forward.lm_local = step(null,
                           scope=list(lower=null, upper=full),
                            direction="forward",
                            trace =0 )
    pr_forward <- predict(forward.lm_local,full_data[which(full_data$time == objective_time),-1])
    return_data[i+pre_time_data,4] <- pr_forward
    print('forward')
    ##tree
    tree_data <- train_data[complete.cases(train_data),-1]
    hyper_grid <- expand.grid(
      minsplit = seq(5,20,1),
      maxdepth = seq(8,15,1)
    )
    models <- list()
    for(k in 1:nrow(hyper_grid)){
      minsplit <- hyper_grid$minsplit[k]
      maxdepth <- hyper_grid$maxdepth[k]
      
      models[[k]] <- rpart(
        formula = Holder2_V0 ~., 
        data = tree_data, 
        method = "anova",
        control = list(minsplit = minsplit, maxdepth = maxdepth)
      )
    }
    min_er <- hyper_grid %>% 
      mutate(
        cp = purrr::map_dbl(models,get_cp),
        error = purrr::map_dbl(models,get_min_error)
      )  %>% 
      arrange(error)%>% 
      top_n(-1, wt = error)
    optimal_tree <- rpart(
      formula = Holder2_V0 ~ .,
      data = tree_data,
      method = "anova",
      control = list(minsplit = min_er[1,1], maxdepth = min_er[1,2], cp = min_er[1,3])
    )
    pr_tree <- predict(optimal_tree, newdata = full_data[which(full_data$time == objective_time),-1])
    return_data[i+pre_time_data,5] <- as.numeric(as.data.frame(t(pr_tree))[1,1])
    print('tree')
    ###random forest
    rf_data <- train_data[complete.cases(train_data),-1]
    rf_fit <- randomForest(Holder2_V0~.,data=rf_data)
    pr_rf <- predict(rf_fit, newdata = full_data[which(full_data$time == objective_time),-1])
    return_data[i+pre_time_data,6] <- pr_rf
    print('RF')
    ###SVR
    #SVR_data <- train_data[complete.cases(train_data),-1]
    #SVR_l.fit <- svm(Holder2_V0~.,data=SVR_data,kernel = 'linear',cost=10)
    #pr_SVR_l <- predict(SVR_l.fit, newdata = full_data[which(full_data$time == objective_time),-1])
    #return_data[i+pre_time_data,7] <- pr_SVR_l
    print(i)
  }
  return(return_data)
}

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:20),predict_time=c(1:100),k_number_local_sample=500,test_sample = 228645,pre_time_data = 100)
write.csv(Predtion,'Predtion_228645_lag_20_k_500_pre_100_prediction_100.csv',row.names = F)
Predtion_non_local <-Pred_reg_non_local(response_data,pred_data,season_data,timedata,lag_time = c(1:20),predict_time=c(1:100),test_sample = 228645,pre_time_data = 100)
write.csv(Predtion,'Predtion_non_local_228645_lag_20_pre_100_prediction_100.csv',row.names = F)

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:30),predict_time=c(1:100),k_number_local_sample=500,test_sample = 228645,pre_time_data = 100)
write.csv(Predtion,'Predtion_228645_lag_30_k_500_pre_100_prediction_100.csv',row.names = F)
Predtion_non_local <-Pred_reg_non_local(response_data,pred_data,season_data,timedata,lag_time = c(1:30),predict_time=c(1:100),test_sample = 228645,pre_time_data = 100)
write.csv(Predtion,'Predtion_non_local_228645_lag_30_pre_100_prediction_100.csv',row.names = F)


testMAPE <-MAPE(Predtion$true_value[101:130],Predtion$Random_Forest[101:130])
testMAPE

write.csv(Predtion,'Predtion_220322_lag_10_k_500_pre_100_prediction_100.csv',row.names = F)
