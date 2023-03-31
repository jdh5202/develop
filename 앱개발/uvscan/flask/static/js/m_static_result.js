/*!
    * Start Bootstrap - SB Admin v7.0.5 (https://startbootstrap.com/template/sb-admin)
    * Copyright 2013-2022 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
    */


//1-1 파일 업로드 드래그앤드롭 처리
$(document).ready(function() {
    const frm = $('#frm');
    const chooseFile = $('#chooseFile');
    const uploadArea = $('#uploadArea');

    // dragover 이벤트 발생 시 클래스 추가
    uploadArea.on('dragover', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).addClass('dragging'); // dragging 클래스 추가
    });

    // dragleave 이벤트 발생 시 클래스 제거
    uploadArea.on('dragleave', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).removeClass('dragging'); // dragging 클래스 제거
    });

    // drop 이벤트 발생 시 클래스 제거
    uploadArea.on('drop', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).removeClass('dragging');

        let files = e.originalEvent.dataTransfer.files;
        showFiles(files);
        chooseFile.prop('files', files);
        fileupload(files); // 파일 업로드 함수 호출
     }); // dragging 클래스 제거

    uploadArea.on('click', function() {
        chooseFile.click();
    });

    chooseFile.on('change', function() {
        showFiles(this.files);
        fileupload(this.files); // 파일 업로드 함수 호출
    });

    function showFiles(files) {
        let file = files[0];
        $('#file_name').text(file.name);
    }
});

//1-2 파일 업로드 제출
function fileupload(files) { // 인자를 files로 변경
    // 파일 확장자 검증
    if (ext_chk(files) == true) {
        var file = files[0]; // 파일 객체를 가져옴
        var str = file.name; // 파일 이름을 가져옴
        var file_name = str.substring(str.lastIndexOf("\\") + 1);
        var file_size = file.size; // 파일 크기를 가져옴
        file_size = byteConvertor(file_size);
        document.getElementById('file_name').innerHTML = `<font color='black'><b>${file_name}<br>${file_size}</b></font>`;
    
        var isFrm = document.getElementById("frm");
        var isData = new FormData(isFrm);
    
        $.ajax({
        url: "/apkupload",
        type: "POST",
        enctype: 'multipart/form-data',
        processData: false,
        contentType: false,
        data: isData,
    
        beforeSend: function() {
            document.getElementById('progress').innerHTML = '<b>..apk uploading..</b>';
        },
        success: function(data) {
            jadxplugin();
        }
        });
    }
}
      
      
// 2. jadx 디컴파일
function jadxplugin()
{
    $.ajax({
        url: "/decompileing",
        type: "GET",
        beforeSend:function(){
                document.getElementById('progress').innerHTML= '<b>Decompiling to Java with jadx</b>';		
        },
        success:function(data){
            Apk_Analysis_view();   
        }
    });
}

// 3. 파일정보 분석
// function analysisSourcecode()
// {
//     $.ajax({
//         url: "/analysisSourcecode",
//         type: "GET",
//         beforeSend:function(){
//                 document.getElementById('progress').innerHTML= '<b>analysis source code</b>';		
//         },
//         success:function(data){
//             Apk_Analysis_view();
//         }
//     });
// }

// 4. 결과 view
function Apk_Analysis_view()
{
    $.ajax({
        url: "/Apk_Analysis_view",
        type: "GET",
        beforeSend:function(){
            document.getElementById('progress').innerHTML= '<b>...print...</b>';		
        },
        success:function(data){
            $('#uploadArea').hide();

            // script 태그 추출
            var scriptRegEx = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
            var scriptTags = data.match(scriptRegEx);
            
            // script 태그 제거
            var html = data.replace(scriptRegEx, '');

            // HTML 파싱
            var parser = new DOMParser();
            var doc = parser.parseFromString(html, 'text/html');

            // HTML 출력
            var container = document.getElementById('result');
            container.innerHTML = '';
            var newContent = document.createDocumentFragment();
            var el;
            while (el = doc.firstChild) {
                newContent.appendChild(el);
            }
            container.appendChild(newContent);

            // script 태그 실행
            for (var i = 0; i < scriptTags.length; i++) {
                var scriptTag = document.createElement('script');
                scriptTag.innerHTML = scriptTags[i].replace(/<\/?script>/g, '');
                container.appendChild(scriptTag);
            }
        }
    });
}