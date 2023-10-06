shoesbox = {'nike': 2, 'adidus': 5, 'puma': 1, 'converse': 4}
shoe = ['nike', 'adidus', 'puma', 'nike', 'nike', 'converse', 'adidus']
for i in shoe:
    if i in shoesbox:
        shoesbox[i] += 1
    else:
        shoesbox[i] = 1
print(shoesbox)