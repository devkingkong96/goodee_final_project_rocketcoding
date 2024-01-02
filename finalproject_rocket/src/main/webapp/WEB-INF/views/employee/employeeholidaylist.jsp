<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="title" value=""/>
</jsp:include>
 <!-- extract 버튼 가져오기 -->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
   <script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
   <script src="https://cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
   <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.colVis.min.js"></script>
   <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
   <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
   <script src="https://cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>
   <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.bootstrap.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
   <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
   <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
   <script src="https://cdn.datatables.net/fixedheader/3.1.2/js/dataTables.fixedHeader.min.js"></script>
<div class="content-wrapper">
   <div class="container-full">
      <!-- Main content -->
      <section class="content">
         <div class="row">

			<div class="col-12">
			  <!-- /.box -->

			  <div class="box">
				<div class="box-header with-border">
				  <h3 class="box-title">사원별휴가사용조회</h3>
				  <h6 class="box-subtitle">휴가일수조회</h6>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="table-responsive">
					  <table id="example" class="table table-bordered table-hover display nowrap margin-top-10 w-p100">
						<thead>
							<tr>
								<th>사원번호</th>
								<th>사원이름</th>								
								<th>휴가종류</th>
								<th>휴가사유</th>
								<th>사용기간</th>
							</tr>
						</thead>
						<tbody>
				    <c:forEach var="employee" items="${employees}">
				        <c:forEach var="document" items="${employee.documentList}">
				            <tr>
				                <td>${employee.EMP_NO}</td>
				                <td>${employee.EMP_NAME}</td>
				                <td>${document.DOC_NO}</td>
				                <td>${document.DOC_TITLE}</td>
				                <td>${document.START_DATE} ~ ${document.END_DATE}</td>
				            </tr>
				        </c:forEach>
				    </c:forEach>
					</tbody>
				<tfoot>
				    <tr>
				        <th>사원번호</th>
				        <th>사원이름</th>								
				        <th>휴가종류</th>
				        <th>휴가사유</th>
				        <th>사용기간</th>
				    </tr>
				</tfoot>
					</table>
					</div>              
				</div>
				<!-- /.box-body -->
			  </div>
			  <!-- /.box -->          
			</div>
			<!-- /.col -->
		  </div>
		  <!-- /.row -->
				<div class="col-lg-3 col-12">
					<button class="btn btn-primary w-100 mb-2">휴가항목등록</button>
				</div>
      </section>
   </div>
</div>
	

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>