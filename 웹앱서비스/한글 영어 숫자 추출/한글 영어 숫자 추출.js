<div>
  
<center>  <div> <font color="red"><b>입력창</b></font><br />
<textarea rows="15" cols="120" id="contents" placeholder="이 곳에 텍스트를 입력하세요." autofocus="" required="" wrap="hard">Agent의 종류는 두 가지로써 Agent와 Agent-less다.
일반적으로 Agent SW를 설치하지 않는 버전이 Agent-less, 설치하면 Agent라고
잘 못 이해하고 있는데, Agent가 없으면 SW 상태를 체크할 수 없다.
올바른 정의는 Agent의 유무가 아닌 네트워크를 통제하는 위치다.

Agent 소프트웨어에서 네트워크를 통제한다.
하드웨어 및 프로세스 정보 수집, Patch 지원, 백신 연동 등을 지원한다.

Agent 세대는 1, 2, 3로 분류된다. 
</textarea></div>
<div>
<input type="button" value="영어_추출" onclick="Data(value)">
<input type="button" value="한글_추출" onclick="Data(value)">
<input type="button" value="숫자_추출" onclick="Data(value)">
</div><br />
  
<div>  <font color="blue"><b>결과창</b></font><br />
<textarea rows="15" cols="120" id="result" autofocus="" required="" wrap="hard"></textarea>
</div>
<div id="word_count">  
</div>  
</center>  

<script>
function Data(val)
{
  var Artist = document.getElementById("contents").value.split("\n");
  var res = [];  
  
  
  for(var i=0; i< Artist.length; i++)
    {
      if (val == '한글_추출' )
      res.push( Artist[i].replace(/[^\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F- -'-"-,-.]/gi,"") );
  else if (val == '영어_추출' )
    res.push( Artist[i].replace(/[^a-zA-Z- -'-"-,-.]/g,"") );
  else if (val == '숫자_추출' )
  res.push( Artist[i].replace(/[^0-9- ]/g,"") );
    }  $("#result").val(res.join("\n"));
  
  $("#word_count")[0].innerHTML = "<b>➽ 총 글자 수 : " + res.join("\n").length + "</b><br />";
    $("#word_count")[0].innerHTML += "<b>➽ 공백 제외 &nbsp;: " + res.join("\n").replace(/(\s*)/g,"").length + '</b>';
  
}

</script>

<br /><p><br /></p><div><center><div><b><span style="background-color: rgb(124, 67, 177); color: rgb(255, 255, 255);">&nbsp;</span><span style="background-color: rgb(124, 67, 177); color: rgb(255, 255, 255);">정규식 소스&nbsp;</span></b></div></center></div><p style="text-align: center;">→&nbsp;<a href="https://jdh5202.tistory.com/451" target="_blank" class="tx-link">https://jdh5202.tistory.com/451</a>&nbsp;←</p>
<p><br /></p></div>