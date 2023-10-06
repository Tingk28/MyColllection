Ori_ID="H14086236873" #輸入學號
ID=Ori_ID.replace(Ori_ID[0],"")#移除第一位英文字母並轉存到ID中
sum=0
for I in ID:
    sum+=int(I)
print("My ID is "+Ori_ID+" and the sum is : "+str(sum))#印出結果