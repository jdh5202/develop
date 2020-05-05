<script>
var way = "encode_mode"; // default
$("input[type=radio]").click(function(){ way = $(this).val(); });

// move
$("input[type=button]:input[value='Go']").click(function(){ 
  
  var curen_id = $(this).attr('id');
  var textarea_id = [];
  $("table textarea").each(function() { textarea_id.push(($(this).attr('id'))); });
  
  
  $("table input[type=button]:odd").each(function(index) {     
    if ( $(this).attr('id') == curen_id )
      $("#contents").val($("#"+textarea_id[index]).val());
  });
});

// copy
$("input[type=button]:input[value='บนป็']").click(function(){ 
  
  var curen_id = $(this).attr('id');
  var textarea_id = [];
  $("table textarea").each(function() { textarea_id.push(($(this).attr('id'))); });
  
  
  $("table input[type=button]:even").each(function(index) {     
    if ( $(this).attr('id') == curen_id )
    { 
        var copyText = $("#"+textarea_id[index]);
        copyText.select();
        document.execCommand("Copy");
    }
    
  });
});


function execute()
{
  var data = $("#contents").val();

  var base64 = $("#result_content1");
  var URL = $("#result_content2");
  var All_URL = $("#result_content3");
  var Html = $("#result_content4");
  var Hex = $("#result_content5");
  var Unicode = $("#result_content6");
   if ( data ) 
   {
    if ( way == "encode_mode")
      {
        try {
        base64.val(window.btoa(unescape(encodeURIComponent(data))));
        } finally {
        URL.val(encodeURI(data));
        All_URL.val(encodeURIComponent(data));
        Html.val($('<textarea/>').text(data).html());
        Hex.val(data.hexEncode());
        Unicode.val(charToUnicode(data));
        }

      }
    else {

        try {
        base64.val(decodeURIComponent(escape(window.atob(data.replace(/\s/g, '')))));
        } finally {
        URL.val(decodeURI(data));
        All_URL.val(decodeURIComponent(data));
        Html.val($('<textarea/>').html(data).text());
        Hex.val(data.hexDecode());
        Unicode.val(UnicodeTochar(data));
        }
    }
   }
}


String.prototype.hexEncode = function(){
    var hex, i;

    var result = "";
    for (i=0; i<this.length; i++) {
        hex = this.charCodeAt(i).toString(16);
        result += ("000"+hex).slice(-4);
    }

    return result;
}

String.prototype.hexDecode = function(){
    var j;
    var hexes = this.match(/.{1,4}/g) || [];
    var back = "";
    for(j = 0; j<hexes.length; j++) {
        back += String.fromCharCode(parseInt(hexes[j], 16));
    }

    return back;
}

charToUnicode = function(str) {
  if (!str) return false; // Escaping if not exist
  var unicode = '';
  for (var i = 0, l = str.length; i < l; i++) {
    unicode += '\\' + str[i].charCodeAt(0).toString(16);
  };
  return unicode;
}

UnicodeTochar = function(str) { 
  
  if (!str) return false;
  var char = str.split('\\');
  var result = "";
  for ( var i = 1; i< char.length; i++)
  {
    result += String.fromCharCode(parseInt(char[i],16));
  } 
  return result;
}


function reset_but()
{
  $("#contents").val('The command uses the Get-Alias cmdlet to get the aliases. It uses the pipeline operator (|) to send the aliases to the ConvertTo-Html cmdlet, which creates the HTML page.');
  $("#result_content1").val('');
  $("#result_content2").val('');
  $("#result_content3").val('');
  $("#result_content4").val('');
  $("#result_content5").val('');
  $("#result_content6").val('');
}
</script>