<form>
    <div>
        패스워드 길이 <select name="passwordLength" id="passwordLength">
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8" selected="">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
            <option value="19">19</option>
            <option value="20">20</option>
            <option value="21">21</option>
            <option value="22">22</option>
        </select>
    </div>
    <div>
        <label for="special_characters">특수문자 포함</label>
        <input type="checkbox" name="special_characters" id="special_characters">
    </div>
</form>
<div class="clear">&nbsp;</div>
<input type="button" id="generate_password" name="generate_password" value="패스워드 생성">
<div class="clear">&nbsp;</div>
<div id="new-password"></div>

<script>
var charSet1 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
var charSet2 = '^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>';
var objPasswordLength = document.getElementById('passwordLength');
var objSpecialCharactes = document.getElementById('special_characters');
var strResult = '';

var btnGeneratePassword = document.getElementById('generate_password');
btnGeneratePassword.addEventListener('click', generatePassword, false);

function generatePassword() {
    document.getElementById('new-password').innerHTML = '';
    strResult='';
    if (objPasswordLength.value >= 1) {
        passwordLength = objPasswordLength.value;
        if (objSpecialCharactes.checked) {
            charSet2 = charSet1 + charSet2;
            for (i = 0; i < passwordLength; i++) {
                strResult += charSet2.charAt(Math.floor(Math.random() * charSet2.length));
            }
        } else {
            for (i = 0; i < passwordLength; i++) {
                strResult += charSet1.charAt(Math.floor(Math.random() * charSet1.length));
            }
        }

        document.getElementById('new-password').innerHTML = '생성된 패스워드: <font color="blue">'+ strResult+ '</font>';

    } else {
        alert('Please select a password length!');
    }
}
</script>

