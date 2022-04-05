<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="java.sql.*" %>
<%@page import = "vo.*" %>
<%@page import ="dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");

	//요청값 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println( "수정폼No요청값 : " + boardNo); // 디버깅
	
	// 비지니스 로기직(모델계층)
	Board board = null;
	BoardDao boardDao = new BoardDao();// 넣을 곳에서 insertGuestbook메서드에(guestbook) 넣기
	board = boardDao.updateBoardOne(boardNo);
	
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
	<h1>글 수정</h1>
	<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
		<table class="table">
			<tr>
				<td>boardNo</td>
				<td><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>categroyName</td>
				<td>
					<select name="categoryName" class="form-select">
							<option value="독서">독서</option>
							<option value="등산">등산</option>
							<option value="만화">만화</option>
							<option value="맛집">맛집</option>
							<option value="여행">여행</option>
							<option value="요가">요가</option>
							<option value="요리">요리</option>
							<option value="자동차">자동차</option>
							<option value="컴퓨터">컴퓨터</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>boardTitle</td>
				<td><input type="text" name="boardTitle"  class="form-control" value=<%=board.getBoardTitle()%>></td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea rows="5" cols="50" name="boardContent" class="form-control"><%=board.getBoardContent()%></textarea>
				</td>
			<tr>	
				<td>boardPw</td>
				<td><input type="password" name="boardPw" class="form-control"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-dark">수정</button>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/board/boardList.jsp">뒤로</a>
	</form>
</div>
</body>
</html>