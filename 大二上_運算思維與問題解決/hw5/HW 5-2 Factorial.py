def Factorial(num):
    if num == 1 or num == 0:
        return 1
    else:
        return num * Factorial(num - 1)


print(Factorial(4))