<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2022. 4. 18.오전 9:40:18</title>
</head>
<body>
	<h1>Board Read Page</h1>
	<h2>cri : ${cri}</h2>
	<form method="post">
		<h4><label for="title">title</label><h4>
		<input name="title" id="title" value="${boards.title}" readonly>

		<h4><label for="content">content</label><h4>
		<textarea rows="20" cols="40" name="content" id="content" readonly>${boards.content}</textarea>
		
		<h4><label for="writer">writer</label><h4>
		<input name="writer" id="writer" value="${boards.writer}" readonly>
		
		<hr>
		<a href="modify${cri.params}&bno=${boards.bno}">수정</a>
		<a href="list${cri.params}">목록</a>
	</form>
</body>
</html>