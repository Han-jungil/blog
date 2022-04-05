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
	
	//디버깅
	System.out.println("삭제액션번호요청값 : " + guestbookNo);
	System.out.println("삭제액션비번요청값 : " + guestbookPw);
	
	// 비번 이슈
	if(guestbookPw.equals("")) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
		return;
	}
	
	// 비지니스 로기직(모델계층)
	Guestbook guestbook = null;
	GuestbookDao guestbookDao = new GuestbookDao();// 넣을 곳에서 insertGuestbook메서드에(guestbook) 넣기
	int row = guestbookDao.deleteGuestbook(guestbookNo, guestbookPw);
	// 디버깅
	if(row == 1) { // 테이블 데이터 삭제 성공
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
		return;
		// 이동...
	} else {
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp");
		// 이동....
	}
	%>
