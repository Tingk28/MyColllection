setwd('~/Desktop/machinelearning/力綱')
COGg <- read.csv("COGvariables.csv")
test_time <-read.csv('test_time.csv')$x
test_time <-as.POSIXct(test_time)
Holder2_V0 <- COGg$holder2_V0[200000:264961]
timedata <- COGg$time[200000:264961]
true.valuep_1 <- data.frame(true_value=Holder2_V0[which(timedata==test_time[1])+1])
for(i in 2:300){
  true.valuep_1 <- rbind(true.valuep_1 , data.frame(true_value=Holder2_V0[which(timedata==test_time[i])+1]))
  print(i)
}

true.valuep_5 <- data.frame(true_value=Holder2_V0[which(timedata==test_time[1])+5])
for(i in 2:300){
  true.valuep_5 <- rbind(true.valuep_5 , data.frame(true_value=Holder2_V0[which(timedata==test_time[i])+5]))
}

true.valuep_10 <- data.frame(true_value=Holder2_V0[which(timedata==test_time[1])+10])
for(i in 2:300){
  true.valuep_10 <- rbind(true.valuep_10 , data.frame(true_value=Holder2_V0[which(timedata==test_time[i])+10]))
}

true.valuep_30 <- data.frame(true_value=Holder2_V0[which(timedata==test_time[1])+30])
for(i in 2:300){
  true.valuep_30 <- rbind(true.valuep_30 , data.frame(true_value=Holder2_V0[which(timedata==test_time[i])+30]))
}

true.valuep_60 <- data.frame(true_value=Holder2_V0[which(timedata==test_time[1])+60])
for(i in 2:300){
  true.valuep_60 <- rbind(true.valuep_60 , data.frame(true_value=Holder2_V0[which(timedata==test_time[i])+60]))
}

true.valuep_120 <- data.frame(true_value=Holder2_V0[which(timedata==test_time[1])+120])
for(i in 2:300){
  true.valuep_120 <- rbind(true.valuep_120 , data.frame(true_value=Holder2_V0[which(timedata==test_time[i])+120]))
}

true.valuep_180 <- data.frame(true_value=Holder2_V0[which(timedata==test_time[1])+180])
for(i in 2:300){
  true.valuep_180 <- rbind(true.valuep_180 , data.frame(true_value=Holder2_V0[which(timedata==test_time[i])+180]))
}

true.valuep_1440 <- data.frame(true_value=Holder2_V0[which(timedata==test_time[1])+1440])
for(i in 2:300){
  true.valuep_1440 <- rbind(true.valuep_1440 , data.frame(true_value=Holder2_V0[which(timedata==test_time[i])+1440]))
}

data1<-data.frame(
  true.valuep_1 = true.valuep_1,
  true.valuep_5 = true.valuep_5,
  true.valuep_10=true.valuep_10,
  true.valuep_30=true.valuep_30,
  true.valuep_60=true.valuep_60,
  true.valuep_120=true.valuep_120,
  true.valuep_180=true.valuep_180,
  true.valuep_1440=true.valuep_1440
  )
colnames(data1)<-c('p1','p5','p10','p30','p60','p120','p180','p1440')
write.csv(data1,'修改資料.csv',row.names = F)

data2<-data.frame(
  'p1'=true.valuep_1,
  'p5'=true.valuep_5,
  'p10'=true.valuep_10,
  'p30'=true.valuep_30,
  'p60'=true.valuep_60,
  'p120'=true.valuep_120,
  'p180'=true.valuep_180,
  'p1440'=true.valuep_1440
)

test_time <-read.csv('')$x

write.csv(data2,'修改資料2.csv',row.names = F)
