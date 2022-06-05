<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@page import ="dao.*" %>
<%
	//한글호환
	request.setCharacterEncoding("utf-8");

	// 페이지 설정
		// boardList페이지 실행하면 최근 10개의 목록을 보요주고 1page로 설정
		int currentPage = 1; // 현재페이지의 기본값이 1페이지
		if(request.getParameter("currentPage") != null) { // 이전, 다음 링크를 통해서 들어왔다면
   			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		System.out.println(currentPage+ " <-- currentPage");	// 디버깅
		
		// 이전,다음링크에서 null값을 넘기는 것이 불가능하여 null을 ""으로 바꾸고 치환하고 null이 아니면 다시 원래 있는 카테고리를 넣는다.
		String categoryName = "";
		if(request.getParameter("categoryName") != null) {
			categoryName = request.getParameter("categoryName");
		}
		
		// 페이지 바뀌면 끝이 아니고, 가지고 오는 데이터가 변경되어야 한다.
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage")!= null){//rowPerPage가 null이 아니면 요청값 저장
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		int beginRow = (currentPage-1)*rowPerPage; // 현재페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터 변경된다.
  		
		// 케테고리별 갯수를 반환 
		BoardDao boardDao = new BoardDao();
		ArrayList<HashMap<String, Object>> categoryList = boardDao.categoryBoardTotalRow(categoryName);
		
		
		// 카테고리별 행의 수
		boardDao = new BoardDao();
		ArrayList<Board> list = boardDao.selectBoardListByPage(categoryName, beginRow, rowPerPage);
		
		// 검색
			String search =  request.getParameter("search");
			if(search != null &&!search.equals("")) {
				categoryName = "";
	
				//요청값 받기
				categoryName = request.getParameter("categoryName");
				String selectSearch = request.getParameter("selectSearch");
				search = request.getParameter("search");
				
				// 디버깅
				System.out.println("selectSearch "+categoryName);
				System.out.println("selectSearch "+selectSearch);
				System.out.println("selectSearch "+search);
				
				//요청값 넣기
				boardDao = new BoardDao();
				list = boardDao.searchBoardListByPage(selectSearch, search, categoryName, beginRow, rowPerPage);
			}
		
		// 전체 행의수
		int totalCount = boardDao.boardTotalRow();
		
		// 마지막페이지 설정
		int lastPage = 0;
		lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- category별 게시글 링크 메뉴 -->
<div class="container">
	<!-- 상단메뉴 -->
	<!-- 상단메뉴 -->
	<div class= "row">
		<div class="col-sm-10 bg-secondary text-white">
			<tr>[스마트혼합]공공데이터 융합자바/스프링 개발자 양성과정(19회차) &nbsp&nbsp Teacher : P.SungHwan &nbsp&nbsp Manager : L.SunMin</tr>
			<tr><jsp:include page="/inc/upMenu.jsp"></jsp:include></tr>
		</div>
	</div>
	<!-- 좌측메뉴+메인 -->
	<div class= "row">
	<!--  좌측메뉴 -->
			<div class="col-sm-2 bg-dark">
				<ul class="list-group">
					<div>&nbsp;</div>
					<div>&nbsp;</div>
					<div>&nbsp;</div>
					<div>&nbsp;</div>
					<div>&nbsp;</div>
					<div>&nbsp;</div>
					<div>&nbsp;</div>
					<div>&nbsp;</div>
					<h4 class="text-white"> category메뉴 </h4>			
					<%
						for(HashMap<String, Object> m : categoryList) {
					%>
							<li class="list-group-item">
								<a class="btn btn-bg-dark" href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%><span class="badge btn-primary"><%=m.get("cnt")%></span></a>
							</li>
					<%
							}
					%>
				</ul>
			</div>
		<!-- 게시글 리스트(메인) -->
		<div class="col-sm-8">
     	<!--  배너 -->
      <div class="mt-4 p-5 bg-dark text-white rounded">
      	 	<h1>구디아카데미</h1>
			<p>GDJ46기 블로그과제</p>
      </div>
      <div class="row">
      		<div class = "col-sm-8">
      			<h1>게시글 목록(총 : <%=totalCount %>개)</h1>
      		</div>
      		<div class = "col-sm-4">
      		<div>&nbsp;</div>
	      		<form method ="post" action ="<%=request.getContextPath()%>/board/boardList.jsp">
		      	게시글 : <%=rowPerPage %>개
		       	<select name="rowPerPage" onchange="this.form.submit()">
		       		<option value="">범위선택</option>
		       		<option value="5" >5개씩</option>
		       		<option value="10">10개씩</option>
		       		<option value="15">15개씩</option>
		       		<option value="20">20개씩</option>
		       		<option value="25">25개씩</option>
		       		<option value="30">30개씩</option>
		       		<input type="hidden" name="currentPage" value="<%=currentPage%>">
		       	</select>
		     </form>
	     </div>
      </div>
      <form action="<%=request.getContextPath()%>/board/boardList.jsp" method="get">
      <div  class="row">
      <div class = "col-sm-4">
      	 <a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/board/insertBoardForm.jsp">게시글 입력</a>
      </div>
      <div class = "col-sm-8">
         <p class ="text-right"> 
            <select class="form-select" name="categoryName">
            <option value="">전체</option>
                  <%
                     for(HashMap<String, Object> m : categoryList) {
                  %>
                           <option><%=m.get("categoryName")%></option>
                  <%
                     }
                  %>
            </select>
            <select class="form-select" name="selectSearch">
               <option value="boardTitle">제목</option>
               <option value="boardContent">내용</option>
               <option value="boardTitleContent">제목+내용</option>
            </select>
            <input type="text" name="search">
            <button type="submit" class="btn btn-dark">검색</button>
         </p>
      </div>
      </div>
      </form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>categoryName</th>
					<th>boardtitle</th>
					<th>createDate</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Board b : list) {
				%>
						<tr>
							<td><%=b.getCategoryName()%></td>
							<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
							<td><%=b.getCreateDate()%></td>
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
					<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>&nbsp&nbsp&nbsp
			<%	
				}
				for(int i = currentPage; i < currentPage+10; i++) {
				if(i <= lastPage ) {
			%>
				
				<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=i%>&categoryName=<%=categoryName%>"><%=i%></a>&nbsp&nbsp&nbsp
			<%
					}
				}
			%>
			<%
				if(currentPage < lastPage) { // 마지막페이지가 있다면 
			%>
					<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">다음</a>&nbsp&nbsp&nbsp
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