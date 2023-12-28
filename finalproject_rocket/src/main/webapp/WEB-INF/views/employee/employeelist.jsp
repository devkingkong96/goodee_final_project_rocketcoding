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
				  <h3 class="box-title">인사카드 등록</h3>
				  <h6 class="box-subtitle">인사카드</h6>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="table-responsive">
					  <table id="example" class="table table-bordered table-hover display nowrap margin-top-10 w-p100">
						<thead>
							<tr>
								<th>사원번호</th>
								<th>성명</th>
								<th>부서명</th>
								<th>직위/직급</th>
								<th>이메일</th>
								<th>입사일자</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>emp_no1</th>
								<th>emp_name1</th>
								<th>dep_name1</th>
								<th>emp_lv1</th>
								<th>emp_email1</th>
								<th>emp_date1</th>
							</tr>
							<tr>
								<th>emp_no2</th>
								<th>emp_name2</th>
								<th>dep_name2</th>
								<th>emp_lv2</th>
								<th>emp_email2</th>
								<th>emp_date2</th>
							</tr>
							<tr>
								<th>emp_no3</th>
								<th>emp_name3</th>
								<th>dep_name3</th>
								<th>emp_lv3</th>
								<th>emp_email3</th>
								<th>emp_date3</th>
							</tr>
							<tr>
								<th>emp_no</th>
								<th>emp_name</th>
								<th>dep_name</th>
								<th>emp_lv</th>
								<th>emp_email</th>
								<th>emp_date</th>
							</tr>
							<tr>
								<th>emp_no</th>
								<th>emp_name</th>
								<th>dep_name</th>
								<th>emp_lv</th>
								<th>emp_email</th>
								<th>emp_date</th>
							</tr>
							<tr>
								<th>emp_no</th>
								<th>emp_name</th>
								<th>dep_name</th>
								<th>emp_lv</th>
								<th>emp_email</th>
								<th>emp_date</th>
							</tr>
							<tr>
								<th>emp_no</th>
								<th>emp_name</th>
								<th>dep_name</th>
								<th>emp_lv</th>
								<th>emp_email</th>
								<th>emp_date</th>
							</tr>
							<tr>
								<th>emp_no</th>
								<th>emp_name</th>
								<th>dep_name</th>
								<th>emp_lv</th>
								<th>emp_email</th>
								<th>emp_date</th>
							</tr>
							<tr>
								<th>emp_no</th>
								<th>emp_name</th>
								<th>dep_name</th>
								<th>emp_lv</th>
								<th>emp_email</th>
								<th>emp_date</th>
							</tr>
							<tr>
								<th>emp_no</th>
								<th>emp_name</th>
								<th>dep_name</th>
								<th>emp_lv</th>
								<th>emp_email</th>
								<th>emp_date</th>
							</tr>
							<tr>
								<th>emp_no</th>
								<th>emp_name</th>
								<th>dep_name</th>
								<th>emp_lv</th>
								<th>emp_email</th>
								<th>emp_date</th>
							</tr>
							<tr>
								<th>emp_no</th>
								<th>emp_name</th>
								<th>dep_name</th>
								<th>emp_lv</th>
								<th>emp_email</th>
								<th>emp_date</th>
							</tr>
						</tbody>				  
						<tfoot>
							<tr>
								<th>사원번호</th>
								<th>성명</th>
								<th>부서명</th>
								<th>직위/직급</th>
								<th>이메일</th>
								<th>입사일자</th>
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
      </section>
   </div>
</div>
	

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>