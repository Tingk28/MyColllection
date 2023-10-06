library(ISLR2)
data<-Auto
dim(data)
data<-na.omit(data)

## 9-1
names(data)

## 9-2
for(i in 1:6){# excluded last 3 col(names, origin,).
  cat(names(data)[i],"\t")
  cat(range(data[,i]),"\n")
}

## 9-3
for(i in 1:6){# temp has 8 col.
  cat(names(data)[i],"\t")
  cat("mean:",mean(data[,i]),"\t")
  cat("standard deviation: ",sd(data[,i]),"\n")
}

##9.4

for(i in 1:6){# temp has 8 col.
  data_col<-data[,i]
  q10<-quantile(data_col,.1)
  q85<-quantile(data_col,.85)
  a<-data_col[data_col<q10|data_col>q85]
  #print(length(a))
  cat(names(data)[i],"\t")
  cat("mean:",mean(a),"\t")
  cat("standard deviation: ",sd(a),"\n")
}

##9.5
pairs(data)
pairs(data[c(1,3,4,5)])
attach ( Auto)

##9.6
mpg<-data$mpg

for(i in 3:5){
  #xlab=names(data)[i]
  #predictor<-data[i]
  #line<-lm(mpg~horsepower,data=data)
  #line<-lm(mpg~ploy(horsepower,2),data=data)
  line<-lm(mpg~horsepower+I(horsepower^2)+I(horsepower^3),data=data)
  plot(x=data$horsepower,y=data$mpg,ylab="mpg",xlab = "hoursepower")
  intercept<-line$coefficients[1]
  #abline(a=intercept,b=line$coefficients[2],col='red')
  points(data$horsepower,fitted(line),col="red")
  lines(sort(data$horsepower),fitted(line)[order(data$horsepower)],col="red")
}


# Q10
library(ISLR2)
data2<-Boston
#crime<-as.factor(data2$crim)
## 10.1
dim(data2)
## 10.2
pairs(data2)
## 10.3
plot(data2$dis,data2$crim, main="distance and crime rate")
plot(data2$medv,data2$crim, main="house price and crime rate")
## 10.4
boxplot(data2$crim,main="Crime rate")
boxplot(data2$tax,main="Tax")
boxplot(data2$ptratio,main="Pupil-teacher ratio")
## 10.5
data2$chas
sum(data2$chas)
## 10.6
summary(data2$ptratio)
## 10.7
min(data2$medv)
lowest=which(min(data2$medv)==data2$medv)
## the census tracts index 399 and 406 have lowest medv
lowest=data2[c(399,406),]
# quantile_inverse<-function(x,data){
#   sorted<-sort(data)
#   index<-which(x==sorted)
#   len=length(data)
#   return (index/len)
# }
# for(i in 1:12){
#   cat(names(lowest)[i],"\n")
#   cat(quantile_inverse(lowest[1,i],data2[,i]),"\n")
#   cat(quantile_inverse(lowest[2,i],data2[,i]),"\n")
#   #cat(rank(lowest[2,i])/length(data2[,i]),"\n")
#   
# }
lowest
summary(data2)
## 10.8
room7=data2[data2$rm>=7,]
room8=data2[data2$rm>=8,]
summary(data2)
summary(room7)
summary(room8)
