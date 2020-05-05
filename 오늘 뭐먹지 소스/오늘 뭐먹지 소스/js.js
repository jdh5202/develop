<script>
$(document).ready(function() {

//Main 카테고리를 선택 할때 마다 AJAX를 호출할 수 있지만 DB접속을 매번 해야 하기 때문에 main, sub카테고리 전체을 들고온다.

//****************이부분은 DB로 셋팅하세요.
//Main 카테고리 셋팅 (DB에서 값을 가져와 셋팅 하세요.)
var mainCategoryArray = new Array();
var mainCategoryObject = new Object();
var subCategoryArray = new Array();
var subCategoryObject = new Object();

var top_category = [ "음식" , "가공식품" , "패밀리레스토랑","간단메뉴"];
var food_category = ["밥류","빵-과자류","면-만두류","죽-스프류","국-탕류","찌개-전골류","찜류","구이류","전-부침류","볶음류","조림류","튀김류","나물-숙채류","생채-무침류","김치류","젓갈류","장아찌-절임류","유제품류-빙과류","음료-차류","과일류","당류","곡류-서류-제품","수조어육류","햄버거","피자","제빵","아이스크림","분식","과자","음료"];

var profood_category = ["과자류","빵-떡류","코코아가공품류-초콜릿류","면류","커피","과일-채소류음료","두유류","즉석섭취-편의식품류"];

// 전체메뉴
top_category.forEach(function(element,index){

mainCategoryObject = new Object();
mainCategoryObject.main_category_id = String(index+1);
mainCategoryObject.main_category_name = element;
mainCategoryArray.push(mainCategoryObject);
});

// 음식메뉴
food_category.forEach(function(element,index){ 
subCategoryObject = new Object();
subCategoryObject.main_category_id = "1";
subCategoryObject.sub_category_id = String(index+1);
subCategoryObject.sub_category_name = element;	
subCategoryArray.push(subCategoryObject);
});

// 가공식품메뉴
profood_category.forEach(function(element,index){ 
subCategoryObject = new Object();
subCategoryObject.main_category_id = "2";
subCategoryObject.sub_category_id = String(index+1);
subCategoryObject.sub_category_name = element;	
subCategoryArray.push(subCategoryObject);
});

//메인 카테고리 셋팅
var mainCategorySelectBox = $("select[name='mainCategory']");

for(var i=0;i<mainCategoryArray.length;i++){
mainCategorySelectBox.append("<option value='"+mainCategoryArray[i].main_category_id+"'>"+mainCategoryArray[i].main_category_name+"</option>");
}

//*********** 1depth카테고리 선택 후 2depth 생성 START ***********
$(document).on("change","select[name='mainCategory']",function(){

//두번째 셀렉트 박스를 삭제 시킨다.
var subCategorySelectBox = $("select[name='subCategory']");
subCategorySelectBox.children().remove(); //기존 리스트 삭제

//선택한 첫번째 박스의 값을 가져와 일치하는 값을 두번째 셀렉트 박스에 넣는다.
$("option:selected", this).each(function(){
var selectValue = $(this).val(); //main category 에서 선택한 값
subCategorySelectBox.append("<option value=''>전체</option>");
for(var i=0;i<subCategoryArray.length;i++){
if(selectValue == subCategoryArray[i].main_category_id){

subCategorySelectBox.append("<option value='"+subCategoryArray[i].sub_category_id+"'>"+subCategoryArray[i].sub_category_name+"</option>");

}
}
});

});

});


function clicks()
{
    var main_ctg = $("select[name='mainCategory'] option:selected").text();
    var selected_ctg = $("select[name='subCategory'] option:selected").text();


  if ( main_ctg == "패밀리레스토랑") 
  {  
    selected_ctg = "fa_m";
  } else if ( main_ctg == "간단메뉴" ) { selected_ctg = "simple_menu";
  } else if ( main_ctg == "전체" )
  {
     // 대분류 랜덤선택
     if ( Math.floor(Math.random() * 2) == 0 )
     {
       var obj = $("textarea[name=food]");
       selected_ctg = obj[Math.floor(Math.random() * obj.length)].id;
     } else { 
       var obj = $("textarea[name=pfood]");
       selected_ctg = obj[Math.floor(Math.random() * obj.length)].id;
     }
   } else {
     
      // 음식 & 가공음식
     if ( selected_ctg == "전체" )
     {
         var obj = $("select[name=subCategory]")[0];
         var rn = Math.floor(Math.random() * obj.length)+1;
         if ( rn == 31 || rn == 9 ) rn--;
        selected_ctg = obj[rn].innerText;
                  
       
     }
     
   }
   
  
var category = $('#'+selected_ctg).val();
  
  if ( category )
  { 
  category = category.split('\n');
  var food = category[Math.floor(Math.random() * category.length)];

  var auto_search = 'https://search.naver.com/search.naver?where=image&sm=tab_jum&query=' + food;
  $("#this_url").html(food + ' <b>이미지<b> ' + ' <a href="' + auto_search + '" target="_blank"> 네이버 검색결과</a>');
  $("#result_food").val(food);
  }

}
</script>