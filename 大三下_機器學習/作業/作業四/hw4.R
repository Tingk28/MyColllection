# 5-6
set.seed(1)
data_1<-Default
## 6-a
glm.fit<-glm(default~income+balance,data=data_1,family = binomial)
summary(glm.fit)
##6-b
boot.fn <- function ( data , index )
  +coef (glm(default~income+balance,data=data_1,family = binomial,subset = index))
boot.fn(Default,1:392)

##6-c
boot(Default,boot.fn,R=1000)
##6-d

# 5-9
data_2 <- Boston
##9-a
mean(data_2$medv)
##9-b
length(data_2$medv)#length=506
(var(data_2$medv)/506)^.5
##9-c
boot.fn<-function(data,index)
  mean(data[index])
#boot.fn(data_2$medv,1:506)#22.53281
boot(data_2$medv,boot.fn,R=1000)
##9-d
t.test(data_2$medv)
std.error<-.4106622
ci<-c(mean(data_2$medv)+2*std.error,mean(data_2$medv)-2*std.error)

##9-e
median(data_2$medv)
##9-f
boot.fn2<-function(data,index)
  median(data[index])
boot(data_2$medv,boot.fn2,R=1000)
midstd.error<-.3708901
ci<-c(median(data_2$medv)-2*midstd.error,median(data_2$medv)+2*midstd.error)
##9-g
quantile(data_2$medv,.1)
##9-h
boot.fn3<-function(data,index)
  quantile(data[index],.1)
boot(data_2$medv,boot.fn3,R=1000)
std10.error<- .4994414
ci<-c(12.75-2*std10.error,12.75+2*std10.error)
