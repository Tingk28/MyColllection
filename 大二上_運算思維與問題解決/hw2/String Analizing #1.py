poem =\
"Do not go gentle into that good night.\
Old age should burn and rave at close of day.\
Rage, rage against the dying of the light.\
Though wise men at their end know dark is right.\
Because their words had forked no lightning they.\
Do not go gentle into that good night."
array=poem.split(".",6)#以句點分割並將其存到一個名為array的陣列，共六行
for i in range(len(array)-1):#array[6]為空("")故-1
    array[i]+="."#將作為分隔符號的句點加回去
    print('for "'+array[i]+'" is '+str(len(array[i])))#輸出結果