<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="java.sql.*" %>
<%@page import = "vo.*" %>
<%@page import ="dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");
	
	//요청값 받기
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	
	// 디버깅
	System.out.println("categoryName");
	System.out.println("boardTitle");
	System.out.println("boardContent");
	System.out.println("boardPw");
	
	//null 이슈
	if(categoryName.equals("") || boardTitle.equals("") || boardContent.equals("") || boardPw.equals("")) {
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	}
	
	//요청값 넣기
	Board board = new Board();
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	board.setBoardPw(boardPw);
	
	// 비지니스 로기직(모델계층)
	BoardDao boardDao = new BoardDao(); // 넣을 곳 변수선언
	boardDao.insertBoard(board);	// 넣을 곳에서 insertBoard메서드에(board) 넣기
	
	// 원래있던곳으로 돌아가기
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>