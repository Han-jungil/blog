<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");

	//페이지 설정
	int currentPage = 1; // 현재페이지의 기본값이 1페이지
	if(request.getParameter("currentPage") != null) { // 이전, 다음 링크를 통해서 들어왔다면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+ " <-- currentPage"); // 디버깅
	
	// 페이지 바뀌면 끝이 아니고, 가지고 오는 데이터가 변경되어야 한다.
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage; // 현재페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터 변경된다.
		
	// pdf 갯수를 반환 
	PdfDao pdfDao = new PdfDao();
	ArrayList<Pdf> list = pdfDao.selectPdfListByPage(beginRow, rowPerPage);
	
	// 검색
		String search =  request.getParameter("search");
		if(search != null &&!search.equals("")) {
				
			//요청값 받기
			String selectSearch = request.getParameter("selectSearch");
			search = request.getParameter("search");
							
			// 디버깅
			System.out.println("selectSearch "+selectSearch);
			System.out.println("selectSearch "+search);
						
			//요청값 넣기
			PdfDao pdfdao = new PdfDao();
			list = pdfdao.searchPdfListByPage(selectSearch, search, beginRow, rowPerPage);
		}
	
	// 전체 행의수
	int totalCount = pdfDao.selectPdfTotalRow();
	
	// 마지막페이지 설정
	int lastPage = 0;
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pdfList</title>
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
			<h1>pdf 목록(총 :<%=totalCount %> 개)</h1>
		<form action="<%=request.getContextPath()%>/pdf/pdfList.jsp" method="get">
		<div class= "row">
		<div class = "col-sm-4">
				<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/pdf/insertPdfForm.jsp">pdf 입력</a>
		</div>	
		<div class = "col-sm-8">
         <p class ="text-right"> 
			<select class="form-select" name="selectSearch">
				<option value="writer">글쓴이</option>
				<option value="originalName">pdf이름</option>
			</select>
			<input type="text" name="search">
			<button type="sumit" class="btn btn-dark">검색</button>
		</form>
		</p>
		</div>
		</div>
		<!-- 이미지 입력 -->
		<table  class="table table-hover">
			<thead>
				<tr>
					<td>pdf</td>
					<td>글쓴이</td>
					<td>작성날짜</td>
					<td>삭제여부</td>
				</tr>
			</thead>
			<tbody>
				<%
					for(Pdf p : list) {
				%>
					<tr>
						<td><%=p.getPdfOriginalName()%></td>
						<td><%=p.getWriter()%></td>
						<td><%=p.getCreateDate() %>
						<td><a class = "btn bg-dark text-white" href="<%=request.getContextPath()%>/pdf/deletePdfForm.jsp?pdfNo=<%=p.getPdfNo()%>&pdfName=<%=p.getPdfOriginalName() %>">삭제</a></td>
					</tr>
				<%
					}
				%>
			</tbody>
			</table>
			<!-- 이전,다음 페이지설정 -->
			<div class="btn-group">		
				<%
					if(currentPage > 1) { // 현재페이지가 1이면 이전페이지가 존재해서는 안된다.
				%>
						<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage-1%>">이전</a>&nbsp;&nbsp;&nbsp;
				<%	
					}
					if(currentPage < lastPage) { // 마지막페이지가 있다면 
				%>
						<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage+1%>">다음</a>&nbsp;&nbsp;&nbsp;
				<%		
					}
				%>
			</div>
			<!--  하단정보표시 -->
			<jsp:include page="/inc/bottomMenu.jsp"></jsp:include>
		</div>
	</div>
</div>
</body>
</html>