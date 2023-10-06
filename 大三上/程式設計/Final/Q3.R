ztable <- matrix(NA, nrow = 18, ncol = 8)
colnames(ztable)<-c("x","Mean to x","Larger protion","Smaller Portion","x","Mean to x","Larger protion","Smaller Portion")

for (i in 1:18) {
  ztable[i, 1]<-0.01*(i-1)
  ztable[i, 2] <- round(pnorm( q = 0.01*(i-1), mean = 0, sd = 1),4)-.5
  ztable[i, 3] <- round(pnorm( q = 0.01*(i-1), mean = 0, sd = 1),4)
  ztable[i, 4] <- 1- ztable[i, 3]
}
i=41
for (i in 41:58) {
  ztable[i-40, 5]<-0.01*(i-1)
  ztable[i-40, 6] <- round(pnorm( q = 0.01*(i-1), mean = 0, sd = 1),4)-.5
  ztable[i-40, 7] <- round(pnorm( q = 0.01*(i-1), mean = 0, sd = 1),4)
  ztable[i-40, 8] <- 1- ztable[i-40, 7]
}

ztable
