
<center>
<input type="button" value="문제 초기화" onclick="random_prob();resize_cmd(); resize_ans_cmd();" style="color: #fff; background:gray; font-size:2em; font-weight:bold;">
<input type="button" value="큰 화면으로 보기" onclick="full_scr()" style="color: #Eff; background:#50bcdf; font-size:2em; font-weight:bold;"><br />
<input type="button" value="글씨 크기 최대" style="color: #afe; 
background:skyblue; font-size:1em; font-weight:bold;" onclick="size_max();resize_cmd(); resize_ans_cmd();">
<input type="button" value="글씨 크기 최소" class="size_min" style="color: #ffc; 
background:skyblue; font-size:1em; font-weight:bold;" onclick="size_min();resize_cmd(); resize_ans_cmd();">
<input type="button" value="글씨 크기 ↑" class="size_up" style="color: #afe; 
background:skyblue; font-size:1em; font-weight:bold;">
<input type="button" value="글씨 크기 ↓" class="size_do" style="color: #ffc; 
background:lightblue; font-size:1em; font-weight:bold;">

  <br /><br />

<div id="problem_area"></div>
<textarea rows="5" cols="50" id="problem_text" placeholder="" autofocus="" required="" wrap="hard" disabled=""></textarea><br /><br />

<div id="answer_area"><font color="mediumturquoise" size="6px"><b>→ 답안지 ←

</b></font></div>
<textarea rows="5" cols="50" id="answer_text" onkeydown="resize_ans_cmd()" placeholder="" autofocus="" required="" wrap="hard" style="height:67px;"></textarea><br /><br />
  

<input type="button" id="view_ans" value="답안 보기" onclick="view_answer();resize_cmd(); resize_ans_cmd();" style="color: #fff; 
background:blue; font-size:2em; font-weight:bold; border-radius:0.5em; padding:5px 20px;">


<input type="button" id="next_pro" value="다음 문제" onclick="next_prob();resize_cmd(); resize_ans_cmd();" style="color: #fff; background:green; font-size:2em; font-weight:bold; border-radius:0.5em; padding:5px 20px;">
<input type="button" id="prev_pro" value="이전 문제" onclick="prev_prob();resize_cmd(); resize_ans_cmd();" style="color: #ffE; background:lightgreen; font-size:2em; font-weight:bold; border-radius:0.5em; padding:5px 20px;"><br /><br />
  
<div id="solv_prob"></div>

</center>


<div id="myModal" class="modal">
     
 <table><tr> 
 
   <tr> <td class="md-content">
        <div class="modal-content"></div></td>
        <td class="md-content">
        <div class="modal-content2">
        </div></td></tr></table>

  <div class="pop_but" onClick="close_pop();">
                <span class="pop_bt" style="font-size: 26pt;" >
                     화면 닫기
                </span>
  </div>

 
    </div>

<style>
textarea
{
  width:729px;
  overflow-y :hidden;
  font-weight:bold;
  color:#00004B;
  font-size:28px;
  border: #888888 6px solid;
  
}

#problem_text {
 background-color: #EBEBE4;
}


/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  overflow: auto;
  margin: 20%; /* 15% from the top and centered */
  padding: 20px;
  border-radius: 10px;
  border: 5px solid #0EF;
  width: 75%; 
  height: 80%;            
}

.modal-content2 {
  background-color: #fefefe;
  overflow: auto;
  margin: 5%; 
  padding: 20px;
  border: 5px solid #0EF;
  border-radius: 10px;
  width: 75%; 
  height: 80%;           
}

.pop_but
{
  cursor:pointer;
  text-align: center;
  padding-bottom: 10px;
  padding-top: 10px;
  width: 175px;
  right: 63px;
  background-color:blue;
  color:white;
  font-weight:bold;
  border-radius: 40px;
  position:relative;
  left:895px;
  bottom:75px;
  
  

}
       
.md-content
{
  width:1200px;
  height:800px;
} 

</style>

<script>

$(document).ready(function () { setTimeout(function() { resize_cmd(); },100); });

function resize_cmd() {
resize($("#problem_text")[0]);
}  
function resize_ans_cmd() {
resize($("#answer_text")[0]);
}  
function resize(obj) {
  //alert(obj);
  obj.style.height = "1px";
  obj.style.height = (40+obj.scrollHeight)+"px";
}


var xml = "";

// here


xml = replaceAll(xml,"&lt;br&gt;","\n");

var xmlDoc= $.parseXML(xml); //xml 파일로 만든다.

var problem = [];
var answer = [];
var random = [];
var my_ans = "";
var idx; // 푼 문제
var flag = 0; // 내가 제출한 답 보기
var fin_flag = 0; // 답 제출 금지

$(xmlDoc).find("problem").each(function(index){     
  problem.push( $(this).text() );
}); 
$(xmlDoc).find("answer").each(function(index){     
  answer.push( $(this).text() );
});
var prob_cnt = $(xmlDoc).find("problem").length;

random_prob();

    
function view_answer()
{
  if ( flag == 0 )
  {
    my_ans = $("#answer_text").val();
    $("#view_ans").attr('value',"나의 답 보기");
    $("#view_ans").css('font-size',"1.5em");
    $("#view_ans").css('background',"skyblue");
    
    $("#answer_text").css('color',"#043927");
    $("#answer_text").attr('disabled','disabled');
    
    flag = 1;
    
    if ( fin_flag == 0 )
    $("#answer_text").val( answer[random[idx]] );
  } else {
    
    $("#answer_text").val( my_ans );
    but_init();
    
  }

  
}
function next_prob()
{
  if ( prob_cnt-1 > idx )
  { 
    ++idx; 
    but_init();
    prob_func();
   
  } else { $("#problem_text").val("👍 모든 문제를 푸셨습니다. ^^");
           $("#answer_text").val("👍 모든 문제를 푸셨습니다. ^^");
           fin_flag = 1;
           $("#view_ans").hide();
           $("#next_pro").hide();
           $("#prev_pro").hide();
           $("#answer_text").attr('disabled',true);
          
           $("#problem_area").html("");
           $("#solv_prob").html("<font color='blue'>👍 " + prob_cnt + " 문제를 모두 푸셨습니다 👍</font><br /><font color='#2e77bb'>문제를 다시 풀고 싶다면 상단에 문제 초기화 버튼을 눌러주세요. ^^</font> ");
         }

}
function prev_prob()
{
  if ( 0 < idx )
  { 
    --idx;
    but_init();
    prob_func();
  } 
  
}
function random_prob()
{ 
  random = [];
  for (var i = 0; i< problem.length; i++)
  random.push(i);
  shuffle(random);

  // init()
  idx = -1;
  fin_flag = 0;
  flag = 0;
  my_ans = "";
  $("#answer_text").val("");
  $("#view_ans").show();
  $("#next_pro").show();
  $("#prev_pro").show();
  
  but_init();
  $("#solv_prob").html("");
  next_prob(); // 바로 다음 문제
}

function shuffle(a) { 
    var j, x, i; 
    for (i = a.length; i; i -= 1) { 
        j = Math.floor(Math.random() * i); 
        x = a[i - 1]; 
        a[i - 1] = a[j]; 
        a[j] = x; 
    } 
} 

function but_init()
{
  flag = 0;
  $("#view_ans").attr('value',"답안 보기");
  $("#view_ans").css('font-size',"2em");
  $("#view_ans").css('background',"blue");
  $("#answer_text").css('color',"#00004B");
  $("#answer_text").attr('disabled',false);
}
function prob_func()
{
  $("#answer_text").val("");
  $("#problem_area").html("<font color='dodgerblue' size='6px'><b>→ "+ (idx+1) +"번 문제 ←</b></font>"); 
  $("#problem_text").val( problem[random[idx]] );

}
function replaceAll(str, searchStr, replaceStr) {
  return str.split(searchStr).join(replaceStr);
}

$(".size_do").click(function() {
		var $speech = $("textarea");
		var currentSize = $speech.css("fontSize");	
		var num = parseFloat(currentSize, 10);	
		var unit = currentSize.slice(-2);	
    
    if ( num > 11 ) 	--num;
    $speech.css("fontSize",num);
   resize_cmd(); resize_ans_cmd();
});

$(".size_up").click(function() {
		var $speech = $("textarea");
		var currentSize = $speech.css("fontSize");	
		var num = parseFloat(currentSize, 10);	
		var unit = currentSize.slice(-2);	
    
    if ( num < 28 ) 	++num;
    $speech.css("fontSize",num);
   resize_cmd(); resize_ans_cmd();
});

function size_max()
{
  var $speech = $("textarea");
  var currentSize = $speech.css("fontSize",'28px');
}
function size_min()
{
  var $speech = $("textarea");
  var currentSize = $speech.css("fontSize",'11px');
}

// modal
var problem_form1 = '<center><font size="10em" color="red"><b>문제</b></font></center>';
var problem_form2 = '<center><font size="10em" color="blue"><b>답안</b></font></center>';

var ans_view_but = '<center><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><input type="button" style="font-size:45px;" onclick="full_ans_click()" value="답안 보기"> </center>';


function full_scr()
{
  $('#myModal').show();

 var full_problem = replaceAll(problem[random[idx]],'\n','<br />');
  
  $(".modal-content").html(problem_form1 + "<font size='4em'>" +  full_problem + "</font>");
  
  $(".modal-content2").html(ans_view_but);
  
}
function close_pop(flag) {
  $('#myModal').hide();
  
};

function full_ans_click() {

  var full_answer = replaceAll(answer[random[idx]],'\n','<br />');
  
  
  $(".modal-content2").html(problem_form2 + "<font size='4em'>" +  full_answer + "</font>");
  
};


</script>
