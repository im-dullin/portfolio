<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2022. 5. 2.오전 10:29:31</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	$(function () {
		var $clone = $(".uploadDiv").clone();
		
		var regexp = /(.*?)\.(exe|sh|js|jsp)$/;
		var maxSize = 1024 * 1024 * 5;
		
		function validateFiles(fileName, fileSize) {
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regexp.test(fileName)) {
				alert("해당 파일의 종류는 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		$(".uploadDiv").on("change", ":file", function() {
			var formData = new FormData();
			
			for(var i in this.files) {
				if(!validateFiles(this.files[i].name, this.files[i].size)) {
					return false;
				} 
				formData.append("files", this.files[i]);
			}
			
		/* 	console.log(this.files);
			console.log(formData); */
			$.post({
				processData : false,
				contentType : false,
				data : formData,
				url : "/upload",
				dataType : "json"
			}).done(function(result) {
				console.log(result);
				$(".uploadDiv").html($clone.html());
			})
		})
	})
</script>
</head>
<body>
<div class="uploadDiv">
	<input type="file" multiple>
</div>
</body>
</html>