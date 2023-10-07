setwd('~/Desktop/machinelearning/力綱')
library('ggplot2')
### read data
COGg <- read.csv("COGvariables.csv")
Holder1_VO <- COGg$holder1_V0
Holder2_VO <- COGg$holder2_V0
time <- as.POSIXct(COGg$time)
data_V0 <-data.frame(
  time=time,
  Holder1_VO=Holder1_VO,
  Holder2_VO=Holder2_VO
)
### time series plot ALL
p<-ggplot(data_V0, aes(x = time)) +
  geom_line(aes(y = data_V0[,2],colour = "Holder1_VO" )) +
  geom_line(aes(y = data_V0[,3],colour = "Holder2_VO")) +
  labs(x = "time", y = "m^3", title = "Holder_VO")
png('Holder_V0_2013.png',width=700, height=500)
print(p)
dev.off()
### time series plot month
for (month in c('07','08','09','10','11','12')) {
  t <- paste('2013',month,sep='-')
  data_plot <- data_V0[grepl(t,data_V0$time),]
  plot_name <- paste('Holder_V0','2013',month,'.png')
  p<-ggplot(data_plot, aes(x = time)) +
    geom_line(aes(y = data_plot[,2],colour = "Holder1_VO" )) +
    geom_line(aes(y = data_plot[,3],colour = "Holder2_VO")) +
    labs(x = "time", y = "m^3", title = "Holder_VO")
  png(plot_name,width=700, height=500)
  print(p)
  dev.off()
}
###ACF Holder2 VO
Holder2_V0m <- Holder2_VO
Holder2_V0h <- Holder2_VO[1:264961%%60==1]
Holder2_V0d <- Holder2_VO[1:264961%%1440==1]
png('Holder2_V0_ACF.png',width=1500, height=500)
par(mfrow=c(1,3))
acf(Holder2_V0m,lag.max = 60,xlab = 'lag(min)',main = 'ACF Holder2 V0(min)')
acf(Holder2_V0h,lag.max = 24,xlab = 'lag(hr)',main = 'ACF Holder2 V0(hr)')
acf(Holder2_V0d,lag.max = 7,xlab = 'lag(day)',main = 'ACF Holder2 V0(day)')
dev.off()

