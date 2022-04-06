<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "java.util.ArrayList" %>
<%
	//페이지 설정
	int currentPage = 1;	// 현재페이지의 기본값이 1페이지
	if(request.getParameter("currentPage") != null) { // 이전, 다음 링크를 통해서 들어왔다면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+ " <-- currentPage");
	
	// 페이지 바뀌면 끝이 아니고, 가지고 오는 데이터가 변경되어야 한다.
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;	// 현재페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터 변경된다.
	
	// guestbook 갯수를 반환
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	
	// 라스트페이지 설정
	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 4.0 / 2.0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- 메인 메뉴 -->
	<!-- 상단메뉴 -->
	<div class= "row">
		<div class="col-sm-10 bg-secondary text-white">
			<tr>[스마트혼합]공공데이터 융합자바/스프링 개발자 양성과정(19회차) &nbsp&nbsp Teacher : P.SungHwan &nbsp&nbsp Manager : L.SunMin</tr>
			<tr><jsp:include page="/inc/upMenu.jsp"></jsp:include></tr>
		</div>
	</div>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. 내부에서 요청하여 페이지에 넣는다. -->
	<!-- 메인 메뉴 끝-->

	<!-- 좌측메뉴+메인 -->
	<div class= "row">
	<!--  좌측메뉴 -->
	<div class="col-sm-2 bg-dark">
	</div>
	<!-- 게시글 리스트(메인) -->
		<div class="col-sm-8">
			<!--  배너 -->
			<div class="mt-4 p-5 bg-dark text-white rounded">
				<h1>구디아카데미</h1>
				<p>GDJ46기 블로그과제</p>
			</div>
			<h1>방명록 목록(총 :<%=totalCount %> 개)</h1>
		<!-- 방명록 입력 -->
		<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
			<button type="submit" class="btn-dark">방명록 입력</button>
			<table border="1" class="table">
				<tr>
					<td>글쓴이</td>
					<td><input type="text" name="writer" class="form-control"></td>
					<td>비밀번호</td>
					<td><input type="password" name="guestbookPw" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="4"><textarea name="guestbookContent" rows="2" cols="60" class="form-control"></textarea></td>
				</tr>
			</table>
			
		</form>
		<% 
			for(Guestbook g : list) {
		%>
				<table border="1" class="table">
					<tr>
						<td><%=g.getWriter()%></td>
						<td><%=g.getCreateDate()%></td>
					</tr>
					<tr>
						<td colspan="2"><%=g.getGuestbookContent()%></td>
					</tr>
				</table>
				<div>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/guestbook/selectGuestbookOne.jsp?guestbookNo=<%=g.getGuestbookNo()%>&guestbookContent=<%=g.getGuestbookContent()%>">수정</a>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>">삭제</a>
				
		<%	
			}
		%>
		</div>
		<%
		if(currentPage > 1) {
		%>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%		
		}
		
		if(currentPage < lastPage) {
		%>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
		}
		%>
		<!--  하단정보표시 -->
		<jsp:include page="/inc/bottomMenu.jsp"></jsp:include>
	</div>
</div>
</body>
</html>