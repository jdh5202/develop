from flask import Blueprint, request, render_template, jsonify
import subprocess, re
from socketio_config import socketio

m_dynamic_adb = Blueprint('m_dynamic_adb', __name__)

def get_device_id():
    devices_output = subprocess.check_output(['adb', 'devices']).decode('utf-8').strip()
    devices = devices_output.split('\n')[1:]

    if len(devices) == 1 and 'device' in devices[0]:
        device_id = devices[0].split()[0]
        return device_id
    else:
        return None

def get_running_apps():
    cmd = "frida-ps -Uai"
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)
    app_data, error = process.communicate()

    if error:
        print(f"Error: {error}")
        return []
    app_lines = app_data.strip().split('\n')[2:]
    running_apps = [line for line in app_lines if re.match(r'\s*\d', line)]
    return running_apps

@socketio.on('request_running_apps')
def handle_request_running_apps():
    running_apps = get_running_apps()
    for app in running_apps:
        socketio.emit('running_apps_data', app)
        
@socketio.on('request_logcat')
def handle_request_logcat(app_package):
    logcat(app_package)
    
@m_dynamic_adb.route('/logcat/<app_package>')
def logcat(app_package):

    device_id = get_device_id()

    # 앱 이름으로 PID 정보 검색
    pid_command = f"adb -s {device_id} shell pidof -s {app_package}"
    print(f"PID Command: {pid_command}")
    pid_process = subprocess.Popen(pid_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)

    # PID 정보 읽기
    pid_data, pid_error = pid_process.communicate()
    if pid_error:
        print(f"PID Error: {pid_error}")
        return render_template('error.html', message="PID Error occurred.")

    # PID 정보가 없을 경우 종료
    if not pid_data:
        print(f"No PID found for package: {app_package}")
        return render_template('error.html', message="No PID found for package.")

    # PID 정보를 사용하여 logcat 명령어 실행
    pid = pid_data.strip()
    logcat_command = f"adb -s {device_id} logcat -v time --pid {pid}"
    # print(f"Logcat Command: {logcat_command}")
    logcat_process = subprocess.Popen(logcat_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)
    
    # logcat 결과 출력
    @socketio.on('logcat_connect')
    def emit_logcat_data():
        try:
            for line in iter(logcat_process.stdout.readline, ''):
                socketio.emit('logcat_data', line.strip())
        except KeyboardInterrupt:
            logcat_process.kill()

    socketio.start_background_task(target=emit_logcat_data)

    return render_template('mob_dynamic_analysis/m_dynamic_result.html')
