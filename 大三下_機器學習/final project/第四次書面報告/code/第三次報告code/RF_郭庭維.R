source("pattern_retrieval.R")
library(randomForest)

data <- read.csv("資料/COGgerneration2013_useknn2.csv")
head(data)

holder1 <- matrix(data$W51_LX.152.1.OV,ncol=1)
holder2 <- matrix(data$W51_LX.152.2.OV,ncol=1)


#基本參數設定
data_col <- 2 #欄數
lag <- 10 #投入前多少分鐘的資料
k <- 10 #找距離前K近的Pattern
tstar <- 180 #預測多久後的資料
times <- 50 #預測多少次


#end <- sample(240000:255000,times) # 抽樣抽十次
#想找的pattern集合
targets <- construst_data_array(holder1,end,lag,tstar)

training_data <- matrix(holder1[1:239999],ncol=1)


predicts <- c()#預測的結果
for(i in 1:dim(targets)[1]){#for i in 1:times，預測每個抽樣
  closed_pattern <- c()#相近的時間點
  target <- targets[i,,]#第i筆資料中的y,x1,x2....
  closed_pattern <- pattern_retrieval(training_data,target,k,0)#找相似
  
  local_train <- construst_data_array(holder1,closed_pattern,lag,tstar)# 若更改預測目標 記得更改此處的data
  
  local_train <- output_to_dataframe(local_train)
  
  rf.fit <- randomForest(V1~.,data=local_train,mtry=3)
  #summary(lm.fit)
  
  target <- matrix(target,nrow=1)
  target <- as.data.frame(target)
  predicts <- c(predicts,predict(rf.fit,target))
}
#importance(rf.fit)
#varImpPlot(rf.fit)
#lag=10???執行此??????
mean(abs((targets[,1,1]-predicts)/targets[,1,1]))#mape
mean((targets[,1,1]-predicts)^2)#MSE
plot(targets[,1,1]-predicts,main=c("predict",as.character(tstar)))#殘差圖









