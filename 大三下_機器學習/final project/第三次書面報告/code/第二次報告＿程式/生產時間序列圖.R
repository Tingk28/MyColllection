library('ggplot2')
COGgerneration2013_useknn2 <- read.csv("~/Desktop/machinelearning/資料/COGgerneration2013_useknn2.csv")
COGgerneration2013 <- read.csv("~/Desktop/machinelearning//資料/COGgerneration2013.csv")
COGgerneration2013_useknn2$time <- COGgerneration2013$time
colnames(COGgerneration2013_useknn2)[1] <- 'time'
write.csv(COGgerneration2013_useknn2,"Desktop/machinelearning/COGgerneration2013_useknn2.csv",row.names = F)
## Holder 壓力 W51_PT-101.OV & W51_PX-153.OV
###full_time
data_press <- as.data.frame(cbind(COGgerneration2013_useknn2$time,COGgerneration2013_useknn2$W51_PT.101.OV,COGgerneration2013_useknn2$W51_PX.153.OV))
colnames(data_press) <- c('time','W51_PT-101.OV','W51_PX-153.OV')
data_press$time<-as.POSIXct(data_press$time)
data_press$`W51_PT-101.OV`<-as.numeric(data_press$`W51_PT-101.OV`)
data_press$`W51_PX-153.OV`<-as.numeric(data_press$`W51_PX-153.OV`)
ggplot(data_press, aes(x = time)) +
  geom_line(aes(y = data_press[,2],colour = "W51_PT-101.OV" )) +
  geom_line(aes(y = data_press[,3],colour = "W51_PX-153.OV")) +
  labs(x = "time", y = "mmH2O", title = "COG Holder press")
###7/7
data_press_7_7 <-data_press[grep('2013-07-07',data_press$time),]
ggplot(data_press_7_7, aes(x = data_press_7_7[,1])) +
  geom_line(aes(y = data_press_7_7[,2],colour = "W51_PT-101.OV" )) +
  geom_line(aes(y = data_press_7_7[,3],colour = "W51_PX-153.OV")) +
  labs(x = "time", y = "mmH2O", title = "COG Holder press 7/7")
###7/19
data_press_7_19 <-data_press[grep('2013-07-19',data_press$time),]
ggplot(data_press_7_19, aes(x = data_press_7_19[,1])) +
  geom_line(aes(y = data_press_7_19[,2],colour = "W51_PT-101.OV" )) +
  geom_line(aes(y = data_press_7_19[,3],colour = "W51_PX-153.OV")) +
  labs(x = "time", y = "mmH2O", title = "COG Holder press 7/19")
###9/1
data_press_9_1 <-data_press[grep('2013-09-01',data_press$time),]
ggplot(data_press_9_1, aes(x = data_press_9_1[,1])) +
  geom_line(aes(y = data_press_9_1[,2],colour = "W51_PT-101.OV" )) +
  geom_line(aes(y = data_press_9_1[,3],colour = "W51_PX-153.OV")) +
  labs(x = "time", y = "mmH2O", title = "COG Holder press 9/1")
###9/7
data_press_9_7 <-data_press[grep('2013-09-07',data_press$time),]
ggplot(data_press_9_7, aes(x = data_press_9_7[,1])) +
  geom_line(aes(y = data_press_9_7[,2],colour = "W51_PT-101.OV" )) +
  geom_line(aes(y = data_press_9_7[,3],colour = "W51_PX-153.OV")) +
  labs(x = "time", y = "mmH2O", title = "COG Holder press 9/07")
###10/2
data_press_10_2 <-data_press[grep('2013-10-02',data_press$time),]
ggplot(data_press_10_2, aes(x = data_press_10_2[,1])) +
  geom_line(aes(y = data_press_10_2[,2],colour = "W51_PT-101.OV" )) +
  geom_line(aes(y = data_press_10_2[,3],colour = "W51_PX-153.OV")) +
  labs(x = "time", y = "mmH2O", title = "COG Holder press 10/02")
###7_8_14
data_press_7_8_14 <-data_press[grep('2013-07-08|2013-07-09|2013-07-10|2013-07-11|2013-07-12|2013-07-13|2013-07-14',data_press$time),]
ggplot(data_press_7_8_14, aes(x = data_press_7_8_14[,1])) +
  geom_line(aes(y = data_press_7_8_14[,2],colour = "W51_PT-101.OV" )) +
  geom_line(aes(y = data_press_7_8_14[,3],colour = "W51_PX-153.OV")) +
  labs(x = "time", y = "mmH2O", title = "COG Holder press 7/8~7/14")
###8_1_7
data_press_8_1_7 <-data_press[grep('2013-08-01|2013-08-02|2013-08-03|2013-08-04|2013-08-05|2013-08-06|2013-08-07',data_press$time),]
ggplot(data_press_8_1_7, aes(x = data_press_8_1_7[,1])) +
  geom_line(aes(y = data_press_8_1_7[,2],colour = "W51_PT-101.OV" )) +
  geom_line(aes(y = data_press_8_1_7[,3],colour = "W51_PX-153.OV")) +
  ylim(850,1100)+
  labs(x = "time", y = "mmH2O", title = "COG Holder press 8/1~8/7")
###9_15_22
data_press_9_15_21 <-data_press[grep('2013-09-15|2013-09-16|2013-09-17|2013-09-18|2013-09-19|2013-09-20|2013-09-21',data_press$time),]
ggplot(data_press_9_15_21, aes(x = data_press_9_15_21[,1])) +
  geom_line(aes(y = data_press_9_15_21[,2],colour = "W51_PT-101.OV" )) +
  geom_line(aes(y = data_press_9_15_21[,3],colour = "W51_PX-153.OV")) +
  ylim(850,1100)+
  labs(x = "time", y = "mmH2O", title = "COG Holder press 9/15~9/21")
## Holder液位 W51_LX-152-1.OV W51_LX-152-2.OV
###full time
data_level <- as.data.frame(cbind(COGgerneration2013_useknn2$time,COGgerneration2013_useknn2$W51_LX.152.1.OV,COGgerneration2013_useknn2$W51_LX.152.2.OV))
colnames(data_level) <- c('time','W51_LX-152-1.OV','W51_LX-152-2.OV')
data_level$time<-as.POSIXct(data_level$time)
data_level$`W51_LX-152-1.OV`<-as.numeric(data_level$`W51_LX-152-1.OV`)
data_level$`W51_LX-152-2.OV`<-as.numeric(data_level$`W51_LX-152-2.OV`)
ggplot(data_level, aes(x = time)) +
  geom_line(aes(y = data_level[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = data_level[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "%", title = "COG Holder level")
###7/7
data_level_7_7 <-data_level[grep('2013-07-07',data_level$time),]
ggplot(data_level_7_7, aes(x = data_level_7_7[,1])) +
  geom_line(aes(y = data_level_7_7[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = data_level_7_7[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "%", title = "COG Holder level 7/7")
###7/19
data_level_7_19 <-data_level[grep('2013-07-19',data_level$time),]
ggplot(data_level_7_19, aes(x = data_level_7_19[,1])) +
  geom_line(aes(y = data_level_7_19[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = data_level_7_19[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "%", title = "COG Holder level 7/19")
###9/1
data_level_9_1 <-data_level[grep('2013-09-01',data_level$time),]
ggplot(data_level_9_1, aes(x = data_level_9_1[,1])) +
  geom_line(aes(y = data_level_9_1[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = data_level_9_1[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "%", title = "COG Holder level 9/1")
###9/7
data_level_9_7 <-data_level[grep('2013-09-07',data_level$time),]
ggplot(data_level_9_7, aes(x = data_level_9_7[,1])) +
  geom_line(aes(y = data_level_9_7[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = data_level_9_7[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "%", title = "COG Holder level 9/7")
###10/2
data_level_10_2 <-data_level[grep('2013-10-02',data_level$time),]
ggplot(data_level_10_2, aes(x = data_level_10_2[,1])) +
  geom_line(aes(y = data_level_10_2[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = data_level_10_2[,3],colour = "W51_LX-152-2.OV")) +
  labs(x = "time", y = "%", title = "COG Holder level 10/2")

###7_8_14
data_level_7_8_14 <-data_level[grep('2013-07-08|2013-07-09|2013-07-10|2013-07-11|2013-07-12|2013-07-13|2013-07-14',data_press$time),]
ggplot(data_level_7_8_14, aes(x = data_level_7_8_14[,1])) +
  geom_line(aes(y = data_level_7_8_14[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = data_level_7_8_14[,3],colour = "W51_LX-152-2.OV")) +
  ylim(10,90)+
  labs(x = "time", y = "%", title = "COG Holder level 7/8~7/14")
###8_1_7
data_level_8_1_7 <-data_level[grep('2013-08-01|2013-08-02|2013-08-03|2013-08-04|2013-08-05|2013-08-06|2013-08-07',data_press$time),]
ggplot(data_level_8_1_7, aes(x = data_level_8_1_7[,1])) +
  geom_line(aes(y = data_level_8_1_7[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = data_level_8_1_7[,3],colour = "W51_LX-152-2.OV")) +
  ylim(10,90)+
  labs(x = "time", y = "%", title = "COG Holder level 8/1~8/7")
###9_15_22
data_level_9_15_21 <-data_level[grep('2013-09-15|2013-09-16|2013-09-17|2013-09-18|2013-09-19|2013-09-20|2013-09-21',data_press$time),]
ggplot(data_level_9_15_21, aes(x = data_level_9_15_21[,1])) +
  geom_line(aes(y = data_level_9_15_21[,2],colour = "W51_LX-152-1.OV" )) +
  geom_line(aes(y = data_level_9_15_21[,3],colour = "W51_LX-152-2.OV")) +
  ylim(10,90)+
  labs(x = "time", y = "%", title = "COG Holder level 9/15~9/22")

## COG產量 W51_FT-101D.OV W51_FX-153.OV
###full time
data_gernerate <- as.data.frame(cbind(COGgerneration2013_useknn2$time,COGgerneration2013_useknn2$W51_FT.101D.OV,COGgerneration2013_useknn2$W51_FX.153.OV))
colnames(data_gernerate) <- c('time','W51_FT-101D.OV','W51_FX-153.OV')
data_gernerate$time<-as.POSIXct(data_gernerate$time)
data_gernerate$`W51_FT-101D.OV`<-as.numeric(data_gernerate$`W51_FT-101D.OV`)
data_gernerate$`W51_FX-153.OV`<-as.numeric(data_gernerate$`W51_FX-153.OV`)
ggplot(data_gernerate, aes(x = time)) +
  geom_line(aes(y = data_gernerate[,2],colour = "W51_FT-101D.OV" )) +
  geom_line(aes(y = data_gernerate[,3],colour = "W51_FX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG gernerate")
###7/7
data_gernerate_7_7 <-data_gernerate[grep('2013-07-07',data_gernerate$time),]
ggplot(data_gernerate_7_7, aes(x = data_gernerate_7_7[,1])) +
  geom_line(aes(y = data_gernerate_7_7[,2],colour = "W51_FT-101D.OV" )) +
  geom_line(aes(y = data_gernerate_7_7[,3],colour = "W51_FX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG gernerate 7/7")
###7/19
data_gernerate_7_19 <-data_gernerate[grep('2013-07-19',data_gernerate$time),]
ggplot(data_gernerate_7_19, aes(x = data_gernerate_7_19[,1])) +
  geom_line(aes(y = data_gernerate_7_19[,2],colour = "W51_FT-101D.OV" )) +
  geom_line(aes(y = data_gernerate_7_19[,3],colour = "W51_FX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG gernerate 7/19")
###9/1
data_gernerate_9_1 <-data_gernerate[grep('2013-09-01',data_gernerate$time),]
ggplot(data_gernerate_9_1, aes(x = data_gernerate_9_1[,1])) +
  geom_line(aes(y = data_gernerate_9_1[,2],colour = "W51_FT-101D.OV" )) +
  geom_line(aes(y = data_gernerate_9_1[,3],colour = "W51_FX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG gernerate 9/1")
###9/7
data_gernerate_9_7 <-data_gernerate[grep('2013-09-07',data_gernerate$time),]
ggplot(data_gernerate_9_7, aes(x = data_gernerate_9_7[,1])) +
  geom_line(aes(y = data_gernerate_9_7[,2],colour = "W51_FT-101D.OV" )) +
  geom_line(aes(y = data_gernerate_9_7[,3],colour = "W51_FX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG gernerate 9/7")
###10/2
data_gernerate_10_2 <-data_gernerate[grep('2013-10-02',data_gernerate$time),]
ggplot(data_gernerate_10_2, aes(x = data_gernerate_10_2[,1])) +
  geom_line(aes(y = data_gernerate_10_2[,2],colour = "W51_FT-101D.OV" )) +
  geom_line(aes(y = data_gernerate_10_2[,3],colour = "W51_FX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG gernerate 10/2")

###7_8_14
data_gernerate_7_8_14 <-data_gernerate[grep('2013-07-08|2013-07-09|2013-07-10|2013-07-11|2013-07-12|2013-07-13|2013-07-14',data_press$time),]
ggplot(data_gernerate_7_8_14, aes(x = data_gernerate_7_8_14[,1])) +
  geom_line(aes(y = data_gernerate_7_8_14[,2],colour = "W51_FT-101D.OV" )) +
  geom_line(aes(y = data_gernerate_7_8_14[,3],colour = "W51_FX-153.OV")) +
  ylim(40000,200000)+
  labs(x = "time", y = "NM3/hr", title = "COG gernerate level 7/8~7/14")
###8_1_7
data_gernerate_8_1_7 <-data_gernerate[grep('2013-08-01|2013-08-02|2013-08-03|2013-08-04|2013-08-05|2013-08-06|2013-08-07',data_press$time),]
ggplot(data_gernerate_8_1_7, aes(x = data_gernerate_8_1_7[,1])) +
  geom_line(aes(y = data_gernerate_8_1_7[,2],colour = "W51_FT-101D.OV" )) +
  geom_line(aes(y = data_gernerate_8_1_7[,3],colour = "W51_FX-153.OV")) +
  ylim(40000,200000)+
  labs(x = "time", y = "NM3/hr", title = "COG gernerate level 8/1~8/7")
###9_15_22
data_gernerate_9_15_21 <-data_gernerate[grep('2013-09-15|2013-09-16|2013-09-17|2013-09-18|2013-09-19|2013-09-20|2013-09-21',data_press$time),]
ggplot(data_gernerate_9_15_21, aes(x = data_gernerate_9_15_21[,1])) +
  geom_line(aes(y = data_gernerate_9_15_21[,2],colour = "W51_FT-101D.OV" )) +
  geom_line(aes(y = data_gernerate_9_15_21[,3],colour = "W51_FX-153.OV")) +
  ylim(40000,200000)+
  labs(x = "time", y = "NM3/hr", title = "COG gernerate level 9/15~9/22")

## Holder溫度 W51_TT-101.OV W51_TX-153.OV
data_temp <- as.data.frame(cbind(COGgerneration2013_useknn2$time,COGgerneration2013_useknn2$W51_TT.101.OV,COGgerneration2013_useknn2$W51_TX.153.OV))
colnames(data_temp ) <- c('time','W51_TT-101.OV','W51_TX-153.OV')
data_temp$time<-as.POSIXct(data_temp$time)
data_temp$`W51_TT-101.OV`<-as.numeric(data_temp$`W51_TT-101.OV`)
data_temp$`W51_TX-153.OV`<-as.numeric(data_temp$`W51_TX-153.OV`)
ggplot(data_temp , aes(x = time)) +
  geom_line(aes(y = data_temp [,2],colour = "W51_TT-101.OV" )) +
  geom_line(aes(y = data_temp [,3],colour = "W51_TX-153.OV")) +
  labs(x = "time", y = "C", title = "COG Holder temperature")

###7/7
data_temp_7_7 <-data_temp[grep('2013-07-07',data_temp$time),]
ggplot(data_temp_7_7, aes(x = data_temp_7_7[,1])) +
  geom_line(aes(y = data_temp_7_7[,2],colour = "W51_TT-101.OV" )) +
  geom_line(aes(y = data_temp_7_7[,3],colour = "W51_TX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG Holder temperature 7/7")
###7/19
data_temp_7_19 <-data_temp[grep('2013-07-19',data_temp$time),]
ggplot(data_temp_7_19, aes(x = data_temp_7_19[,1])) +
  geom_line(aes(y = data_temp_7_19[,2],colour = "W51_TT-101.OV" )) +
  geom_line(aes(y = data_temp_7_19[,3],colour = "W51_TX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG Holder temperature 7/19")
###9/1
data_temp_9_1 <-data_temp[grep('2013-09-01',data_temp$time),]
ggplot(data_temp_9_1, aes(x = data_temp_9_1[,1])) +
  geom_line(aes(y = data_temp_9_1[,2],colour = "W51_TT-101.OV" )) +
  geom_line(aes(y = data_temp_9_1[,3],colour = "W51_TX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG Holder temperature 9/1")
###9/7
data_temp_9_7 <-data_temp[grep('2013-09-07',data_temp$time),]
ggplot(data_temp_9_7, aes(x = data_temp_9_7[,1])) +
  geom_line(aes(y = data_temp_9_7[,2],colour = "W51_TT-101.OV" )) +
  geom_line(aes(y = data_temp_9_7[,3],colour = "W51_TX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG Holder temperature 9/7")
###10/2
data_temp_10_2 <-data_temp[grep('2013-10-02',data_temp$time),]
ggplot(data_temp_10_2, aes(x = data_temp_10_2[,1])) +
  geom_line(aes(y = data_temp_10_2[,2],colour = "W51_TT-101.OV" )) +
  geom_line(aes(y = data_temp_10_2[,3],colour = "W51_TX-153.OV")) +
  labs(x = "time", y = "NM3/hr", title = "COG Holder temperature 10/2")
###7_8_14
data_temp_7_8_14 <-data_temp[grep('2013-07-08|2013-07-09|2013-07-10|2013-07-11|2013-07-12|2013-07-13|2013-07-14',data_press$time),]
ggplot(data_temp_7_8_14, aes(x = data_temp_7_8_14[,1])) +
  geom_line(aes(y = data_temp_7_8_14[,2],colour = "W51_TT-101.OV" )) +
  geom_line(aes(y = data_temp_7_8_14[,3],colour = "W51_TX-153.OV")) +
  ylim(-10,90)+
  labs(x = "time", y = "C", title = "COG Holder temperature 7/8~7/14")
###8_1_7
data_temp_8_1_7 <-data_temp[grep('2013-08-01|2013-08-02|2013-08-03|2013-08-04|2013-08-05|2013-08-06|2013-08-07',data_press$time),]
ggplot(data_temp_8_1_7, aes(x = data_temp_8_1_7[,1])) +
  geom_line(aes(y = data_temp_8_1_7[,2],colour = "W51_TT-101.OV" )) +
  geom_line(aes(y = data_temp_8_1_7[,3],colour = "W51_TX-153.OV")) +
  ylim(-10,90)+
  labs(x = "time", y = "C", title = "COG Holder temperature 8/1~8/7")
###9_15_22
data_temp_9_15_21 <-data_temp[grep('2013-09-15|2013-09-16|2013-09-17|2013-09-18|2013-09-19|2013-09-20|2013-09-21',data_press$time),]
ggplot(data_temp_9_15_21, aes(x = data_temp_9_15_21[,1])) +
  geom_line(aes(y = data_temp_9_15_21[,2],colour = "W51_TT-101.OV" )) +
  geom_line(aes(y = data_temp_9_15_21[,3],colour = "W51_TX-153.OV")) +
  ylim(-10,90)+
  labs(x = "time", y = "C", title = "COG Holder temperature 9/15~9/22")
