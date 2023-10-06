import facebookapi as fb
import json
import csv

dataset = fb.get_json_from_cloud(date='1112')
ids = fb.get_all_user_ids(dataset)
post_list = fb.get_all_posts_all_user_comments_times(dataset)
score_dict = {}
for id in ids:
    score_dict[id] = 0

for id in ids:
    emoji = fb.get_user_emoji_times_by_user_id(dataset, user_id=id)
    score_dict[id] = post_list[id]*3 + sum(emoji.values())
del score_dict["林偉棻"]
del score_dict["杜冠勳"]
del score_dict["Nicolas Hei"]
del score_dict["高士鈞"]
#print(score_dict)

a = max(score_dict, key=score_dict.get)
b = min(score_dict, key=score_dict.get)
max_score = score_dict[a]
min_score = score_dict[b]

for i in score_dict:
    score = score_dict[i]
    score = ((score - min_score) / (max_score - min_score)) * 5 + 15
    score_dict[i] = score
    print(i, "：", score_dict[i])

with open('score.csv', 'w', encoding='UTF-8') as f:
    for key in score_dict:
        f.write("%s,%s\n"%(key,score_dict[key]))
 #  (i - min) / (max - min)