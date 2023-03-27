<center>
<div id="total">
<h5>&nbsp;</h5>
</div>
<b>확률 설정(%)</b>&nbsp;<input id="val" size="5" type="text" value="50.0" /> <input id="plus" type="button" value="+" /> <input id="minus" type="button" value="-" /> <br /><br /><b>시도할 횟수</b>&nbsp;<input id="draw" size="5" type="text" value="10" /> <input id="plus2" min="1" type="button" value="+" /> <input id="minus2" type="button" value="-" /> <br /><br /><b>성공 시 얻을 금액(\)</b>&nbsp;<input id="bounty" size="6" type="text" value="10000" /> <br /><br /><input class="test" type="button" value="확률 테스트" /> <br /><br /><br />
<div id="record">&nbsp;</div>
<br />
<div id="result">&nbsp;</div>
</center>
<script>

let global_score = [];
let global_test = 0;
let global_draw = 0;

function ckENT(event){ 
  var x = event.keyCode; 
  if (x==13) 
    clickRandom();
}

function reset()
{  
  global_score = [];
  global_test = 0;
  global_draw = 0;
  document.getElementById("total").innerHTML = '<div id="total"><h5></h5></div>';
}

function clickRandom() {

  let record_obj = document.getElementById("record");
  let result_obj = document.getElementById("result");
  let total_obj = document.getElementById("total");
  let draw = document.getElementById("draw").value;
  let percent1 = document.getElementById("val").value;
  let money = document.getElementById("bounty").value;
  
  if ( percent1 == "" ) { alert("확률을 지정하세요.");     document.getElementById("val").focus(); return;}
  if ( draw == "" ) { alert("횟수를 지정하세요."); document.getElementById("draw").focus(); return;}
  if ( money == "" ) { alert("확률 성공 시 얻을 금액을 지정하세요."); document.getElementById("bounty").focus(); return;}
  
  let percent2 = percent1 / 100;
  let win_counter = 0;
  let lose_counter = 0;
  record_obj.innerHTML = "";
  result_obj.innerHTML = "";
 
  let array = [];
  
  for( let i=0; i < draw; i++ )
  {
      // score
        let rand = Math.random();
    
        if (rand < percent2 ) {
          win_counter +=1;
          array += 1; 
        } else {
          lose_counter +=1;
          array += 0; 
        } 
  } 

    for ( let j = 0; j < array.length; j++ )
    {
       if (array[j] == 1 ) result_obj.innerHTML += (j + 1) + ". <font color='#f89b00'>🎁</font> 성공 <font color='#f89b00'>🎁</font><br>";
       else result_obj.innerHTML += (j + 1) + ". 💣 실패 💣<br>";
    }
    global_test++;
    global_draw += array.length;
  
  let scr = (win_counter / draw*100).toFixed(1);
  global_score.push(scr);
  let tmp_scr = 0.0;
  
  for ( let d = 0; d < global_score.length; d++)
  {
     tmp_scr += Math.floor(global_score[d] + tmp_scr);

  } let real_score = (tmp_scr / global_score.length).toFixed(1);
  
    record_obj.innerHTML = "<p><b>전적(" + scr + "%) - 🎁성공: " + win_counter + " " + "💣실패: " + lose_counter + "</b></p>" + "<p>💰"+ win_counter * money + "\\💰</p>";
  
    total_obj.innerHTML = "<h5>" + "총 전적(" + real_score + "%) - 테스트 횟수("+ global_test +") - 시도 횟수("+ global_draw + ") <input type='button' onclick='reset()' id='rst' value='초기화'></h5>";
  
  document.getElementById("rst").onclick = function(){reset();}

}

var plusEle = document.querySelector('#plus');
var minusEle = document.querySelector('#minus');
var isPressed = false;

plusEle.addEventListener('mouseup', function(event) {
  isPressed = false;
});

plusEle.addEventListener('mousedown', function(event) {
  isPressed = true;
  doInterval('1');
});

minusEle.addEventListener('mouseup', function(event) {
  isPressed = false;
});

minusEle.addEventListener('mousedown', function(event) {
  isPressed = true;
  doInterval('-1');
});

function doInterval(action) {
  if (isPressed) {
    var countEle = document.querySelector('#val');
    
    
    if ( countEle.value > 0 ) countEle.value = parseFloat(countEle.value) + parseFloat(action);
  else { if (action == '1') countEle.value = parseFloat(countEle.value) + parseFloat(action);  }
    
    setTimeout(function() {
      doInterval(action);
    }, 100);
  }
 };

var plusEle2 = document.querySelector('#plus2');
var minusEle2 = document.querySelector('#minus2');
var isPressed2 = false;

plusEle2.addEventListener('mouseup', function(event) {
  isPressed2 = false;
});

plusEle2.addEventListener('mousedown', function(event) {
  isPressed2 = true;
  doInterval2('1');
});

minusEle2.addEventListener('mouseup', function(event) {
  isPressed2 = false;
});

minusEle2.addEventListener('mousedown', function(event) {
  isPressed2 = true;
  doInterval2('-1');
});

function doInterval2(action) {
  if (isPressed2) {
    var countEle = document.querySelector('#draw');
    
    if ( countEle.value > 1 ) countEle.value = parseFloat(countEle.value) + parseFloat(action);
  else { if (action == '1') countEle.value = parseFloat(countEle.value) + parseFloat(action);  }

    setTimeout(function() {
      doInterval2(action);
    }, 100);
  }
 };


</script>