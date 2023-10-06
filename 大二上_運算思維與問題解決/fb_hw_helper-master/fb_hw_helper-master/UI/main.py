import sys
import os

from PyQt5 import QtWidgets
from PyQt5.QtCore import pyqtSignal, QThread
from PyQt5.QtCore import QTimer
from PyQt5.QtWidgets import QAbstractItemView, QApplication, QDialog, QFileDialog, QLabel, QListWidget, QListWidgetItem, QMainWindow, QMessageBox, QPushButton, QToolBox

if __name__ == "__main__":
    from MainScreen import Ui_MainWindow
    from StudentListSelect import Ui_Dialog_StudentList
    from LoginCodi import Ui_Dialog_LoginCodi
else:
    from UI.MainScreen import Ui_MainWindow
    from UI.StudentListSelect import Ui_Dialog_StudentList
    from UI.comm import Worker
    from UI.LoginCodi import Ui_Dialog_LoginCodi

# img change to Qimg
from PyQt5 import QtCore, QtGui
from PyQt5.QtCore import QFile, QObject
from PyQt5.QtGui import QPixmap

##############################################


dict_State = {'繳交':'[V]',
              '未過':'[X]',
              '未交':'[?]'}
dict_Color = {'繳交':QtGui.QColor("green"),'未過':QtGui.QColor("red"),'未交':QtGui.QColor("black")}

# region 登入
def UIGotAccount(ui, account="account", password="password"):
    """使用者嘗試登入"""
    # 回傳登入結果
    tid = int(QThread.currentThreadId())
    print(f'Main thread: {tid}')
    FBlogin = ui.comm.FBh.login
    driver = ui.comm.FBh.driver
    ui.worker.assignJob(FBlogin, driver, account, password)
    ui.worker.start.emit()

def UserLogout(ui):
    """使用者登出"""
    pass
# endregion

# region 使用者要求頁面
def UserWantQuiz(ui, quiz = "HW1", section = "0"):
    """使用者要求頁面"""
    stu = StateMachine.StudentList[StateMachine.StudentNow]
    quiz_content = ui.comm.getQuizContent(stu, quiz, section)
    code_content = ui.comm.getCodeContent(stu, quiz, section)
    console_result = ""

    ui.Main_MainShow(quiz_content)
    ui.Main_ConsoleShow(console_result)
    
    if code_content['type'] == 'img': # HasPicture
        ui.Main_CodeShow('(圖片如下)') # 供測試使用
        ui.pushButton_exec.setEnabled(False)
        ui.ShowPicture(code_content['data'])
    else:
        ui.Main_CodeShow(code_content['data'])
        ui.ShowPicture(None)
        ui.pushButton_exec.setEnabled(True)

def UserWantRunCode(ui):
    """使用者執行程式"""
    import importlib, HWTEMPFILE

    print('start emit')
    with open('./HWTEMPFILE.py', 'w', encoding='utf8') as f:
        code = ui.textBrowser_Code.toPlainText()
        f.write(code)

    sys.stdout = EmittingStream(textWritten=ui.Main_ConsoleWrite)
    importlib.reload(HWTEMPFILE)
    sys.stdout = sys.__stdout__
    with open('./HWTEMPFILE.py', 'w', encoding='utf8') as f:
        pass
    print('end emit')
# endregion

# region 作業批改
def HWStateModify(ui, state = int):
    quiz = StateMachine.TagList[StateMachine.TagNow]
    stu = StateMachine.StudentList[StateMachine.StudentNow]
    section = StateMachine.quizNow
    st = ['繳交','未過','未交'][state]
    ui.Console_ShowSomething(f'{stu}/{quiz} {section}: {st}')
    ui.mkdb.setMark(quiz, (stu, st))

def SetState(ui, HW = str, student = str):
    """[來自中控的通知] 應該把狀態按鈕切換成 State (['繳交','未過','未交'])"""
    state = ui.mkdb.getMark(HW, student)
    for i , wt in enumerate(['繳交','未過','未交']):
        if( wt == state):
            ui.SetState(i)
            break
# endregion

#region CodiMD login
def Login_CodiMD(codi):
    """取得codi 帳號密碼"""
    account = codi.lineEdit_account.text()
    password = codi.lineEdit_password.text()
    print(account)
    print(password)

    comm = codi.parent.comm
    success = comm.codiMDLogin(account, password)
    ### UI 顯示至狀態欄 ###
    if success:
        codi.parent.Console_ShowSomething("CodiMD login success")
    else:
        codi.parent.Console_ShowSomething("CodiMD login fail")

#endregion

##############################################
class EmittingStream(QObject):
    textWritten = pyqtSignal(str)
    def write(self, text):
        self.textWritten.emit(str(text))
        
SLPath = f"{os.path.split(os.path.realpath(__file__))[0]}/SL.slfile"

class StateMachine:
    StudentList = []
    StudentNow = 0
    TagList = []
    TagNow = 0
    quizNumList = [] # 每個大題的小題編號
    quizNow = 0
        
    @staticmethod
    def NextStudent(PMW):
        if StateMachine.StudentNow + 1 < len(StateMachine.StudentList):
            StateMachine.StudentNow += 1
            PMW.HWlist[StateMachine.TagList[StateMachine.TagNow]].setCurrentRow(StateMachine.StudentNow)
            return (StateMachine.StudentNow, StateMachine.StudentList[StateMachine.StudentNow])
        else:
            return (StateMachine.StudentNow, StateMachine.StudentList[StateMachine.StudentNow])
    
    @staticmethod
    def LastStudent(PMW):
        if StateMachine.StudentNow - 1 >= 0:
            StateMachine.StudentNow -= 1 
            PMW.HWlist[StateMachine.TagList[StateMachine.TagNow]].setCurrentRow(StateMachine.StudentNow)
            return (StateMachine.StudentNow, StateMachine.StudentList[StateMachine.StudentNow])
        else:
            return (StateMachine.StudentNow, StateMachine.StudentList[StateMachine.StudentNow])
             
class LoginWindow(QtWidgets.QWidget, Ui_Dialog_LoginCodi):
    def __init__(self):
        super(LoginWindow, self).__init__()
        
        # ui
        self.setupUi(self)
        
        self.icon.setPixmap(QtGui.QPixmap(f"{os.path.split(os.path.realpath(__file__))[0]}/codi.png"))
        
    
        # Bind
        self.pushButton_login.clicked.connect(self.Login)
    
    def Login(self):
        Login_CodiMD(self)
        
    
class PySubWindow(QtWidgets.QWidget, Ui_Dialog_StudentList):
    def __init__(self):
        super(PySubWindow, self).__init__()
        self.StudentList = [["ID",'Name',"FBID"]]
        
        # ui
        self.setupUi(self)
        self.setWindowIcon(QtGui.QIcon(os.path.split(
            os.path.realpath(__file__))[0] + '/icon.png'))

        # Bind
        self.pushButton_LoadSLFile.clicked.connect(self.readFile)
        self.pushButton_SLComfirm.clicked.connect(self.Close)
        
        # read
        if os.path.exists(SLPath):
            with open(SLPath, 'r', encoding='utf8') as f:
                lines = f.readlines()
                for line in lines[1:]:
                    self.StudentList.append(line.split(','))
                    self.StudentList.append(line.split(',')[1])
            self.model = TableModel(self.StudentList)
            self.tableView_SL.setModel(self.model)
                
        self.pushButton_SLComfirm.setEnabled(True)
        
        self.pushButton_SLComfirm.setEnabled(False)

    def Close(self):
        self.parent.CheckSL()
        self.close()

    def readFile(self):
        fname = QFileDialog.getOpenFileName(
            self, "Open File", "./", "Csv (*.csv)")

        if fname[0]: # 路徑非空白
            self.StudentList = [["ID",'Name',"FBID"]]
            f = QFile(fname[0])            
            f = open(fname[0], "r", encoding='utf8')
            
            with f:
                data = f.readlines()
                header = data[0]
                for index, tag in enumerate(header.split(',')):
                    if tag == "Name":
                        self.HeaderName = index
                    elif tag == "FBID":
                        self.HeaderFBID = index
                    elif tag == "ID":
                        self.HeaderID = index
                for line in data[1:]:
                    line = line.split(',')
                    if line[0] == "":
                        self.StudentList.append([line[self.HeaderID],line[self.HeaderName],line[self.HeaderFBID]])
                    
            f.close()
            with open(SLPath, 'w', encoding='utf8') as f:
                for a,b,c in self.StudentList:
                    f.write(f'{a},{b},{c}\n')
            self.model = TableModel(self.StudentList)
            self.tableView_SL.setModel(self.model)
                    
            self.pushButton_SLComfirm.setEnabled(True)
    
class TableModel(QtCore.QAbstractTableModel):
    def __init__(self, data):
        super(TableModel, self).__init__()
        self._data = data

    def data(self, index, role):
        if role == QtCore.Qt.DisplayRole:
            # See below for the nested-list data structure.
            # .row() indexes into the outer list,
            # .column() indexes into the sub-list
            return self._data[index.row()][index.column()]

    def rowCount(self, index):
        # The length of the outer list.
        return len(self._data)

    def columnCount(self, index):
        # The following takes the first sub-list, and returns
        # the length (only works if all rows are an equal length)
        return len(self._data[0])            

# 安裝教學 https://www.cnblogs.com/fawaikuangtu123/p/9761943.html
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from Crypto.Random import get_random_bytes
import hashlib
import os
class Cryptology(object):
    keyPath = './key'
    def __init__(self):
        # 随机生成16字节（即128位）的加密密钥
        if not os.path.exists(self.keyPath):
            self.key = get_random_bytes(16)
            with open(self.keyPath, 'wb') as f:
                f.write(self.key)
        else:
            with open(self.keyPath, 'rb') as f:
                self.key = f.readline()
    
    def Encoding(self, data = str):
        data = data.encode()
        # 实例化加密套件，使用CBC模式
        cipher = AES.new(self.key, AES.MODE_CBC)
        # 对内容进行加密，pad函数用于分组和填充
        encrypted_data = cipher.encrypt(pad(data, AES.block_size))

        # 将加密内容写入文件
        with open("./encrypted.bin", "wb") as file_out:
            # 在文件中依次写入key、iv和密文encrypted_data
            [file_out.write(x) for x in (self.key, cipher.iv,  encrypted_data)]
    
    def Decoding(self):
        # 从前边文件中读取出加密的内容
        if not os.path.exists("./encrypted.bin"):
            return None
        with open("./encrypted.bin", "rb") as file_in:
            # 依次读取key、iv和密文encrypted_data，16等是各变量长度，最后的-1则表示读取到文件末尾
            self.key, iv, encrypted_data = [file_in.read(x) for x in (16, AES.block_size, -1)]

            # 实例化加密套件
            cipher = AES.new(self.key, AES.MODE_CBC, iv)
            # 解密，如无意外data值为最先加密的b"123456"
            data = unpad(cipher.decrypt(encrypted_data), AES.block_size)
            
            return data.decode()

class PyMainWindow(QMainWindow, Ui_MainWindow):
    crypt = Cryptology() 
    def __init__(self):
        super(PyMainWindow, self).__init__()

        self.sub_window = PySubWindow()
        self.sub_window.parent = self

        self.sub_codimd = LoginWindow()
        self.sub_codimd.parent = self
        # ui
        self.setupUi(self)
        self.setWindowIcon(QtGui.QIcon(os.path.split(os.path.realpath(__file__))[0] + '/icon.png'))

        # load
        acpshe = self.crypt.Decoding()
        if not acpshe is None:
            acpshe = acpshe.split(';')
            acps = acpshe[0].split(',')
            
            s = hashlib.sha256()
            sha = s.update((f"{acpshe[0]}ComputationalThinkingandProblemSolvingFall2020").encode()) # count sha1
            h = s.hexdigest() # sha to hex
            if h == acpshe[1]:                
                self.lineEdit_Account.setText(acps[0])
                self.lineEdit_Password.setText(acps[1])
            else:
                self.Console_ShowSomething("本地端儲存的密碼文件已遭修改!")

        # Bind
        self.pushButton_UserProfileConfirm.clicked.connect(self.UserProfileConfirm_clicked)
        self.pushButton_UserProfileReset.clicked.connect(self.pushButton_UserProfileReset_clicked)
        self.pushButton_SL.clicked.connect(self.OpenSL)
        
        self.pushButton_NextStudent.clicked.connect(self.pushButton_NextStudent_OnClick)
        self.pushButton_LastStudent.clicked.connect(self.pushButton_LastStudent_OnClick)

        self.pushButton_exec.clicked.connect(self.pushButton_exec_OnClick)

        self.radioButton_Atarashi.toggled.connect(self.radioButton_Atarashi_OnClick)
        self.radioButton_Rewrite.toggled.connect(self.radioButton_Rewrite_OnClick)
        self.radioButton_Pass.toggled.connect(self.radioButton_Pass_OnClick)

        self.ResetAll()
        self.show()
        self.CheckSL()

    # region Student List
    def CheckSL(self):        
        # SL
        self.SL = []
        self.SL_Name = []
        if os.path.exists(SLPath):
            with open(SLPath, 'r', encoding='utf8') as f:
                lines = f.readlines()
                for line in lines[1:]:
                    self.SL.append(line.split(','))
                    self.SL_Name.append(line.split(',')[1])
            self.label_SL.setText(f'Student List: {len(self.SL_Name)} students')
        else:
            # self.sub_window.setWindowModality(QtCore.Qt.ApplicationModal)
            self.OpenSL()
                       
    def OpenSL(self):
        self.sub_window.show()

    def ResetAll(self):
        # HW
        self.HWListClear()
        
    # endregion   
    # region UserProfile
    def UserProfileConfirm_clicked(self):
        """當按下確定登入按鈕"""
        self.Console_ShowSomething(
            f'Get account: {self.lineEdit_Account.text()}')
        self.Console_ShowSomething(
            f'Get password: {"*"*len(self.lineEdit_Password.text())}')
        
        if(self.lineEdit_Account.text() != "" and self.lineEdit_Password.text() != ""):
            UIGotAccount(self,
                        account=self.lineEdit_Account.text(),
                        password=self.lineEdit_Password.text())
            
            if(self.checkBox_SavePassword.isChecked()):
                s = hashlib.sha256()
                data = f"{self.lineEdit_Account.text()},{self.lineEdit_Password.text()}"
                sha = s.update(f'{data}ComputationalThinkingandProblemSolvingFall2020'.encode()) # count sha1
                h = s.hexdigest() # sha to hex
                self.crypt.Encoding(f'{data};{h}')

    def UserAccountConfirm(self, result=True):
        """告訴使用者登入結果"""
        if result is True:
            self.Console_ShowSomething(f'Login success.')
            self.LockUserProfile(enable=True)
        else:
            self.Console_ShowSomething(f'Login fail.')

    def pushButton_UserProfileReset_clicked(self):
        """當按下清除按鈕"""
        self.lineEdit_Account.clear()
        self.lineEdit_Password.clear()
        self.LockUserProfile(False)  # 解除鎖定
        UserLogout(self)

    def LockUserProfile(self, enable=True):
        """阻止使用者更改登入資訊"""
        self.lineEdit_Account.setReadOnly(enable)
        self.lineEdit_Password.setReadOnly(enable)
    # endregion
        
    # region Console and MainTextScreen
    def Console_ShowSomething(self, text, replacement=False):
        """在 console 區域新增個什麼東西"""
        if not replacement:
            oldtext = self.textEdit_Console.toPlainText()
            self.textEdit_Console.setPlainText(oldtext + '\n' + text)
        else:
            self.textEdit_Console.setPlainText(text)
    # endregion
    
    # region HW List
    def SetHWList(self, data):
        """
        傳入所有作業資料，並立即顯示在畫面中
        param data: list(tuple(str, dict))
        """
        # StateMachine
        StateMachine.TagNow = 0     
        StateMachine.TagList = []
        StateMachine.quizNumList = []
        
        # SetHWList
        for (topic, quizNum, students) in data:
            self.AddHWTag(topic, quizNum)
            for student, state in students.items():
                self.AddHWStudent(topic, student, state)
                
        StateMachine.StudentNow = 0
        StateMachine.StudentList = self.SL_Name

    def HWListClear(self):
        """清除舊有的HW清單資料"""
        self.HWlist = dict()  # clear
        for i in range(self.toolBox_HWSelector.count()):
            self.toolBox_HWSelector.removeItem(0)

    def AddHWTag(self, tag, quizNum):
        """新增HW大題"""
        listWidget = QListWidget()
        listWidget.setSelectionMode(QAbstractItemView.SingleSelection)
        listWidget.itemClicked.connect(self.ChooseStudent)
        listWidget.tag = len(self.HWlist)
        self.toolBox_HWSelector.addItem(listWidget, tag)
        self.HWlist[tag] = listWidget
        self.HWlist[tag].itemlist = [] # 在 QListWidgetItem 底下外掛一個list
        StateMachine.TagList.append(tag)
        StateMachine.quizNumList.append(quizNum)

    def AddHWStudent(self, HW, studentName, state):
        """在HW大題下新增學生"""
        newitem = QListWidgetItem(f"{dict_State[state]} {studentName}")
        
        newitem.studentName = studentName # 在 QListWidgetItem 底下外掛一個字串
        newitem.index = len(self.HWlist[HW]) # 在 QListWidgetItem 底下外掛一個數字
        newitem.tag = self.HWlist[HW].tag # 在 QListWidgetItem 底下外掛一個數字
        
        newitem.setForeground(dict_Color[state])
        newitem.setFont(QtGui.QFont('consolas', 10, QtGui.QFont.Normal))
        
        self.HWlist[HW].addItem(newitem)
        self.HWlist[HW].itemlist.append(newitem)
        
    def ChooseStudent(self, item):
        """使用者選擇學生"""
        tag = item.studentName
        StateMachine.StudentNow = item.index
        StateMachine.TagNow = item.tag
        self.ChangeStudentNow(tag)
        self.Main_MainShow(tag)
        
        self.SetPageSection(StateMachine.quizNumList[StateMachine.TagNow]) # 設定當前大題有幾小題
        
        HW = StateMachine.TagList[StateMachine.TagNow]
        STU = StateMachine.StudentList[StateMachine.StudentNow]
        SetState(self, HW, STU )
        

    def RenewHWStudent(self, state):
        
        HW = StateMachine.TagList[StateMachine.TagNow]
        newitem = self.HWlist[HW].itemlist[StateMachine.StudentNow]
        
        newitem.setText(f"{dict_State[['繳交','未過','未交'][state]]} {newitem.studentName}")
        newitem.setForeground(dict_Color[['繳交','未過','未交'][state]])
        newitem.setFont(QtGui.QFont('consolas', 10, QtGui.QFont.Normal))
        
        self.HWlist[HW].repaint()
        QtCore.QCoreApplication.processEvents()
        
    # endregion
    # region Navigation
    def SetPageSection(self, Section):
        """標示當前有幾個小題"""
        self.listWidget_navigation.itemClicked.connect(self.listWidget_navigation_OnClick)
        self.listWidget_navigation.clear()
        for sec in range(Section):
            newitem = QListWidgetItem(f"{StateMachine.TagList[StateMachine.TagNow]}-{sec+1}")
            newitem.title = StateMachine.TagList[StateMachine.TagNow]
            newitem.index = sec
            self.listWidget_navigation.addItem(newitem)

    def listWidget_navigation_OnClick(self, item):
        """使用者選擇小題"""
        title = item.title
        index = item.index
        StateMachine.quizNow = index
        UserWantQuiz(self, quiz = title, section = index)
        

    # 一次性收取三個小題的資料，UI這邊自己決定要秀哪一個
    # endregion
    # region Main
    def Main_MainShow(self, text):
        """在Main中清除舊文字並顯示新文字"""
        self.textBrowser_Main.setText(text)

    def Main_CodeShow(self, text):
        """在Code中清除舊文字並顯示新文字"""
        self.textBrowser_Code.setText(text)
        
    def Main_ConsoleShow(self, text):
        """在Console中清除舊文字並顯示新文字"""
        self.label_CodeExec.setText(text)
        
    def Main_ConsoleWrite(self, text):
        """在Console中顯示新文字"""
        self.label_CodeExec.setText(self.label_CodeExec.text() + text)
    
    def pushButton_exec_OnClick(self):
        self.Main_ConsoleShow("")
        UserWantRunCode(self)
        
    def ShowPicture(self, Qimg = QPixmap):
        if Qimg is None:
            self.label_CodeExec.clear()
        else:
            Qimg = Qimg.scaledToHeight(self.label_CodeExec.height())
            self.label_CodeExec.setPixmap(Qimg)
    # endregion
    # region StudentNow
    def ChangeStudentNow(self, stuName):
        """更換現在選擇的學生"""
        self.label_StudentNow.setText(f"Now looking: {stuName}")
        
    def pushButton_NextStudent_OnClick(self):
        """下一位學生"""
        index, stu = StateMachine.NextStudent(self)
        self.label_StudentNow.setText(f"Now looking: {stu}")
        
    def pushButton_LastStudent_OnClick(self):
        """上一位學生"""
        index, stu = StateMachine.LastStudent(self)
        self.label_StudentNow.setText(f"Now looking: {stu}")
    # endregion
    # region hw state
    def SetState(self, which = int):
        [self.radioButton_Pass,
        self.radioButton_Rewrite,
        self.radioButton_Atarashi][which].setChecked(True)
        
    def radioButton_Atarashi_OnClick(self, enabled):
        if enabled:
            HWStateModify(self, 2)
            self.RenewHWStudent(2)
    def radioButton_Rewrite_OnClick(self, enabled):
        if enabled:
            HWStateModify(self, 1)
            self.RenewHWStudent(1)
    def radioButton_Pass_OnClick(self, enabled):
        if enabled:
            HWStateModify(self, 0)
            self.RenewHWStudent(0)
    # endregion

if __name__ == "__main__":
    # start
    app = QApplication(sys.argv)
    MainWindow = QMainWindow()
    ui = PyMainWindow()
    ui.show()
    
    from random import randint
    testdata = {}
    for stu in ui.SL_Name:
        testdata[stu] = ['繳交', '未過', '未交'][randint(0,2)]
        
    ui.SetHWList([("HW1", 3, testdata),
                ("HW2", 5, testdata)])
    # exit
    sys.exit(app.exec_())
