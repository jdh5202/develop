<style>

    /* contents */
    .content {display: none;position:fixed; top: 0; margin-left: -25%; width: 100%;height: 100%; background: rgba(0,0,0,0.9);}
    .content .close {position:fixed; top: 20px; right: 20px;}
    .content .close img {margin-top: 7%; margin-left: 1000px; width: 32px; height: 32px;}
    .content div {position: fixed; top: 28%; left: -19%;  margin-top: -150px; margin-left: 25%; padding: 20px 2%; height: 660px; width: 85%; overflow-y: auto;display: none;  background: #fff;  }
    .content div.open {display: block;}
  </style>

  <div class="content">
    <p class="close"><a href=""><img src="https://www.astri.org/wp-content/uploads/home/x.png" alt=""></a></p>
 <div id="a1">

    <div class="txc-textbox" style="BORDER-TOP: #eeeeee 1px solid; BORDER-RIGHT: #eeeeee 1px solid; BORDER-BOTTOM: #eeeeee 1px solid; PADDING-BOTTOM: 14px; PADDING-TOP: 14px; PADDING-LEFT: 14px; BORDER-LEFT: #eeeeee 1px solid; PADDING-RIGHT: 14px; BACKGROUND-COLOR: #eeeeee"><strong><span style="font-size: 16pt;">? IDA View<br /></span></strong></div> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; Graph view - 프로그램 흐름이 바뀌는걸 보여준다.( 점프 jxx 기준 )<br /></b></span><hr> 분기 - 참 = 초록색 화살표<br /> - 거짓 = 빨강색 화살표<br /> - 무조건 = 파란색 화살표<br /> <br /> <span style="display:inline-block;border-top:thick double skyblue;border-bottom:thick double skyblue;padding-bottom : 2px;font-size:14pt;"><font color="#0d1a81"><b> View - Graphs - xrefs to<br /></b></font></span> 특정 함수에 도달하는 모든 경우를 그래프로 보여준다.<br /> <br /> <span style="display:inline-block;border-top:thick double skyblue;border-bottom:thick double skyblue;padding-bottom : 2px;font-size:14pt;"><font color="#0d1a81"><b> View - Graphs - xrefs from<br /></b></font></span> 함수에서 호출하는 함수들을 나열한다.<br /> <br /> <font size="4pt"><b>? 보라색 상자 = 라이브러리<br /></b></font> <br /> 모든 경우의 함수 흐름을 그래프로 보여준다.<br /> <br /> user xrefs chart는 두 기능을 동시에 사용한다.<br /> <br /> depth를 -1로하면 이동 횟수에 제한 없이 전부 보여주며, <br /> <br /> externals 체크시 라이브러리함수는 안보인다.<br /> <br /> <font size="4pt"><b>? graph view 주소 보는법 option -&gt; general -&gt; disassembly -&gt; line prefixes 체크<br /></b></font> <br /> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; String view - 프로그램 내의 모든 문자열을 찾아 보여준다.<br /></b></span><hr> 열기 : view -&gt; open subviews -strings<br /> <br /> 우클릭 - setup에서 allowd string types를 모두 허용해주면 더 잘 찾으며<br /> Ignore instruction/data definition에 체크해주면 명령어나 데이터라 생각되는 문자열도 찾는다.<br /> <br /> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; hex view<br /></b></span><hr> <br /> IDA view-A와 Hex view-A는 커서위치 기준으로 동기화되어있음.<br /> 즉 IDA view-A에서 커서가 100주소를 가리키고 있으면 <br /> Hex view-A도 똑같이 해당 주소를 가리키고 있다.<br /> <br /> 해당 설정은 우클릭 - synchronize with에서 변경가능하다.<br /> <br /> <font size="4pt"><b>? view 전환법 : Space bar<br /></b></font> <br /> <br /> <div class="txc-textbox" style="BORDER-TOP: #eeeeee 1px solid; BORDER-RIGHT: #eeeeee 1px solid; BORDER-BOTTOM: #eeeeee 1px solid; PADDING-BOTTOM: 14px; PADDING-TOP: 14px; PADDING-LEFT: 14px; BORDER-LEFT: #eeeeee 1px solid; PADDING-RIGHT: 14px; BACKGROUND-COLOR: #eeeeee"><strong><span style="font-size: 16pt;">? IDA 기능<br /></span></strong></div> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; Debuging<br /></b></span><hr> Local win32 Debugger - 현재 컴퓨터에서 디버깅<br /> <br /> F2: BP 설정<br /> F7: step into<br /> F8: step over<br /> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; Decompiler<br /></b></span><hr> 해당 함수에서 F5를 누르면 디컴파일되며 , 함수단위로만 사용 가능하다.<br /> <br /> <br /> <div class="txc-textbox" style="BORDER-TOP: #eeeeee 1px solid; BORDER-RIGHT: #eeeeee 1px solid; BORDER-BOTTOM: #eeeeee 1px solid; PADDING-BOTTOM: 14px; PADDING-TOP: 14px; PADDING-LEFT: 14px; BORDER-LEFT: #eeeeee 1px solid; PADDING-RIGHT: 14px; BACKGROUND-COLOR: #eeeeee"><strong><span style="font-size: 16pt;">? IDA 저장<br /></span></strong></div> IDA는 작업 시 원본 실행파일이 아닌 idb라는 데이터베이스에 작업을 하게 된다.<br /> IDA를 종료하려고 하는 경우 IDA 어떤 방식으로 저장할지 창이 뜨게 되는데<br /> IDA로 생성된 id0 id1 nam til 파일들을 idb 파일로 묶을지 설정한다.<br /> <br /> Don't Pack Database = 파일을 묶지않겠다.<br /> Pack Database(Store,Deflate) = 파일을 묶겠다.<br /> Don'T SAVE the database = 작업 내용을 저장하지 않는다.<br /> <br /> <font size="4pt"><b>? 기본 설정 값 = Pack Database<br /></b></font> </div>

    <p id="a2">
      내용2
    </p>
    <p id="a3">
      내용3
    </p>
    <p id="a4">
      내용4
    </p>
  </div><strong>
  <script>
    $(window).on('hashchange', function(){
      $('.content').css('display', 'block');
      $(':target').addClass('open');
    });
  </script>