<script>
// init
$(document).ready(function () {
  $("#input_area").text(`
   #include <stdio.h>
 
   void printmessage(int n)
   {
    if (n % 2 == 0) {
        printf("EVEN");
    }
    else if (n % 2 == 1) {
        printf("ODD");
    }
    else printf("error");
   }
 
   int main()
   {
    int n;
    scanf_s("%d", &n);
 
    printmessage(n);
   }
   `);

  $("#valid_chrs").val("[]{}()<>");
  valid_chk($("#input_area").val());
  $("#input_area").focus();
});

//
$("#input_area").on("change keyup paste", function () {
  valid_chk($("#input_area").val());
});

$("#valid_chrs").on("change keyup paste", function () {
  valid_chk($("#input_area").val());
});

let glob_stack;
let isBalanced = (valid_chr, input) => {
  let brackets = valid_chr; // []{}()<>
  let stack = [];

  for (let bracket of input) {
    let bracketsIndex = brackets.indexOf(bracket);

    if (bracketsIndex === -1) {
      continue;
    }

    if (bracketsIndex % 2 === 0) {
      stack.push(bracketsIndex + 1);
    } else {
      if (stack.pop() !== bracketsIndex) {
        glob_stack = valid_chr[bracketsIndex];
        return false;
      }
    }
  }
  //  false after pop
  if (stack.length > 0) {
    let len = stack.length;
    for (let i = 0; i < len; i++) {
      glob_stack = valid_chr[stack.pop() - 1];
    }
    return false;
  }

  return stack.length === 0;
};

let valid_chr = () => {
  return $("#valid_chrs").val();
};

let valid_chk = (input) => {
  if (input) {
    let result = isBalanced(valid_chr(), input);
    let res_text;

    if (result == true) res_text = "<font color=blue><b>Valid</b></font>";
    else res_text = "<b><font color=red>Invalid</font> " + glob_stack + "</b>";

    $("#valid_res").html(res_text);
  } else {
    $("#valid_res").html("");
  }
};

</script>