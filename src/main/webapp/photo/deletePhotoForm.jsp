<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import ="dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");
	
	//요청값 받기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoName = request.getParameter("photoName");
	
	//디버깅
	System.out.println("번호요청값 : " + photoNo);
	System.out.println("이름요청값 : " + photoName);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePhotoForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
	<h1>이미지 삭제</h1>
	<form  method="post" action="deletePhotoAction.jsp">
		<div>번호 : <input type="text" name="photoNo" value="<%=photoNo%>" readonly="readonly"></div>
		<div>이름 : <input type="text" name="photoName" value="<%=photoName %>" readonly="readonly"></div>
		<div>비밀번호 : <input type="password" name="photoPw"></div>
		<div>
			<button type="submit" class="btn btn-dark">삭제</button>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/photo/photoList.jsp">뒤로</a>
		</div>
	</form>
</div>
</body>
</html>
</body>
</html>