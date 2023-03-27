from flask import Flask, request, render_template
import xml.etree.ElementTree as ET
import os
import threading
import subprocess
import hashlib
from flask import Flask, flash, request, redirect
from flask import url_for, render_template
from werkzeug.utils import secure_filename
import re

app = Flask(__name__)


def search_files(root_path, target_str_list):
    results = {}
    threads = []
    lock = threading.Lock()

    # helper function to process file
    def process_file(file_path):
        try:
            with lock:
                with open(file_path, 'r', encoding='utf-8') as f:
                    lines = f.readlines()
                    for i, line in enumerate(lines):
                        for target_str in target_str_list:
                            if isinstance(target_str, str):
                                if target_str in line:
                                    file_path=os.path.basename(file_path)
                                    if file_path not in results:
                                        results[file_path] = {}
                                    if i not in results[file_path]:
                                        results[file_path][i] = []
                                    results[file_path][i].append(line.replace('\n', ''))
                            elif isinstance(target_str, re.Pattern):
                                if target_str.search(line):
                                    file_path=os.path.basename(file_path)
                                    if file_path not in results:
                                        results[file_path] = {}
                                    if i not in results[file_path]:
                                        results[file_path][i] = []
                                    results[file_path][i].append(line.replace('\n', ''))
                            else:
                                raise ValueError('Invalid target string type')
        except FileNotFoundError:
            print(f'File not found: {file_path}')

    # thread function to process files
    def process_files(root, files):
        for file in files:
            file_path = os.path.join(root, file)
            process_file(file_path)

    for root, dirs, files in os.walk(root_path):
        # split files into chunks for each thread
        n_threads = min(len(files), 8)
        chunk_size = (len(files) // n_threads) + 1 if n_threads > 0 else 0
        if chunk_size == 0:
            file_chunks = [files]
        else:
            file_chunks = [files[i:i+chunk_size] for i in range(0, len(files), chunk_size)]
        for chunk in file_chunks:
            t = threading.Thread(target=process_files, args=(root, chunk))
            threads.append(t)
            t.start()

    # wait for all threads to finish
    for t in threads:
        t.join()

    return results
                        
jadx_path = "Tools/jadx/bin"
win_jadx_path = "Tools\\jadx\\bin\\"
apk_file_path = ""
apkfile= ""

# index
@app.route('/', methods=['GET', 'POST'] )
def main():
    if request.method == 'GET':
        return render_template("index.html")
    return f"id : {uid} pw : {upw}"

#1. apk 업로드
@app.route('/apkupload', methods = ['POST'])
def apkupload():

    global jadx_path
    global apkfile
    global apk_file_path

    
    if request.method == 'POST':
        apkfile = request.files['file']

    if apkfile.filename == '':
        flash('APK 파일이 없습니다.')
        return redirect(url_for('/'))


    os.makedirs(jadx_path, exist_ok=True)
    apkfile.filename = secure_filename(apkfile.filename)
    
    apk_file_path = jadx_path + "/" + apkfile.filename
    apkfile.save(apk_file_path)
    
    
    return "true"

#2. apk를 jadx로 디컴파일
@app.route('/decompileing', methods = ['GET'])
def decompileing():

    global win_jadx_path
    global apkfile
        
#    os.chdir(win_jadx_path)
    jadx_exec = "jadx.bat -d out "+apkfile.filename
    # result = subprocess.run(jadx_exec.split(' '), stdout=subprocess.PIPE, text=True)
    print("finished apk decompile")
    return "true"

#3. 파일 목록 불러오기 & 텍스트 검색
@app.route('/analysisSourcecode', methods = ['GET'])
def analysisSourcecode():
    
    # print(os.getcwd())
    # scan1 = "out\\resources\\AndroidManifest.xml"
    # fp = open(scan1, 'r') 
    # file_data = fp.read()
    
    # fp.close()
    return "true"

#4. 파일 정보 및 결과 출력
@app.route('/Apk_Analysis_view', methods = ['GET'])
def Apk_Analysis_view():
    global apkfile
    global win_jadx_path
      
    # file_info - filename, filesize, hash(md5,sha1,sha256)
    print("Testar: "+os.getcwd())
    os.chdir(win_jadx_path)
    f = open(apk_file_path, 'rb')
    data = f.read()
    f.close()
        
    n = os.path.getsize(apk_file_path)
    file_size= "%.2f MB" % (n / (1024.0 * 1024.0))  # MB
  
    hash_list = [hashlib.md5(data).hexdigest(), hashlib.sha1(data).hexdigest(), hashlib.sha256(data).hexdigest()]

    xmltree = ET.parse("C://Users//jkb//Desktop//flask//Tools//jadx//bin//out//resources//res//values//strings.xml")
    # Appname = xmltree.find('./String[@name="app_name"]')
    Appname = ""
    for elem in xmltree.iter("string"):
        if (  elem.attrib['name'] == 'app_name' ):
            Appname = elem.text
        
    xmltree2 = ET.parse("C://Users//jkb//Desktop//flask//Tools//jadx//bin//out//resources//AndroidManifest.xml")
    pkname = xmltree2.getroot().get('package')
    
    
                 
    # 0. 액티비티 확인
    MainActivity = ""
    for movie1 in xmltree2.iter("activity"):
        for elem in movie1.iter('category'):
            if ("android.intent.category.LAUNCHER" == elem.attrib['{http://schemas.android.com/apk/res/android}name'] ):
                MainActivity = movie1.attrib['{http://schemas.android.com/apk/res/android}name']
                
    # 1. 동적 디버깅 여부 확인
    debuggable = ""
    for movie1 in xmltree2.iter("application"):
        try:
            debuggable = movie1.attrib['{http://schemas.android.com/apk/res/android}debuggable']
        except Exception as e:
            print(e)

    # 2. 액티비티 강제 실행 가능 여부 확인
    amactivity = []
    for movie1 in xmltree2.iter("activity"):
        if ("true" == movie1.attrib['{http://schemas.android.com/apk/res/android}exported'] ):
            amactivity.append( movie1.attrib['{http://schemas.android.com/apk/res/android}name'] )
            
    # 3. 딥링크 사용 여부 확인
    deeplink_activity = {}
    deeplink_scheme=""
    deeplink_host=""
    deeplink_path=""


    for movie1 in xmltree2.iter("activity"):
        for movie2 in movie1.iter("intent-filter"):
            for movie3 in movie2.iter("data"):
                try:
                    deeplink_scheme = movie3.attrib['{http://schemas.android.com/apk/res/android}scheme']
                    deeplink_host = movie3.attrib['{http://schemas.android.com/apk/res/android}host']
                    deeplink_path = movie3.attrib['{http://schemas.android.com/apk/res/android}path']
                    deeplink_activity[movie1.attrib['{http://schemas.android.com/apk/res/android}name'] ] = [deeplink_scheme,deeplink_host,deeplink_path]
                    break
                except Exception as e:
                    print(e)
                    

    # 4. 웹뷰 사용 위치
        #4-1 인터넷 사용 중
    webview = ""
    for movie1 in xmltree2.iter("uses-permission"):
        try:
            if (movie1.attrib['{http://schemas.android.com/apk/res/android}name']=="android.permission.INTERNET"):
                webview = "android.permission.INTERNET"
        except Exception as e:
            print(e)

        #4-2 웹뷰 loadurl 검사
    directory = r'C:\Users\jkb\Downloads\kyobo\jadx\bin\out\sources'
    pattern = re.compile(r'https?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+')
    webview = search_files(directory, [pattern])
    # webview = search_files(directory, ['.loadUrl', pattern])

    # 5. URLS
        
   
    return render_template("apk_analysis_result.html",apkfile_info=apkfile, hash=hash_list, file_size=file_size, Appname=Appname, pkname=pkname, MainActivity=MainActivity, debuggable=debuggable, amactivity=amactivity, deeplink=deeplink_activity, webview=webview, trim_blocks=True )



if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
    