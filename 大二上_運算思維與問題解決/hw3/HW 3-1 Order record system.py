dict={}
dict["Mary"]=["Mojito"]#Mary wants a Mojito
print(dict)

dict["Hank"]=["Long Island Ice Tea"]#Hank wants a Long Island Ice Tea
print(dict)

dict["Hank"].append("Dark Beer")#Hank wants a Dark Beer
print(dict)

dict["Mary"].append("Mojito")#Mary wants a Mojito (the second one)
print(dict)

dict["Jason"]=["Screwdriver"]#Jason wants a Screwdriver
print(dict)

del dict["Mary"]#Mary leave the bar"
print(dict)