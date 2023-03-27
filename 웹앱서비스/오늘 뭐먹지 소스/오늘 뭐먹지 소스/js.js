<script>
$(document).ready(function() {

//Main ī�װ��� ���� �Ҷ� ���� AJAX�� ȣ���� �� ������ DB������ �Ź� �ؾ� �ϱ� ������ main, subī�װ� ��ü�� ���´�.

//****************�̺κ��� DB�� �����ϼ���.
//Main ī�װ� ���� (DB���� ���� ������ ���� �ϼ���.)
var mainCategoryArray = new Array();
var mainCategoryObject = new Object();
var subCategoryArray = new Array();
var subCategoryObject = new Object();

var top_category = [ "����" , "������ǰ" , "�йи��������","���ܸ޴�"];
var food_category = ["���","��-���ڷ�","��-���η�","��-������","��-����","�-�����","���","���̷�","��-��ħ��","������","������","Ƣ���","����-��ä��","��ä-��ħ��","��ġ��","������","�����-���ӷ�","����ǰ��-������","����-����","���Ϸ�","���","���-����-��ǰ","����������","�ܹ���","����","����","���̽�ũ��","�н�","����","����"];

var profood_category = ["���ڷ�","��-����","���ھư���ǰ��-���ݸ���","���","Ŀ��","����-ä�ҷ�����","������","�Ｎ����-���ǽ�ǰ��"];

// ��ü�޴�
top_category.forEach(function(element,index){

mainCategoryObject = new Object();
mainCategoryObject.main_category_id = String(index+1);
mainCategoryObject.main_category_name = element;
mainCategoryArray.push(mainCategoryObject);
});

// ���ĸ޴�
food_category.forEach(function(element,index){ 
subCategoryObject = new Object();
subCategoryObject.main_category_id = "1";
subCategoryObject.sub_category_id = String(index+1);
subCategoryObject.sub_category_name = element;	
subCategoryArray.push(subCategoryObject);
});

// ������ǰ�޴�
profood_category.forEach(function(element,index){ 
subCategoryObject = new Object();
subCategoryObject.main_category_id = "2";
subCategoryObject.sub_category_id = String(index+1);
subCategoryObject.sub_category_name = element;	
subCategoryArray.push(subCategoryObject);
});

//���� ī�װ� ����
var mainCategorySelectBox = $("select[name='mainCategory']");

for(var i=0;i<mainCategoryArray.length;i++){
mainCategorySelectBox.append("<option value='"+mainCategoryArray[i].main_category_id+"'>"+mainCategoryArray[i].main_category_name+"</option>");
}

//*********** 1depthī�װ� ���� �� 2depth ���� START ***********
$(document).on("change","select[name='mainCategory']",function(){

//�ι�° ����Ʈ �ڽ��� ���� ��Ų��.
var subCategorySelectBox = $("select[name='subCategory']");
subCategorySelectBox.children().remove(); //���� ����Ʈ ����

//������ ù��° �ڽ��� ���� ������ ��ġ�ϴ� ���� �ι�° ����Ʈ �ڽ��� �ִ´�.
$("option:selected", this).each(function(){
var selectValue = $(this).val(); //main category ���� ������ ��
subCategorySelectBox.append("<option value=''>��ü</option>");
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


  if ( main_ctg == "�йи��������") 
  {  
    selected_ctg = "fa_m";
  } else if ( main_ctg == "���ܸ޴�" ) { selected_ctg = "simple_menu";
  } else if ( main_ctg == "��ü" )
  {
     // ��з� ��������
     if ( Math.floor(Math.random() * 2) == 0 )
     {
       var obj = $("textarea[name=food]");
       selected_ctg = obj[Math.floor(Math.random() * obj.length)].id;
     } else { 
       var obj = $("textarea[name=pfood]");
       selected_ctg = obj[Math.floor(Math.random() * obj.length)].id;
     }
   } else {
     
      // ���� & ��������
     if ( selected_ctg == "��ü" )
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
  $("#this_url").html(food + ' <b>�̹���<b> ' + ' <a href="' + auto_search + '" target="_blank"> ���̹� �˻����</a>');
  $("#result_food").val(food);
  }

}
</script>