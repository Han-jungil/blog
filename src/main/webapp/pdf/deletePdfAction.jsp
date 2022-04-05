<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="java.sql.*" %>
<%@page import = "vo.*" %>
<%@page import ="dao.*" %>
<%@ page import = "java.io.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");

	//요청값 받기
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	String pdfName  = request.getParameter("pdfName");
	String pdfPw = request.getParameter("pdfPw");
	
	//디버깅
	System.out.println( "삭제No요청값 : " + pdfNo);
	System.out.println( "삭제Pw요청값 : " + pdfPw);
	System.out.println( "삭제Pw요청값 : " + pdfName);
	
	//비번 이슈
	if(pdfPw.equals("")) {
		response.sendRedirect(request.getContextPath()+"/pdf/deletePdfForm.jsp");
		return;
	}
	
	// 비지니스 로기직(모델계층)
	// 1) 테이블 데이터 삭제 <-pdfNo 필요
	Pdf pdf = null;
	PdfDao pdfDao = new PdfDao();
	pdfDao.deletePdf(pdfNo, pdfPw);
	
	// 1) 테이블 데이터 삭제
	int delRow = pdfDao.deletePdf(pdfNo, pdfPw);
	// 2) 폴더 이미지 삭제
		if(delRow == 1) { // 테이블 데이터 삭제 성공
			String path = application.getRealPath("pdfupload"); // application(현재프로젝트)안의 upload폴더의 실제 폴더경로를 반환
			File file = new File(path+"\\"+pdfName); // 이미지 파일을 불러온다. java.io.File  
			file.delete(); // 이미지 파일을 삭제
			response.sendRedirect(request.getContextPath()+"/pdf/pdfList.jsp");
			return;
			// 이동...
		} else {
			System.out.println("삭제 실패!");
			response.sendRedirect(request.getContextPath()+"/pdf/deletepdfForm.jsp");
			// 이동....
		}
%>
