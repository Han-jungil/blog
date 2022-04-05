<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">	
	<h1>글 입력</h1>
	<form method="post" action= "<%=request.getContextPath()%>/board/insertBoardAction.jsp">
		<table class="table">
			<tr>
				<td>categroyName</td>
				<td>
					<select name="categoryName" class="form-select">
							<option value="독서">독서</option>
							<option value="등산">등산</option>
							<option value="만화">만화</option>
							<option value="맛집">맛집</option>
							<option value="여행">여행</option>
							<option value="요가">요가</option>
							<option value="요리">요리</option>
							<option value="자동차">자동차</option>
							<option value="컴퓨터">컴퓨터</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>boardTitle</td>
				<td>
					<input name="boardTitle" type="text" class="form-control">
				</td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea name="boardContent"rows="5" cols="80" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td>boardPw</td>
				<td>
					<input name="boardPw" type="password" class="form-control"></input>
				</td>
			</tr>
			<tr>
				<td>
					<button type="submit" class="btn-dark">board 입력</button>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/board/boardList.jsp">뒤로</a>
				</td>
			</tr>
			
		</table>
		
	</form>
</div>
</body>
</html>