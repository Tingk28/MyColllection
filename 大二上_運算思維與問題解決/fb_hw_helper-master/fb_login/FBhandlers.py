from selenium import webdriver
from selenium.webdriver.common.by import By
from PyQt5.QtCore import pyqtSignal, QObject, pyqtSlot
from bs4 import BeautifulSoup
import requests
import time
import os

class FBhandlers(QObject):

    ### Signals
    LoginFinished = pyqtSignal(object)

    def __init__(self):
        super(FBhandlers, self).__init__()
        ### Initialize webdriver
        prefs = {"download.default_directory": os.getcwd()}
        options = webdriver.ChromeOptions()  # 此下三行為driver初始設定
        options.add_argument("--disable-notifications")
        options.add_experimental_option("prefs", prefs)
        if __name__ == '__main__':
            self.driver = webdriver.Chrome('./chromedriver.exe', options=options)
        else:
            self.driver = webdriver.Chrome('./fb_login/chromedriver.exe', options=options)

        # Initialize requests session
        self.codiSession = requests.Session()

    def foo(self, *args):
        for i in args:
            print(i)
        output = {'success': True, 'needAuth': '0'}
        self.LoginFinished.emit(output)

    def get_otp(self, driver):
        while not driver.current_url == 'https://www.facebook.com/':
            pass

        if __name__ == '__main__':
            return input("需要二階認證或二階認證驗證碼輸入錯誤，請輸入二階段驗證碼")

    def login(self, driver, account, password):
        ### Output param
        output = {
            'success': False,
            'needAuth': 'test'
        }

        driver.get(r'https://www.facebook.com/')  # 連線至指定的網頁
        account_id = driver.find_element_by_id("email")
        account_id.send_keys(account)
        account_pass = driver.find_element_by_id("pass")
        account_pass.send_keys(password)
        login_button = driver.find_element_by_name("login")
        login_button.click()
        try:  # 登入區塊，從檢查是否有兩階認證 一路到登入FB首頁
            while (1):
                try:
                    enter_OTP = driver.find_element_by_id("approvals_code")
                    OTP = self.get_otp(driver)
                    enter_OTP.send_keys(OTP)
                    OTP_button = driver.find_element_by_id("checkpointSubmitButton")
                    OTP_button.click()
                except Exception as e:
                    print(e)
                    break
            while (1):
                try:
                    # driver.find_element(By.CSS_SELECTOR, ".uiInputLabel:nth-child(2) .\\_2iem").click()
                    driver.find_element(By.ID, "checkpointSubmitButton").click()
                except:
                    break
        except Exception as e:
            print(e)

        if len(driver.find_elements(By.CSS_SELECTOR, '._9ay4')) == 0:
            output['success'] = True
        else:
            print('login  failed')
            output['success'] = False

        self.LoginFinished.emit(output)

    def getMDPath(self, URL, account='', password=''):
        before_file_list = os.listdir()
        self.codiMDDownload_fast(URL, account, password)
        after_file_list = os.listdir()
        for name in before_file_list:
            after_file_list.remove(name)
        file_path = os.path.join(os.getcwd(), after_file_list[0])
        return file_path  # 中控到時候 return file_path 就好

    def codiMDLogin(self, account='', password=''):
        auth = 'https://playlab.computing.ncku.edu.tw:3001/auth/ldap'
        payload = {'username': account, 'password': password}
        self.codiSession.post(auth, data=payload)
        response = self.codiSession.get('https://playlab.computing.ncku.edu.tw:3001/history')
        h_len = len(response.history)

        return h_len == 0

    def codiMDDownload_fast(self, mdurl):
        ### return: pure text in markddown format
        ### mdurl: dict()
        # { 'HWX':
        #       { 'Name': 'link',
        #          ...
        #       }
        # }
        mddata = {}
        s = self.codiSession

        for hw, content in mdurl.items():
            mddata[hw] = {}
            for name, link in content.items():
                try:
                    url = s.get(link).headers['Refresh']
                except:
                    print(f'Wrong url:\n {link}')
                    continue
                url = url.split('?')[0]
                url = url.split('=')[1]
                url += '/download'
                r = s.get(url)
                mddata[hw][name] = r.text
        return mddata

    def codiMDDownload(self, driver, url_list, account='', password=''):

        def if_fail():
            print("fail")

        def codimd_login(account, password):
            driver.get(r'https://playlab.computing.ncku.edu.tw:3001/')  # 連線至指定的網頁
            while(1):
                try:
                    driver.find_element(By.CSS_SELECTOR, ".btn-success:nth-child(1)").click()  # 點開登入視窗
                    time.sleep(1)
                    driver.find_element(By.NAME, "username").send_keys(account)  # 填入帳號
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

        codimd_login(account, password)  # todo:登入失敗的處理方式
        for url in url_list:
            codimd_download(url)
        driver.quit()  # 都載好了關閉driver
        files_path = []
        before_file_list =os.listdir()
        after_file_list=os.listdir()
        for name in before_file_list: # 刪除存在的檔案
            after_file_list.remove(name)
        for name in after_file_list: # 幫檔案名稱加上路徑
            files_path.append(os.path.join(os.getcwd(),name))
        return files_path # 中控到時候 return file_path 就好

    def get_id(self, i):
        driver = self.driver
        try:
            comment = driver.find_element_by_xpath(
                f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[4]/div/div/div/div/div/div[1]/div/div/div/div/div/div/div/div/div/div/div[2]/div/div[4]/div/div/div[2]/ul/li[{i}]/div[1]/div/div[2]/div[1]/div[1]/div/div/span/div/a/span/span')
            comment = comment.text
        except:
            try:
                comment = driver.find_element_by_xpath(
                    f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[4]/div/div/div/div/div/div[1]/div/div/div/div/div/div/div/div/div/div/div[2]/div/div[4]/div/div/div[2]/ul/li[{i}]/div[1]/div/div[2]/div/div[1]/div/div[1]/div/div/span/div/a/span/span')
                comment = comment.text
            except:
                comment = ""
        return comment

    def get_link(self, i):
        driver = self.driver
        try:
            link = driver.find_element_by_xpath(
                f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[4]/div/div/div/div/div/div[1]/div/div/div/div/div/div/div/div/div/div/div[2]/div/div[4]/div/div/div[2]/ul/li[{i}]/div[1]/div/div[2]/div[1]/div[1]/div/div/div/span/div/div[2]/a')
            link = link.get_attribute('href')
        except:
            try:
                link = driver.find_element_by_xpath(
                    f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[4]/div/div/div/div/div/div[1]/div/div/div/div/div/div/div/div/div/div/div[2]/div/div[4]/div/div/div[2]/ul/li[{i}]/div[1]/div/div[2]/div[1]/div[1]/div/div/div/span/div/div/a')
                link = link.get_attribute('href')
            except:
                link = ""
        return link

    def HWlist(self):
        driver = self.driver
        driver.get(r"https://www.facebook.com/groups/315124296585941/search/?query=Submission&epa=SEARCH_BOX")
        for x in range(4):
            print(x)
            driver.execute_script("window.scrollTo(0,document.body.scrollHeight)")
            time.sleep(2)
        # 爬連結區塊始
        content_list = []
        link_list = []
        soup = BeautifulSoup(driver.page_source, 'html.parser')
        link_tags = soup.find_all('a', {
            'class': 'oajrlxb2 g5ia77u1 qu0x051f esr5mh6w e9989ue4 r7d6kgcz rq0escxv nhd2j8a9 a8c37x1j p7hjln8o kvgmc6g5 cxmmr5t8 oygrvhab hcukyx3x jb3vyjys rz4wbd8a qt6c0cv9 a8nywdso i1ao9s8h esuyzwwr f1sip0of lzcic4wl gmql0nx0 p8dawk7l'})
        i = 1
        while (i):
            try:
                content = driver.find_element_by_xpath(
                    f'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div/div/div/div/div/div[{i}]/div/div/div/div/div/div[3]/a/div[1]/div/div[1]/div/div[1]/span/span')
                i += 1
                content_list.append(content.text)
            except Exception as e:
                break
        for link in link_tags:
            link_list.append(link['href'])
        result = {}
        for i in range(len(content_list)):
            key = content_list[i]
            value = link_list[i]
            if 'HW Submission_HW' in key:
                key = key[key.find('[') + 2:key.find(']')]
                result[key] = value
        return result

    def get_comment(self, URL):
        driver = self.driver
        driver.get(URL)  # 到達該貼文
        while (1):  # 點擊「查看另外n則留言」
            try:
                time.sleep(3)
                driver.find_element(By.CSS_SELECTOR, ".j83agx80:nth-child(5) > .j83agx80 > .oajrlxb2 .d2edcug0").click()
            except Exception as e:
                break
        # 爬連結區塊始
        result = {}
        i = 1
        while (i):
            id = self.get_id(i)
            link = self.get_link(i)
            if id != "" and link != "":
                result[id] = link
            if id == "":
                break
            i += 1
        return result

    def getMDLinks(self):
        hw_list = self.HWlist()
        for key, url in zip(hw_list.keys(), hw_list.values()):
            hw_list[key] = self.get_comment(url)
        return hw_list

    def parseMDtext(self, path):
        ### 分析完MD檔案
        # path: str. md raw text
        # return: [ list(), list(), list() ]
        source_code = path

        split_code = source_code.split("```")
        code = []
        md_left = []

        for i in range(len(split_code)):
            if i % 2 == 1:
                code.append(split_code[i].strip("=python\n"))
            else:
                md_left.append(split_code[i])

        picture_link = []
        temp_left = ""
        for index in range(len(md_left)):
            picture_link.append([])
            md_part = md_left[index]

            if len(md_part.split("![](")) > 1:
                for i in range(1, len(md_part.split("![]("))):
                    temp = md_part.split("![](")[i]
                    picture_link[len(picture_link)-1].append(temp[:temp.find(")")])

                    if '## HW' in temp and len(md_part.split("![](")) > i+1:
                        picture_link.append([])
                        index += 1
            else:
                temp_left += md_part

        return [temp_left, code, picture_link]

    def getMDcode(self, path):
        ### 分析完MD檔案後回傳程式碼部分
        # path: str. md raw text
        # return: list()
        code = self.parseMDtext(path)[1]
        return code

    def getMDtext(self, path):
        ### 分析完MD檔案後回傳文字部分
        # path: str. md raw text
        # return: list()
        text = self.parseMDtext(path)[0]
        return text


if __name__ == '__main__':

    FBh = FBhandlers()
    with open('HW5_B24064077_陳怡真.md', encoding='utf-8') as f:
        path = f.read()
    d = FBh.parseMDtext(path)
    print(d)
