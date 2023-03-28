from flask import Blueprint, request, render_template, url_for, redirect
import config
import xml.etree.ElementTree as ET
import os
import threading
import subprocess
import hashlib
import re

m_static_apkinfo = Blueprint('m_static_apkinfo', __name__)

def search_files(root_path, target_str_list):
    results = {}
    lock = threading.Lock()

    # helper function to process file
    def process_file(file_path):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                lines = f.readlines()
                for i, line in enumerate(lines):
                    for target_str in target_str_list:
                        if isinstance(target_str, str):
                            if target_str in line:
                                file_path=os.path.basename(file_path)
                                results.setdefault(file_path, {}).setdefault(i, []).append(line.replace('\n', ''))
                        elif isinstance(target_str, re.Pattern):
                            if target_str.search(line):
                                file_path=os.path.basename(file_path)
                                results.setdefault(file_path, {}).setdefault(i, []).append(line.replace('\n', ''))
                        else:
                            raise ValueError('Invalid target string type')
        except FileNotFoundError:
            print(f'File not found: {file_path}')

    for root, dirs, files in os.walk(root_path):
        # helper function to process files
        def process_files(files):
            for file in files:
                file_path = os.path.join(root, file)
                process_file(file_path)

        # split files into chunks for each thread
        n_threads = min(len(files), 8)
        chunk_size = (len(files) // n_threads) + 1 if n_threads > 0 else 0
        if chunk_size == 0:
            process_files(files)  # 스레드가 하나밖에 없을 때는 스레드를 사용하지 않습니다.
        else:
            file_chunks = [files[i:i+chunk_size] for i in range(0, len(files), chunk_size)]
            threads = [threading.Thread(target=process_files, args=(chunk,)) for chunk in file_chunks]
            for t in threads:
                t.start()
            for t in threads:
                t.join()

    return results


class ApkAnalyzer:
    
    def __init__(self):
        self.jadx_path= config.G_path['jadx_path']
        self.win_jadx_path= config.G_path['win_jadx_path']
        self.xml_pc = config.XmlPc()
        self.xmltree = ET.parse(config.xml_path['Strings'])
        self.xmltree2 = self.xml_pc.parse_xml(config.xml_path['AOSManifest'])

    def mstep1_apkinfo(self, apkfile, apk_file_path):
        print("Testar: "+os.getcwd())
        os.chdir(self.win_jadx_path)
        with open(apk_file_path, 'rb') as f:
            data = f.read()

        # file size    
        n = os.path.getsize(apk_file_path)
        file_size= "%.2f MB" % (n / (1024.0 * 1024.0))  # MB

        # hash info
        hash_list = []
        hash_list.append(hashlib.md5(data).hexdigest())
        hash_list.append(hashlib.sha1(data).hexdigest())
        hash_list.append(hashlib.sha256(data).hexdigest())

        # appname
        Appname = ""
        for elem in self.xmltree.iter("string"):
            if (  elem.attrib['name'] == 'app_name' ):
                Appname = elem.text

        # pkgname
        pkname = self.xmltree2.getroot().get('package')

        # mainActivity name
        MainActivity = ""
        for movie1 in self.xmltree2.iter("activity"):
            for elem in movie1.iter('category'):
                if ("android.intent.category.LAUNCHER" == elem.attrib['{http://schemas.android.com/apk/res/android}name'] ):
                    MainActivity = movie1.attrib['{http://schemas.android.com/apk/res/android}name']

        return {"apkfile":apkfile, "Appname": Appname, "file_size":file_size, "hash_list": hash_list, "pkname": pkname, "MainActivity": MainActivity}


    def mstep2_debug_chk(self):               
        # 1. 동적 디버깅 여부 확인
        debuggable = ""
        for movie1 in self.xmltree2.iter("application"):
            try:
                debuggable = movie1.attrib['{http://schemas.android.com/apk/res/android}debuggable']
            except Exception as e:
                print(e)
        
        return debuggable

    def mstep3_activity_chk(self):
        # 2. 액티비티 강제 실행 가능 여부 확인
        amactivity = []
        for movie1 in self.xmltree2.iter("activity"):
            if ("true" == movie1.attrib['{http://schemas.android.com/apk/res/android}exported'] ):
                amactivity.append( movie1.attrib['{http://schemas.android.com/apk/res/android}name'] )
        return amactivity


    def mstep4_deeplink_chk(self):            
        # 3. 딥링크 사용 여부 확인
        deeplink_activity = {}
        deeplink_scheme=""
        deeplink_host=""
        deeplink_path=""

        for movie1 in self.xmltree2.iter("activity"):
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
        return deeplink_activity
                    

    def mstep5_webview_chk(self):

        webview = ""
        for movie1 in self.xmltree2.iter("uses-permission"):
            try:
                if (movie1.attrib['{http://schemas.android.com/apk/res/android}name']=="android.permission.INTERNET"):
                    webview = "android.permission.INTERNET"
            except Exception as e:
                print(e)

        directory = r'C:\Users\jkb\Downloads\kyobo\jadx\bin\out\sources'
        webview = search_files(directory, ['.loadUrl'])
        return webview

    def mstep6_url_chk(self):
        directory = r'C:\Users\jkb\Downloads\kyobo\jadx\bin\out\sources'
        pattern = re.compile(r'https?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+')
        urls = search_files(directory, [pattern])
        return urls

analyzer = ApkAnalyzer()


    
@m_static_apkinfo.route('/Apk_Analysis_view', methods = ['GET'])
def result():
    apkfile= config.G_path['apkfile']
    apk_file_path = config.G_path['apk_file_path']
    
    step1 = analyzer.mstep1_apkinfo(apkfile, apk_file_path)
    step2 = analyzer.mstep2_debug_chk()
    step3 = analyzer.mstep3_activity_chk()    
    step4 = analyzer.mstep4_deeplink_chk()
    step5 = analyzer.mstep5_webview_chk()
    step6 = analyzer.mstep6_url_chk()
    
    return render_template("mob_static_analysis/m_static_result.html", step1=step1, step2=step2, step3=step3, step4=step4, step5=step5, step6=step6)