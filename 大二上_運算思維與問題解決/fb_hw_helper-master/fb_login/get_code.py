def prasing_md(path):

    file = open(path,"r",encoding='utf-8')
    source_code=file.read()

    split_code = source_code.split("```")
    code = []
    md_left = []

    for i in range(len(split_code)):
        if i % 2 == 1:
            code.append(split_code[i].strip("=python\n"))
        else:
            md_left.append(split_code[i])

    picture_link = []
    temp_left=""
    for md_part in md_left:
        if len(md_part.split("![]("))>1:
            for i in range (1,len(md_part.split("![]("))):
                temp = md_part.split("![](")[i]
                picture_link.append(temp[:temp.find(")")])
        else:
            temp_left+=md_part

    return [temp_left,code,picture_link]

print(prasing_md("HW5_H14086030_郭庭維.md"))
