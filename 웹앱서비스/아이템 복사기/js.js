<script>
// init
$(document).ready(function () {
  $("#input_area").text(`<Items>
      <item>§§</item>
      <item>§100§</item>
      <item>♤LowerCase♤</item>
      <item>♤UpperCase♤</item>
</items>`);

// 클릭한 버튼의 name 값 가져오기
$(".copy_selector").click(function(e){
    let but_name = $(this)[0].name;
    let copy_text;
   
      if ( but_name === '_num' )  copy_text = '§1§';
      else if ( but_name === '_low') copy_text = '♤LowerCase♤';
      else if ( but_name === '_upp') copy_text = '♤UpperCase♤';

    // copy
     var input = document.createElement("textarea");
      //adding p tag text to textarea 
      input.value = copy_text;
	    document.body.appendChild(input);
      input.select();
      document.execCommand("Copy");
     // removing textarea after copy
      input.remove();
      $("#copy_to_text").text("Something was selected").show().fadeOut(500);
      
});
  
   execute();
   $("#num").select();

});



function execute()
{
  let n_item = $("#num").val();
  let pat = /§.*?[\w|\t|\r|\W]*?§/g;
  let str_pat = /♤.*?[\w|\t|\r|\W]*?♤/g;
  let s = $(".input").val();
  let items = [];

  // int 
  /// item 복사 개수
  for ( let i=0; i < n_item; i++  )
    {
  items.push( s.replace(pat,function(n){ 
    n = parseInt( n.replace('§','') ); 
    if ( isNaN(n) == true ) return i+1; 
    return n+i;  
  } ).replace(str_pat, function(str){
     str =  str.replaceAll('♤','');
    
    if ( str === "LowerCase" )
   return String.fromCharCode( (((i) % 26) + 97) );
    else if ( str === "UpperCase" )
   return String.fromCharCode( (((i) % 26) + 65) );

  } )
     
            );
      
    
 
    }

  
  $("#result_area").val(items.join('\r\n'));
  
   $("#copy_to_text").text("Something was selected").show().fadeOut(500);
     $("#result_area").select();
     document.execCommand("Copy");
  
}

</script>