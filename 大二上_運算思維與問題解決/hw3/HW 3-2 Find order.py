import json
with open('order_list.json', 'r') as f:
        dataset = json.load(f)
print(dataset['Drunkard'][-3])