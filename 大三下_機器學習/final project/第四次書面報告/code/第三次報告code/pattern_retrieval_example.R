# author:???x??
# readme:https://hackmd.io/@zNBPdFcsSb-BLfsSsupEKg/BkhJuR4Iq

data_reconstruct <- function(data,timelag,na_omit=T,rev=F){
  result <- matrix(NA,nrow = length(data),ncol = timelag)
  for(i in 1:length(data)){
    #print(i)
    if(i<timelag){
      if(na_omit){
        next
      }
      result[i,] <- c(rep(NA,timelag-i),data[1:i])
    }else{
      result[i,] <- data[(i-timelag+1):i]
    }
    if(rev){
      result[i,] <- rev(result[i,])
    }
  }
  return(result)
}

pattern_retrieval <- function(data,target,k,diff=0){#data and target ??????多維度????????????確保???者???col???一???
  lag <- dim(target)[1]
  if(diff!=0){
    target <- diff(target,diff)
  }
  for(i in 1:dim(data)[2]){
    temp_data <- data_reconstruct(data[,i],lag)
    if(diff!=0){
      temp_data <- diff(temp_data,diff)
      temp_data <- temp_data[,1:(lag-diff)]
    }
    #temp_data <- na.omit(temp_data)
    if(i==1){
      distance_list <- rep(0,dim(temp_data)[1])
    }
    #print(length(distance_list))
    #print(length(apply(X = temp_data, 1, FUN = function(x) distance1(x,target[,i+1]))))
    distance_list <- distance_list+apply(X = temp_data, 1, FUN = function(x) distance1(x,target[,i+1]))
  }
  distance_list_sort <- sort(distance_list)
  threshold <- distance_list_sort[k]
  a <- which(distance_list<=threshold)
  return(a)
}

construst_data_array <- function(data,index,lag,tstar){
  output <- array(NA,dim=c(length(index),lag,dim(data)[2]+1))
  output[,,1] <- c(data[index+tstar,1],rep(NA,(lag-1)*length(index)))
  for(i in 1:dim(data)[2]){
    temp_output <- c()#???????????????數???數???
    for(j in index){
      temp_output <- c(temp_output,data[(j-lag+1):j,i])
    }
    temp_output <- matrix(temp_output,nrow = length(index),byrow=T)
    output[,,i+1] <-temp_output 
  }
  return(output)
}

distance1 <- function(a,b){
  (sum((a-b)^2))^0.5
}
output_to_dataframe <- function(input_data){
  local_train <- as.data.frame(local_train)
  local_train <- t(na.omit(t(local_train)))
  local_train <- as.data.frame(local_train)
}


COGg07 <- read.csv("資料/COGgeneration201307.csv")#先使用七月份的資料
COGg07 <-cbind(COGg07$W51_LX.152.2.OV,COGg07$W51_LX.152.1.OV)
#匯入holder 1 &2
# holder 2 放在第一個，所以以預測holder 2為主

#基本參數設定
data_col <- 2 #欄數
lag <- 10 #投入前多少分鐘的資料
k <- 10 #找距離前K近的Pattern
tstar <- 5 #預測多久後的資料
times <- 10 #預測多少次
set.seed(1) #示範用
end <- sample(30000:31000,times) # 抽樣抽十次
#想找的pattern集合
targets <- construst_data_array(COGg07,end,lag,tstar)

#targets <- output_to_dataframe(targets)
predicts <- c()#預測的結果
for(i in 1:dim(targets)[1]){#for i in 1:times，預測每個抽樣
  closed_pattern <- c()#相近的時間點
  target <- targets[i,,]#第i筆資料中的y,x1,x2....
  closed_pattern <- pattern_retrieval(training_data,target,k,1)#找相似
  local_train <- construst_data_array(training_data,closed_pattern,lag,tstar)
  local_train <- output_to_dataframe(local_train)
  
  lm.fit <- lm(V1~V11+V15+V20+V25+V30,data=local_train)
  #summary(lm.fit)
  
  target <- matrix(target,nrow=1)
  target <- as.data.frame(target)
  predicts <- c(predicts,predict(lm.fit,target))
}

#predicts[predicts<0] <- 0
#predicts[predicts>100] <- 100

#lag=10???執行此??????
mean(abs((targets[,1,1]-predicts)/targets[,1,1]))#mape
mean((targets[,1,1]-predicts)^2)#MSE
plot(targets[,1,1]-predicts)#殘差圖
