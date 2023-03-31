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
    running_apps = []

    for line in app_lines:
        line_parts = line.strip().split()
        if len(line_parts) >= 3 and line_parts[0].isdigit():
            pid = line_parts[0]
            name = ' '.join(line_parts[1:-1])
            identifier = line_parts[-1]
            running_apps.append({'pid': pid, 'name': name, 'identifier': identifier})
    return running_apps


@socketio.on("request_running_apps")
def handle_request_running_apps():
    running_apps = get_running_apps()
    app_data = []
    for app in running_apps:
        pid = app["pid"]
        name = app["name"]
        identifier = app["identifier"]
        app_data.append({"pid": pid, "name": name, "identifier": identifier})
    socketio.emit("running_apps_data", app_data)


def logcat(app_pid):
    print("logcat() called")
    device_id = get_device_id()
    print(f"Device ID: {device_id}")

    pid_command = f"adb -s {device_id} shell logcat -v time --pid={app_pid}"
    print(f"PID Command: {pid_command}")
    try:
        pid_process = subprocess.Popen(pid_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True,encoding='utf-8')
    except Exception as e:
        print(f"Error occurred during subprocess.Popen: {e}")

    logcat_command = f"adb -s {device_id} logcat -v time --pid={app_pid}"
    print(f"Logcat Command: {logcat_command}")
    logcat_process = subprocess.Popen(logcat_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True,encoding='utf-8')
    if logcat_process is not None:
        print("logcat_process initialized")
    else:
        print("logcat_process is still None")

    return logcat_process

@socketio.on('request_logcat')
def handle_request_logcat(app_pid):
    logcat_process = logcat(app_pid)

    while True:
        output_line = logcat_process.stdout.readline()
        socketio.emit('logcat_output',output_line)
        if not output_line:
            break
