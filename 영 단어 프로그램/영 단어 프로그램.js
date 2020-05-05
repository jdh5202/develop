<center>
<body onkeydown='ckENT(event)'>
<input type="button" value="단어 초기화" onclick="random_prob()" style="color: #fff; background:gray; font-size:2em; font-weight:bold;">

  <br /><br />

<div id="problem_area"></div>
<textarea rows="1" cols="50" id="problem_text" placeholder="" autofocus="" required="" wrap="hard" disabled=""></textarea><br /><br />

<div id="answer_area"><font color="mediumturquoise" size="6px"><b>→ 답 입력 ←

</b></font></div>
<textarea rows="5" cols="10" id="answer_text" placeholder="" autofocus="" required="" wrap="hard"></textarea><br /><br />
  

<input type="button" id="view_ans" value="답안 보기(Enter)" onclick="view_answer()" style="color: #fff; 
background:blue; font-size:2em; font-weight:bold; border-radius:0.5em; padding:5px 20px;">


<input type="button" id="next_pro" value="다음 단어(Enter)" onclick="next_prob()" style="color: #fff; background:green; font-size:2em; font-weight:bold; border-radius:0.5em; padding:5px 20px; display:none;"><br /><br />
  
<div id="solv_prob"></div>

</body>
</center>

<style>
textarea
{
  width:549px;
  height:85px;
  font-weight:bold;
  color:#00004B;
  font-size:28px;
  border: #888888 6px solid;
  
}
</style>
<script>
var xml = "";

// here
xml+='<?xml version="1.0"?>';
xml+='<problems>';
xml+='  <problem id="1">the</problem>';
xml+='  <answer id="1">그</answer>';
xml+='  <problem id="2">of</problem>';
xml+='  <answer id="2">의</answer>';
xml+='  <problem id="3">and</problem>';
xml+='  <answer id="3">그리고</answer>';
xml+='</problems>';


xml = replaceAll(xml,"&lt;br&gt;","\n");

var xmlDoc= $.parseXML(xml); //xml 파일로 만든다.

var problem = [];
var answer = [];
var random = [];
var my_ans = "";
var random_pan;
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

    $("#answer_text").css('color',"#043927");
    $("#answer_text").attr('disabled','disabled');
    flag = 1;
    
    
    if ( fin_flag == 0 )
      {
        $("#view_ans").show();
        $("#view_ans").css('background',"green");
        $("#view_ans").attr("value","다음 단어(Enter)");
        $("#answer_text").val("");
        if ( random_pan == 1 )
          {
            $("#answer_text").val( answer[random[idx]] );      
          } else {
            $("#answer_text").val( problem[random[idx]] );      
          }
      }
    
  } else {
    $("#view_ans").css('background',"blue");
    $("#view_ans").attr("value","답안 보기(Enter)");
    next_prob();
    focus_on();
    but_init();
  }
  
  
  
}
function next_prob()
{
  if ( prob_cnt-1 > idx )
  { 
    random_pan = Math.floor(Math.random() * 2);
    ++idx; 
    but_init();
    prob_func();
    $("#view_ans").show();
    
    
  } else { $("#problem_text").val("👍 모든 문제를 푸셨습니다. ^^");
           $("#answer_text").val("");
           fin_flag = 1;
           $("#view_ans").hide();
           $("#next_pro").hide();
           $("#prev_pro").hide();
           $("#answer_text").attr('disabled',true);
          
           $("#problem_area").html("");
           $("#solv_prob").html("<font color='blue'>👍 " + prob_cnt + " 문제를 모두 푸셨습니다 👍</font><br /><font color='#2e77bb'>문제를 다시 풀고 싶다면 상단에 단어 초기화 버튼을 눌러주세요. ^^</font> ");
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
  $("#answer_text").css('color',"#00004B");
  $("#answer_text").attr('disabled',false);
  $("#view_ans").css('background',"blue");
  $("#view_ans").attr("value","답안 보기(Enter)");
  $("#answer_text").focus();
  $("#answer_text").text("");
}
function prob_func()
{
  $("#answer_text").val("");
  $("#problem_area").html("<font color='dodgerblue' size='6px'><b>→ "+ (idx+1) +"번 문제 ←</b></font>"); 
  
  if ( random_pan == 1 )
          {
            $("#problem_text").val( problem[random[idx]] );
          } else {          
            $("#problem_text").val( answer[random[idx]] );      
          }
  
 
}
function replaceAll(str, searchStr, replaceStr) {
  return str.split(searchStr).join(replaceStr);
}

function ckENT(event){ 
  var x = event.keyCode; 
  if (x==13) 
    view_answer();
 }

function focus_on()
{
  var focus_timer = setInterval(function() {  
    $("#answer_text").val("");
    clearInterval(focus_timer);
  }, 300);
}

</script>

</script>