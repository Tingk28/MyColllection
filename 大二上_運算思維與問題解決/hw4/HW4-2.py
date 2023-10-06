hero = ['Iron Man', 'Captain America', 'Black Widow', 'Thor', 'Hulk']
weight = [75, 85, 58, 90, 250]
height = [175, 182, 162, 185, 220]
heros = {}
for a, b, c in zip(hero, weight, height):
    heros[a] = (b, c)
print(heros)