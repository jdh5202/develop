<%@page import="model.MemberDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../Header.jsp" />
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-12 text-center">
				<div class="col-sm-3"></div>

				<div class="col-sm-6">

					<%
						request.setCharacterEncoding("UTF-8"); //post 전달 방식일 경우 한글 처리
					%>
					<!--  useBean 을 이용하여 한꺼번에 데이터를 받아옴 -->
					<jsp:useBean id="mbean" class="model.MemberBean">
						<jsp:setProperty name="mbean" property="*" />
						<!--  맵핑 시키시오 -->
					</jsp:useBean>

		<%			
					
					//데이터 베이스클래스 객체 생성
					MemberDAO dao=new MemberDAO();
					if ( dao.insertMember(mbean) )
					{
						out.print("<script>alert('회원가입이 완료되었습니다.');");
						out.print("location.href='RentCarMain.jsp?center=MemberLogin.jsp';</script> ");
					} else { out.print("<script>alert('중복된 아이디입니다.');history.go(-1);</script>"); }
													
				
		%>
		
		<script>
				location.href="RentCarMain.jsp?center=MemberLogin.jsp";
			</script>

				</div>
			</div>
		</div>
	</div>


</body>
</html>







			