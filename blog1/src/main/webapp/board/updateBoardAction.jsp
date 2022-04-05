<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="java.sql.*" %>
<%@page import = "vo.*" %>
<%@page import ="dao.*" %>
<% 
// 한글 나오게하기
	request.setCharacterEncoding("utf-8");
	// 요청값 받아오기
	int boardNo= Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	String updateDate = request.getParameter("updateDate");
	
	//디버깅
	System.out.println(boardNo);
	System.out.println(categoryName);
	System.out.println(boardTitle);
	System.out.println(boardContent);
	System.out.println(boardPw);
	System.out.println(updateDate);
	
	// 넘어온 요청값 하나의 변수로
	Board board = new Board();		
	board.setBoardNo(boardNo);				//번호
	board.setCategoryName(categoryName);	//이름
	board.setBoardTitle(boardTitle);		//제목	
	board.setBoardContent(boardContent);	//내용
	board.setBoardPw(boardPw);				//비밀번호
	board.setUpdateDate(updateDate);		//수정날짜
	
	// 비지니스 로기직(모델계층)
	BoardDao boardDao = new BoardDao(); // 넣을 곳 변수선언
	int row = boardDao.updateBoard(board);	// 넣을 곳에서 updateBoard메서드에(board) 넣기
	
	// 디버깅 및 삭제여부에 따라 페이지 이동
	if(row == 1) {
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
		return;
		// 이동...
	} else {
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp");
		// 이동...
	}
%>
