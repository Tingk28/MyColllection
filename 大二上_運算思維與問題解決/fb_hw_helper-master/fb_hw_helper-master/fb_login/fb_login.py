from selenium import webdriver
from selenium.webdriver.common.by import By
import json
import time
from bs4 import BeautifulSoup


def get_otp():
    return input("需要二階認證或二階認證驗證碼輸入錯誤，請輸入二階段驗證碼")


def if_fail():
    print("fail")


def login(accounts, password):
    driver.get(r'https://www.facebook.com/')  # 連線至指定的網頁
    account_id = driver.find_element_by_id("email")
    account_id.send_keys(accounts)
    account_pass = driver.find_element_by_id("pass")
    account_pass.send_keys(password)
    login_button = driver.find_element_by_name("login")
    login_button.click()
    time.sleep(2)
    if len(driver.find_elements_by_id("loginbutton")) == 1:
        if_fail()
    else:
        print("登入成功")

    try:  # 登入區塊，從檢查是否有兩階認證 一路到登入FB首頁
        while (1):
            try:
                enter_OTP = driver.find_element_by_id("approvals_code")
                OTP = get_otp()
                enter_OTP.send_keys(OTP)
                OTP_button = driver.find_element_by_id("checkpointSubmitButton")
                OTP_button.click()
            except:
                break
        while (1):
            try:
                # driver.find_element(By.CSS_SELECTOR, ".uiInputLabel:nth-child(2) .\\_2iem").click()
                driver.find_element(By.ID, "checkpointSubmitButton").click()
            except:
                break
    except Exception as e:
        print(e)


def get_id(i):
    try:
        comment = driver.find_element_by_xpath(f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[4]/div/div/div/div/div/div[1]/div/div/div/div/div/div/div/div/div/div/div[2]/div/div[4]/div/div/div[2]/ul/li[{i}]/div[1]/div/div[2]/div[1]/div[1]/div/div/span/div/a/span/span')
        comment = comment.text
    except:
        try:
            comment = driver.find_element_by_xpath(f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[4]/div/div/div/div/div/div[1]/div/div/div/div/div/div/div/div/div/div/div[2]/div/div[4]/div/div/div[2]/ul/li[{i}]/div[1]/div/div[2]/div/div[1]/div/div[1]/div/div/span/div/a/span/span')
            comment = comment.text
        except:
            comment = ""
    return comment
def get_link(i):
    try:
        link = driver.find_element_by_xpath(f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[4]/div/div/div/div/div/div[1]/div/div/div/div/div/div/div/div/div/div/div[2]/div/div[4]/div/div/div[2]/ul/li[{i}]/div[1]/div/div[2]/div[1]/div[1]/div/div/div/span/div/div[2]/a')
        link = link.get_attribute('href')
    except:
        try:
            link = link = driver.find_element_by_xpath(f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[4]/div/div/div/div/div/div[1]/div/div/div/div/div/div/div/div/div/div/div[2]/div/div[4]/div/div/div[2]/ul/li[{i}]/div[1]/div/div[2]/div[1]/div[1]/div/div/div/span/div/div/a')
            link = link.get_attribute('href')
        except:
            link = ""
    return link

def HWlist():
    driver.get(r"https://www.facebook.com/groups/315124296585941/search/?query=Submission&epa=SEARCH_BOX")
    for x in range(4):
        print(x)
        driver.execute_script("window.scrollTo(0,document.body.scrollHeight)")
        time.sleep(2)
    # 爬連結區塊始
    content_list = []
    link_list = []
    soup = BeautifulSoup(driver.page_source, 'html.parser')
    link_tags = soup.find_all('a', {'class': 'oajrlxb2 g5ia77u1 qu0x051f esr5mh6w e9989ue4 r7d6kgcz rq0escxv nhd2j8a9 a8c37x1j p7hjln8o kvgmc6g5 cxmmr5t8 oygrvhab hcukyx3x jb3vyjys rz4wbd8a qt6c0cv9 a8nywdso i1ao9s8h esuyzwwr f1sip0of lzcic4wl gmql0nx0 p8dawk7l'})
    i=1
    while (i):
        try:
            content=driver.find_element_by_xpath(f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div/div/div/div/div/div[{i}]/div/div/div/div/div/div[3]/a/div[1]/div/div[1]/div/div[1]/span/span')
            i+=1
            content_list.append(content.text)
        except Exception as e:
            break
    for link in link_tags:
        link_list.append(link['href'])
    result ={}
    for i in range(len(content_list)):
        key = content_list[i]
        value = link_list[i]
        if 'HW Submission_HW' in key:
            key = key[key.find('[')+2:key.find(']')]
            result[key] = value
    return result
def get_comment(URL):
    driver.get(URL)  # 到達該貼文
    while (1):  # 點擊「查看另外n則留言」
        try:
            time.sleep(3)
            driver.find_element(By.CSS_SELECTOR, ".j83agx80:nth-child(5) > .j83agx80 > .oajrlxb2 .d2edcug0").click()
        except Exception as e:
            break
    # 爬連結區塊始
    result={}
    i=1
    while (i):
        id = get_id(i)
        link = get_link(i)
        if id != "" and link != "":
            result[id] = link
        if id == "":
            break
        i += 1
    return result


#<editor-fold desc="帳號密碼">
with open('fbaccount.json', 'r', encoding='utf-8') as f:
    output = json.load(f)
acc = output['account']
passwd = output['password']
#</editor-fold>


options = webdriver.ChromeOptions()# 此下三行為driver初始設定
options.add_argument("--disable-notifications")
driver = webdriver.Chrome(r'chromedriver.exe', options=options)
login(acc,passwd)
hw_list=HWlist()
for key, url in zip(hw_list.keys(), hw_list.values()):
    hw_list[key] = get_comment(url)
print(hw_list)
