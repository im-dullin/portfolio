<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2022. 4. 21.오후 12:34:42</title>
<script src="/resources/assets/vendor/jquery/jquery.min.js"></script>
<script>
$(function() {
	$("#btnAjaxText").on("click", function() {
		console.log("call text")
		$.ajax("/sample/getText").done(function(result) {
			console.log(result)
		});
	});
	$("#btnAjaxSample").on("click", function() {
		console.log("call sample")
		$.ajax({
			url:"/sample/getSample",
			dataType: "json",
			success: funtion(result) {
				console.log(result)
			}
		})
	});
	$("#btnAjaxList").on("click", function() {
		console.log("call list")
		$.ajax({
			url:"/sample/getList",
			dataType: "json",
			success: funtion(result) {
				console.log(result)
			}
		})
	});
})
</script>
</head>
<body>
	<button id="btnAjaxText">ajax text call</button>
	<button id="btnAjaxSample">ajax sample call</button>
	<button id="btnAjaxList">ajax list call</button>
</body>
</html>