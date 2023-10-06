poem =\
"Do not go gentle into that good night.\
Old age should burn and rave at close of day.\
Rage, rage against the dying of the light.\
Though wise men at their end know dark is right.\
Because their words had forked no lightning they.\
Do not go gentle into that good night."
Array=poem.split(".",6)#以句點分割並將其存到一個名為Array的陣列，共六行
for I in range(len(Array)-1):#Array[6]為空("")故-1
    Sub_Array=Array[I].split(",")#將","從字串中移除
    if len(Sub_Array)==2:
        Sub_Array[0]+=Sub_Array[1]
    Sub_Array=Sub_Array[0].split(" ")#將" "從字串中移除
    Array[I]=""#清空Array中的原字串
    for i in range(len(Sub_Array)):
        Array[I]+=Sub_Array[i]#把移除","和" "的字串重新寫入Array
    print('for "' + Array[I] + '" is ' +str(len(Array[I])))  # 輸出結果