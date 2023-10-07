library(leaps)
setwd("D:/成功大學/機器學習/COG 201307-12/machinelearning-main")
## data selection
COGgerneration2013_useknn2 <- read.csv("COGgerneration2013_useknn2.csv")
COGuser2013_rawdata_2 <- read.csv("COGuser2013.csv",na.strings="Unit Down")
COGuser2013_rawdata_2 <- COGuser2013_rawdata_2[,-1]
for(i in c(2:dim(COGuser2013_rawdata_2)[2])){
  COGuser2013_rawdata_2[,i] <- as.numeric(COGuser2013_rawdata_2[,i])
  }
analysis_data <- data.frame(
  COGgerneration2013_useknn2,
  total_used = apply(COGuser2013_rawdata_2[,-c(1,2)],1,function(x) sum(x,na.rm = T))
)
diffH152.1 = analysis_data$W51_LX.152.1.OV[-1]-analysis_data$W51_LX.152.1.OV[-dim(analysis_data)[1]]
diffH152.2 = analysis_data$W51_LX.152.2.OV[-1]-analysis_data$W51_LX.152.2.OV[-dim(analysis_data)[1]]
analysis_datadiffH152.1 <- data.frame(
  analysis_data[-264966,],
  diffH152.1 = diffH152.1
)
analysis_datadiffH152.2 <- data.frame(
  analysis_data[-264966,],
  diffH152.2 = diffH152.2
)
## model selection 
nullH152.1 <- lm(diffH152.1~1,analysis_datadiffH152.1[c(1:10080),-1])
fullH152.1 <- lm(diffH152.1~.,analysis_datadiffH152.1[c(1:10080),-1])
forwardselection = step(nullH152.1, scope=list(nullH152.1,fullH152.1), direction="forward")
backwardselection = step(fullH152.1, scope=list(nullH152.1,fullH152.1), direction="backward")
backward_model <- lm(diffH152.1 ~ W51_FT.101D.OV + W51_FX.153.OV + W51_PX.153.OV + 
                       W51_LX.152.1.OV + W51_LX.152.2.OV + W51_TT.101.OV + W51_TX.153.OV + 
                       total_used,analysis_datadiffH152.1)
summary(backward_model)
regfit.full <- regsubsets(diffH152.1~.,analysis_datadiffH152.1[c(1:10080),-1])
regfit.summary<-summary(regfit.full)
order(regfit.summary$bic)
### glm losgistic regression
glmdataH152.1.train <-analysis_datadiffH152.1[sample(c(1:264965),20000),]
for(i in c(1:nrow(glmdataH152.1.train))){
  if (glmdataH152.1.train$diffH152.1[i] >0){
    glmdataH152.1.train$diffH152.1[i] <- 1
  }
  else{
    glmdataH152.1.train$diffH152.1[i] <- 0
  }
}
glm_model_152.1.train <-  glm(diffH152.1~ ., data = glmdataH152.1.train[,-1], family = "binomial")
summary(glm_model_152.1.train)

###
range_user<-apply(COGuser2013_rawdata_2[,-1],2,function(x) range(x,na.rm = T))
###
sort(range_user[2,]-range_user[1,])

glmdataH152.1.user.train <- data.frame(
  diffH152.1 = diffH152.1,
  W51_FX.151.OV = COGuser2013_rawdata_2$W51_FX.151.OV[-264966],
  W51_FX.110.OV = COGuser2013_rawdata_2$W51_FX.110.OV[-264966],
  W51_FX.181.1.OV = COGuser2013_rawdata_2$W51_FX.181.1.OV[-264966],
  W51_FX.180.1.OV = COGuser2013_rawdata_2$W51_FX.180.1.OV[-264966],
  W51_FX.186D.OV = COGuser2013_rawdata_2$W51_FX.186D.OV[-264966],
  W51_FX.185D.OV = COGuser2013_rawdata_2$W51_FX.185D.OV[-264966],
  W51_FX.188D.OV = COGuser2013_rawdata_2$W51_FX.188D.OV[-264966],
  W51_FX.154.OV = COGuser2013_rawdata_2$W51_FX.154.OV[-264966],
  W51_FX.156.OV = COGuser2013_rawdata_2$W51_FX.156.OV[-264966]
)

glmdataH152.1.user.train <-glmdataH152.1.user.train[sample(c(1:264965),1000),]
for(i in c(1:nrow(glmdataH152.1.user.train))){
  if (glmdataH152.1.user.train$diffH152.1[i] >0){
    glmdataH152.1.user.train$diffH152.1[i] <- 1
  }
  else{
    glmdataH152.1.user.train$diffH152.1[i] <- 0
  }
}
glm_modelH152.1.user.train <-  glm(diffH152.1~ ., data = glmdataH152.1.user.train, family = "binomial")
summary(glm_modelH152.1.user.train)


### lda
library(MASS)
test.model<-analysis_datadiffH152.1[262966:264965,]
names(test.model)
ldadataH152.1.train <-analysis_datadiffH152.1[sample(c(1:262965),20000),]
for(i in c(1:nrow(ldadataH152.1.train))){
  if (ldadataH152.1.train$diffH152.1[i] >0){
    ldadataH152.1.train$diffH152.1[i] <- 1
  }
  else{
    ldadataH152.1.train$diffH152.1[i] <- 0
  }
}
lda_model_152.1.train <-  lda(diffH152.1~ ., data = ldadataH152.1.train[,-1])
summary(lda_model_152.1.train)
lda.pred<-predict(lda_model_152.1.train,test.model)
names(lda.pred)
lda.class <- lda.pred$class
table(lda.class,test.model$diffH152.1)
mean(lda.class == test.model$diffH152.1)
# ###
# range_user<-apply(COGuser2013_rawdata_2[,-1],2,function(x) range(x,na.rm = T))
# ###
# sort(range_user[2,]-range_user[1,])
# 
# ldadataH152.1.user.train <- data.frame(
#   diffH152.1 = diffH152.1,
#   W51_FX.151.OV = COGuser2013_rawdata_2$W51_FX.151.OV[-264966],
#   W51_FX.110.OV = COGuser2013_rawdata_2$W51_FX.110.OV[-264966],
#   W51_FX.181.1.OV = COGuser2013_rawdata_2$W51_FX.181.1.OV[-264966],
#   W51_FX.180.1.OV = COGuser2013_rawdata_2$W51_FX.180.1.OV[-264966],
#   W51_FX.186D.OV = COGuser2013_rawdata_2$W51_FX.186D.OV[-264966],
#   W51_FX.185D.OV = COGuser2013_rawdata_2$W51_FX.185D.OV[-264966],
#   W51_FX.188D.OV = COGuser2013_rawdata_2$W51_FX.188D.OV[-264966],
#   W51_FX.154.OV = COGuser2013_rawdata_2$W51_FX.154.OV[-264966],
#   W51_FX.156.OV = COGuser2013_rawdata_2$W51_FX.156.OV[-264966]
# )
# 
# ldadataH152.1.user.train <-ldadataH152.1.user.train[sample(c(1:264965),1000),]
# for(i in c(1:nrow(ldadataH152.1.user.train))){
#   if (ldadataH152.1.user.train$diffH152.1[i] >0){
#     ldadataH152.1.user.train$diffH152.1[i] <- 1
#   }
#   else{
#     ldadataH152.1.user.train$diffH152.1[i] <- 0
#   }
# }
# lda_modelH152.1.user.train <-  lda(diffH152.1~ ., data = ldadataH152.1.user.train)
# summary(lda_modelH152.1.user.train)

### qda
qdadataH152.1.train <-analysis_datadiffH152.1[sample(c(1:262965),20000),]
for(i in c(1:nrow(qdadataH152.1.train))){
  if (qdadataH152.1.train$diffH152.1[i] >0){
    qdadataH152.1.train$diffH152.1[i] <- 1
  }
  else{
    qdadataH152.1.train$diffH152.1[i] <- 0
  }
}
qda_model_152.1.train <-  qda(diffH152.1~ ., data = qdadataH152.1.train[,-1])
summary(qda_model_152.1.train)
qda.pred<-predict(qda_model_152.1.train,test.model)
names(qda.pred)
qda.class <- qda.pred$class
table(qda.class,test.model$diffH152.1)
mean(qda.class == test.model$diffH152.1)
