<script>

$(document).ready(function(){
   execute();
  
  // 키 입력이 감지되면 코딩 함수 실행
    $("#contents").on('change keyup paste', function() 
    {
      execute();
    });
  
    $('input:radio[name="chk_info"]').on('click', function(e) {
     way = $(this).val();
     execute();
    });
  
  // copy
  $("input[type=button]:input[value='복사']").click(function(){ 

      var curen_id = $(this).attr('id');
      var textarea_id = [];

        curen_id = curen_id.replace("but","result_content");
        var copyText = $(`#${curen_id}`);
        copyText.select();
        document.execCommand("Copy");

    
  }); 

  
});



// 인코딩 / 디코딩 버튼 확인
var way = "encode_mode"; // default


function execute()
{
  var data = $("#contents").val();

   if ( data ) 
   {
    if ( way == "encode_mode")
      {
        $("#result_content1").val(efunc(data));
        $("#result_content2").val(ufunc(data));
        $("#result_content3").val(lfunc(data));
        try { $("#result_content4").val(btoa(data)); } catch { $("#result_content4").val(""); }
        $("#result_content5").val( data.hexEncode() );
        $("#result_content6").val( charToAscii(data) );
        $("#result_content7").val( encodeURIComponent(data) );
       }
    else {
 var text = $('<textarea />').html( $("#contents").val() ).text();
  $("#result_content1").val(text);
      
  $("#result_content2").val(UnicodeTochar(data));
  $("#result_content3").val(DeISO_Latin(data));
      
  try { $("#result_content4").val(atob(data)); } catch {$("#result_content4").val(""); }
     $("#result_content5").val( hex_to_str(data) );
     $("#result_content6").val( AsciiToChar(data) );
     $("#result_content7").val( decodeURIComponent(data) );
  
    } 
   } else { $(".result_content_f").val(""); }
  
}


efunc = function(str) {
  if (!str) return false; 
  var ascii = '';
  for (var i = 0, l = str.length; i < l; i++) {
    ascii += '\&\#' + str[i].charCodeAt(0).toString(10);
  };
  return ascii;
}

ufunc = function(str) {
  if (!str) return false; 
  var unicode = '';
  for (var i = 0, l = str.length; i < l; i++) {
    unicode += '\\u00' + str[i].charCodeAt(0).toString(16);
  };
  return unicode;
}

lfunc = function(str) {
  if (!str) return false; 
  var unicode = '';
  for (var i = 0, l = str.length; i < l; i++) {
    unicode += '\\x' + str[i].charCodeAt(0).toString(16);
  };
  return unicode;
}

UnicodeTochar = function(str) { 
  
  if (!str) return false;
  var char = str.split('\\u00');
  var result = "";
  for ( var i = 1; i< char.length; i++)
  {
    result += String.fromCharCode(parseInt(char[i],16));
  } 
  return result;
}

DeISO_Latin = function(str) { 
  
  if (!str) return false;
  var char = str.split('\\x');
  var result = "";
  for ( var i = 1; i< char.length; i++)
  {
    result += String.fromCharCode(parseInt(char[i],16));
  } 
  return result;
}

String.prototype.hexEncode = function(){
    var hex, i;

    var result = "";
    for (i=0; i<this.length; i++) {
        hex = this.charCodeAt(i).toString(16);
        result += ( "&#x"+ hex);
    }

    return result;
}

function hex_to_str(str1)
 {

	var hex  = str1.toString();
    hex = hex.split("&#x").join('');

	var str = '';

	for (var n = 0; n < hex.length; n += 2) {
		str += String.fromCharCode(parseInt(hex.substr(n, 2), 16));


	}
	return str;
}

charToAscii = function(str) { 
  
  if (!str) return false;
  var result = "";
  for ( var i = 0; i< str.length; i++)
  { 
    result += str.charCodeAt(i)+',';
  } 
  return result.slice(0,-1); // last , delete
}

charToAscii = function(str) { 
  
  if (!str) return false;
  var result = "";
  for ( var i = 0; i< str.length; i++)
  { 
    result += str.charCodeAt(i)+',';
  } 
  return result.slice(0,-1); // last , delete
}

AsciiToChar = function(str) { 
  
  if (!str) return false;
  var char = str.split(',');
  var result = "";
  for ( var i = 0; i< char.length; i++)
  {
    result += String.fromCharCode(char[i]);
  } 
  return result;
}


</script>
