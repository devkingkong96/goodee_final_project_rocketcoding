<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">

   <jsp:param name="title" value=""/>
</jsp:include>

<style>
   table {
    display: table;
    border-collapse: separate;
    box-sizing: border-box;
    text-indent: initial;
    border-spacing: 2px;
    border-color: gray;
}
</style>



<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
	  <div class="container-full">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="d-flex align-items-center">
				<div class="me-auto">
					<h4 class="page-title">Editors</h4>
					<div class="d-inline-block align-items-center">
						<nav>
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
								<li class="breadcrumb-item" aria-current="page">Forms</li>
								<li class="breadcrumb-item active" aria-current="page">Editors</li>
							</ol>
						</nav>
					</div>
				</div>
				
			</div>
		</div>
		<!-- Main content -->
		<section class="content">
		  <div class="row">
			<div class="col-12">          
			  <div class="box">
			  	<div class="box-header">
			  		<h4>결재선 설정</h4>
			  		<div class="table table-bordered mb-0">
			  			<div class="row">
	<div class="col-12">          
	  <div class="box">
	  	<div class="box-header">
	  		<h4>결재선 설정</h4>
	  		<div class="table table-bordered mb-0">
	  			<table style="border: 1px solid black;">
	  				<colgroup>
	  					<col style="width:12.09%">
	  					<col style="width:87.91%">
	  				</colgroup>
	  				<tbody>
	  					<tr>
	  						<th scope="row" class="sign">
	  							<div style="height: 161px; display: table-cell; width: 116.2px; vertical-align: middle; text-align: center;">
	  							 결재 
	  							</div>
	  						</th>
	  						<td>
	  							<table style= "width:100%; table-layout:fixed; border-width: 2px; border: 1px solid black;" >
	  								<colgroup>
	  									<col>
	  									<col>
	  									<col>
	  								</colgroup>
	  								<tbody>
		  								<tr>
		  									<td style="height: 40px;">이름</td>
		  									<td style="height: 40px;">이름</td>
		  									<td style="height: 40px;">이름</td>
		  									<td style="height: 40px;">이름</td>
		  									<td style="height: 40px;">이름</td>
		  									<td style="height: 40px;">이름</td>
		  								</tr>
		  								<tr>
		  									<td style="height: 80px; border: 1px solid black;">도장</td>
		  									<td style="height: 80px; border: 1px solid black;">도장</td>
		  									<td style="height: 80px; border: 1px solid black;">도장</td>
		  									<td style="height: 80px; border: 1px solid black;">도장</td>
		  									<td style="height: 80px; border: 1px solid black;">도장</td>
		  									<td style="height: 80px; border: 1px solid black;">도장</td>
		  								</tr>
		  								<tr>
		  									<td style="height: 40px;">직급</td>
		  									<td style="height: 40px;">직급</td>
		  									<td style="height: 40px;">직급</td>
		  									<td style="height: 40px;">직급</td>
		  									<td style="height: 40px;">직급</td>
		  									<td style="height: 40px;">직급</td>
		  								</tr>
	  								</tbody>
	  							</table>
	  						</td>
	  					</tr>
	  				</tbody>
	  			</table>
	  		</div>
	  	</div>
			  			
	

				<form action="${path }/aprv/insertaprv" method="post">
				<div class="box-header">
				  <h4 class="box-title">제목<br>
					<input type="text" name="" class="form-control">
				  </h4>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
				<h4 class="box-title">본문</h4>
						<textarea id="editor1" name="tagContent" rows="10" cols="80">
												
						</textarea>
						<br>
					<button class="btn btn-primary" type="submit">제출하기</button>
				  </form>
				</div>
			  </div>
			  <!-- /.box -->
			</div>
			<!-- /.col-->
		  </div>
		  <!-- ./row -->
		 
		 
		</section>
		<!-- /.content -->
	  </div>
  </div>
  <!-- /.content-wrapper -->
  
   
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>