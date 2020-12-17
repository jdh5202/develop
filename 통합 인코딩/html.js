<p style="text-align: center;"><b><span style="font-size: 12pt;"><img src="http://i1.daumcdn.net/deco/contents/emoticon/things_16.gif?v=2" border="0" class="txc-emo"></span></b><b><span style="font-size: 12pt; color: rgb(47, 157, 39);">입력창</span><span style="font-size: 12pt;"><img src="//i1.daumcdn.net/deco/contents/emoticon/things_16.gif?v=2" border="0" class="txc-emo"></span></b><br />
</p><form name="this_text"><textarea rows="2" cols="120" id="contents" placeholder="이 곳에 텍스트를 입력하세요." autofocus="" required="" wrap="hard">The command uses the Get-Alias cmdlet to get the aliases. It uses the pipeline operator (|) to send the aliases to the ConvertTo-Html cmdlet, which creates the HTML page.</textarea><br />

<table border="0">
<tbody><tr>
<td><input type="radio" name="chk_info" value="encode_mode" checked="">인코딩</td>
<td><input type="radio" name="chk_info" value="decode_mode">디코딩</td>
</tr></tbody></table> 

<input type="button" value="실행" onclick="execute()">
<input type="button" value="초기화" onclick="reset_but()"><br />

<table border="0">
<tbody>
<tr><td><font color="blue"><b>■ Base64 ■</b></font></td>
<td><textarea rows="2" cols="95" id="result_content1" placeholder="" autofocus="" required="" wrap="hard"></textarea></td><td><input type="button" id="but1" value="복사"><br /><input type="button" id="move1" value="Go"></td></tr>
  
<tr><td><font color="blue"><b>■ URL ■</b></font></td>
<td><textarea rows="2" cols="95" id="result_content2" placeholder="" autofocus="" required="" wrap="hard"></textarea></td><td><input type="button" id="but2" value="복사"><br /><input type="button" id="move2" value="Go"></td></tr>
  
<tr><td><font color="blue"><b>■ ALL_URL ■</b></font></td>
<td><textarea rows="2" cols="95" id="result_content3" placeholder="" autofocus="" required="" wrap="hard"></textarea></td><td><input type="button" id="but3" value="복사"><br /><input type="button" id="move3" value="Go"></td></tr>
  
<tr><td><font color="blue"><b>■ HTML ■</b></font></td>
<td><textarea rows="2" cols="95" id="result_content4" placeholder="" autofocus="" required="" wrap="hard"></textarea></td><td><input type="button" id="but4" value="복사"><br /><input type="button" id="move4" value="Go"></td></tr>
  
<tr><td><font color="blue"><b>■ Hex ■</b></font></td>
<td><textarea rows="2" cols="95" id="result_content5" placeholder="" autofocus="" required="" wrap="hard"></textarea></td><td><input type="button" id="but5" value="복사"><br /><input type="button" id="move5" value="Go"></td></tr>

<tr><td><font color="blue"><b>■ Unicode ■</b></font></td>
<td><textarea rows="2" cols="95" id="result_content6" placeholder="" autofocus="" required="" wrap="hard"></textarea></td><td><input type="button" id="but6" value="복사"><br /><input type="button" id="move6" value="Go"></td></tr>
  
<tr><td><font color="blue"><b>■ Ascii ■</b></font></td>
<td><textarea rows="2" cols="95" id="result_content7" placeholder="" autofocus="" required="" wrap="hard"></textarea></td><td><input type="button" id="but7" value="복사"><br /><input type="button" id="move7" value="Go"></td></tr>

</tbody>
</table>
</form>