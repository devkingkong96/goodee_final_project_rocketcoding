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
   
	/* 닫기 버튼 스타일 */
	.close {
	  color: #aaa;
	  position: absolute;
	  right: 20px;
	  top: 20px;
	  font-size: 28px;
	  font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	  color: black;
	  text-decoration: none;
	  cursor: pointer;
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
			  			
	<div>          
	  <div>
	  	<div>
	  		<div>
			  <div>
				<div class="box-body" style="display: flex">			  
		  		<h4>결재선 설정</h4>
		  		&nbsp;&nbsp;&nbsp;
				</div>
			  </div>
			</div>
			<!-- /.col -->
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
		  									
		  								</tr>
		  								<tr>
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
						<div id="tagCont">
							
						
						</div>
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
		 <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="background-color: white;">
				<div class="modal-header">
					<h4 class="modal-title" id="myLargeModalLabel">결재선 설정</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="myBtn"></button>
				</div>
				<div class="modal-body" >
					<div id="flex-cotainer" style="display: flex" class="b-groove">
						<div id="tree-container"class="b-groove">
							<div id="jstree">
			    	<ul class="treeview-menu">
				        <li>
				            <input type="checkbox" id="root">
				            <label for="root" class="node">로켓서점</label>
				            <ul class="treeview-menu">
				                <li>
				                    <input type="checkbox" id="node1">
				                    <label for="node1" class="node leaf">인사</label>
				                </li>
				                <li>
				                    <input type="checkbox" id="node2">
				                    <label for="node2" class="node">경영</label>
				                    
				                <li>
				                    <input type="checkbox" id="node2-1">
				                    <label for="node2-1" class="node leaf">회계</label>
				               </li>
				               <li>
				                    <input type="checkbox" id="node2-1">
				                    <label for="node2-1" class="node leaf">재고</label>
				               </li>
							</ul>
				         </li>
				    </ul>
				     
				</div>
						</div>
						<div id="btn-container"class="b-groove">
							select emp_name from employee where 부서코드 = 
						</div>
						<div id="table-container"class="b-groove">
							그거 저장해야되는데 어케하지????
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger text-start" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
  <!-- /.modal -->
			</div>
			</div>
			</div>
		</section>
		<!-- /.content -->
	  </div>
  </div>
  <!-- /.content-wrapper -->
  <script>
//모달 창과 모달 창을 여는 버튼, 그리고 닫기 버튼을 변수로 가져옵니다.
  var modal = document.getElementById("myModal");
  var btn = document.getElementById("myBtn");
  var span = document.getElementsByClassName("close")[0];

  // 사용자가 버튼을 클릭하면 모달 창을 보여줍니다.
  btn.onclick = function() {
    modal.style.display = "block";
  }

  // 사용자가 (x) 버튼을 클릭하면 모달 창을 닫습니다.
  span.onclick = function() {
    modal.style.display = "none";
  }
  </script>
  <script>
  $(function () {
    // 6 create an instance when the DOM is ready
    $('#jstree').jstree();
    // 7 bind to events triggered on the tree
    $('#jstree').on("changed.jstree", function (e, data) {
      console.log(data.selected);
    });
  });
  </script>
  
  
   
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- jstree CSS -->
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script> 