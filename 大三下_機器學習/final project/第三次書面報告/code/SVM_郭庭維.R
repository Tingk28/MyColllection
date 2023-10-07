source("pattern_retrieval.R")
library(e1071)

data <- read.csv("資料/COGgerneration2013_useknn2.csv")
head(data)

holder1 <- matrix(data$W51_LX.152.1.OV,ncol=1)
holder2 <- matrix(data$W51_LX.152.2.OV,ncol=1)


#基本參數設定
data_col <- 1 #欄數
lag <- 10 #投入前多少分鐘的資料
k <- 10 #找距離前K近的Pattern
tstar <- 180 #預測多久後的資料
times <- 50 #預測多少次

set.seed(1)
end <- sample(240000:264900,times) # 抽樣抽十次
#想找的pattern集合
targets <- construst_data_array(holder2,end,lag,tstar)

training_data <- matrix(holder2[1:239999],ncol=1)


predicts_l <- c()#linear 預測的結果
predicts_ploy <- c()#poly 預測的結果
predicts_rad <- c()#radial 預測的結果

for(i in 1:dim(targets)[1]){#for i in 1:times，預測每個抽樣
  closed_pattern <- c()#相近的時間點
  target <- targets[i,,]#第i筆資料中的y,x1,x2....
  closed_pattern <- pattern_retrieval(training_data,target,k,0)#找相似
  local_train <- construst_data_array(training_data,closed_pattern,lag,tstar)
  local_train <- output_to_dataframe(local_train)
  
  SVM_l.fit <- svm(V1~.,data=local_train,kernel = 'linear',cost=10)
  SVM_p.fit <- svm(V1~.,data=local_train,kernel = 'polynomial',cost=10,gamma=1)
  SVM_r.fit <- svm(V1~.,data=local_train,kernel = 'radial' ,cost=10,gamma=1)
  #summary(lm.fit)
  
  target <- matrix(target,nrow=1)
  target <- as.data.frame(target)
  predicts_l <- c(predicts_l,predict(SVM_l.fit,target[,11:20]))
  predicts_ploy <- c(predicts_ploy,predict(SVM_p.fit,target[,11:20]))
  predicts_rad <- c(predicts_rad,predict(SVM_r.fit,,target[,11:20][1])[1])
}

par(mfcol=c(3,1))

# linear
mean(abs((targets[,1,1]-predicts_l)/targets[,1,1]))#mape
mean((targets[,1,1]-predicts_l)^2)#MSE
plot(targets[,1,1]-predicts_l,main=c("predict linear",as.character(tstar)))#殘差圖

#poly
mean(abs((targets[,1,1]-predicts_ploy)/targets[,1,1]))#mape
mean((targets[,1,1]-predicts_ploy)^2)#MSE
plot(targets[,1,1]-predicts_ploy,main=c("predict ploy",as.character(tstar)))#殘差圖

#radial
mean(abs((targets[,1,1]-predicts_rad)/targets[,1,1]))#mape
mean((targets[,1,1]-predicts_rad)^2)#MSE
plot(targets[,1,1]-predicts_rad,main=c("predict radial",as.character(tstar)))#殘差圖


