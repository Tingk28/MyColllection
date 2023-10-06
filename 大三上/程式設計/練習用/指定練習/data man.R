set.seed(1234)

df1 <- data.frame(name = c("Mary", "Thor", "Sven", "Jane", "Ake", "Stephan", 
                           "Bjorn", "Oden", "Dennis"),
                  treatment_gr = c(rep(c(1, 2, 3), each = 3)), 
                  weight_p1 = round(runif(9, 100, 200), 0))
df2 <- data.frame(name = c("Sven", "Jane", "Ake", "Mary", "Thor", "Stephan", 
                           "Oden", "Bjorn"), 
                  weight_p2 = round(runif(8, 100, 200), 0))                           
df3 <- data.frame(treatment_gr = c(1, 2, 3), 
                  type = c("dog-lovers", "cat-lovers", "all-lovers"))

df4<-merge(x=df1,y=df2,by="name")
df5<-merge(x=df4,y=df3,by="treatment_gr")
df5
##df5[1:5]<-c(df5$name,df5$treatment_gr,df5$weight_p1,df5$type,df5$weight_p2)
df6<-df5[order(df5[,1]),]
rownames(df6)<-1:8
df6
