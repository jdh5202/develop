from flask import Blueprint, render_template
import os
import config

apk_decompile = Blueprint('apk_decompile', __name__)


#2. apk를 jadx로 디컴파일
@apk_decompile.route('/decompileing', methods = ['GET'])
def decompileing():

#    os.chdir(win_jadx_path)
    jadx_exec = "jadx.bat -d out "+config.G_path['apkfile']
    # result = subprocess.run(jadx_exec.split(' '), stdout=subprocess.PIPE, text=True)
    print("finished apk decompile")
    return "true"
