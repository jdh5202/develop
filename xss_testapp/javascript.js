<script>
// [global] default value
var input_option = "input_opt1";
var output_define = "";

function ckENT(event){ 
  var x = event.keyCode; 
  if (x==13) { $("#confirm-button").trigger("click"); }
}

 
$(document).ready(function() {

$("#input_area").hide();
$("#output_define").hide();
$("#filter_define").hide();
$("#code").hide();
$("#preview_html").text("<h1>${INPUT_VALUE}</h1>");


$("#output_define").on('change keyup paste', function() 
{
	var output_define = $("#output_define").val();
	$("#preview_html").text(output_define);
});

 
$('input:radio[name="input_opt"]').on('click', function(e) {

	if ( $(this).attr('id') == 'input_opt1' ) 
	{
		$("#input").show();
		$("#input_area").hide();

	} else {
		$("#input_area").show();
		$("#input").hide();
	} input_option = $(this).attr('id');
		
});

$('input:radio[name="output_opt"]').on('click', function(e) {

	var display_text = "";
	var id = $(this).attr('id');
	$("#output_define").hide();
	
	switch ( id ) {
		
		case 'output_opt1':
		display_text = "<h1>${INPUT_VALUE}</h1>";
		break;
		
		case 'output_opt2':		
		display_text = "<a href=\"${INPUT_VALUE}\">Click</a>";
		break;
		
		case 'output_opt3':		
		display_text = "<img src=\"${INPUT_VALUE}\">";
		
		break;

		default:
		$("#output_define").show();
		display_text = $("#output_define").val();
		break;
		
		
	}

	$("#preview_html").text(display_text);


});


$('input:checkbox[id="Filter_opt3"]').on('click', function(e) {

	if ( $(this).is(":checked") == false ) 
	{	
	$("#filter_define").hide();
	} else { 
	$("#filter_define").show();
	}

});


function xss_filter(xss_val) 
{

   if ( $("input:checkbox[id='Filter_opt1']").is(":checked") )
   {
		 
		xss_val = xss_val.replaceAll("<"  , "&lt;")
				         .replaceAll(">"  , "&gt;");
   }
   
   if ( $("input:checkbox[id='Filter_opt2']").is(":checked") )
   {
		xss_val = xss_val.replaceAll("\"", "&quot;")
						 .replaceAll("'"  , "&#39;");
   }
   
   
   if ( $('input:checkbox[id="Filter_opt3"]').is(":checked") )
   {
		var filter_list = $("#filter_define").val();
		var split_filter = filter_list.split( ',' ) ;

		for ( var i=0; i < split_filter.length; i++ )
		{	
			var re = new RegExp(`${split_filter[i]}`,"gi");
			xss_val = xss_val.replace(re , "");
		}
   }

   return xss_val;
}
// 1 - OK 
function codeOutput(xss_val) {

  xss_val = xss_filter(xss_val);
   
  if ( xss_val = output_option(xss_val) )
  {
	  $("#code").show();    
	  $("#code-title").html("<p><b><font size='4.2em'>[Output code]</font></b></p>");
	  $("#code").text(xss_val);
	  $("#output-html").html(xss_val);
  }
}

function output_option(xss_val) {

// 2 - OK(output 옵션 실행)
  var id = $("input:radio[name=output_opt]:checked")[0].id;
  var output_str = "";
  if ( id == "output_opt1" ) output_str = `<h1>${xss_val}</h1>`;
  else if ( id == "output_opt2" ) output_str = `<a href=\"${xss_val}\">Click</a>`;
  else if ( id == "output_opt3" ) output_str = `<img src=\"${xss_val}\">`;
  else { 
	
	var test_var = $("#preview_html").text();
	
	if ( test_var.indexOf("$[INPUT_VALUE]") != -1 )
	{ 
	output_str = test_var.replace( '$[INPUT_VALUE]', `${xss_val}` );    
	} else { 	
	output_str = "";
	alert("$[INPUT_VALUE]를 정의하시오."); 
	}
  
  }   
  return output_str;
  
}



$('#confirm-button').on('click', function(e) {
  e.preventDefault();
  
  const codeTitle = document.querySelector("#code-title");
  var xss_val = "";

  if ( input_option == "input_opt1" )
  {
    xss_val = $("#input").val();
  } else { xss_val = $("#input_area").val(); }
  
  codeOutput(xss_val);
    
	
 });

});

</script>
