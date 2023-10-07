g07 <- read.csv("COGgeneration201307.csv")
summary(g07)
g07_n <-na.omit(g07)
summary(g07_n)
g08 <- read.csv("COGgeneration201308.csv")
g09 <- read.csv("COGgeneration201309.csv",na.strings="Unit Down",stringsAsFactors=T)
g10 <- read.csv("COGgeneration201310.csv",na.strings="Unit Down",stringsAsFactors=T)
g11 <- read.csv("COGgeneration201311.csv")
g12 <- read.csv("COGgeneration201312.csv")
g08_n <-na.omit(g08)
g09_n <-na.omit(g09)
g10_n <-na.omit(g10)
g11_n <-na.omit(g11)
g12_n <-na.omit(g12)
summary(g08_n)
summary(g09_n)
summary(g10_n)
summary(g11_n)
summary(g12_n)
COGuser <- read.csv("COGuser2013.csv")
install.packages("mice")
library(mice)
install.packages("randomForest")
library(randomForest)
library(MASS)
c07 <- read.csv("COGuser201307.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
c08 <- read.csv("COGuser201308.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
c09 <- read.csv("COGuser201309.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
c10 <- read.csv("COGuser201310.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
c11 <- read.csv("COGuser201311.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
c12 <- read.csv("COGuser201312.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
View(c07_n)

c07_n <- c07[,-c(6,59)]
c08_n <- c08[,-c(6,59)]
c09_n <- c09[,-c(6,59)]
c10_n <- c10[,-c(6,59)]
c11_n <- c11[,-c(6,59)]
c12_n <- c12[,-c(6,59)]
c07_1 <- c07_n[1:20000,]
c07_2 <- c07_n[-(1:20000),]
c08_1 <- c08_n[1:20000,]
c08_2 <- c08_n[-(1:20000),]
c09_1 <- c09_n[1:20000,]
c09_2 <- c09_n[-(1:20000),]
c10_1 <- c10_n[1:20000,]
c10_2 <- c10_n[-(1:20000),]
c11_1 <- c11_n[1:20000,]
c11_2 <- c11_n[-(1:20000),]
c12_1 <- c12_n[1:20000,]
c12_2 <- c12_n[-(1:20000),]
mice_user07_1 <- mice(c07_1,m = 2,maxit = 50,method = "rf",seed =1)
mice_user07_2 <- mice(c07_2,m = 2,maxit = 50,method = "rf",seed =1)
mice_user08_1 <- mice(c08_1,m = 2,maxit = 50,method = "rf",seed =1)
mice_user08_2 <- mice(c08_2,m = 2,maxit = 50,method = "rf",seed =1)
mice_user09_1 <- mice(c09_1,m = 2,maxit = 50,method = "rf",seed =1)
mice_user09_2 <- mice(c09_2,m = 2,maxit = 50,method = "rf",seed =1)
mice_user10_1 <- mice(c10_1,m = 2,maxit = 50,method = "rf",seed =1)
mice_user10_2 <- mice(c10_2,m = 2,maxit = 50,method = "rf",seed =1)
mice_user11_1 <- mice(c11_1,m = 2,maxit = 50,method = "rf",seed =1)
mice_user11_2 <- mice(c11_2,m = 2,maxit = 50,method = "rf",seed =1)
mice_user12_1 <- mice(c12_1,m = 2,maxit = 50,method = "rf",seed =1)
mice_user12_2 <- mice(c12_2,m = 2,maxit = 50,method = "rf",seed =1)
summary(complete(mice_user09_1, 1))

c_all <- read.csv("COGuser2013.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
summary(c_all)
View(c_all)
c_all[,6]
c_all[,59]
c_all_n <- c_all[,-c(6,59)]
sum(is.na(c_all_n_1[,39]))
sum(is.na(c_all_n_10))
View(c_all_n)
summary(c_all_n)
install.packages("DMwR2")
require(DMwR2)


c_all_n[1,1]
re50424 <- c_all_n$W51_FX.167D.OV
c_all_n_1 <- c_all_n[,-40]
imputeData <- knnImputation(c_all_n_1)
summary(c_all_n_1)
View(c_all_n_1)
re32162 <- c_all_n_1$W51_FX.158.OV
c_all_n_2 <- c_all_n_1[,-39]
imputeData <- knnImputation(c_all_n_2)
summary(c_all_n_2)
View(c_all_n_2)
re33910 <- c_all_n_2$W51_FX.109.OV
c_all_n_3 <- c_all_n_2[,-66]
imputeData <- knnImputation(c_all_n_3)
summary(c_all_n_3)
View(c_all_n_3)
re27655 <- c_all_n_3$W51_FX.132.OV
c_all_n_4 <- c_all_n_3[,-9]
imputeData <- knnImputation(c_all_n_4)
summary(c_all_n_4)
View(c_all_n_4)
re23339 <- c_all_n_4$W51_FX.184D.OV
c_all_n_5 <- c_all_n_4[,-53]
imputeData <- knnImputation(c_all_n_5)
summary(c_all_n_5)
View(c_all_n_5)
re12918 <- c_all_n_5$W51_FX.156.OV
c_all_n_6 <- c_all_n_5[,-13]
imputeData <- knnImputation(c_all_n_6)
summary(c_all_n_6)
View(c_all_n_6)
re3646 <- c_all_n_6$W51_FX.180.1.OV
c_all_n_7 <- c_all_n_6[,-13]
imputeData <- knnImputation(c_all_n_7)
summary(c_all_n_7)
View(c_all_n_7)
re3652 <- c_all_n_7$W51_FX.180.2.OV
c_all_n_8 <- c_all_n_7[,-14]
imputeData <- knnImputation(c_all_n_8)
summary(c_all_n_8)
View(c_all_n_8)
re1635 <- c_all_n_8$W51_FX.179.OV
c_all_n_9 <- c_all_n_8[,-60]
imputeData <- knnImputation(c_all_n_9)
summary(c_all_n_9)
View(c_all_n_9)
re556 <- c_all_n_9$W51_FX.106.OV
c_all_n_10 <- c_all_n_9[,-48]
imputeData <- knnImputation(c_all_n_10)



###add last day,last week predictor
g_all[1,7]
g_all <- read.csv("COGgerneration2013_useknn2.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
mindiff_1 <- rep(NA, 264966)
mindiff_2 <- rep(NA, 264966)
mindiff <- rep(NA, 264966)
for(j in 1:264965){
  mindiff_1[j+1] <- g_all[j+1,6]-g_all[j,6]
  mindiff_2[j+1] <- g_all[j+1,7]-g_all[j,7]
  mindiff[j+1] <- mindiff_1[j+1]+mindiff_2[j+1]
}
lastday_1 <- rep(NA, 264966)
lastday_2 <- rep(NA, 264966)
lastday <- rep(NA, 264966)
for(j in 1:263525){
  lastday_1[j+1441] <- mindiff_1[j+1]
  lastday_2[j+1441] <- mindiff_2[j+1]
  lastday[j+1441] <- mindiff[j+1]
}
lastweek_1 <- rep(NA, 264966)
lastweek_2 <- rep(NA, 264966)
lastweek <- rep(NA, 264966)
for(j in 1:254885){
  lastweek_1[j+10081] <- mindiff_1[j+1]
  lastweek_2[j+10081] <- mindiff_2[j+1]
  lastweek[j+10081] <- mindiff[j+1]
}
COGgerneration2013_useknn3 <- data.frame(g_all,mindiff_1,mindiff_2,mindiff,lastday_1,lastday_2,lastday,lastweek_1,lastweek_2,lastweek)
write.csv(COGgerneration2013_useknn3,"C:/Users/Administrator/Documents/COGgerneration2013_useknn3.csv", row.names = TRUE)
install.packages("DMwR2")
library(DMwR2)
require(DMwR2)
g_alldiff <- read.csv("COGgerneration2013_useknn3.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
g_alldiffknn <- knnImputation(g_alldiff)
View(g_alldiffknn)
write.csv(g_alldiffknn,"C:/Users/Administrator/Documents/COGgerneration2013_useknn4.csv", row.names = TRUE)


g_all_2[2,2]

g_all_2 <- read.csv("COGgerneration2013_useknn4.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
mingdiff_1 <- rep(NA, 264966)
mingdiff_2 <- rep(NA, 264966)
mingdiff <- rep(NA, 264966)
for(j in 1:264965){
  mingdiff_1[j+1] <- g_all_2[j+1,2]-g_all_2[j,2]
  mingdiff_2[j+1] <- g_all_2[j+1,3]-g_all_2[j,3]
  mingdiff[j+1] <- mingdiff_1[j+1]+mingdiff_2[j+1]
}
lastdayg_1 <- rep(NA, 264966)
lastdayg_2 <- rep(NA, 264966)
lastdayg <- rep(NA, 264966)
for(j in 1:263525){
  lastdayg_1[j+1441] <- mingdiff_1[j+1]
  lastdayg_2[j+1441] <- mingdiff_2[j+1]
  lastdayg[j+1441] <- mingdiff[j+1]
}
lastweekg_1 <- rep(NA, 264966)
lastweekg_2 <- rep(NA, 264966)
lastweekg <- rep(NA, 264966)
for(j in 1:254885){
  lastweekg_1[j+10081] <- mingdiff_1[j+1]
  lastweekg_2[j+10081] <- mingdiff_2[j+1]
  lastweekg[j+10081] <- mingdiff[j+1]
}
COGgerneration2013_useknn5 <- data.frame(g_all_2,mingdiff_1,mingdiff_2,mingdiff,lastdayg_1,lastdayg_2,lastdayg,lastweekg_1,lastweekg_2,lastweekg)
write.csv(COGgerneration2013_useknn5,"C:/Users/Administrator/Documents/COGgerneration2013_useknn5.csv", row.names = TRUE)
g_alldiff_2 <- read.csv("COGgerneration2013_useknn5.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
View(g_alldiff_2)
g_alldiffknn_2 <- knnImputation(g_alldiff_2)
View(g_alldiffknn_2)
write.csv(g_alldiffknn_2,"C:/Users/Administrator/Documents/COGgerneration2013_useknn6.csv", row.names = TRUE)


###SVM
f <- read.csv("COGgerneration2013_day,week.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
s <- read.csv("seasonality_training.csv",na.strings=c("Unit Down","NA"),stringsAsFactors=T)
g_svmdata <- data.frame(f,s)
g_svmdata <- g_svmdata[,-28]
a <- ifelse(sapply(g_svmdata$W51_LX.152.1.OV,function(x) return(x<80 && x>20)),"normal","abnormal")
b <- ifelse(sapply(g_svmdata$W51_LX.152.2.OV,function(x) return(x<80 && x>20)),"normal","abnormal")
g_svmdata <- data.frame(g_svmdata,a,b)
g_svmdata <- g_svmdata[,-c(34,35,36,37,38,39,42,43)]
g_svmdata_1 <- g_svmdata[,-c(1,6,7,10,11,12,14,15,17,18,19,20,21,22,23,24,25,26,27,29,30,32,33,35)]
View(g_svmdata_1)
g_svmdata_2 <- g_svmdata[,-c(1,6,7,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26,27,28,30,31,33,34)]
View(g_svmdata_2)
library(e1071)
set.seed (1)
train <- 1:220321
g_svmdata_1$a <- as.factor(g_svmdata_1$a)
g_svmdata_2$b <- as.factor(g_svmdata_2$b)
set.seed (1)
tune.out <- tune (svm , a ~ ., data = g_svmdata_1[train , ],
                  kernel = "radial",
                  ranges = list (
                    cost = c(0.1, 1, 10, 100, 1000),
                    gamma = c(0.5, 1, 2, 3, 4)
                  )
)
summary (tune.out)
table (
  true = g_svmdata_1[-train , "a"],
  pred = predict (
    tune.out$best.model, newdata = g_svmdata_1[-train , ]
  )
)
svmfit_1 <- svm (a ~ ., data = g_svmdata_1[train , ], kernel = "radial",gamma = 1, cost = 1)










