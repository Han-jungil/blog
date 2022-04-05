<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import ="dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPhotoForm.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">	
	<h1>이미지 등록</h1>
	<!-- 
		1) form태그안에 값을 넘기는 기본값(enctype속성)은 문자열이다.
		2) 파일을 넘길 수 없다. 기본값(application/x-www-form-urlencoded)을 변경해야 한다.
		3) 기본값을 "multipart/form-data"로 변경하면 기본값이 문자열에서 바이너리(이진수)로 변경된다.
		4) 같은 폼안에 모든 값이 바이너리로 넘어간다. 글자를 넘겨받는 request.getParameter()를 사용할 수 없다.
		5) 복잡한 코드를 통해서만 바이너리 내용을 넘겨 받을 수있다.
		6) 외부 라이브러리(cos.jar)를 사용해서 복잡은 코드 간단하게 구현하자.
	-->
	<form action="<%=request.getContextPath()%>/photo/insertPhotoAction.jsp" method="post" enctype="multipart/form-data">
		<table class="table">
			<tr>
				<td>이미지파일</td>
				<td><input type="file" name="photo" class="form-control"></td>
			</tr>
			<td>photoCategoryName</td>	
				<td>
					<select name="photoCategoryName" class="form-select">
							<option value="밀짚모자해적단">밀짚모자해적단</option>
							<option value="백수해적단">백수해적단</option>
							<option value="흰수염해적단">흰수염해적단</option>
					</select>
				</td>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="photoPw" class="form-control"></td>
			</tr>
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer" class="form-control"></td>
			</tr>
		</table>
		<button type="submit" class="btn-dark">이미지등록</button>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/photo/photoList.jsp">뒤로</a>
	</form>
</div>
</body>
</html>