##holder1,2 v0
g_all <- read.csv("COGgerneration2013_day,week.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
View(g_all)
g_all <- g_all[,-c(12,15,18,21,24,27)]
pre1 <- (g_all$W51_PT.101.OV)*9.80665+101325
pre2 <- (g_all$W51_PX.153.OV)*9.80665+101325
holder1_V0 <- (pre1)*30000*(g_all$W51_LX.152.1.OV)*273.15/(101325*100*(273.15+g_all$W51_TT.101.OV))
holder2_V0 <- (pre2)*60000*(g_all$W51_LX.152.2.OV)*273.15/(101325*100*(273.15+g_all$W51_TX.153.OV))
g_all <- data.frame(g_all,holder1_V0,holder2_V0)
View(g_all)

##different
v0_mingdiff_1 <- rep(NA, 264961)
v0_mingdiff_2 <- rep(NA, 264961)
for(j in 1:264960){
  v0_mingdiff_1[j+1] <- g_all[j+1,22]-g_all[j,22]
  v0_mingdiff_2[j+1] <- g_all[j+1,23]-g_all[j,23]
}
v0_lastdayg_1 <- rep(NA, 264961)
v0_lastdayg_2 <- rep(NA, 264961)
for(j in 1:263520){
  v0_lastdayg_1[j+1441] <- v0_mingdiff_1[j+1]
  v0_lastdayg_2[j+1441] <- v0_mingdiff_2[j+1]
}
v0_lastweekg_1 <- rep(NA, 264961)
v0_lastweekg_2 <- rep(NA, 264961)
for(j in 1:254880){
  v0_lastweekg_1[j+10081] <- v0_mingdiff_1[j+1]
  v0_lastweekg_2[j+10081] <- v0_mingdiff_2[j+1]
}
g_all <- data.frame(g_all,v0_mingdiff_1,v0_mingdiff_2,v0_lastdayg_1,v0_lastdayg_2,v0_lastweekg_1,v0_lastweekg_2)
View(g_all)
write.csv(g_all,"C:/Users/Administrator/Documents/COGgerneration2013_day,week,vo3.csv", row.names = TRUE)
print(holder1_V0)
print(holder2_V0)

##missing value
install.packages("CRAN")
install.packages("imputeTS")
install.packages("devtools")
library(imputeTS)
install.github("SteffenMoritz/imputeTS")
c_all <- read.csv("COGuser2013.csv",na.strings=c("Unit Down","NA"))
str(c_all)
c_all$W51_FX.167D.OV <- as.numeric(c_all$W51_FX.167D.OV)
summary(c_all)
View(c_all_n)
str(c_all_n)
c_all[,1]
c_all[,59]
c_all_n <- c_all[,-c(6,59)]
xx <- na_interpolation(c_all_n)
xx <- data.frame(xx)
write.csv(xx,"C:/Users/Administrator/Documents/COGuser2013_complete.csv", row.names = TRUE)
sum(is.na(xx))
View(xx)
total_user <- 0
for(j in 1:67){
  total_user <- total_user+xx[,j+1]
}
x <- data.frame(xx,total_user)
View(x)
x <- x[,c(1,69)]
write.csv(x,"C:/Users/Administrator/Documents/COGuser2013_sum.csv", row.names = TRUE)

##variable bind
v_1 <- read.csv("COGgerneration2013_day,week,vo3.csv",na.strings=c("Unit Down","NA"))
v_2 <- read.csv("COGuser2013_sum.csv",na.strings=c("Unit Down","NA"))
v_3 <- read.csv("seasonality_training.csv",na.strings=c("Unit Down","NA"))
v_1 <- v_1[,-1]
v_2 <- v_2[,2]
v_3 <- v_3[,-1]
View(v_1)
View(v_2)
View(v_3)
COGvariables <- cbind(v_1,v_2,v_3)
write.csv(COGvariables,"C:/Users/Administrator/Documents/COGvariables.csv", row.names = TRUE)
str(COGvariables)
