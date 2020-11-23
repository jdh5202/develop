<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
<jsp:include page="Header.jsp" />
  </head>
<body>

	<div align="center" style="margin-top:110px;">
		<img src="img/event.jpg"  class="img-responsive img-rounded">
			<pre style="margin-left:500px;margin-right:500px;">sm 렌터카 첫 대여시 전지점 20% 할인 쿠폰이 증정됩니다.<br>아래에 이벤트/쿠폰을 남겨주시면 다음 결제 시 할인이 적용됩니다.</pre>
	</div>

	<div style="margin-top:50px;">
	<h2 class="text-center">이벤트/쿠폰 등록</h2>
	</div>
	
		<div style="margin-left:300px;margin-right:300px;">
		<form action="CarEventProc.jsp" enctype="multipart/form-data" method="post">
		<table class="table">
		   <tr>
		     <td>이름</td>
		     <td><input type="text" name="name" class="form-control"></td>
		   </tr>
			<tr>
			  <td>이벤트/쿠폰</td>
			  <td><input type="file" name="filedata" class="form-control"> </td>
			</tr>
			<tr>
			  <td class="text-center" colspan="2"><input type="submit" value="등록" class="btn btn-success"></td>
			</tr>
		</table>
	    </form>
	   <div>






</body>
</html>