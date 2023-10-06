import json
with open('students.json', 'r') as f:
        dataset = json.load(f)
unbelievable=[]
bad=[]
notbad=[]

good=[]
excellent=[]
for i in dataset:
    if dataset[i]<35:
        unbelievable.append(i)
    elif dataset[i]<50:
        bad.append(i)
    elif dataset[i]<70:
        notbad.append(i)
    elif dataset[i]<85:
        good.append(i)
    else:
        excellent.append(i)
print("excellent: ",end="")
print(excellent)
print("good: ",end="")
print(good)
print("notbad: ",end="")
print(notbad)
print("bad: ",end="")
print(bad)
print("unbelievable: ",end="")
print(unbelievable)