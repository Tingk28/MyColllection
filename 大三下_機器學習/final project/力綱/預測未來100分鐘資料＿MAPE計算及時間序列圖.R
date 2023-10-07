setwd('~/Desktop/machinelearning/力綱')
library(ggplot2)

###MAPE_Calculate
MAPE <- function(true, pred){
  dif <- abs(pred - true)
  return(round(mean(dif/true)*100,3))
}
### MAPE_times
MAPE_times <- function(pre_time,data){
  data_output <- data.frame( ##data structure
    predict.times = c(5,10,15,30,50,100),
    lasso = rep(NA,6),
    forward =rep (NA,6),
    tree = rep(NA,6),
    Random_Forest = rep(NA,6)
  )
  true_value <- data$true_value
  lasso <- data$lasso
  forward <- data$forward
  tree <- data$tree
  Random_Forest <- data$Random_Forest
  for (t in c(5,10,15,30,50,100)) {
    data_output$lasso[which(data_output$predict.times==t)] <- MAPE(true_value[(pre_time+1):(pre_time+t)],lasso[(pre_time+1):(pre_time+t)])
    data_output$forward[which(data_output$predict.times==t)] <- MAPE(true_value[(pre_time+1):(pre_time+t)],forward[(pre_time+1):(pre_time+t)])
    data_output$tree[which(data_output$predict.times==t)] <- MAPE(true_value[(pre_time+1):(pre_time+t)],tree[(pre_time+1):(pre_time+t)])
    data_output$Random_Forest[which(data_output$predict.times==t)] <- MAPE(true_value[(pre_time+1):(pre_time+t)],Random_Forest[(pre_time+1):(pre_time+t)])
  }
  return(data_output)
}


###time_series_plot

time_series_plot <- function(pre_time,data){
  data$time <- as.POSIXct(data$time)
  beging_time <- data$time[pre_time]
  p<-ggplot(data, aes(x = time)) +
    geom_line(aes(y = data$true_value,colour = "true_value" )) +
    geom_line(aes(y = data$lasso,colour = "lasso")) +
    geom_line(aes(y = data$forward,colour = "forward")) +
    geom_line(aes(y = data$tree,colour = "tree")) +
    geom_line(aes(y = data$Random_Forest,colour = "Random_Forest")) +
    labs(x = "time", y = "m^3", title = beging_time)
  return(p)
}
###caculation MAPE
data_name <- as.vector(t(list.files('~/Desktop/machinelearning/力綱/time_series_forest_data')))
for(i in data_name){
  name1 <- paste0('~/Desktop/machinelearning/力綱/time_series_forest_data/',i)
  data1 <- read.csv(name1)
  output_data <- MAPE_times(100,data1)
  name2 <- paste0('~/Desktop/machinelearning/力綱/time_series_forest_result/',i)
  write.csv(output_data,name2,row.names = F)
}
for(i in data_name){
  name1 <- paste0('~/Desktop/machinelearning/力綱/time_series_forest_data/',i)
  data1 <- read.csv(name1)
  output_data <- time_series_plot(100,data1)
  name2 <-paste0('~/Desktop/machinelearning/力綱/time_series_forest_result/',i,'.png')
  png(name2,width=700, height=500)
  print(output_data)
  dev.off()
}

###arima 
ar_data <- read.csv('test_result_final.csv')
data1_lag10_local <-  read.csv('~/Desktop/machinelearning/力綱/time_series_forest_data/Predtion_235432_lag_10_k_500_pre_100_prediction_100.csv')
data1_lag10_nlocal <-  read.csv('~/Desktop/machinelearning/力綱/time_series_forest_data/Predtion_non_local_235432_lag_10_k_500_pre_100_prediction_100.csv')
data1_lag20_local <- read.csv('~/Desktop/machinelearning/力綱/time_series_forest_data/Predtion_235432_lag_20_k_500_pre_100_prediction_100.csv')
data1_lag20_nlocal <- read.csv('~/Desktop/machinelearning/力綱/time_series_forest_data/Predtion_235432_lag_20_k_500_pre_100_prediction_100_non_local.csv')
data1_lag30_local <- read.csv('~/Desktop/machinelearning/力綱/time_series_forest_data/Predtion_235432_lag_30_k_500_pre_100_prediction_100.csv')
data1_lag30_nlocal <- read.csv('~/Desktop/machinelearning/力綱/time_series_forest_data/Predtion_235432_lag_30_k_500_pre_100_prediction_100_non_local.csv')
###MAPE
predict.times = c(5,10,30,100)
true_value <- data1$true_value[101:200]
for(i in predict.times){
  print(MAPE(true_value[1:i],ar_data$X2013.12.11.11.50[1:i]))
}
###plot data1
ar_plot_data1 <-c(rep(NA,100),ar_data$X2013.12.11.11.50)
p <- time_series_plot(100,data1_lag10_local)
p<-p+geom_line(aes(y = ar_plot_data1,colour = "Arima" ))
png('data1_lag_10_local.png',width=700, height=500)
print(p)
dev.off()
p <- time_series_plot(100,data1_lag10_nlocal)
p<-p+geom_line(aes(y = ar_plot_data1,colour = "Arima" ))
png('data1_lag_10_nlocal.png',width=700, height=500)
print(p)
dev.off()
p <- time_series_plot(100,data1_lag20_local)
p<-p+geom_line(aes(y = ar_plot_data1,colour = "Arima" ))
png('data1_lag_20_local.png',width=700, height=500)
print(p)
dev.off()
p <- time_series_plot(100,data1_lag20_nlocal)
p<-p+geom_line(aes(y = ar_plot_data1,colour = "Arima" ))
png('data1_lag_20_nlocal.png',width=700, height=500)
print(p)
dev.off()
p <- time_series_plot(100,data1_lag30_local)
p<-p+geom_line(aes(y = ar_plot_data1,colour = "Arima" ))
png('data1_lag_30_local.png',width=700, height=500)
print(p)
dev.off()
p <- time_series_plot(100,data1_lag30_nlocal)
p<-p+geom_line(aes(y = ar_plot_data1,colour = "Arima" ))
png('data1_lag_30_nlocal.png',width=700, height=500)
print(p)
dev.off()

###2
data2_lag10_local <-  read.csv('~/Desktop/machinelearning/力綱/time_series_forest_data/Predtion_230674_lag_10_k_500_pre_100_prediction_100.csv')
data2_lag10_nlocal <-  read.csv('~/Desktop/machinelearning/力綱/time_series_forest_data/Predtion_non_local_230674_lag_10_k_500_pre_100_prediction_100.csv')
predict.times = c(5,10,30,100)
true_value2 <- data2_lag10_local$true_value[101:200]
for(i in predict.times){
  print(MAPE(true_value2[1:i],ar_data$X2013.12.8.4.32[1:i]))
}

ar_plot_data2 <-c(rep(NA,100),ar_data$X2013.12.8.4.32)
p <- time_series_plot(100,data2_lag10_local)
p<-p+geom_line(aes(y = ar_plot_data2,colour = "Arima" ))
png('data2_lag_10_local.png',width=700, height=500)
print(p)
dev.off()

p <- time_series_plot(100,data2_lag10_nlocal)
p<-p+geom_line(aes(y = ar_plot_data2,colour = "Arima" ))
png('data2_lag_10_nlocal.png',width=700, height=500)
print(p)
dev.off()
