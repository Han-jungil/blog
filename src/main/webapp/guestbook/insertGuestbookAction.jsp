<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="java.sql.*" %>
<%@page import = "vo.*" %>
<%@page import ="dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");
	
	
	//요청값 받기
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");
	
	// 디버깅
	System.out.println("writer");
	System.out.println("guestbookPw");
	System.out.println("guestbookContent");
	
	//null 이슈
	if(writer.equals("") || guestbookPw.equals("") || guestbookContent.equals("")) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	}
	
	//요청값 넣기
	Guestbook guestbook = new Guestbook();
	guestbook.setWriter(writer);
	guestbook.setGuestbookPw(guestbookPw);
	guestbook.setGuestbookContent(guestbookContent);
	
	// 비지니스 로기직(모델계층)
	GuestbookDao  guestbookDao = new GuestbookDao(); // 넣을 곳 변수선언
	guestbookDao.insertGuestbook(guestbook);	// 넣을 곳에서 insertGuestbook메서드에(guestbook) 넣기

	// 원래있던곳으로 돌아가기
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");


%>
