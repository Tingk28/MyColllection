while 1 == 1:
    try:
        weight=int(input("Please enter your weight(kg):"))
        break
    except :
        print("only accept the int input, please check again")
while 1 == 1:
    try:
        height=int(input("Please enter your height(cm):"))
        break
    except :
        print("only accept the int input, please check again")

BMI = (weight/(height/100)**2)
print("Your BMI is :"+str(BMI))

if BMI < 18.5:
    print("Too thin!!")
elif BMI>24:
    print("Overweight")
else:
    print("Just fine")