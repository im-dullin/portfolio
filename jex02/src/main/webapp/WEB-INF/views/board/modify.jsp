<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html lang="ko">
<head>
    <jsp:include page="../common/head.jsp"/>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
                <jsp:include page="../common/nav.jsp"/>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-4 text-gray-800">Board Modify Page</h1>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary float-left">DataTables Example</h6>
                        </div>
                        <div class="card-body">
                        	<form method="post">
							  <div class="form-group">
							    <label for="title">title</label>
							    <input type="text" class="form-control" placeholder="title" id="title" name="title" value="${boards.title}">
							  </div>
							  
							  <div class="form-group">
							    <label for="content">content</label>
							    <textarea  class="form-control" placeholder="content" id="content" name="content" >${boards.content}</textarea>
							  </div>
							  
							  <div class="form-group">
							    <label for="writer">writer</label>
							    <input type="text" class="form-control" placeholder="writer" id="writer" name="writer" required readonly value="${boards.writer}">
							  </div>
							  
							  <div class="form-group uploadDiv">
							    <label for="attach" class="btn btn-success btn-sm">첨부</label>
							    <input type="file" class="form-control d-none" placeholder="attach" id="attach" name="attach" multiple>
							  </div>
							  
							  	<input type="hidden" name="bno" value="${boards.bno}">
							  	<input type="hidden" name="pageNum" value="${cri.pageNum}">
								<input type="hidden" name="amount" value="${cri.amount}">
								<input type="hidden" name="type" value="${cri.type}">
								<input type="hidden" name="keyword" value="${cri.keyword}">
								<sec:authorize access="isAuthenticated() && principal.username == #boards.writer">
								<button type="submit" class="btn btn-warning btn-sm" formaction="modify">수정</button>
								<button type="submit" class="btn btn-danger btn-sm" formaction="remove">삭제</button>
								<sec:csrfInput/>
								</sec:authorize>
								<a class="btn btn-secondary btn-sm" href="list${cri.params}">목록</a>
							</form>
								<div class="card shadow mb-4">
						          <div class="card-header py-3">
						              <h6 class="m-0 font-weight-bold text-primary float-left">Files</h6>
						          </div>
						          <div class="card-body">
						           <ul class="list-group small container px-1 upload-files">
									</ul>
								  <div class="container pt-3 px-1">
						 			<div class="row thumbs">
							 
							 		</div>
					    		  </div>
					            </div>
				               </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->
            
			<jsp:include page="../common/footer.jsp"/>
            <script>
            $(function() {
            	var bno = '${boards.bno}';
            	var $clone = $(".uploadDiv").clone();
            	
            	var regexp = /(.*?)\.(exe|sh|js|jsp)$/;
				var maxSize = 1024 * 1024 * 5;
				
        		lightbox.option({
					resizeDuration: 200,
					wrapAround: true,
					imageFadeDuration: 100
				})
        		
        		function validateFiles (fileName, fileSize) {
					if(fileSize >= maxSize) {
						alert("파일 사이즈 초과");
						return false;
					}
					if(regexp.test(fileName)) {
						alert("해당 파일의 종류는 업로드할 수 없습니다.");
						return false;
					}
					return true;
				}
        		
	         	// 첨부된 파일의 확인
				var showFiles = function(post) {
	        	 var ajaxObj = {
						url:"/board/attachs",
						data:{bno:bno},
						method:'get',
						dataType:'json'
					};
	        	 	if(post){
						var formData = new FormData();
						for(var i in post.files) {
							if(!validateFiles(post.files[i].name, post.files[i].size)) {
								return false;
							} 
							formData.append("files", post.files[i]);
						}
						ajaxObj.processData = false;
						ajaxObj.contentType = false;
						ajaxObj.data = formData;
						ajaxObj.method = 'post'
						ajaxObj.url = '/upload';
	        	 	}
					$.ajax(ajaxObj)
					.done(function(result) {
						console.log(result);
						$(".uploadDiv").html($clone.html());
						var str = "";
						var thumbStr = "";
						for(var i in result){
							console.log(result[i]);
							console.log($.param(result[i]));
							str += getAttachStr(result[i])
							if(result[i].image){
								thumbStr += getAttachStr(result[i])
							}
						}
						$(".upload-files").append(str);
						$(".thumbs").append(thumbStr);
					})
				}
				
				showFiles();
				
				$(".uploadDiv").on("change", ":file", function() {
					showFiles(this);
				})
				
                // 파일 삭제 이벤트
				$(".upload-files, .thumbs").on("click", ".close", function() {
					var $dom = $(this).closest("[data-uuid]");
					var uuid = $dom.data("uuid");
					$("[data-uuid='" + uuid + "']").remove();
				});
	            
				// 모듈화
                function getAttachStr(attach) {
                	var str = "";
                	str += '<li class="list-group-item" data-uuid="' + attach.uuid + '" data-path="' + attach.path + '" data-image="' + attach.image + '" data-origin="' + attach.origin + '"><a href="/download?' + $.param(attach) +'">' 
					+ attach.origin + '</a><button type="button" class="close"><span>&times;</span></button></li>';
                	return str;
                }
				
				// 모듈화
                function getThumbStr(attach) {
                	var str = "";
                	var o = {...attach}; // clone
					o.uuid = 's_' + o.uuid;
					str += '<div class="col-6 col-sm-4 col-lg-3 col-xl-2" data-uuid="' + attach.uuid + '" data-path="' + attach.path + '" data-image="' + attach.image + '" data-origin="' + attach.origin + '">';
					str += '  	<figure class="d-inline-block" style="position: relative;">';
					str += '  		<figcaption><button type="button" class="close" style="position: absolute; top:15px; right:8px;"><span>&times;</span></button></figcaption>';
					str += '  		<a href="/display?' + $.param(attach) + '" data-lightbox="img" data-title="' + o.origin +'"><img alt="" src="/display?' + $.param(o) + '" class="mx-1 my-2 img-thumbnail"></a>';
					str += '  	</figure>';
					str += '</div>';
                	return str;
                }
            });
            </script>
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->
</body>
</html>