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

pattern_retrieval <- function(data,target,k,diff=0){#data and target 可為多維度資料，請確保二者的col數一致
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
  return(which(distance_list<=threshold))
}
construst_data_array <- function(data,index,lag,tstar){
  output <- array(NA,dim=c(length(index),lag,dim(data)[2]+1))
  output[,,1] <- c(data[index+tstar,1],rep(NA,(lag-1)*length(index)))
  for(i in 1:dim(data)[2]){
    temp_output <- c()#暫時存各變數的數值
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