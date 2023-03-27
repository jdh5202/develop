var arr = new Array();
$(".point01").each( function(index, item){ 

var strings = item.innerText;
var len = strings.indexOf("(");
if ( len != -1) { strings = strings.substr(strings,len); } 
arr.push(strings + '\n');

}); 
arr = arr.join('');

$("#historyKeywordList")[0].innerHTML = "<textarea id='copy_text'>" + arr + "</textarea>";

$("#copy_text").select();
document.execCommand('copy');
