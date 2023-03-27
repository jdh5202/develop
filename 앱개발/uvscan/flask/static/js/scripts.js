/*!
    * Start Bootstrap - SB Admin v7.0.5 (https://startbootstrap.com/template/sb-admin)
    * Copyright 2013-2022 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
    */
    // 
// Scripts
// 

window.addEventListener('DOMContentLoaded', event => {

    // Toggle the side navigation
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        // Uncomment Below to persist sidebar toggle between refreshes
        // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
        //     document.body.classList.toggle('sb-sidenav-toggled');
        // }
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
        
    }

});


//1. apk 파일 업로드
function fileupload(file) {

    // 파일 확장자 검증
    if ( ext_chk(file) == true )
    {
        var str = file.value;
        var file_name = file.value.substring(str.lastIndexOf("\\")+1);    
        var file_size = file.files[0].size;
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

            beforeSend:function(){
                    document.getElementById('progress').innerHTML= '<b>..apk uploading..</b>';		
            },
            success:function(data){
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