<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">

   <jsp:param name="title" value=""/>
</jsp:include>
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
				  <h4 class="box-title">CK Editor<br>
					<small>Advanced and full of features</small>
				  </h4>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
				  <form action="${path }/aprv/insertaprv" method="post">
						<textarea id="editor1" name="tagContent" rows="10" cols="80">
												
						</textarea>
						
					<button class="btn btn-display" type="submit">제출하기</button>
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