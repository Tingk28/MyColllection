library("DMwR2")
library("ggplot2")
##read data and bind them to 1
COGu<-read.csv("COGuser2013_rawdata.csv")
total_use<-COGu$sum
COGg<-read.csv("COGgerneration2013_useknn2.csv")
total_produce<-COGg[,2]+COGg[,3]


plot(x=1:1440,y=total_use[1:1440],type = "l", main="一天內的COG生產與消耗",xlab="time",ylab="total",col="red",xaxt='n') 
lines(x=1:1440,y=total_produce[1:1440], col = "blue")

plot(x=(1:length(COGg[,2]))/1440,y=total_use,type = "l", main="六個月COG生產與消耗",xlab="time",ylab="total",col="red",xaxt='n') 
lines(x=(1:length(COGg[,2]))/1440,y=total_produce, col = "blue")
legend("topright",lty = 1,col = c("red", "blue"),legend = c("'COG消耗","COG產量"),bty="o" )
axis(1,seq(0,180,30))


plot(x=total_produce,y=total_use)#生產與消耗的散佈圖
cor(total_use,total_produce) #0.6718


#兩個生產單位的折線圖
plot(x=(1:length(COGg[,2]))/1440,y=COGg[,2],type = "l", main="COG產量",xlab="time",ylab="total",col="red",xaxt='n',ylim=c(30000,190000)) 
lines(x=(1:length(COGg[,2]))/1440,y=COGg[,3], col = "blue")
legend("topright",lty = 1,col = c("red", "blue"),legend = c("一二階COG產量", "三四階COG產量"),bty="o" )
axis(1,seq(0,180,30))
