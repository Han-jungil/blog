<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import ="dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");

	//요청값 받기
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	String pdfName = request.getParameter("pdfName");
	//디버깅
	System.out.println("번호요청값 : " + pdfNo);
	System.out.println("번호요청값 : " + pdfName);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePdfForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
	<h1>pdf 삭제</h1>
	<form  method="post" action="deletePdfAction.jsp">
		<div>번호 : <input type="text" name="pdfNo" value="<%=pdfNo%>" readonly="readonly"></div>
		<div>이름 : <input type="text" name="pdfName" value="<%=pdfName%>" readonly="readonly"></div>
		<div>비밀번호 : <input type="password" name="pdfPw"></div>
		<div>
			<button type="submit" class="btn btn-dark">삭제</button>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/pdf/pdfList.jsp">뒤로</a>
		</div>
	</form>
</div>
</body>
</html>