<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");

	//0) 요청값 가져오기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	System.out.println("photoNo : " + photoNo);	//디버깅
	
	// 생성자 메서드에 넣기 및 들어갈 변수 만들기
	Photo photo = new Photo();
	PhotoDao photoDao = new PhotoDao();// 넣을 곳에서 insertGuestbook메서드에(guestbook) 넣기
	photo = photoDao.selectPhotoOne(photoNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">	
	<h1>photo 상세보기</h1>
	<table class="table">
		<img src="<%=request.getContextPath()%>/upload/<%=photo.getPhotoName() %>" width="1000" height="500">
		<tr>
			<td>photoNo</td>
			<td><%=photo.getPhotoNo()%></td>
		</tr>
		<tr>
			<td>writer</td>
			<td><%=photo.getWriter()%></td>
		</tr>
		<tr>
			<td>photoCategoryName</td>
			<td><%=photo.getPhotoCategoryName()%></td>
		</tr>
		<tr>
			<td>photoName</td>
			<td><%=photo.getPhotoName()%></td>
		</tr>
		<tr>
			<td>photoOriginalName</td>
			<td><%=photo.getPhotoOriginalName()%></td>
		</tr>
		<tr>
			<td>photoType</td>
			<td><%=photo.getPhotoType()%></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td><%=photo.getCreateDate()%></td>
		</tr>
		<tr>
			<td>updateDate</td>
			<td><%=photo.getUpdateDate()%></td>
		</tr>
	</table>
	<div class="btn-group">
		<li class="page-item"><a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/photo/photoList.jsp">뒤로</a></li>&nbsp&nbsp&nbsp
		<li class="page-item"><a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photo.getPhotoNo()%>&photoName=<%=photo.getPhotoName()%>">삭제</a></li>
	</div>
</div>
</body>
</html>