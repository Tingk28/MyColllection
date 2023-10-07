# 尋找相似pattern
[toc]
## read me

### 重要參數設定

```r=
data_col <- 2#原始時間數列有幾個column(未來可能會改用dim自動抓)
lag <- 10 #投入前多少分鐘的資料
k <- 30 #找距離前K近的Pattern
tstar <- 5 #預測多久後的資料
times <- 10 #預測多少次
```
### <a name="id">輸入資料格式</a>
直接將不同Col的時間數列資料變成matrix, data frame即可
備註：**本function沒有處理遺失值，請確保原始資料完整性**
- 單變數
```r=
#先使用七月份的資料看看效果
COGg07 <- read.csv("資料/COGgeneration201307.csv")
#以預測變化較大的holder2為主
input_data <- cbind(COGg07$W51_LX.152.2.OV)
```
- 多變數
```r=
#先使用七月份的資料看看效果
COGg07 <- read.csv("資料/COGgeneration201307.csv")
#匯入holder 1 2
input_data <- cbind(COGg07$W51_LX.152.2.OV,COGg07$W51_LX.152.1.OV)
```
`input_data` 的第一個column為希望預測的數值
### <a name="id">輸出資料格式</a>
分成 `times(抽樣次數)*lag(延遲時長)*(data_col+1)(資料維度)` 的array（多維度matrix）
若有array A 抽15個點、延遲10分鐘、input資料維度為2維度是`15*10*3`
- 常用存取方式：
```
A[,,i] # 調用i維度的各抽樣的所有資料
A[,i,] # 所有維度lag i 分鐘的資料（較沒意義）
A[i,,] # 第i筆資料各個維度與延遲下的所有數值（相當於第i筆抽樣的所有資料）
```
其中`A[,,1]`代表的是這組資料的實際結果（i+tstar($t^*$) 的資料／應變數）
**此為`construst_data_array`的輸出格式**

### 相關函數使用方法

#### data_reconstruct
內部函數，供其他兩個函數調用。功能為將一時間數列資料，變成延遲lag的matrix
- Input
`(data,timelag,na_omit=T,rev=F)`
data：原始時間數列資料
timelag：每個row所要包含的變數(lag)數
omit：跳過前lag分鐘（前lag分鐘部分有NA），預設為true，前lag-1分鐘整列為NA，需用`na.omit()`刪除
備註：不建議使用`na.omit()`來刪除有NA的資料行，會造成後續分析時，整個時間被往前挪動（回傳第t分鐘有最小值，但實際是第t+lag分鐘）
rev：預設為False，輸出的第一欄為lag分鐘前，最後一欄為當前時間。若設定為true則反過來
- Output：延遲lag的matrix
- Example
`data_reconstruct(1:10,3)`
![](https://i.imgur.com/PdjGRVm.png)
`data_reconstruct(1:10,3,0)`
![](https://i.imgur.com/R3G2191.png)

#### construst_data_array
給定特定時間點，建構屬於該時間下的資料（包含所有變數、延遲下的資料）
- Input
`construst_data_array(data,output,index,lag,tstar)`
data：放入[輸入資料格式](#輸入資料格式)中的`input_data`即可
index：想要尋找的時間點集合，例如c(5,10,15)，建構5,10,15分鐘下的資料
lag、tstar：資料包含的延遲長度，輸入lag、tstar即可（一開始已經宣告）
- Output：回傳一個output_array相關說明請見[輸出資料格式](#輸出資料格式)
```r=
#targets <- array(NA,dim=c(times,lag,data_col+1))#空的array
# 更新後已經不用宣告空的Array了
targets <- construst_data_array(COGg07,end,lag,tstar)#想找的pattern集合
```
- Example
```r=
end <- sample(30000:31000,10)#抽樣的時間
targets <- construst_data_array(COGg07,end,lag,tstar)#想找的pattern集合
```
![](https://i.imgur.com/BJMekCe.png)

- 備註：此function適合用於建立訓練與測試集。(給定時間點與資料集即可)
#### pattern_retrieval
透過計算兩個Pattern的距離（歐式／差分後）回傳與目標最相近的K個時間點
- Input
`pattern_retrieval(data,target,k,diff=0)`
data：放入[輸入資料格式](#輸入資料格式)中的`input_data`即可
**若data只有一維，請使用`as.matrix(data)`，作為輸入。**
target：想要尋找的Pattern點集合請使用`construst_data_array`的輸出，輸入特定筆的資料，如`targets[1,,]`
k：尋找與pattern前k相近時間點
diff：是否要差分，若大於1則計算diff階差分後的距離，預設為0，計算歐式距離
- Output：輸出與pattern前k相近時間點 
**注意：**
1. 若執行差分，回傳的時間點已經考慮差分後的偏移。
2. 可能會因為門檻值數值剛好有多筆數據的距離相同，所以回傳多餘k筆的資料。
3. 若執行過差分，則可能會多非常多筆（程式完成後經過多次測試都沒有發現此現象，目前研判為撰寫過程中的bug，已排除）

- Example
```r
closed_pattern <- pattern_retrieval(training_data,target,k,0) #k=10
closed_pattern <- pattern_retrieval(training_data,target,k,1)#找相似
```
![](https://i.imgur.com/s2D984r.png)

#### output_to_dataframe
將`construst_data_array`的資料轉換成可以套入模型的dataframe，用於轉換訓練與預測資料集
- Input
`output_to_dataframe(input_data)`
input_data：使用`construst_data_array`回傳的內容即可
- Output
為一個dataframe，注意此data frame的欄名稱並不連續，其中`v1`為該變數時間點`t`延遲`tstar`分鐘後（預測時的應變數）的結果，其他如`v11`為第一個變數的第一個時間（變數時間點`t`往前`lag`分鐘）的數值。
（此結果會隨`lag`時間不同而改變，若`lag=6`，則`v7`為第一個變數第一個時間的數值）
採用此格式的原因為可以更一目瞭然存取每個變數不同時間的數值
- Example
```r=
local_train <- output_to_dataframe(local_train)
```
![](https://i.imgur.com/2Xe5MLn.png)



### 實際預測的方法
因為預設output為array而非matrix或data frame，所以做預測上會比較麻煩，以下提供三種方法

<details> <summary>詳細內容</summary>
1. 方法一
    
```r=
local_train <- construst_data_array(input_data,closed_pattern,lag,tstar)
local_train <- cbind(local_train[,1,1],local_train[,,2],local_train[,,3])
local_train <- as.data.frame(local_train)
```
![](https://i.imgur.com/brI8LEy.png)
優點：變數名稱沒有跳號
缺點：需要根據資料維度手動更改第二行`cbind()`的維度

2. 方法二
```r=
local_train <- construst_data_array(input_data,closed_pattern,lag,tstar)
local_train <- matrix(local_train,nrow = times)
local_train <- t(na.omit(t(local_train)))
# 因為na.omit只支援刪除有na.row 所以要轉至後再處理
local_train <- as.data.frame(local_train)
```
3. 方法三
```r=
local_train <- construst_data_array(input_data,closed_pattern,lag,tstar)
local_train <- as.data.frame(local_train)
local_train <- t(na.omit(t(local_train)))
local_train <- as.data.frame(local_train)
```
備註：決定好何種資料格式後會將其寫成function 方便後續使用</details>

5/9 更：此轉換已經用`output_to_dataframe`完成，但要存取`target`（預測點的實際資料）作為`predict`函數使用時，還是要特別處理成data frame。
```r=
target <- matrix(target,nrow=1)
target <- as.data.frame(target)

predicts <- predict(lm.fit,target)
```
以下以`lm`為例：
匯入資料與基本參數紹定
```r=
COGg07 <- read.csv("資料/COGgeneration201307.csv")#先使用七月份的資料
COGg07 <-cbind(COGg07$W51_LX.152.2.OV,COGg07$W51_LX.152.1.OV)
#匯入holder 1 &2
# holder 2 放在第一個，所以以預測holder 2為主

#基本參數設定
data_col <- 2 #欄數
lag <- 10 #投入前多少分鐘的資料
k <- 10 #找距離前K近的Pattern
tstar <- 5 #預測多久後的資料
times <- 10 #預測多少次
```
抽預測的時間點
```r=
set.seed(1) #示範用
end <- sample(30000:31000,times) # 抽樣抽十次
#想找的pattern集合
targets <- construst_data_array(COGg07,end,lag,tstar)

```
投入預測
```r=
predicts <- c()#預測的結果
for(i in 1:dim(targets)[1]){#for i in 1:times，預測每個抽樣
  closed_pattern <- c()#相近的時間點
  target <- targets[i,,]#第i筆資料中的y,x1,x2....
  closed_pattern <- pattern_retrieval(training_data,target,k,1)#找相似
  local_train <- construst_data_array(training_data,closed_pattern,lag,tstar)
  local_train <- output_to_dataframe(local_train)
  
  lm.fit <- lm(V1~V11+V15+V20+V25+V30,data=local_train)
  #summary(lm.fit)

  target <- matrix(target,nrow=1)
  target <- as.data.frame(target)
  predicts <- c(predicts,predict(lm.fit,target))
}
```
預測結果
```r=
mean(abs((targets[,1,1]-predicts)/targets[,1,1]))#mape
mean((targets[,1,1]-predicts)^2)#MSE
plot(targets[,1,1]-predicts)#殘差圖
```
MAPE為3.9655%
MSE為4.078622
殘差圖
![](https://i.imgur.com/XEGd2tN.png)

