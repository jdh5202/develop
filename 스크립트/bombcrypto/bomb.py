import sys
from PyQt5.QtWidgets import *
from PyQt5 import QtCore, uic
from PyQt5.QtCore import *
from PyQt5 import QtTest


form_class = uic.loadUiType("pyui.ui")[0]
# pip install opencv-python, pyautogui==0.9.38, image, partial
# pyautogui 최신버전은 한글 윈도우에서 인코딩 문제로 설치가 안됨 
from PIL import ImageGrab
from functools import partial
import pyautogui
import time

ImageGrab.grab = partial(ImageGrab.grab, all_screens=True)

global def_path
def_path ='objects/'
global confid
confid=0.9
global trasure_time
trasure_time=0

global go_screen
go_screen=30

global go_lobby
go_lobby=300

global go_work
go_work=9000

class WindowClass(QMainWindow, form_class):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.start_but.clicked.connect(self.main)     
        self.stop_but.clicked.connect(self.exit_app)
        self.setWindowFlags(Qt.WindowStaysOnTopHint)

    def exit_app(self):
        self.textarea.clear()
        quit()


    def main(self):

        try:
            while True:       
                connect_wallet(self)
                trasure_map(self)
            
        except TypeError:
            print("error")


def excute_func(self,objimg,second):
    timeout=second
    end = 0

    while click_object(objimg) is False:
        self.cur_work.setText( str(second-end) )
        QtTest.QTest.qWait(900)
        end = end +1
        if end > timeout:
            self.textarea.append('[*] ' + objimg +' timeout')
            return False
    # self.textarea.setPlainText('[*]' + objimg +'click')
    self.textarea.append('[*] ' + objimg)
    return True

def connect_wallet(self):

    screen_check(self)
    pyautogui.hotkey('ctrl', 'F5')
    global confid
    login_check1 = pyautogui.locateCenterOnScreen('objects/trasureh.png',confidence=confid)
    login_check2 = pyautogui.locateCenterOnScreen('objects/x.png',confidence=confid)
    login_check3 = pyautogui.locateCenterOnScreen('objects/golobby.png',confidence=confid)

    # (login_check1 is None) and (login_check2 is None) and (login_check3 is None) 
    if ( True ):
        waiting=20
        while True:
            excute_func(self,'loadingok',1)
            if not excute_func(self,'connectwallet',waiting) or not excute_func(self,'metunlock',waiting):
                continue
            #excute_func(self,'password',waiting)
            #excute_func(self,'sign',waiting)
            #pyautogui.typewrite('a', interval=0.1)
            
            loading_check = excute_func(self,'loading',50)
            if (loading_check==True):
                self.textarea.append('[*] enter game')
                excute_func(self,'trasureh',5)
                excute_func(self,'trasureh',5)
                break
            else:
                screen_check(self)
                pyautogui.hotkey('ctrl', 'F5')
 
        

def screen_check(self):
    screenCenter = pyautogui.size()
    screenCenter = (int(screenCenter[0] / 2), int(screenCenter[1] / 2))
    pyautogui.moveTo(screenCenter[0],screenCenter[1] ,1)
    pyautogui.doubleClick()
    self.textarea.append('[*] screen check!')

def time_sleep(self):
    global trasure_time
    global go_screen
    global go_lobby
    global go_work

    QtTest.QTest.qWait(850)
    trasure_time+=1
    self.screen.setText( str( ( go_screen - trasure_time  ) % go_screen) )
    self.lobby.setText( str( (go_lobby - trasure_time ) % go_lobby) )
    self.work_time.setText( str( (go_work - trasure_time ) % go_work) )

    if ( trasure_time % go_screen == 0 ): # 화면 유지용 클릭 시간
        screen_check(self)
    if ( trasure_time % go_lobby == 0 ):
        #excute_func(self,'golobby',1)
        #excute_func(self,'golobby',1)
        #excute_func(self,'trasureh',2)
        #excute_func(self,'trasureh',1)
        connect_wallet(self) # 그냥 새로고침
        
    
    if ( trasure_time % go_work == 0 ): # 2시간 반마다 캐릭터 work
        work_heroes(self)

    return False


def work_heroes(self):
    global confid
    scro=0

    while True:
        excute_func(self,'trasureup',2)
        excute_func(self,'trasureup',2)
        excute_func(self,'heroesmap',8)
        QtTest.QTest.qWait(3500)
        excute_func(self,'allwork',8)
        excute_func(self,'x',2)
        excute_func(self,'x',2)
        if excute_func(self,'trasureclose',8):
            break
        QtTest.QTest.qWait(1000)


def object_check(img_path):
    obj_clk = pyautogui.locateCenterOnScreen(def_path + img_path + '.png',confidence=confid)
    if (obj_clk is not None):
        return True
    else:
        return False

def refresh():
    oa = 1

def trasure_map(self):

    global confid
    work_heroes(self)
    while not object_check('ok'):
        state = time_sleep(self)

    self.textarea.append('[*] restart')
    QtTest.QTest.qWait(5000)

def click_object(img_path):
    obj_clk = pyautogui.locateCenterOnScreen(def_path + img_path + '.png',confidence=confid)
    if (obj_clk is not None):
        pyautogui.click(obj_clk)
    else:
        return False
    return img_path # current_working



if __name__ == '__main__':    
    app = QApplication(sys.argv)
    mainWindow = WindowClass()
    mainWindow.show()
    app.exec_()
