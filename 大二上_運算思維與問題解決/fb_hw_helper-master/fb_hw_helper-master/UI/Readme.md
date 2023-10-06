UI 使用說明
===

## 引用

如果在根資料夾引用，則輸入:
```python
import sys
sys.path.extend(['./UI'])
from UI.main import *
```

打開與關閉UI都有固定的模板，請在程式碼最前方加入:
```python
# region Run UI
app = QApplication(sys.argv)
MainWindow = QMainWindow()
ui = PyMainWindow()
ui.show()
# endregion
```
並在結尾加入:
```python
# exit
sys.exit(app.exec_())
```

## 可用資訊

1. ui.SL_Name 儲存了讀取檔案後得知的學生清單(Student List)

## 可用方法

1. 設置左方面板的作業資料
```python
ui.SetHWList([("HW1", 3, testdata),
                ("HW2", 2, testdata)])
```
使用此方法需要先建立學生清單，詳細如下:
```python
testdata = {}
for stu in ui.SL_Name:
    # 隨機指派作業狀態給每個學生
    testdata[stu] = ['繳交', '未過', '未交'][randint(0,2)]
```

2. 在各個面板顯示資料

在CodiMD主頁面顯示文字:

```python
    ui.Main_MainShow("哈囉沃德")
```

在程式碼區塊顯示文字:

```python
ui.Main_CodeShow("print('hello world')")
```

3. 中斷使用者輸入驗證碼

```python
TerminateAuth(ui)
```

4. 切換顯示當前的批改狀況

```python
SetState(ui, state = int) # State ['繳交','未過','未交']
```

5. 其他

關於接收UI資料等方法請詳閱main.py上方function欄位之操作範例