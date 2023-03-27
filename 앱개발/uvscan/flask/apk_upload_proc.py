from flask import Blueprint, request, render_template, url_for, redirect
import os
from werkzeug.utils import secure_filename
import config

apk_upload_proc = Blueprint('apk_upload_proc', __name__)

#1. apk 업로드
@apk_upload_proc.route('/apkupload', methods = ['POST'])
def apkupload():
    
    jadx_path= config.G_path['jadx_path']

    if request.method == 'POST':
        apkfile = request.files['file']

    if apkfile.filename == '':
        flash('APK 파일이 없습니다.')
        return redirect(url_for('/'))

    os.makedirs(jadx_path, exist_ok=True)

    apkfile.filename = secure_filename(apkfile.filename)
    apk_file_path = jadx_path + "/" + apkfile.filename
    new_gPath = dict(config.G_path)
    new_gPath['apkfile'] = apkfile.filename
    new_gPath['apk_file_path'] = apk_file_path
    config.G_path = new_gPath
    apkfile.save(apk_file_path)
    
    
    return "true"