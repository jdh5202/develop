<center><div><b><span style="color: rgb(9, 0, 255);"><u><span style="font-size: 18pt;">검색 할 키워드 입력하기</span></u></span></b></div>
<input type="textbox" id="keyword" onkeydown="ckENT(event)">

<input type="Button" value="검색하기" onclick="set_keyword()">

<br /><br />
<div id="url_input">
<table id="table" style="display:none" class="type10" width="500px;" border='1'>
<tbody>
  
</tbody>
<thead>
  <tr>
  <th scope="cols">선택</th>
  <th scope="cols">검색엔진</th>
  <th scope="cols">주소</th>
</tr>
</thead>
</table>
  
</div>
<div id="button_view" style="display:none"><br /><input type="Button" value="선택된 웹 사이트를 모두 엽니다." onclick="all_open()"><br /><p><font color="red">※ 하나의 사이트만 열릴 경우 우측 상단에 팝업 차단 해제 ※</font> </p></div>
</center>


<style>
table.type10 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    margin: 20px 10px;
}
table.type10 thead th {
    white-space: nowrap;
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: #e7708d;
    margin: 20px 10px;
}
table.type10 tbody th {
    white-space: nowrap;
    padding: 10px;
}
.adrs {
    display: block;
    width: 500px;
    padding: 10px;
    vertical-align: top;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
table *{
  font-size:17px;
}


</style>

<script>
var url = ["https://www.google.com/search?q=","https://search.naver.com/search.naver?query=","https://search.daum.net/search?q=","https://duckduckgo.com/?q=","https://www.bing.com/search?q=","https://search.yahoo.com/search?p=","https://www.dogpile.com/serp?q=","https://www.ask.com/web?q=","https://www.ecosia.org/search?q="];

var search_engine = ["구글(Google)","네이버(Naver)","다음(Daum)","덕덕고(DuckDuckGo)","빙(Bing)","야후(Yahoo)","도그파일(Dogfile)","애스크닷컴(Ask.com)","에코시아(Ecosia)"];

var checkbox = [];
var chk_state = [];



for( var i=0; i< search_engine.length; i++ )
{
checkbox.push('<input type="checkbox" class="' + search_engine[i] + '">');
chk_state.push(true);


  

}






var info_url = [];

function set_keyword()
{
var keyword = $("#keyword").val();
keyword = encodeURI(keyword);


$('#table > tbody').empty();
  
var view_info_url = [];
info_url = [];
  
for( var i = 0; i < url.length; i++)
{
info_url.push(url[i] + keyword);
}

// a href
for( var i = 0; i < url.length; i++)
{
view_info_url.push("<a href='" + info_url[i] + "'target='_blank'>" + info_url[i] + "</a>");
}

var idx = 0;
view_info_url.forEach(function(element) { 
$('#table > tbody:last').append('<tr> <td align="center">' + checkbox[idx] + '</td> <th>' + search_engine[idx]+'</th><td class="adrs"> ' + element + '</td> </tr>');
idx++;
});  
  
idx = 0;  
chk_state.forEach(function(checking) {
$("input:checkbox[class='"+ search_engine[idx] +"']").prop("checked", checking); 
idx++;
});
  
$(function(){
  
    $("#url_input :checkbox").click(function(){
      var index = $(this).index('input:checkbox');
      chk_state[index] = $(this).is(":checked");
  });
});
$("#table").show();
$("#button_view").show();
}


function all_open()
{
  for(var i = info_url.length-1; i >= 0; i-- )
  {
    if (chk_state[i] == true)
       window.open(info_url[i], "_blank");
  }
}

function ckENT(event){
  var x = event.keyCode;
  if (x==13)
    set_keyword();
}


</script>
