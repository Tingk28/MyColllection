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
  Holder2_week=Holder2_week,
  Holder2_diff_day=Holder2_diff_day
)
response_data <- data.frame(Holder2_V0=Holder2_V0)

train_sample <- c(1:220321)
testing_sample <- c(220321:264961)

## function lag data build
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

## local model finding
distance1 <- function(a,b){
  (sum((a-b)^2))^0.5
}

local_model_sample <- function(number_sample,test_datav,train_datav,times=timedata){ ##test data train data is vector
  lag_time <- length(test_datav)
  train_lag <- time_lag(train_datav,lag_time)
  train_lag <- train_lag[complete.cases(train_lag),]
  dis <- apply(train_lag,1,function(x,test_data1=test_datav) distance1(x,test_datav))
  dis <- c(rep(NA,lag_time),dis)
  time_rank <- times[order(dis)]
  return(time_rank[1:number_sample])
}

##MSPE & MAPE
MAPE <- function(true, pred){
  dif <- abs(pred - true)
  return(mean(dif/true))
}
MSPE <-function(true, pred){
  dif <- (pred - true)^2
  return(mean(dif))
}
Boostrap_MAPE_CI <-function(true,pred,B,alpha){
  point.estimator <- MAPE(true , pred)
  sample_times <- length(true)
  dif <- abs(true -pred)
  APE <- dif/true
  set.seed(100)
  b_sample <- matrix(0, nrow = B , ncol = sample_times)
  for (i in 1:B) {
      b_sample[i,] <- sample(APE,sample_times,replace = T)
  }
  Boost_MAPE<-apply(b_sample,1,mean)
  return(data.frame(CI_L=sort(Boost_MAPE)[B*(alpha/2)],point.estimator=point.estimator,CI_U=sort(Boost_MAPE)[B*(1-alpha/2)]))
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
### Note that train_sample is numbers, test_sample is vector of times of POXIct data.
Pred_reg <- function(response,predictor_data,season_data=NA,times=NA,lag_time =c(1:10),predict_time=1,k_number_local_sample,train_sample,test_sample){
  full_data <- time_lag_data(response,predictor_data,season_data,times,lag_time,predict_time)
  train_data <- full_data[train_sample,]
  pred_value <- rep(NA,length(test_sample))
  return_data <- data.frame(time=test_sample,lasso=pred_value,forward = pred_value,tree=pred_value,Random_Forest=pred_value,SVR_L=pred_value,SVR_P=pred_value,SVR_R=pred_value)
  train_datav <- as.numeric(t(train_data[,2]))
  response_name <- colnames(train_data)[2]
  for(i in 1:length(test_sample)){
    objective_time <- test_sample[i]
    test_datav <- full_data[grepl(objective_time,full_data$time),grepl(paste0(response_name,'lag'),colnames(full_data))]
    test_datav <- as.vector(t(test_datav))
    local_sample  <- local_model_sample(k_number_local_sample,test_datav,train_datav,times)
    local_model_sampling <- train_data[which(train_data$time==local_sample[1]),]
    for(j in 2:length(local_sample)){
      local_model_sampling <- rbind(local_model_sampling,train_data[which(train_data$time==local_sample[j]),])
    }
    ###lasso
    
    X <- as.matrix(local_model_sampling[,-c(1,2)])
    y <- local_model_sampling[,2]
    grid <- 10^seq(-3,5,lengh = 10000)
    lasso_model <- glmnet(X, y, family = "gaussian", alpha = 1,lambda = grid)
    cv.lasso <- cv.glmnet(x = X, y = y, alpha = 1, nfolds = 5, family = "gaussian")
    bestlam <- cv.lasso$lambda.min
    pr_lasso <- predict(lasso_model,s=bestlam,newx=as.matrix(full_data[which(full_data$time == objective_time),-c(1,2)]))
    return_data[i,2] <- pr_lasso
    
    ##forward
    OLS_function <- paste(response_name,'~.')
    lm_data <- local_model_sampling[,-1]
    null = lm(Holder2_V0 ~ 1, data = lm_data)  
    full = lm(Holder2_V0 ~ ., data = lm_data)
    forward.lm_local = step(null,
                     scope=list(lower=null, upper=full),
                      direction="forward",
                      trace =0 )
    pr_forward <- predict(forward.lm_local,full_data[which(full_data$time == objective_time),-1])
    return_data[i,3] <- pr_forward
    
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
    return_data[i,4] <- as.numeric(as.data.frame(t(pr_tree))[1,1])
    ###random forest
    rf_data <- local_model_sampling[,-1]
    rf_fit <- randomForest(Holder2_V0~.,data=rf_data)
    pr_rf <- predict(rf_fit, newdata = full_data[which(full_data$time == objective_time),-1])
    return_data[i,5] <- pr_rf
    ###SVR
    SVR_data <- local_model_sampling[,-1]
    SVR_l.fit <- svm(Holder2_V0~.,data=SVR_data,kernel = 'linear',cost=10)
    #tune.out_p <- tune (svm , Holder2_V0 ~ ., data = SVR_data,
    #                  kernel = "polynomial",
    #                  ranges = list (
    #                    cost = c(0.1, 1, 10, 100, 1000),
    #                    gamma = c(0.125,0.25,0.5, 1)
    #                  )
    #)
    #SVR_p.fit <-tune.out_p$best.model
    #tune.out_r <- tune (svm , Holder2_V0 ~ ., data = SVR_data,
    #                    kernel = "radial",
    #                    ranges = list (
    #                      cost = c(0.1, 1, 10, 100, 1000),
    #                      gamma = c(0.125,0.25,0.5, 1)
    #                    )
    #)    
    #SVR_r.fit <-tune.out_r$best.model
    pr_SVR_l <- predict(SVR_l.fit, newdata = full_data[which(full_data$time == objective_time),-1])
    return_data[i,6] <- pr_SVR_l
    #pr_SVR_p <- predict(SVR_p.fit, newdata = full_data[which(full_data$time == objective_time),-1])
    #tuneSVR2 <- tune( svm, mpg~drat+wt, data=mtcars )
    #return_data[i,7] <- pr_SVR_p
    #pr_SVR_r <- predict(SVR_r.fit, newdata = full_data[which(full_data$time == objective_time),-1])
    #return_data[i,8] <- pr_SVR_r
    print(i)
  }
  return(return_data)
}

###test set build
#set.seed(300)
#test_time <- sample(timedata[220321:260000,],300)
#test_time[248] <- sample(timedata[220321:260000,],1)
response_time <-data.frame(timedata,response_data)
#write.csv(test_time,'test_time.csv')
test_time<-read.csv('test_time.csv')$x
test_time <-as.POSIXct(test_time)
true.value <- response_time[which(response_time$time==test_time[1]),]
for(i in 2:length(test_time)){
  true.value <- rbind(true.value , response_time[which(response_time$time==test_time[i]),])
}


###calulate
Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:10),predict_time=1,k_number_local_sample=30,train_sample=c(1:220321),test_sample = test_time)
output_data<-cbind(Predtion,true_value=true.valuep_1)
write.csv(output_data,'k_30_p_1_lag_10.csv',row.names = TRUE)

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:60),predict_time=10,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
output_data<-cbind(Predtion,true_value=true.valuep_10)
write.csv(output_data,'k_500_p_10_lag_60.csv',row.names = TRUE)

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:10),predict_time=10,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
output_data<-cbind(Predtion,true_value=true.valuep_10)
write.csv(output_data,'k_500_p_10_lag_10.csv',row.names = TRUE)

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:20),predict_time=10,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
output_data<-cbind(Predtion,true_value=true.value$Holder2_V0)
write.csv(output_data,'k_500_p_10_lag_20.csv',row.names = TRUE)

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:30),predict_time=10,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
output_data<-cbind(Predtion,true_value=true.valuep_10)
write.csv(output_data,'k_500_p_10_lag_30.csv',row.names = TRUE)

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:60),predict_time=10,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
write.csv(Predtion,'k_500_p_10_lag_60.csv',row.names = TRUE)

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:30),predict_time=30,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
write.csv(Predtion,'k_500_p_30_lag_30.csv',row.names = TRUE)

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:20),predict_time=30,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
write.csv(Predtion,'k_500_p_30_lag_20.csv',row.names = TRUE)

Predtion <-Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:10),predict_time=30,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
write.csv(Predtion,'k_500_p_30_lag_10.csv',row.names = TRUE)

Predtion <- Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:20),predict_time=1,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
write.csv(Predtion,'k_500_p_1_lag_20.csv',row.names = TRUE)

Predtion <- Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:10),predict_time=1,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
write.csv(Predtion,'k_500_p_1_lag_10.csv',row.names = TRUE)

Predtion <- Pred_reg(response_data,pred_data,season_data,timedata,lag_time = c(1:60),predict_time=30,k_number_local_sample=500,train_sample=c(1:220321),test_sample = test_time)
write.csv(Predtion,'k_500_p_30_lag_60.csv',row.names = TRUE)


