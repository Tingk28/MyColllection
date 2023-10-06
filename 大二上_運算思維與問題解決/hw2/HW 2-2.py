import json
zoo = {'Zebra':'An Africa horse','Lobster':'Mermaid for insect'}
zoo['Cat']='Crazy angry furry ball'
with open('zoo.json', 'w', encoding='utf-8') as f:
    json.dump(zoo,f)