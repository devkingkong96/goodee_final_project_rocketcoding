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
    .selected {
        background-color: #f8f9fa;  // 여기에 원하는 색상을 설정하면 됩니다.
    }
</style>
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
				  <h3 class="box-title">출/퇴근 반영기준</h3>
       				<h6 class="box-subtitle" data-toggle="modal" data-target="#myModal">근무규칙 추가</h6>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="table-responsive">
					  <table id="example" class="table table-bordered table-hover display nowrap margin-top-10 w-p100">
						<thead>
							<tr class="editable">
								<th>코드</th>
								<th>출근</th>
								<th>퇴근</th>
								<th>조퇴</th>
							</tr>
						</thead>
						<tbody>
						    <c:forEach var="dwrules" items="${dwrules}">
								<tr class="editable" onclick="rowClick(this, ${dwrules.DWRULES_CODE})">
						            <td>${dwrules.DWRULES_CODE}</td>
             						<td>${dwrules.DWRULES_START}</td>
            						<td>${dwrules.DWRULES_END}</td>
            						<td>${dwrules.DWRULES_EARLY}</td>
						        </tr>
						    </c:forEach>
						</tbody>			  
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
<!-- 규칙 추가 모달창 -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title"><strong>근무규칙 설정</strong></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="/dwrulesadd" method="post">
      <div class="modal-body">
       <table class="table table-striped-columns">
	    <tr>
        	<td>출근</td>
        	<td><input type="time" id="dwrulesStart" name="dwrulesStart"/></td>
	    </tr>
	    <tr>
	        <td>퇴근</td>
	        <td><input type="time" id="dwrulesEnd" name="dwrulesEnd"/></td>
	    </tr>
	    <tr>
	    	<td>조퇴</td>
	    	<td><input type="time" id="dwrulesEarly" name="dwrulesEarly"/></td>
	    </tr>
	</table>
        <div id="checkMsg" style="color: red"></div>
      </div>
      <div class="modal-footer">
        <button type="submit" id="saveEmployee" class="btn btn-info float-end">저장</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>
      </form>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<script>
$(document).ready(function() {
	  $('.box-subtitle').click(function() {
	    $('#myModal').modal('show');
	  });
	});
</script>
<script>
    window.onload = function(){
        var comEnroll = document.getElementById('dwrulesStart');
        var comEnd = document.getElementById('dwrulesEnd');
        var comEarly = document.getElementById('dwrulesEarly');

        comEnroll.onchange = function() {
            comEnroll.value = comEnroll.value.slice(0, 3) + '00';
        }

        comEnd.onchange = function() {
            comEnd.value = comEnd.value.slice(0, 3) + '00';
        }
        comEarly.onchange = function() {
        	comEarly.value = comEarly.value.slice(0, 3) + '00';
        }
    }
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>