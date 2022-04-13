<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.sql.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");
	//요청값 받기
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	
	// 디버깅
	System.out.println("categoryName");
	System.out.println("boardTitle");
	System.out.println("boardContent");
	//null 이슈
	
%>
