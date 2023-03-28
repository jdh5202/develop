function displayRunningApps() {
    // 서버에 실행 중인 앱 목록을 요청합니다.
    $("#frm").hide();
    socket.emit('request_running_apps');
}
  
var socket = io.connect('http://' + document.domain + ':' + location.port);

socket.on('connect', function() {
    console.log("Connected to the server");
});

socket.on('running_apps_data', function (data) {
    var result_div = document.getElementById('result');
    var p = document.createElement('p');
    p.appendChild(document.createTextNode(data));
    result_div.appendChild(p);
});

function requestLogcat() {
    var appPackage = prompt("앱 패키지 이름을 입력하세요:", "com.iprovest.mykkl"); // 앱 패키지 이름을 입력받습니다.

    if (appPackage != null) {
       socket.emit('request_logcat', appPackage); // 서버에 logcat 실행 요청을 보냅니다.
    }
}

socket.on('logcat_data', function(data) {
    var result_div = document.getElementById('result');
    var p = document.createElement('p');
    p.appendChild(document.createTextNode(data));
    result_div.appendChild(p);
});
