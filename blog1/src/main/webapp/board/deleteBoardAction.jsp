<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="java.sql.*" %>
<%@page import = "vo.*" %>
<%@page import ="dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");

	//요청값 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	//디버깅
	System.out.println( "삭제No요청값 : " + boardNo);
	System.out.println( "삭제Pw요청값 : " + boardPw);
	
	//비번 이슈
	if(boardPw.equals("")) {
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
		return;
	}
	
	// 비지니스 로기직(모델계층)
	Board board = null;
	BoardDao boardDao = new BoardDao(); 	// 넣을 곳에서 deleteBoard메서드에(board) 넣기
	int row = boardDao.deleteBoard(boardNo, boardPw);
	
	// 디버깅 및 삭제여부에 따라 페이지 이동
	if(row == 1) {
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
		return;
		// 이동...
	} else {
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/board/deleteBoardForm.jsp");
		// 이동...
	}
%>