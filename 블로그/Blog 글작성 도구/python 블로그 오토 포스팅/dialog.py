import datetime
import webbrowser
from PyQt5.QtCore import QTimer
import sys
import csv
import os
import subprocess
import random
import shutil
from PyQt5.QtWidgets import *
from PyQt5 import uic
form_class = uic.loadUiType("C:\\Users\jdh52\\Desktop\\python\\dialog.ui" )[0]

file_index = 0
tmp_path = os.getcwd() + '\\' + 'write_tmp.csv'
api_py = 'python ' + os.getcwd() + '\\' + 'write_api.py'
default_post_title = " 판매순위 TOP-20"

class WindowClass(QMainWindow, form_class):
	def __init__(self):
		super().__init__()
		self.setupUi(self)
		self.sel_dir_str.setDisabled(True)
		self.blog_name.setText("http://abcd.tistory.com")
		self.wri_post_term1.setText("60")
		self.wri_post_term2.setText("120")
		self.wri_post_num.setText("10")
		self.setFixedSize(800, 341)

		# 캐시 파일
		if os.path.isfile(tmp_path):
			f = open(tmp_path,'rt', encoding='utf-8')
			rdr = csv.reader(f)
			lines = list(rdr)
			f.close()

			self.token_str.setText(lines[0][1])
			self.blog_name.setText(lines[1][1])
			self.sel_dir_str.setText(lines[2][1])
			self.wri_post_term1.setText(lines[3][1])
			self.wri_post_term2.setText(lines[4][1])
			self.wri_post_num.setText(lines[5][1])
			self.delete_postfile.setChecked( ( lines[6][1]=='True') )

		self.but_start.clicked.connect(self.write)
		self.but_selectdir.clicked.connect(self.sel_dir)
		self.move_blog.clicked.connect(self.mv_tistory)
		self.but_stop.clicked.connect(self.write_stop)

	def sel_dir(self):
		options = QFileDialog.Options()
		options |= QFileDialog.ShowDirsOnly
		working_path = QFileDialog.getExistingDirectory(self,"select Directory")
		self.sel_dir_str.setText(working_path)


	def closeEvent(self, QCloseEvent):
		re = QMessageBox.question(self, "종료", "설정 값을 저장하시겠습니까?",
		QMessageBox.Yes|QMessageBox.No)
	
		if re == QMessageBox.Yes:
			f = open(tmp_path,'w', newline='') # 행 추가하려면 두 번째 인자에 a 입력
			wr = csv.writer(f)
			wr.writerow([1,self.token_str.text()])
			wr.writerow([2,self.blog_name.text()])
			wr.writerow([3,self.sel_dir_str.text()])
			wr.writerow([4,self.wri_post_term1.text()])
			wr.writerow([5,self.wri_post_term2.text()])
			wr.writerow([6,self.wri_post_num.text()])
			wr.writerow([7,self.delete_postfile.isChecked()])
			f.close()
		QCloseEvent.accept()

	def mv_tistory(self):
		webbrowser.open(self.blog_name.text())

	def write(self):
		
		access_token = self.token_str.text()
		blog_name = self.blog_name.text()
		working_path = self.sel_dir_str.text()
		post_count=int(self.wri_post_num.text())

		file_list = os.listdir(working_path)
		file_list_txt = [file for file in file_list if file.endswith('.txt')]
	
		# 사용자가 설정한 포스팅 개수가 작업 폴더 내 포스팅 개수보다 많을 때
		if len(file_list_txt) < post_count:
			post_count=len(file_list_txt)

		post_term1=int(self.wri_post_term1.text())
		post_term2=int(self.wri_post_term2.text())
		post_term=random.randrange(post_term1,post_term2)
		
		self.timer = QTimer(self)
		self.timer.start(post_term*1000)
		
		self.timer.timeout.connect(lambda:self.write_exec(access_token,blog_name,working_path,post_count,file_list_txt))

	def write_exec(self,access_token,blog_name,working_path,post_count,file_list_txt):
		global file_index

		file_path = working_path + '/' + file_list_txt[file_index]
		post_title = os.path.splitext( os.path.basename( file_path ) )[0]
		post_title = post_title + default_post_title
		work_dir = ""
		process = subprocess.check_output(api_py+" "+access_token + " " + blog_name + " \"" + file_path + "\" \"" + post_title + "\"" , shell=False, encoding='utf-8')
		self.result_browser.insertPlainText(process)
		
		if (self.delete_postfile.isChecked() == True):
			d = datetime.datetime.now()
			d = str(d.year) + "-" + str(d.month) + "-" + str(d.day)
			work_dir = os.getcwd() + '\\' + "Worked_Post" + '\\' + d
		
			if (not os.path.exists(work_dir)):
				os.makedirs(work_dir)
			shutil.move(file_path, work_dir)

		if file_index >= post_count-1:
			self.timer.stop()
			file_index=0
		file_index+=1

	def write_stop(self):
		self.timer.stop()
		QMessageBox.information(self, 'stop', '포스팅 정지')


app = QApplication(sys.argv)
mainWindow = WindowClass()
mainWindow.show()
app.exec_()


