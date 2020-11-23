<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="container marketing" id="marketing2">
   <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="col-sm-3"></div>
	  <div class="col-sm-6"> 	
			<h2></h2>
			<div class="table-responsive">
    <h2 class="text-center">회원가입</h2>
	<form action="RentCarMain.jsp?center=member/MemberJoinProc.jsp" method="post">
		<table class="table table-boardered">
			<tr>
				<th>아이디</th>
				<td><input type="text" class="form-control" name="id" placeholder="id를 넣으세요"></td>		
			</tr>
			<tr>
				<th>패스워드</th>
				<td><input type="password" class="form-control" name="pass1" placeholder="비밀번호는 영문만 넣어주세요"></td>		
			</tr>
			
			<tr>
				<th>패스워드확인</th>
				<td><input type="password" class="form-control" name="pass2"></td>		
			</tr>
			
			<tr>
				<th>이메일</th>
				<td><input type="email" class="form-control" name="email"></td>		
			</tr>
			
			<tr>
				<th>전화번호</th>
				<td><input type="tel" class="form-control" name="tel"></td>		
			</tr>
			
			<tr>
				<th>나이</th>
				<td>
				<input type="radio"  name="age" value="20">20대 &nbsp;&nbsp;
				<input type="radio"  name="age" value="30">30대 &nbsp;&nbsp;
				<input type="radio"  name="age" value="40"  checked="checked">40대 &nbsp;&nbsp;
				<input type="radio"  name="age" value="50">50대 이상 &nbsp;&nbsp;
				</td>		
			</tr>
			
			<tr>
				<th>프로필 소개</th>
				<td>
				 <textarea rows="5" cols="40" name="info" class="form-control">Macaronics:</textarea>
				</td>		
			</tr>
			
			<tr>
				<td colspan="2" class="text-center">
				<input type="submit" class="btn btn-primary" value="전송">
				<input type="reset" class="btn btn-danger" value="취소">
				</td>
			</tr>
			
		</table>
	</form>	

			</div>
	  </div>

 </div>
</div>

