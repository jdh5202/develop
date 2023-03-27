// 1. apk upload process
function byteConvertor(bytes) {
    var bytes = parseInt(bytes);
    var s = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
    var e = Math.floor(Math.log(bytes)/Math.log(1024));
    if(e == "-Infinity") return "0 "+s[0]; 
    else  return (bytes/Math.pow(1024, Math.floor(e))).toFixed(2)+""+s[e];
}


function ext_chk(frm){
	
    var isFrm = document.getElementById('frm');
    var isData = new FormData(isFrm);
    
    
    // // 업로드 할 수 있는 파일 확장자를 제한합니다.	
    var extArray = new Array("apk");
    var path = frm.value;
    
    if (path == "") {
            if (path == "") {
            alert("파일을 선택해 주세요.");
            return false;
        }
    }
      var pos = path.indexOf(".");
        if (pos < 0) {
            alert("확장자가 없는파일 입니다.");
            return false;
        }
        var ext = getExtension(path);
        var checkExt = false;
        for (var i = 0; i < extArray.length; i++) {
            if (ext == extArray[i]) {
                checkExt = true;
                break;
            }
        }
        if (checkExt == false) {
            alert("업로드 할 수 없는 파일 확장자 입니다.");
            return false;
    }

   

    return true;
}


function getExtension(fileName) {
	
    // 파일명의 총 길이
    var fileLength = fileName.length;
    // 마지막 .의 위치 찾기
    var lastDot = fileName.lastIndexOf('.');
    // .의 다음 위치로 부터 파일의 총 길이까지 subString
    var fileExtension = fileName.substring(lastDot+1, fileLength);
    return fileExtension;
}