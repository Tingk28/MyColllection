from fb_login.FBhandlers import FBhandlers
from selenium import webdriver
from PyQt5.QtCore import pyqtSignal, QObject, pyqtSlot, QThread
from PyQt5.QtGui import QPixmap
import requests, csv, re

class Worker(QObject):
    ### Multithread worker object
    start = pyqtSignal()

    def __init__(self, function, *args, **kwargs):
        super(Worker, self).__init__()
        self.function = function
        self.args = args
        self.kwargs = kwargs
        self.start.connect(self.run)

    def assignJob(self, function, *args, **kwargs):
        self.function = function
        self.args = args
        self.kwargs = kwargs

    @pyqtSlot(name='run')
    def run(self):
        tid = int(QThread.currentThreadId())
        print(f'Side thread: {tid}')
        self.function(*self.args, **self.kwargs)

class Communicator(QObject):
    ### Communicate between ui and FB handler
    codiMDFetchFinished = pyqtSignal(str)

    def __init__(self, ui):
        super(Communicator, self).__init__()
        self.ui = ui
        self.FBh = FBhandlers()
        self.thread = QThread()
        self.HWdata = {}
        self.authCode = ''
        self.thread.start()

        ### Bind
        self.FBh.LoginFinished.connect(self.onLoginFinished)
        self.codiMDFetchFinished.connect(self.onCodiMDFetchFinished)

    def getQuizContent(self, who, quiz, section=0):
        who = self.nameToFBname(who)
        try:
            raw = self.HWdata[quiz]
            raw = raw[who]
        except Exception as e:
            raw = repr(e)
        return raw

    def getCodeContent(self, who, quiz, section=0):
        # return {
        #   'type': 'code' / 'img',
        #   'data': str / QPixmap
        # }
        who = self.nameToFBname(who)
        try:
            raw = self.HWdata[quiz]
            raw = raw[who]
            text = self.FBh.parseMDtext(raw)
            if section >= len(text[1]):
                url = text[2][section+1][0]
                data = self.getImageFromUrl(url)
                ttype = 'img'
            else:
                data = text[1][section]
                ttype = 'code'
        except Exception as e:
            data = repr(e)
            ttype = 'code'
        result = {
            'type': ttype,
            'data': data
        }
        return result

    def getImageFromUrl(self, url):
        r = self.FBh.codiSession.get(url)
        pixmap = QPixmap()
        if r.status_code == requests.codes.ok:
            pixmap.loadFromData(r.content)
        else:
            print(r.status_code)

        return pixmap

    def postProcess(self, links):
        results = {}
        for key, val in links.items():
            rKey = key.split('_')[-1].replace(' ', '')
            results[rKey] = val
        return results

    def nameToFBname(self, name):
        table = self.ui.mkdb.innerData
        FBname = ''
        for row in table:
            if row[1] == name:
                FBname = row[2]
                break
        return FBname

    def codiMDLogin(self, account, password):
        success = self.FBh.codiMDLogin(account, password)
        if success:
            worker = self.ui.worker
            worker.assignJob(self.fetchCodiMDRaw)
            worker.start.emit()

        return success

    def fetchCodiMDRaw(self):
        # Fetch all CodiMd links from FB comments
        links = self.FBh.getMDLinks()
        links = self.postProcess(links)
        self.HWdata = self.FBh.codiMDDownload_fast(links)
        self.codiMDFetchFinished.emit('success')

    def setUIList(self):
        ### Prepare ui
        ui = self.ui
        markData = []
        for i in range(10):
            hw = f'HW{i}'
            markData.append(self.ui.mkdb.getMarkByHw(hw))
        ui.SetHWList(
            [
                ("HW3", self.getSecNum("HW3"), markData[2]),
                ("HW4", self.getSecNum("HW4"), markData[3]),
                ("HW5", self.getSecNum("HW5"), markData[4]),
                ("HW6", self.getSecNum("HW6"), markData[5])
            ]
        )

    def getSecNum(self, quiz):
        ### hw: str. 'HW1', 'HW2'...
        ### return: int. Number of sections in the quiz
        raw = self.HWdata[quiz]
        mdData = list(raw.items())[1][1]
        parsed = self.FBh.parseMDtext(mdData)
        length = len(parsed[2]) - 1

        return length

    ### Slots
    @pyqtSlot(object, name='onLoginFinished')
    def onLoginFinished(self, msg):
        self.ui.UserAccountConfirm(msg['success'])
        needAuth = msg['needAuth']  # True while debug mode
        print(needAuth)

        if msg['success']:
            # Request codiMd A/C and pwd.
            codiWindow = self.ui.sub_codimd
            codiWindow.show()

    @pyqtSlot(str, name='onCodiMDFetchFinished')
    def onCodiMDFetchFinished(self, msg):
        if msg == 'success':
            self.ui.sub_codimd.close()
            self.setUIList()
            print('CodiMD fetching success')
        else:
            print('CodiMD fetching fail')

class markDatabase():
    ### Store marking result to file ####
    # Three states are used             #
    # 'a': absent                       #
    # 'p': passed                       #
    # 'f': failed                       #
    #####################################
    markPath = './markData.dat'
    slPath = './UI/SL.slfile'
    innerData = []
    def __init__(self):
        with open(self.markPath, 'r', newline='', encoding='utf-8') as csvfile:
            self.innerData = list(csv.reader(csvfile))

    def writeToDisk(self):
        with open(self.markPath, 'w', newline='', encoding='utf-8') as csvfile:
           writer = csv.writer(csvfile)
           writer.writerows(self.innerData)
           print('Mark data saved')

    def createColumns(self, maxCol):
        ### maxCol: max homework number
        maxCol = int(maxCol)
        begin = len(self.innerData[0]) - 3
        # Create header
        for j in range(begin, maxCol):
            item = f'HW{j+1}'
            self.innerData[0].append(item)
        # Initialize new columns
        for j in range(begin, maxCol):
            for i in range(1, len(self.innerData)):
                self.innerData[i].append('a')

    def getMark(self, hw, student):
        ### hw: str. 'HW1', 'HW2'...
        ### student: str. Name.
        ### return: str. 'state'
        hw_ptr = int(re.search(r'\d', hw).group(0)) + 2
        token = ''
        for i in range(1, len(self.innerData)):
            if self.innerData[i][1] == student:
                token = self.innerData[i][hw_ptr]
                break
        return self.convert(token)

    def getMarkByHw(self, hw):
        ### hw: str. 'HW1', 'HW2'...
        ### return: {'Name1': 'state1', 'Name2': 'state2'...}
        hw_ptr = int(re.search(r'\d', hw).group(0)) + 2
        states = {}
        for i in range(1, len(self.innerData)):
            student = self.innerData[i][1]
            token = self.innerData[i][hw_ptr]
            states[student] = self.convert(token)
        return states

    def setMark(self, hw, state):
        ### hw: str. 'HW1', 'HW2'...
        ### state: tuple(). ('Name', 'state'})
        hw_ptr = int(re.search(r'\d', hw).group(0)) + 2
        student = state[0]
        code = self.convert(state[1], True)
        for i in range(1, len(self.innerData)):
            if self.innerData[i][1] == student:
                self.innerData[i][hw_ptr] = code
                break

    def setMarkByHw(self, hw, states):
        ### hw: str. 'HW1', 'HW2'...
        ### state: dict(). {'Name1': 'state1', 'Name2': 'state2'...}
        for key, val in states:
            d = {}
            d[key] = val
            self.setMark(hw, d)

    def convert(self, token, reverse=False):
        ### Convert token from inner data encoding to ui accepted.
        # Reverse convert direction as reverse set to True.
        if reverse:
            return {
                '繳交': 'p',
                '未過': 'f',
                '未交': 'a'
            }.get(token, '?')
        else:
            return {
                'p': '繳交',
                'f': '未過',
                'a': '未交'
            }.get(token, 'ERROR')


if __name__ == '__main__':

    mdb = markDatabase()

    mdb.createColumns(10)
    mdb.writeToDisk()

    s = mdb.getMarkByHw('HW1')
    print(s)

