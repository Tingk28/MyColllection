library(ISLR2)
library(glmnet)
library(reticulate)
library(tensorflow)
library(keras)
# install_tensorflow()
# install_keras()
# For the python packages when using image_load
# conda_install(envname="r-reticulate",packages=c("pillow","scipy"))

source("pattern_retrieval.R")
data_col <- 4 #欄數
lag <- 10 #投入前多少分鐘的資料
tstar <- 30 #預測多久後的資料

COG <- read.csv("資料/COGvariables.csv")
Train_cog <- COG
Train_cog <- data.matrix(Train_cog[,c("holder2_V0","W51_FT.101D.OV","W51_FX.153.OV","holder1_V0")])
Train_cog <- scale(Train_cog)

#若用6-11月作為training data
#train_array <- RNN_construst_data_array(Train_cog,lag:(264961-tstar),lag = lag,tstar = tstar)#train 60:264951要因lag跟預測時間而改變 

#若用11月作為training data
train_array <- RNN_construst_data_array(Train_cog,(177121+lag):(264961-tstar),lag = lag,tstar = tstar)

n <- nrow ( train_array )
#若用6-11月作為training data
# istrain <- rep(FALSE,n)
# istrain[1:(220320-lag)] <- TRUE #前五個月為training

#若用11月作為training data
istrain <- rep(FALSE,n)
istrain[1:43200] <- TRUE

model <- keras_model_sequential () %>%#這部分保留，之後要調模型的樣子從這裡調整
  layer_simple_rnn ( units = 12 ,
                     input_shape = list (10 , 4) ,
                     dropout = 0.1 , recurrent_dropout = 0.1)%>%
  layer_dense ( units = 1)
model%>% compile ( optimizer = optimizer_rmsprop () ,
                   loss ="mape")

history <- model%>% fit (
  train_array[ istrain ,,2:5], train_array[ istrain,1,1] ,#前面是X後面是Y，注意每個XY之間對應要正確(Y要刪除前五列)
  batch_size = 512 , epochs = 200 ,
  validation_data =
    list ( train_array[!istrain ,,2:5], train_array[!istrain,1,1])#計算testing error的資料
)
kpred <- predict ( model , train_array[!istrain,,2:5])

#MSE
mean((kpred-train_array[!istrain,1,1])^2)
#MAPE
mean(abs((kpred-train_array[!istrain,1,1])/train_array[!istrain,1,1]))
