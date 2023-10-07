setwd('~/Desktop/machinelearning/力綱')
###pre function
MAPE <- function(true, pred){
  dif <- abs(pred - true)
  return(round(mean(dif/true)*100,3))
}
MSPE <-function(true, pred){
  dif <- (pred - true)^2
  return(mean(dif))
}
Boostrap_MAPE_CI <-function(true,pred,B=3000,alpha=0.05){
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
  CI_esitmate <- data.frame(CI_L=round(sort(Boost_MAPE*100)[B*(alpha/2)],2),
                    point.estimator=round(point.estimator,2),
                    CI_U=round(sort(Boost_MAPE*100)[B*(1-alpha/2)],2))
  return <-paste0(CI_esitmate[1,2],'(',CI_esitmate[1,1],',',CI_esitmate[1,3],')')
  return(return)
}
###file name
data_name <- as.vector(t(list.files('~/Desktop/machinelearning/力綱/預測資料')))
###calculate MAPE%,MSE
data_output <- data.frame( ##data structure
  name = c(),
  LASSO_MAPE=c(),
  Forward_MAPE=c(),
  tree_MAPE=c(),
  RF_MAPE =c(),
  SVMR_L_MAPE=c(),
  LASSO_MSPE=c(),
  Forward_MSPE=c(),
  tree_MSPE=c(),
  RF_MSPE =c(),
  SVR_L_MSPE=c()
)
for (i in data_name){
  name1 <- i
  name_read_data <- paste('~/Desktop/machinelearning/力綱/預測資料',name1,sep = '/') 
  data1 <-read.csv(name_read_data)
  return1 <- cbind(
    name=name1,
    LASSO_MAPE=MAPE(data1$true_value,data1$lasso),
    Forward_MAPE=MAPE(data1$true_value,data1$forward),
    tree_MAPE=MAPE(data1$true_value,data1$tree),
    RF_MAPE =MAPE(data1$true_value,data1$Random_Forest),
    SVMR_L_MAPE=MAPE(data1$true_value,data1$SVR_L),
    LASSO_MSPE=MSPE(data1$true_value,data1$lasso),
    Forward_MSPE=MSPE(data1$true_value,data1$forward),
    tree_MSPE=MSPE(data1$true_value,data1$tree),
    RF_MSPE =MSPE(data1$true_value,data1$Random_Forest),
    SVR_L_MSPE=MSPE(data1$true_value,data1$SVR_L)
    )
  data_output<-rbind(data_output,return1)
}
write.csv(data_output,'MAPE&MSPE.csv',row.names = F)


###calculate MAPE% with boostrap CI
data_output <- data.frame( ##data structure
  name = c(),
  LASSO_MAPE=c(),
  Forward_MAPE=c(),
  tree_MAPE=c(),
  RF_MAPE =c(),
  SVMR_L_MAPE=c()
)
for (i in data_name){
  name1 <- i
  name_read_data <- paste('~/Desktop/machinelearning/力綱/預測資料',name1,sep = '/') 
  data1 <-read.csv(name_read_data)
  return1 <- cbind(
    name=name1,
    LASSO_MAPE=Boostrap_MAPE_CI(data1$true_value,data1$lasso),
    Forward_MAPE=Boostrap_MAPE_CI(data1$true_value,data1$forward),
    tree_MAPE=Boostrap_MAPE_CI(data1$true_value,data1$tree),
    RF_MAPE =Boostrap_MAPE_CI(data1$true_value,data1$Random_Forest),
    SVMR_L_MAPE=Boostrap_MAPE_CI(data1$true_value,data1$SVR_L)
  )
  data_output<-rbind(data_output,return1)
}
write.csv(data_output,'MAPE_with_bootstrap_0.95CI.csv',row.names = F)

