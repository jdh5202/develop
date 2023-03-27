<table>
<tr><td width="150px;"><b style="color: green;">□ 입력창 □</b></td>  
<td id="ori_word_count" ></td></tr>
</table>

<form name="this_text"><textarea rows="10" cols="120" name="contents" placeholder="이 곳에 텍스트를 입력하세요." autofocus="" required="" wrap="hard">The command uses the Get-Alias cmdlet to get the aliases. It uses the pipeline operator (|) to send the aliases to the ConvertTo-Html cmdlet, which creates the HTML page.
3
1
4
2
bluefish
tuna
bluefish</textarea><br />

<table border="0">
<tbody><tr>
<td><input type="radio" name="chk_info" onclick="check_radio(this);" value="str_reverse" checked="">문자열 

뒤집기</td>
<td><input type="radio" name="chk_info" value="str_tocase" onclick="check_radio(this);">대,소문자로 변환</td>
<td><input type="radio" name="chk_info" value="str_titcase" onclick="check_radio(this);">Title Case</td>
<td><input type="radio" name="chk_info" value="str_deltag" onclick="check_radio(this);">HTML 태그 제거</td></tr>
<tr>
<td><input type="radio" name="chk_info" value="str_dupword" onclick="check_radio(this);">중복 단어 제거</td>
<td><input type="radio" name="chk_info" value="str_replace" onclick="check_radio(this);">치환</td>
<td><input type="radio" name="chk_info" value="str_insert" onclick="check_radio(this);">좌우 삽입</td>
<td><input type="radio" name="chk_info" value="str_sort" onclick="check_radio(this);">정렬</td>
<td><a href="https://jdh5202.tistory.com/504" target="_blank" class="tx-link">한글,영어,숫자만 추출</a></td>
</tr>
</tbody></table> 

<br /><div id="next_radio"><p><font color="blue">□ 옵션 □</font><br />

</p><div id="str_reverse">
<input type="radio" name="chk_info_2" value="str2_all_reverse" checked="">전체 문자열 뒤집기
<input type="radio" name="chk_info_2" value="str2_sep_tocase">중간 구분자를 가진 단어 뒤집기
<input type="textbox" id="sep_tocase" disabled="disabled" value="," size="1">
</div>

<div id="str_tocase" style="display:none;">
<input type="radio" name="chk_info_3" value="str2_upper" checked="">대문자로 변환
<input type="radio" name="chk_info_3" value="str2_lower">소문자로 변환
</div>

<div id="str_dupword" style="display:none;">
<font color="red">구분자 삽입</font> - <input type="textbox" id="chk_info_4" size="1" value="\n">
</div>

<div id="str_replace" style="display:none;">
<font color="blue"><input type="textbox" id="chk_info_5_l" value=",">를</font>
<font color="blue"><input type="textbox" id="chk_info_5_r" value="\n">로 바꾸겠습니다.</font>
</div>

<div id="str_insert" style="display:none;">
<font color="blue">좌</font> - <input type="textbox" id="chk_info_6_l">
<font color="green">우</font> - <input type="textbox" id="chk_info_6_r"> 행번호[#number]<br />
<font color="red">구분자 삽입</font> - <input type="textbox" id="chk_info_6" size="1" value="\n">
</div>

<div id="str_sort" style="display:none;">
<input type="radio" name="chk_info_7" value="str2_up_sort" checked="">알파벳 순 정렬 - ↑
<input type="radio" name="chk_info_7" value="str2_de_sort">알파벳 순 정렬 - ↓
<input type="radio" name="chk_info_7" value="str2_alp_sort">숫자 순 정렬 - ↑
<input type="radio" name="chk_info_7" value="str2_num_sort">숫자 순 정렬 - ↓<br />
<font color="red">구분자 삽입</font> - <input type="textbox" id="chk_info_7" size="1" value="\n">
</div>

</div><br />

<input type="button" value="실행" onclick="execute()">
<input type="button" value="결과물을 입력창에 이동" onclick="copy_paste()">
<input type="reset"></form><p><br />

<font color="blue"><b>■ 결과창 ■</b></font><br />
</p><textarea rows="14" cols="120" name="r_contents" placeholder="" autofocus="" required="" wrap="hard"></textarea><br />
<div id="word_count">
</div><p><br /></p>

    

<script>
var func = "str2_all_reverse"; // default
$("input[type=radio]").click(function(){ func = $(this).val(); });

// 문자열 뒤집기 옵션 - 텍스트 박스 활성화 유무 설정
$("input[name='chk_info_2']").click(function(){

  var txtbox = $("#sep_tocase");
  if ( $(this).val() == "str2_sep_tocase" ) txtbox.attr("disabled",false);
  else txtbox.attr("disabled",true);

});

function check_radio(rd)
{
var level = rd.name;
var option = rd.value

var rd_obj = $('body').find("#next_radio #" + option)
$('body').find("#next_radio > div").hide();
rd_obj.show();
}

function execute()
{
   var text = $("textarea[name='contents']").val();
   var r_text = $("textarea[name='r_contents']");
   
  if ( text )
  {
   if ( func == "str2_all_reverse" || func == "str_reverse" )
   { r_text.val(text.split("").reverse().join("")); } 
    else if ( func == "str2_sep_tocase" ) {
 
      var chr = $("#sep_tocase").val();
      if ( chr ) {
      text.substr(0, (text.length - 1));  
      var tokens = text.split(chr);  
      r_text.val(tokens.reverse().join(chr));
      }
      
   } else if ( func == "str2_upper" || func == "str_tocase" ) {
     r_text.val(text.toUpperCase());
   } else if ( func == "str2_lower" ) {
     r_text.val(text.toLowerCase());
   } else if ( func == "str_titcase" ) {
     r_text.val(text.replace(/(?:^|\s)\w/g, function(match) {
     return match.toUpperCase();}));
   } else if ( func == "str_deltag" ) {
     text = text.replace(/<br\/>/ig, "\n");
     text = text.replace(/&nbsp;/ig, " ");
     text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
     r_text.val(text);
   } else if ( func == "str_dupword" ) {
     
     var process = [];
     var resultArr = [];
     var splits = $("#chk_info_4").val();
     splits = splits.replace(/\\n/g,"\n");splits = splits.replace(/\\t/g,"\t");
     
     text.split(splits).forEach(function(element,index) {
        process.push(element);
     }); 
     
     $.each(process, function(i,e){ if($.inArray(e,resultArr)===-1) resultArr.push(e) ;});
     $.each(resultArr, function(i,e){ resultArr[i] = resultArr[i] + splits;  } );
     
     r_text.val(resultArr.join(""));
     
   } else if ( func == "str_replace" ) {
     
     
     var chr1 = $("#chk_info_5_l").val();
     var chr2 = $("#chk_info_5_r").val();

     var del_regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/gi;
 
   if (chr2 != "\\n" && chr2 != "\\t") 
   {
    if(del_regExp.test(chr1)){
    chr1 = chr1.replace(del_regExp, '\\'+chr1);
    }
    if(del_regExp.test(chr2)){
    chr2 = chr2.replace(del_regExp, '\\'+chr2);
    }
   } else {
     chr2 = chr2.replace(/\\n/g,"\n");
     chr2 = chr2.replace(/\\t/g,"\t"); 
   }

     if (chr1)
     { r_text.val(text.replace(new RegExp(chr1,'gi'),chr2)); }
     
   } else if ( func == "str_insert" ) {
     
     var chr1 = $("#chk_info_6_l").val();
     var chr2 = $("#chk_info_6_r").val();
     var splits = $("#chk_info_6").val();
     var ins_text = [];
     
     chr1 = chr1.replace(/\\n/g,"\n");chr2 = chr2.replace(/\\n/g,"\n");
     chr1 = chr1.replace(/\\t/g,"\t");chr2 = chr2.replace(/\\t/g,"\t"); 
     splits = splits.replace(/\\n/g,"\n");splits = splits.replace(/\\t/g,"\t"); 
  
     
  
     text.split(splits).forEach(function(element,index) {

        if ( chr1 != "#number" && chr2 != "#number" )
        { ins_text.push(chr1 + element + chr2 + splits); }
        else 
        { 
          var tmp = "";
          
          if ( chr1 == "#number" ) tmp += String(index+1);
          else tmp += chr1;
          tmp +=  element;
          
          if ( chr2 == "#number" ) tmp += String(index+1);
          else tmp += chr2;
          tmp += splits;
          
          ins_text.push(tmp);     
        }
     });

     r_text.val(ins_text.join(""));
  
   
     // sort
   } else if ( func == "str2_up_sort" || func == "str_sort" ) {
     
   var splits = $("#chk_info_7").val();
       splits = splits.replace(/\\n/g,"\n");splits = splits.replace(/\\t/g,"\t"); 
       text = text.split(splits);
       text.sort();
       $.each(text, function(i,e){ text[i] = text[i] + splits; } );
       r_text.val(text.join(""));
     
   } else if ( func == "str2_de_sort" || func == "str_sort" ) {
     
   var splits = $("#chk_info_7").val();
       splits = splits.replace(/\\n/g,"\n");splits = splits.replace(/\\t/g,"\t"); 
       text = text.split(splits);
       text.sort();
       text.reverse();
       $.each(text, function(i,e){ text[i] = text[i] + splits; } );
       r_text.val(text.join("")); 
     
   } else if ( func == "str2_alp_sort" || func == "str_sort" ) {
    
   var splits = $("#chk_info_7").val();
       splits = splits.replace(/\\n/g,"\n");splits = splits.replace(/\\t/g,"\t"); 
       text = text.split(splits);
       text.sort(function(a, b){return a - b});
       $.each(text, function(i,e){ text[i] = text[i] + splits; } );
       r_text.val(text.join(""));
     
   } else if ( func == "str2_num_sort" || func == "str_sort" ) {
     
   var splits = $("#chk_info_7").val();
       splits = splits.replace(/\\n/g,"\n");splits = splits.replace(/\\t/g,"\t"); 
       text = text.split(splits);
       text.sort(function(a, b){return b - a});
       $.each(text, function(i,e){ text[i] = text[i] + splits; } );
       r_text.val(text.join(""));
   }
  } 
    var length_txt = r_text.val();

    $("#word_count")[0].innerHTML = "➽ 총 글자 수 : " + length_txt.length + "<br />";
    $("#word_count")[0].innerHTML += "➽ 공백 제외 &nbsp;: " + length_txt.replace(/(\s*)/g,"").length;
    
  
    $("#ori_word_count")[0].innerHTML = "➽ 총 글자 수 : " + text.length;
}

function copy_paste()
{
  var text = $("textarea[name='contents']").val($("textarea[name='r_contents']").val());
}

</script>
