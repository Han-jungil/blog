<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");

	// 요청값 가져오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println("boardNo : " + boardNo);	//디버깅
	
	// 생성자 메서드에 넣기 및 들어갈 변수 만들기
	Board board = new Board();
	BoardDao boardDao = new BoardDao();// 넣을 곳에서 insertGuestbook메서드에(guestbook) 넣기
	board = boardDao.updateBoardOne(boardNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">	
	<h1>board 상세보기</h1>
	<table class="table">
		<tr>
			<td>boardNo</td>
			<td><%=board.getBoardNo()%></td>
		</tr>
		<tr>
			<td>categoryName</td>
			<td><%=board.getCategoryName()%></td>
		</tr>
		<tr>
			<td>boardTitle</td>
			<td><%=board.getBoardTitle()%></td>
		</tr>
		<tr>
			<td>boardContent</td>
			<td><%=board.getBoardContent()%></td>
		</tr>
		<tr>
			<td>boardPw</td>
			<td><%=board.getBoardPw()%></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td><%=board.getCreateDate()%></td>
		</tr>
		<tr>
			<td>updateDate</td>
			<td><%=board.getUpdateDate()%></td>
		</tr>
	</table>
	<div class="btn-group">
		<li class="page-item"><a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>">수정</a></li>&nbsp&nbsp&nbsp
		<li class="page-item"><a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=board.getBoardNo()%>">삭제</a></li>
	</div>
</div>
</body>
</html>