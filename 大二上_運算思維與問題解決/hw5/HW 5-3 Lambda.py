def new_score_def(num):
    return num *0.6+40
new_score_lambda = lambda num: num*0.6+40
print(new_score_def(60))
print(new_score_lambda(60))