<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import ="dao.*" %>
<%@ page import = "java.io.*" %>
<%
	
	//한글호환
	request.setCharacterEncoding("utf-8");

	//요청값 받기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoName  = request.getParameter("photoName");
	String photoPw = request.getParameter("photoPw");
	
	//디버깅
	System.out.println( "삭제No요청값 : " + photoNo);
	System.out.println( "삭제Name요청값 : " + photoName);
	System.out.println( "삭제Pw요청값 : " + photoPw);
	
	//비번 이슈
	if(photoPw.equals("")) {
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp");
		return;
	}
	
	// 비지니스 로기직(모델계층)
	// 1) 테이블 데이터 삭제 <-photNo 필요
	Photo photo = null;
	PhotoDao photoDao = new PhotoDao();
	photoDao.deletePhoto(photoNo, photoPw);
	// 1) 테이블 데이터 삭제
	int delRow = photoDao.deletePhoto(photoNo, photoPw);
	// 2) 폴더 이미지 삭제
		if(delRow == 1) { // 테이블 데이터 삭제 성공
			String path = application.getRealPath("upload"); // application(현재프로젝트)안의 upload폴더의 실제 폴더경로를 반환
			File file = new File(path+"\\"+photoName); // 이미지 파일을 불러온다. java.io.File  
			file.delete(); // 이미지 파일을 삭제
			response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
			return;
			// 이동...
		} else {
			System.out.println("삭제 실패!");
			response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp");
			// 이동....
		}
%>