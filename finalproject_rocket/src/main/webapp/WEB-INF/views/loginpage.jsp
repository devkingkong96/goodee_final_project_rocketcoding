<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${path}/resources/images/favicon.svg">

    <title>로켓코딩 ERP 로그인</title>
  
	<!-- Vendors Style-->
	<link rel="stylesheet" href="${path}/resources/css/vendors_css.css">
	  
	<!-- Style-->  
	<link rel="stylesheet" href="${path}/resources/css/style.css">
	<link rel="stylesheet" href="${path}/resources/css/skin_color.css">	

</head>
	
<body class="hold-transition theme-primary bg-img" style="background-image: url(${path}/resources/images/auth-bg/bg-1.jpg)">
	
	<div class="container h-p100">
		<div class="row align-items-center justify-content-md-center h-p100">	
			
			<div class="col-12">
				<div class="row justify-content-center g-0">
					<div class="col-lg-5 col-md-5 col-12">
						<div class="bg-white rounded10 shadow-lg">
							<div class="content-top-agile p-20 pb-0">
								<h2 class="text-primary">Rocket Coding ERP</h2>
								<p class="mb-0">서점 ERP</p>							
							</div>
							<div class="p-40">
								<form action="${path }/login" method="post">
									<div class="form-group">
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="si-organization si"></i></span>
											<select name="branchId" class="form-control ps-15 bg-transparent">
												<option disabled selected>지점을 선택하세요.</option>
												<option>신도림점</option>
												<option>광명점</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="ti-user"></i></span>
											<input type="text" name="empNo" class="form-control ps-15 bg-transparent" placeholder="사원번호">
										</div>
									</div>
									<div class="form-group">
										<div class="input-group mb-3">
											<span class="input-group-text  bg-transparent"><i class="ti-lock"></i></span>
											<input type="password" name="empPw" class="form-control ps-15 bg-transparent" placeholder="비밀번호">
										</div>
									</div>
									  <div class="row">
										<div class="col-6">
										  <div class="checkbox">
											<input class="form-check-input" name="rememberMe" type="checkbox" id="basic_checkbox_1" >
											<label for="basic_checkbox_1">로그인 상태 유지</label>
										  </div>
										</div>
										<!-- /.col -->
										<div class="col-6">
										 <div class="fog-pwd text-end">
											<a href="" class="hover-warning" data-bs-toggle="modal" data-bs-target="#modal-default"><i class="ion ion-locked"></i> 비밀번호 찾기</a><br>
										  </div>
										</div>
										<!-- /.col -->
										<div class="d-grid gap-2 col-12 mx-auto">
										  <button type="submit" class="btn btn-info">로그인</button>
										</div>
										<!-- /.col -->
									  </div>
								</form>	
							</div>						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

  <!-- modal Area -->              
<%-- <form  action="${path }/member/sendEmail" method="post"> --%>
  <div class="modal fade" id="modal-default">
	  <div class="modal-dialog" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h4 class="modal-title"><strong>임시 비밀번호 발급</strong></h4>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div class="modal-body">
		  	<table class="table table-striped-columns">
				<tr>
					<td>사원번호</td>
					<td><input type="text" name="empNo"/></td>
				</tr>
				<tr>
					<td>복구 Email</td>
					<td><input type="email" name="email"/></td>
				</tr>
			</table>
			<div id="checkMsg" style="color: red"></div>
		  </div>
		  <div class="modal-footer">
			<button type="button" id="sendEmail" class="btn btn-info float-end">발송</button>
			<button type="submit" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
		  </div>
		</div>
		<!-- /.modal-content -->
	  </div>
	  <!-- /.modal-dialog -->
  </div>
<!-- </form> -->
  <!-- /.modal -->



	<!-- Vendor JS -->
	<script src="${path}/resources/js/vendors.min.js"></script>
	<script src="${path}/resources/js/pages/chat-popup.js"></script>
    <script src="${path}/resources/assets/icons/feather-icons/feather.min.js"></script>	
	<script>
		document.getElementById('sendEmail').addEventListener('click',function(){
			const empNo=document.querySelector('input[name="empNo"]').value;
			const email=document.querySelector('input[name="email"]').value;
			
			if(empNo===""||empNo.trim()==="") alert("회원번호를 입력해주세요.");
			else if(email===""||email.trim()==="") alert("이메일을 입력해주세요.");
			else if{
			//ajax대신 fetch로 통신
			$.ajax({
				type:"GET",
				url:"${path}/member/emailCheck",
				data:{
					"empNo":empNo,
					"email":email
				},
				dataType:"text"
				
				}).done(function(result){
					if(result=="true"){
						sendEmail();
						alert("임시비밀번호를 전송했습니다.");
						window.location.href="${path}/login";
					}else if(result=="false"){
						alert("사원번호 혹은 이메일을 정확히 적어주세요.");
					}
				}).fail(function(error){
					alert(JSON.stringify(error));
				})
			}
		});
		
		function sendEmail(){
			const email=document.querySelector('input[name="email"]').value;
			
			$.ajax({
				type:"POST",
				url:"/member/sendPwd",
				data:{
					"email":email
				},
				error:function(error){
					alert(JSON.stringify(error));
				}
			})
		}
	</script>
</body>
</html>
