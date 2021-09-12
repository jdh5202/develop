import requests
import webbrowser
import sys
import csv
import os
import subprocess 
import time
import random
import shutil
from PyQt5.QtWidgets import *
from PyQt5 import uic
form_class = uic.loadUiType("C:\\Users\jdh52\\Desktop\\python\\make_token.ui")[0]

tmp_path = os.getcwd() + '\\' + 'make_token.csv'
api_page_url = 'https://www.tistory.com/guide/api/manage/list'

class WindowClass(QMainWindow, form_class):
	def __init__(self):
		super().__init__()
		self.setupUi(self)
		self.sc_key.setDisabled(True)
		self.code.setDisabled(True)
		self.rd_code.clicked.connect(self.rd_check)
		self.rd_token.clicked.connect(self.rd_check)
		self.API_Page.clicked.connect(self.mv_API_Page)
		self.execute.clicked.connect(self.exec)
		self.setFixedSize(792, 340)

		# 캐시 파일
		if os.path.isfile(tmp_path):
			f = open(tmp_path,'rt', encoding='utf-8')
			rdr = csv.reader(f)
			lines = list(rdr)
			f.close()

			self.cl_id.setText(lines[0][1])
			self.sc_key.setText(lines[1][1])
			self.callback_uri.setText(lines[2][1])
			self.code.setText(lines[3][1])


	def rd_check(self):
		if self.rd_code.isChecked() : self.sc_key.setDisabled(True); self.code.setDisabled(True)
		if self.rd_token.isChecked() : self.sc_key.setDisabled(False); self.code.setDisabled(False)


	def closeEvent(self, QCloseEvent):
		
		f = open(tmp_path,'w', newline='') # 행 추가하려면 두 번째 인자에 a 입력
		wr = csv.writer(f)
		wr.writerow([1,self.cl_id.text()])
		wr.writerow([2,self.sc_key.text()])
		wr.writerow([3,self.callback_uri.text()])
		wr.writerow([4,self.code.text()])
		f.close()
		
	
	def mv_API_Page(self):
		webbrowser.open(api_page_url)

	def exec(self):
		appid = self.cl_id.text()
		scre_key = self.sc_key.text()
		callback_u = self.callback_uri.text()
		code_str = self.code.text()

		if self.rd_code.isChecked():
			url = 'https://www.tistory.com/oauth/authorize?client_id=' + appid + '&redirect_uri=' + callback_u + '&response_type=code'
			webbrowser.open(url)
		
		if self.rd_token.isChecked():
			url = 'https://www.tistory.com/oauth/access_token?client_id=' + appid + '&client_secret=' + scre_key + '&redirect_uri=' + callback_u + '&code=' + code_str + '&grant_type=authorization_code'
			self.result_browser.setText('token url: ' + url)

app = QApplication(sys.argv)
mainWindow = WindowClass()
mainWindow.show()
app.exec_()


