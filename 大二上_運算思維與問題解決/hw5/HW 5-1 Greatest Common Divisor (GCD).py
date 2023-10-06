def GCD(num1, num2):
    temp = num1
    num1 = num1 % num2
    num2 = num2 % temp  # 兩個都做相除，如此一來不用判斷誰大誰小
    if num1 == 1 or num2 == 1:  # 互質
        return 1  # 回傳1
    if num1 * num2 == 0:  # 其中一數為0
        return num1 + num2  # 回傳不為0的數，為了省去判斷部分，相加後回傳
    else:  # 不符合回傳條件，往下繼續做GCD
        return GCD(num1, num2)
print(GCD(72, 120))