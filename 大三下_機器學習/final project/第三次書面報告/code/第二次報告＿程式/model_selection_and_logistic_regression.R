library(leaps)
load("/Users/li-gung/Desktop/ma_data.RData")
## data selection
COGgerneration2013_useknn2 <- read.csv("Desktop/machinelearning/資料/COGgerneration2013_useknn2.csv")
COGuser2013_rawdata_2 <- read.csv("Desktop/COGuser2013_rawdata-2.csv")
COGuser2013_rawdata_2 <- COGuser2013_rawdata_2[,-c(6,58)]
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

###model selection user vs Holder level
select_data <- COGuser2013_rawdata_2
select_data <- select_data[-c(1,2),]
select_data <- data.frame(
  select_data,
  sum = apply(select_data,1,function(x) sum(x,na.rm = T))
)
apply(select_data,2,function(x) sum(is.na(x)))
select_data <- select_data[,-grep('W51_FX.152.OV|W51_FX.167D.OV|W51_FX.132.OV|W51_FX.159.OV',colnames(select_data))]
select_H1 <- data.frame(
  select_data[-264966,],
  diffH152.1 = diffH152.1
)
select_H1 <- select_H1[complete.cases(select_H1),]
null_selectH1 <-lm(diffH152.1~1,select_H1)
full_selectH1 <-lm(diffH152.1~.,select_H1)
forwardselection = step(null_selectH1, 
                        scope=list(null_selectH1,full_selectH1), 
                        direction="forward")

select_H2 <- data.frame(
  select_data[-264966,],
  diffH152.2 = diffH152.2
)
null_selectH2 <-lm(diffH152.2~1,select_H2)
full_selectH2 <-lm(diffH152.2~.,select_H2)
forwardselection = step(null_selectH2, 
                        scope=list(null_selectH2,full_selectH2), 
                        direction="forward")
differ_select <- select_data[-1,]-select_data[-264966,]
select_dH1 <- data.frame(
  differ_select,
  diffH152.1 = diffH152.1
)
null_selectdH1 <-lm(diffH152.1~1,select_dH1)
full_selectdH1 <-lm(diffH152.1~.,select_dH1)
forwardselection = step(null_selectdH1, 
                        scope=list(null_selectdH1,full_selectdH1), 
                        direction="forward")
select_dH2 <- data.frame(
  differ_select,
  diffH152.2 = diffH152.2
)
null_selectdH2 <-lm(diffH152.2~1,select_dH2)
full_selectdH2 <-lm(diffH152.2~.,select_dH2)
forwardselection = step(null_selectdH2, 
                        scope=list(null_selectdH2,full_selectdH2), 
                        direction="forward")

select_g1 <- data.frame(
  select_data,
  W51_FT.101D.OV<-COGgerneration2013_useknn2$W51_FT.101D.OV
)
select_g1 <- select_g1[complete.cases(select_g1),]
null_selectg1 <-lm(W51_FT.101D.OV ~1,select_g1)
full_selectg1 <-lm(W51_FT.101D.OV ~.,select_g1)
forwardselection = step(null_selectg1, 
                        scope=list(null_selectg1,full_selectg1), 
                        direction="forward")
summary(full_selectg1)
select_g2 <- data.frame(
  select_data,
  W51_FX.153.OV<-COGgerneration2013_useknn2$W51_FX.153.OV
)
null_selectg2 <-lm(W51_FX.153.OV~1,select_g2)
full_selectg2 <-lm(W51_FX.153.OV~.,select_g2)
forwardselection = step(null_selectg2, 
                        scope=list(null_selectg2,full_selectg2), 
                        direction="forward")

### glm losgistic regression
glmdataH152.1.train <-analysis_datadiffH152.1
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
anova(glm_model_152.1.train)
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
predict(glm_modelH152.1.user.train,glmdataH152.1.user.train)
## model3 differ data
glm_differdataH152.1 <- analysis_data[,-c(1,6,7)]
glm_differdataH152.1 <- glm_differdataH152.1[-1,] -glm_differdataH152.1[-264966,]
glm_differdataH152.1 <- data.frame(
  glm_differdataH152.1,
  diffH152.1 = diffH152.1
)  
for(i in c(1:nrow(glm_differdataH152.1))){
  if (glm_differdataH152.1$diffH152.1[i] >0){
    glm_differdataH152.1$diffH152.1[i] <- 1
  }
  else{
    glm_differdataH152.1$diffH152.1[i] <- 0
  }
}
glm_differmodelH152.1 <-  glm(diffH152.1~ ., data = glm_differdataH152.1, family = "binomial")
summary(glm_differmodelH152.1)
## model4 user differ data
glm_differdataH152.1.user <- data.frame(
  W51_FX.151.OV = COGuser2013_rawdata_2$W51_FX.151.OV,
  W51_FX.110.OV = COGuser2013_rawdata_2$W51_FX.110.OV,
  W51_FX.181.1.OV = COGuser2013_rawdata_2$W51_FX.181.1.OV,
  W51_FX.180.1.OV = COGuser2013_rawdata_2$W51_FX.180.1.OV,
  W51_FX.186D.OV = COGuser2013_rawdata_2$W51_FX.186D.OV,
  W51_FX.185D.OV = COGuser2013_rawdata_2$W51_FX.185D.OV,
  W51_FX.188D.OV = COGuser2013_rawdata_2$W51_FX.188D.OV,
  W51_FX.154.OV = COGuser2013_rawdata_2$W51_FX.154.OV,
  W51_FX.156.OV = COGuser2013_rawdata_2$W51_FX.156.OV
)
glm_differdataH152.1.user <- glm_differdataH152.1.user[-1,]-glm_differdataH152.1.user[-264966,]
glm_differdataH152.1.user <- data.frame(
  glm_differdataH152.1.user,
  diffH152.1 = diffH152.1
)
for(i in c(1:nrow(glm_differdataH152.1.user))){
  if (glm_differdataH152.1.user$diffH152.1[i] >0){
    glm_differdataH152.1.user$diffH152.1[i] <- 1
  }
  else{
    glm_differdataH152.1.user$diffH152.1[i] <- 0
  }
}
glm_differmodel_userH152.1 <-  glm(diffH152.1~ ., data = glm_differdataH152.1.user, family = "binomial")
summary(glm_differmodel_userH152.1)


