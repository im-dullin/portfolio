<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp"></jsp:include>
<sec:csrfMetaTags />
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
                    <h1 class="h3 text-gray-800 mb-4">Board Register Page</h1>
                    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary float-left">DataTables Example</h6>
                        </div>
                        <div class="card-body">
                           <form method="post">
							  <div class="form-group">
							    <label for="title">title</label>
							    <input type="text" class="form-control" placeholder="title" id="title" name="title">
							  </div>
							  
							  <div class="form-group">
							    <label for="content">content</label>
							    <input type="text" class="form-control" placeholder="content" id="content" name="content">
							  </div>
							  
							  <div class="form-group">
							    <label for="writer">writer</label>
							    <input type="text" class="form-control" id="writer" name="writer" readonly value='<sec:authentication property="principal.username"/>'>
							  </div>
							  
							  <div class="form-group uploadDiv">
							    <label for="attach" class="btn btn-success btn-sm">첨부</label>
							    <input type="file" class="form-control d-none" placeholder="attach" id="attach" name="attach" multiple>
							  </div>
							  
							  <ul class="list-group small container px-1 upload-files">
							  </ul>
							  <div class="container pt-3 px-1">
						  	 	 <div class="row thumbs">
						  	 	 
						  	 	 </div>
				  		  	  </div>
							  <sec:csrfInput/>
							  <button type="submit" class="btn btn-primary" id="btnReg">Submit</button>
							  <a href="/board/list" type="submit" class="btn btn-primary">목록</a>
							</form>
                        </div>
                    </div>
                </div>
                <!-- container-fluid -->
            </div>
            <!-- End of Main Content -->
			<jsp:include page="../common/footer.jsp" />
			<script>
			var headerName = $("meta[name='_csrf_header']").attr("content");
        	var token = $("meta[name='_csrf']").attr("content");
        	
        	$(document).ajaxSend(function(e, xhr) {
        		xhr.setRequestHeader(headerName, token);
        	})
        	
				$(function() {
					$("#attach").change(function() {
						var str = "";
						$(this.files).each(function() {
						str += "<p>" + this.name + "</p>";
						})
						$(this).next().html(str);
					});
				})
			</script>
			<script>
			
				$(function () {
					lightbox.option({
				      resizeDuratio: 200,
				      wrapAround: true,
				      imageFadeDuration : 100
				    })
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
					
					// 파일 첨부
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

							var str = "";
							var thumbStr = "";
							for(var i in result){
								console.log(result[i]);
								console.log($.param(result[i]));
								str += '<li class="list-group-item" data-uuid="' + result[i].uuid + '" data-path="' + result[i].path + '" data-image="' + result[i].image + '" data-origin="' + result[i].origin + '"><a href="/download?' + $.param(result[i]) +'">' 
										+ result[i].origin + '</a><button type="button" class="close"><span>×</span></button></li>';
								if(result[i].image){
									var o = {...result[i]}; // clone
									o.uuid = 's_' + o.uuid;
									thumbStr += '<div class="col-6 col-sm-4 col-lg-3 col-xl-2" data-uuid="' + result[i].uuid + '" data-path="' + result[i].path + '" data-image="' + result[i].image + '" data-origin="' + result[i].origin + '">';
									thumbStr += '  	<figure class="d-inline-block" style="position: relative;">';
									thumbStr += '  		<figcaption><button type="button" class="close" style="position: absolute; top:15px; right:8px;"><span>&times;</span></button></figcaption>';
									thumbStr += '  		<a href="/display?' + $.param(result[i]) + '" data-lightbox="img" data-title="' + o.origin +'"><img alt="" src="/display?' + $.param(o) + '" class="mx-1 my-2 img-thumbnail"></a>';
									thumbStr += '  	</figure>';
							  		thumbStr += '</div>';
								}
							}
							$(".upload-files").append(str);
							$(".thumbs").append(thumbStr);
						})
					})
					// 파일 첨부 종료
					
					// 파일 삭제 이벤트
					$(".upload-files, .thumbs").on("click", ".close", function() {
						var $dom = $(this).closest("[data-uuid]");
						var uuid = $dom.data("uuid");
						var image = $dom.data("image");
						var path = $dom.data("path");
						console.log(uuid);
						$.post({
							url : "/deleteFile",
							data : {uuid:uuid, path:path, image:image},
							success : function(result) {
								console.log(result);
								$("[data-uuid='" + uuid + "']").remove(); // 속성선택자는 그 안에 요소를 쓸 수 있다.
							}
						})
					});

					// 게시글 등록 이벤트
					$("#btnReg").click(function() {
						event.preventDefault;
						var str = "";
						var attrArr = ['uuid', 'origin', 'path', 'image'];
						$(".upload-files li").each(function(i) {
							for(var j in attrArr){
								attrArr[j]
								str += 
									$("<input>")
									.attr("type", "hidden")
									.attr("name", "attachs[" + i + "]." + attrArr[j])
									.attr("value", $(this).data(attrArr[j])).get(0).outerHTML + "\n";
							}
						});
						console.log(str);
						$(this).closest("form").append(str).submit(); // 첨부파일 글쓰기 가능!
					});
				})
			</script> 
			
	<!-- Footer -->
	<footer class="sticky-footer bg-white">
	    <div class="container my-auto">
	        <div class="copyright text-center my-auto">
	            <span>Copyright &copy; Your Website 2020</span>
	        </div>
	    </div>
	</footer>
	<!-- End of Footer -->
	
 	<!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-warning" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>
    </div>
	<!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/assets/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/assets/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/assets/js/sb-admin-2.min.js"></script>
    <script>
	    $(function() {
		var result ='${result}';
		check(result);
			function check(result) {
				if(!result || history.state) return;
			
				if(parseInt(result)>0){
					alert(result+"번 게시글이 작성되었습니다.");
				}
			}
			history.replaceState({},null,null);
		})
    </script>
</body>
</html>