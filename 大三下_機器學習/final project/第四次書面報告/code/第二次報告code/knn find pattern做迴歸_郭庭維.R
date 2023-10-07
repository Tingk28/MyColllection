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
pattern_retrieval <- function(data,target,k){
  lag <- length(target)  
  data <- data_reconstruct(data,lag)
  data <- na.omit(data)
  distance_list <- c()
  distance_list <- apply(X = data, 1, FUN = function(x) distance1(x,target))
  #for(i in 1:dim(data)[1]){
  #  row <- data[i,]
  #  distance_list <- c(distance_list,distance1(row,target))
  #}

  
  distance_list_sort <- sort(distance_list)
  threshold <- distance_list_sort[k]
  a <- which(distance_list<=threshold)
  #print(data[a[1],])
  #print(a[1]+lag-1)
  return(a+lag-1)
  
}
distance1 <- function(a,b){
  (sum((a-b)^2))^0.5
}


COGg07 <- read.csv("資料/COGgeneration201307.csv")#先使用七月份的資料看看效果
COGg07 <- COGg07$W51_LX.152.2.OV#以預測變化較大的holder2為主

lag <- 10#投入前多少分鐘的資料
k <- 30#找距離前K近的Pattern
tstar <- 5#預測多久後的資料
times <- 500#預測多少次
training_data <- COGg07[1:30000]

targets <- c()#想找的pattern集合
for(i in 1:times){
  end <- sample(30000:44600,1)
  targets <-c(targets,COGg07[(end-lag+1):end],COGg07[end+tstar])
}
targets <- matrix(data = targets,nrow=times,byrow = T)
targets <- as.data.frame(targets)
targets <- na.omit(targets)
predicts <- c()
for(i in 1:dim(targets)[1]){
  closed_pattern <- c()
  target <- targets[i,]
  closed_pattern <- pattern_retrieval(training_data,unlist(target[1:lag]),k)#找相似
  #print(i)
  local_train <- matrix(NA,ncol = lag+1,nrow = length(closed_pattern))#enpty matrix
  for(i in 1:length(closed_pattern)){#組出x matrix
    end <- closed_pattern[i]
    local_train[i,] <- c(COGg07[(end-lag+1):end],COGg07[end+tstar])
  }
  local_train <- as.data.frame(local_train)
  lm.fit <- lm(V11~V1+V5+V10,data=local_train)
  #summary(lm.fit)
  predicts <- c(predicts,predict(lm.fit,as.data.frame(target)))
  
}
predicts[predicts<0] <- 0
predicts[predicts>100] <- 100

#曾使用lag=5作為預測，此段為lag=5時的才執行區塊
#mean(abs((targets$V6-predicts)/targets$V6))#MAPE
#mean((targets$V6-predicts)^2)#MSE
#plot(targets$V6-predicts


#lag=10時執行此區塊
mean(abs((targets$V11-predicts)/targets$V11))
mean((targets$V11-predicts)^2)
plot(targets$V11-predicts)

#lag=15時執行此區塊
mean(abs((targets$V16-predicts)/targets$V16))
mean((targets$V16-predicts)^2)
plot(targets$V16-predicts)
