<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//페이지 설정
	// boardList페이지 실행하면 최근 10개의 목록을 보요주고 1page로 설정
	int currentPage = 1; // 현재페이지의 기본값이 1페이지
	if(request.getParameter("currentPage") != null) { // 이전, 다음 링크를 통해서 들어왔다면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+ " <-- currentPage"); // 디버깅
	
	// 이전,다음링크에서 null값을 넘기는 것이 불가능하여 null을 ""으로 바꾸고 치환하고 null이 아니면 다시 원래 있는 카테고리를 넣는다.
	String photoCategoryName = "";
	if(request.getParameter("photoCategoryName") != null) {
		photoCategoryName = request.getParameter("photoCategoryName");
	}
	
	// 페이지 바뀌면 끝이 아니고, 가지고 오는 데이터가 변경되어야 한다.
	int rowPerPage = 9;
	int beginRow = (currentPage-1)*rowPerPage; // 현재페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터 변경된다.
		
	// 케테고리별 갯수를 반환 
	PhotoDao photoDao = new PhotoDao();
	ArrayList<HashMap<String, Object>> photoCategoryNameList = photoDao.categoryPhotoTotalRow(photoCategoryName);
	
	// 카테고리별 행의 수
	photoDao = new PhotoDao();
	ArrayList<Photo> List = photoDao.selectPhotoListByPage(photoCategoryName, beginRow, rowPerPage);
	
	// 전체 행의수
	int totalCount = photoDao.selectPhotoTotalRow();
	
	// 마지막페이지 설정
	int lastPage = 0;	
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoList</title>
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
			<ul class="list-group">
				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<h4 class="text-white"> &nbsp;&nbsp;&nbsp; pirates메뉴 </h4>			
				<%
				for(HashMap<String, Object> m : photoCategoryNameList) {
				%>
					<li class="list-group-item">
						<a class="btn btn-bg-dark" href="<%=request.getContextPath()%>/photo/photoList.jsp?photoCategoryName=<%=m.get("photoCategoryName")%>"><%=m.get("photoCategoryName")%><span class="badge btn-primary"><%=m.get("cnt")%></span></a>
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
			<h1>이미지 목록(총 :<%=totalCount %> 개)</h1>
			<div>
				<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp">이미지 입력</a>
			</div>
		<!-- 이미지 입력 -->
		<table  class="table table-hover">
			<tr>
			<%	
				// 한행의 5개의 이미지 출력(tr안에 td가 5개)
				// 이미지가 3개 - tr1 - td3
				// 이미지가 5개 - tr1 - td5
				// 이미지가 10개- tr2 - td10
				// 이미지가 개- tr9 - td10
				
				// td의 갯수 5의 배수가 되도록
				// list.size()가 1~5 - td는 5개
				// list.size()가 6~10 - td는 10개
				System.out.println("리스트사이즈" + List.size());
				
				int startIdx = 1;
				int endIdx = (((List.size()-1)/5)+1)*5; // 5의 배수가 되어야 한다. (한줄에 5개씩 출력하기로...)
				System.out.println("endIdx"+endIdx);
				
			//	for(Photo p : List) {	// size()만큼 반복되므로 5의배수가 아닌 경우도 생긴다.
				for(int i=0; i<=endIdx; i++) {
					//tr을 닫고 새로운  tr시작
					if(i !=0 && i%3 == 0) { // 5일떄(0을 제외한 5의 배수일때)
			%>
					</tr><tr>
			<%
					}
					if(i<List.size()) {
			%>
					<td>
						<a href="<%=request.getContextPath()%>/photo/selectPhotoNew.jsp?photoNo=<%=List.get(i).getPhotoNo()%>">
							<img src="<%=request.getContextPath()%>/upload/<%=List.get(i).getPhotoName() %>" width="200" height="200">
							<div><%=List.get(i).getPhotoName() %></div>
							<!-- 상세보기에서는 원본이미지 크기로 -->
						</a>
					</td>
			<%			
					} else {
			%>
							<td>&nbsp;</td>
			<%			
					}
				}
			%>
			</tr>
			</table>
			<!-- 이전,다음 페이지설정 -->
			<div class="btn-group">		
				<%
					if(currentPage > 1) { // 현재페이지가 1이면 이전페이지가 존재해서는 안된다.
				%>
						<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage-1%>&photoCategoryName=<%=photoCategoryName%>">이전</a>&nbsp;&nbsp;&nbsp;
				<%	
					}
					if(currentPage < lastPage) { // 마지막페이지가 있다면 
				%>
						<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage+1%>&photoCategoryName=<%=photoCategoryName%>">다음</a>&nbsp;&nbsp;&nbsp;
				<%		
					}
				%>
			</div>
			<!--  하단정보표시 -->
			<div class="bg-secondary">
			<div>상호명 : GooDee Academy</div>
			<div>전화 : 02-2108-5900</div>
			<div>팩스 : 02-2108-5909</div>
			<div>사업자등록번호 : 457-85-00300</div>
			<div>홈페이지 : <A href="https://www.gdu.co.kr">https://www.gdu.co.kr</A></div>
			<div>주소 : 서울 금천구 가산디지털2로 115 대륭테크노타운 3차 1109호 71가산디지털단지역 5번 출구에서444m</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>