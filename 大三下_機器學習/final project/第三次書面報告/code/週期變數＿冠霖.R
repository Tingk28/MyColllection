setwd("D:/成功大學/機器學習/COG 201307-12/machinelearning-main")
df <- read.csv("D:/成功大學/機器學習/COG 201307-12/machinelearning-main/COGgeneration2013_useknn2.csv",header=TRUE,sep=",")
head(df)
library(forecast)
#df$Date <- as.Date(df$time, "%Y-%m-%d")
df_sum <- df$W51_LX.152.1.OV+ df$W51_LX.152.2.OV
df$time <- as.POSIXct(df$time)
#10days
df10d <- df$W51_LX.152.1.OV[2:14400]
dfts.daily10d <- ts(df10d, frequency = 60*24)
dfts.daily10d
components_dfts.daily10d <- stl(dfts.daily10d, s.window="period")
components_dfts.daily10d.table <- components_dfts.daily10d$time.series
plot(components_dfts.daily10d)
View(components_dfts.daily10d.table)
components_dfts.daily10dd <- decompose(dfts.daily10d)
plot(components_dfts.daily10dd)
components_dfts.daily10dd$seasonal
#str(components_dfts.daily10d)
#components_dfts.daily10d$seasonal[1]
#components_dfts.daily10d$seasonal[1441]
seasonal.test<-as.data.frame(cbind(components_dfts.daily10dd$seasonal,components_dfts.daily10d.table[,1]))
colnames(seasonal.test)<-c("seasonal by decompose","seasonal by stl")
trend.test<-as.data.frame(cbind(components_dfts.daily10dd$trend,components_dfts.daily10d.table[,2]))
colnames(trend.test)<-c("trend by decompose","trend by stl")
random.test<-as.data.frame(cbind(components_dfts.daily10dd$random,components_dfts.daily10d.table[,3]))
colnames(random.test)<-c("remainder by decompose","remainder by stl")
View(cbind(seasonal.test,trend.test,random.test))
#daily
##holder1
dfts.daily1 <- ts(df$W51_LX.152.1.OV[2:220322], frequency = 60*24)
dfts.daily1
components_dfts.daily1 <- stl(dfts.daily1, s.window="period")
components_dfts.daily1.table <- components_dfts.daily1$time.series
plot(components_dfts.daily1,main = "holder1_日")
View(components_dfts.daily1.table)
components_dfts.daily1.table[,1]
##holder2
dfts.daily2 <- ts(df$W51_LX.152.2.OV[2:220322], frequency = 60*24)
dfts.daily2
components_dfts.daily2 <- stl(dfts.daily2, s.window="period")
components_dfts.daily2.table <- components_dfts.daily2$time.series
plot(components_dfts.daily2,main = "holder2_日")
View(components_dfts.daily2.table)
components_dfts.daily2.table[,1]
##holder1+2
dfts.daily1.2 <- ts(df_sum[2:220322], frequency = 60*24)
dfts.daily1.2
components_dfts.daily1.2 <- stl(dfts.daily1.2, s.window="period")
components_dfts.daily1.2.table <- components_dfts.daily1.2$time.series
plot(components_dfts.daily1.2,main = "holder_total_日")
View(components_dfts.daily1.2.table)
components_dfts.daily1.2.table[,1]
#weekly
##holder1
dfts.weekly1 <- ts(df$W51_LX.152.1.OV[2:220322], frequency = 60*24*7)
dfts.weekly1
components_dfts.weekly1 <- stl(dfts.weekly1, s.window="period")
components_dfts.weekly1.table <- components_dfts.weekly1$time.series
plot(components_dfts.weekly1,main = "holder1_周")
View(components_dfts.weekly1.table)
components_dfts.weekly1.table[,1]
##holder2
dfts.weekly2 <- ts(df$W51_LX.152.2.OV[2:220322], frequency = 60*24*7)
dfts.weekly2
components_dfts.weekly2 <- stl(dfts.weekly2, s.window="period")
components_dfts.weekly2.table <- components_dfts.weekly2$time.series
plot(components_dfts.weekly2,main = "holder2_周")
View(components_dfts.weekly2.table)
components_dfts.weekly2.table[,1]
##holder1+2
dfts.weekly1.2 <- ts(df_sum[2:220322], frequency = 60*24*7)
dfts.weekly1.2
components_dfts.weekly1.2 <- stl(dfts.weekly1.2, s.window="period")
components_dfts.weekly1.2.table <- components_dfts.weekly1.2$time.series
plot(components_dfts.weekly1.2,main = "holder_total_周")
components_dfts.weekly1.2.table[,1]

seasonality<-data.frame(df$time[1:220321],components_dfts.daily1.table[,1],components_dfts.daily2.table[,1],components_dfts.daily1.2.table[,1],components_dfts.weekly1.table[,1],components_dfts.weekly2.table[,1],components_dfts.weekly1.2.table[,1])
colnames(seasonality)<-c("time","daily_holder1","daily_holder2","daily_holder_total","weekly_holder1","weekly_holder2","weekly_holder_total")
write.csv(seasonality,"D:/成功大學/機器學習/0507/seasonality_training.csv",row.names=F)
View(seasonality)
seasonality[1,]
seasonality[1441,]
seasonality[10081,]

