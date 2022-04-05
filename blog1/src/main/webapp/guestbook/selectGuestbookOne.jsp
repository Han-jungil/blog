<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import ="dao.*" %>
<% 
	//한글호환
	request.setCharacterEncoding("utf-8");
	
	//요청값 받기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	
	//디버깅
	System.out.println("번호요청값 : " + guestbookNo);

	// 생성자 메서드에 넣기 및 들어갈 변수 만들기
	Guestbook guestbook = null;
	GuestbookDao guestbookDao = new GuestbookDao();// 넣을 곳에서 insertGuestbook메서드에(guestbook) 넣기
	guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">	
	<h1>방명록 수정</h1>
	<form method="post" action="updateGuestbookAction.jsp">
	<table  border="1" class="table">
		<tr>
			<td>guestbookNo</td>
			<td><input type="text" name="guestbookNo" value="<%=guestbook.getGuestbookNo()%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>guestbookContent</td>
			<td>
				<textarea rows="5" cols="50" name="guestbookContent" class="form-control"><%=guestbook.getGuestbookContent()%></textarea>
			</td>
		<tr>	
		<tr>
			<td>guestbookPw</td>
			<td><input type="password" name="guestbookPw" class="form-control"></td>
		</tr>
	</table>
	<button type="submit" class="btn btn-dark">수정</button>
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/guestbookList.jsp">뒤로</a>
	</form>
</div>
</body>
</html>

