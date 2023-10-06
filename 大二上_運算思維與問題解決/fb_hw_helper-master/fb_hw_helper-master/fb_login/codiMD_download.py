from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import os

def if_fail():
    print("fail")


def codimd_login(accounts, password):
    driver.get(r'https://playlab.computing.ncku.edu.tw:3001/')  # 連線至指定的網頁
    while(1):
        try:
            driver.find_element(By.CSS_SELECTOR, ".btn-success:nth-child(1)").click()  # 點開登入視窗
            time.sleep(1)
            driver.find_element(By.NAME, "username").send_keys(accounts)  # 填入帳號
            time.sleep(1)
            driver.find_element(By.NAME, "password").send_keys(password)  # 填入密碼
            driver.find_element(By.CSS_SELECTOR, ".col-sm-12 > .btn").click()  # 按下"登入"
            driver.find_element_by_class_name("dropdown-menu") # 有找到表示登入成功 沒找到會觸發exception
            break
        except :
            if_fail() # 登入失敗，可能要請使用者重新輸入帳密。 一樣break出去或是把 account 跟passwd的輸入拉到function內


def codimd_download(URL):
    driver.get(URL)
    driver.find_element(By.CSS_SELECTOR, "a:nth-child(1) > .fa-caret-down").click()
    driver.find_element(By.LINK_TEXT, "Markdown").click()
    time.sleep(1)


before_file_list =os.listdir()
url_list=["https://playlab.computing.ncku.edu.tw:3001/P-YMVq9BQKinFXGFXGHy8w","https://playlab.computing.ncku.edu.tw:3001/SkhuMjFdTlSCKrgqXN6wQA","https://playlab.computing.ncku.edu.tw:3001/3aLd2i3lQGGbxBMct0pRkw"]
files_path=[]
chromeOptions = webdriver.ChromeOptions()# 此下三行為driver初始設定
prefs = {"download.default_directory" : os.getcwd()}
chromeOptions.add_experimental_option("prefs",prefs)
driver = webdriver.Chrome(executable_path=r"chromedriver.exe", options=chromeOptions)
codimd_login("帳號","密碼") # todo:登入失敗的處理方式
for url in url_list:
    codimd_download(url)
driver.quit() # 都載好了關閉driver
after_file_list=os.listdir()
for name in before_file_list: # 刪除存在的檔案
    after_file_list.remove(name)
for name in after_file_list: # 幫檔案名稱加上路徑
    files_path.append(os.path.join(os.getcwd(),name))
print(files_path) # 中控到時候 return file_path 就好
