<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="java.sql.*" %>
<%@page import = "vo.*" %>
<%@page import ="dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");
	
	//요청값 받기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");
	
	//디버깅
	System.out.println("수정번호요청값 : " + guestbookNo);
	System.out.println("수정비번요청값 : " + guestbookPw);
	System.out.println("수정내용요청값 : " + guestbookContent);
	
	// 비번 이슈
	if( guestbookContent.equals("")) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
		return;
	}
	
	//요청값 넣기
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setGuestbookPw(guestbookPw);
	guestbook.setGuestbookContent(guestbookContent);
	
	// 비지니스 로기직(모델계층)
	GuestbookDao  guestbookDao = new GuestbookDao(); // 넣을 곳 변수선언
	int row = guestbookDao.updateGuestbook(guestbook);
	
	if(row == 1) { // 테이블 데이터 삭제 성공
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
		return;
		// 이동...
	} else {
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp");
		// 이동....
	}
%>
