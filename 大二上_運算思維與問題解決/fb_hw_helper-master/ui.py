import sys
sys.path.extend(['./UI'])
from UI.main import *
from UI.comm import Communicator, Worker, markDatabase
from random import randint

if __name__ == "__main__":
    # region Run UI
    app = QApplication(sys.argv)
    MainWindow = QMainWindow()
    ui = PyMainWindow()
    ui.comm = Communicator(ui)
    ui.mkdb = markDatabase()
    ui.worker = Worker(lambda: None)
    ui.worker.moveToThread(ui.comm.thread)
    # endregion

    # 開啟Codi登入介面
    # Aquire_CodiMD(ui)

    '''
    markData = []
    for i in range(10):
        hw = 'HW' + i
        markData.append(ui.mkdb.getMarkByHw(hw))
        
    ui.SetHWList(
        [
            ("HW3", ui.mkdb.getSecNum("HW3"), markData[2]),
            ("HW4", ui.mkdb.getSecNum("HW4"), markData[3]),
            ("HW5", ui.mkdb.getSecNum("HW5"), markData[4]),
            ("HW6", ui.mkdb.getSecNum("HW6"), markData[5])
        ]
    )
    '''

    ui.Main_MainShow("哈囉沃德")
    ui.Main_CodeShow("print('hello world')")
    # exit
    exit_code = app.exec_()
    ui.mkdb.writeToDisk()
    sys.exit(exit_code)
