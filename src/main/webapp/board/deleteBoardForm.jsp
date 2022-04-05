<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//요청값 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println( "값넘어오는거 확인 : " + boardNo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteBoardForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
	<h1>글 삭제</h1>
	<form method="post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
		<div>번호 : <input type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly"></div>
		<div>비밀번호 : <input type="password" name="boardPw"></div>
		<div>
			<button type="submit" class="btn btn-dark">삭제</button>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/board/boardList.jsp">뒤로</a>
		</div>
	</form>
</div>
</body>
</html>