from flask import Flask, request, render_template
from socketio_config import socketio

from apk_upload_proc import apk_upload_proc
from apk_decompile import apk_decompile
from m_static_apkinfo import m_static_apkinfo
from m_dynamic_adb import m_dynamic_adb

app = Flask(__name__)
socketio.init_app(app)

app.register_blueprint(apk_upload_proc)
app.register_blueprint(apk_decompile)
app.register_blueprint(m_static_apkinfo)
app.register_blueprint(m_dynamic_adb)

    
# index
@app.route('/', methods=['GET'] )
def main():
    return render_template("index.html")

# command Tools > adb logcat 

if __name__ == "__main__":
    socketio.run(app, host='0.0.0.0', port=5000, debug=True)
