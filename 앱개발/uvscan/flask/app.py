from flask import Flask, request, render_template

from apk_upload_proc import apk_upload_proc
from apk_decompile import apk_decompile
from step1_apkinfo import step1_apkinfo
import os 

app = Flask(__name__)

app.register_blueprint(apk_upload_proc)
app.register_blueprint(apk_decompile)
app.register_blueprint(step1_apkinfo)

# index
@app.route('/', methods=['GET'] )
def main():
    return render_template("index.html")


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
    