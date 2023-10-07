library("DMwR2")
library("ggplot2")
library("grid") 
library("scales")
library(ISLR2)
##read data and bind them to 1
COGgeneration201307 <- read.csv("Desktop/machinelearning/COGgeneration201307.csv")
COGgeneration201308 <- read.csv("Desktop/machinelearning/COGgeneration201308.csv")
COGgeneration201309 <- read.csv("Desktop/machinelearning/COGgeneration201309.csv")
COGgeneration201310 <- read.csv("Desktop/machinelearning/COGgeneration201310.csv")
COGgeneration201311 <- read.csv("Desktop/machinelearning/COGgeneration201311.csv")
COGgeneration201312 <- read.csv("Desktop/machinelearning/COGgeneration201312.csv")
COGg <- rbind(COGgeneration201307,COGgeneration201308,COGgeneration201309,COGgeneration201310,COGgeneration201311,COGgeneration201312)
write.csv(COGg,"Desktop/machinelearning/COGgerneration2013.csv")
## basic statistic inference
COGg$`W51_TT-101.OV` <- as.double(COGg$`W51_TT-101.OV`)
summary(COGg)
boxplot(COGg[,2])
boxplot(COGg[,3])
## geration outlier detect and time series graph
COGg_knn <- knnImputation(COGg[,2:9], k = 10, scale = TRUE, meth = "weighAvg",distData = NULL)
plot(seq_along(COGg_knn[,1]),COGg_knn[,1],'l',xlab='time',ylab='NM3/hr',main='一,二階COG產量W51_FT-101D.OV')
write.csv(COGg_knn,"Desktop/machinelearning/COGgerneration2013_useknn2.csv")

pl_data <- cbind(COGg[,1],COGg_knn[,1])
GOCtime1 <- ggplot(data = pl_data, mapping = aes(x = time, y = pl_data[,2])) + geom_line(colour = "blue")

pl_data2 <- cbind(COGg[,1],COGg_knn[,2])
GOCtime2 <-ggplot(data = pl_data2, mapping = aes(x = time, y = pl_data2[,2])) + geom_line(colour = "red")

## level 
pl_data3 <- cbind(COGg[,1],COGg_knn[,5])
colnames(pl_data3)[2]<-'tanklevel'
ggplot(data = pl_data3, mapping = aes(x = time, y = tanklevel)) + geom_line(colour = "blue")+labs(x = "time", y = "tank level", title = "W51_LX-152-1.OV")+scale_x_datetime(breaks = "month")
pl_data4 <- cbind(COGg[,1],COGg_knn[,6])
ggplot(data = pl_data4, mapping = aes(x = time, y = pl_data4[,2])) + geom_line(colour = "red")+labs(x = "time", y = "tank level", title = "W51_LX-152-2.OV")+scale_x_datetime(breaks = "month")
##spacial time1
pl_data4 <- cbind(COGg[242000:255000,1],COGg_knn[242000:255000,5])
colnames(pl_data4)[2]<-'tanklevel'
ggplot(data = pl_data4, mapping = aes(x = time, y = tanklevel)) + geom_line(colour = "blue")+labs(x = "time", y = "tank level", title = "W51_LX-152-1.OV")+scale_x_datetime(breaks = "3 days")
pl_data5 <- cbind(COGg[242000:255000,1],COGg_knn[242000:255000,6])
ggplot(data = pl_data5, mapping = aes(x = time, y = pl_data5[,2])) + geom_line(colour = "red")+labs(x = "time", y = "tank level", title = "W51_LX-152-1.OV")+scale_x_datetime(breaks = "month")
pl_data6 <-cbind(COGg[242000:255000,1],COGg_knn[242000:255000,5],COGg_knn[242000:255000,6])
ggplot(pl_data6, aes(x = time)) +
  geom_line(aes(y = pl_data6[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = pl_data6[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "tank level", title = "W51_LX-152.OV")
##spacial time2
pl_data7 <-cbind(COGg[7707:10127,1],COGg_knn[7707:10127,5],COGg_knn[7707:10127,6])
ggplot(pl_data7, aes(x = time)) +
  geom_line(aes(y = pl_data7[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = pl_data7[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "tank level", title = "W51_LX-152.OV")
##special time3
pl_data8 <-cbind(COGg[12967:14406,1],COGg_knn[12967:14406,5],COGg_knn[12967:14406,6])
ggplot(pl_data8, aes(x = time)) +
  geom_line(aes(y = pl_data8[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = pl_data8[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "tank level", title = "W51_LX-152.OV")
##special time4
pl_data9 <-cbind(COGg[47319:48279,1],COGg_knn[47319:48279,5],COGg_knn[47319:48279,6])
ggplot(pl_data9, aes(x = time)) +
  geom_line(aes(y = pl_data9[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = pl_data9[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "tank level", title = "W51_LX-152.OV")
##special time5
pl_data10 <-cbind(COGg[178595:179346,1],COGg_knn[178595:179346,5],COGg_knn[178595:179346,6])
ggplot(pl_data10, aes(x = time)) +
  geom_line(aes(y = pl_data10[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = pl_data10[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "tank level", title = "W51_LX-152.OV")
##special time6
pl_data11 <-cbind(COGg[228962:229805,1],COGg_knn[228962:229805,5],COGg_knn[228962:229805,6])
ggplot(pl_data11, aes(x = time)) +
  geom_line(aes(y = pl_data11[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = pl_data11[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "tank level", title = "W51_LX-152.OV")
##special time7
pl_data12 <-cbind(COGg[234357:235883,1],COGg_knn[234357:235883,5],COGg_knn[234357:235883,6])
ggplot(pl_data12, aes(x = time)) +
  geom_line(aes(y = pl_data12[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = pl_data12[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "tank level", title = "W51_LX-152.OV")

##COR
cor(COGg_knn[,1],COGg_knn[,2])


##pairs
ggscatmat(COGg[,2:9])
