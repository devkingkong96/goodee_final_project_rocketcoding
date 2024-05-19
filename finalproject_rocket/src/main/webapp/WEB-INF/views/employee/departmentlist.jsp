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
				  <h3 class="box-title">부서현황</h3>
       				<h6 class="box-subtitle" data-toggle="modal" data-target="#myModal">부서등록</h6>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="table-responsive">
					  <table id="example" class="table table-bordered table-hover display nowrap margin-top-10 w-p100">
						<thead>
							<tr class="editable">
								<th>부서번호</th>
								<th>부서명</th>
								<th>부서별 인원수</th>
							</tr>
						</thead>
						<tbody>
					    <c:forEach var="departments" items="${departments}">
        					<tr class="editable" data-dep-code="${departments.DEP_CODE}" data-dep-name="${departments.DEP_NAME}">
					            <td>${departments.DEP_CODE}</td>
					            <td>${departments.DEP_NAME}</td>
					            <td>${departments.DEP_COUNT}</td>
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
<!-- 부서 추가 모달창 -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title"><strong>부서등록</strong></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
    <form id="departmentForm" action="${path}/department/add" method="post">
        <table class="table table-striped-columns">
            <tr>
                <td>부서명</td>
                <td><input type="text" id="depName" name="depName"/></td>
            </tr>
        </table>
        <div id="checkMsg" style="color: red"></div>
    </form>
	</div>
	<div class="modal-footer">
	    <button type="submit" form="departmentForm" class="btn btn-info float-end">저장</button>
	    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
	</div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- 상세화면모달 -->
<div class="modal fade" id="myModal2">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" id="modalHeader">
		<h4 class="modal-title"><strong id="depTitle">부서상세화면</strong></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div id="scrollArea" style="max-height: 500px; overflow-y: auto;">
        <table class="table table-striped-columns">
            <thead>
					<tr class="editable">
						<th>사원번호</th>
						<th>사원명</th>
						<th>직급</th>
					</tr>
				</thead>
				<tbody id="detailTableBody">
    			</tbody>	
        	</table>
	    </div>
	</div>
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
$(document).ready(function() {
    $('tr.editable').on('click', function() {
        var depName = $(this).data('dep-name');  // 부서명 가져오기

        $('#depTitle').text(depName + ' 부서상세화면');
        $.ajax({
            url: '${path}/departmentdetail', 
            method: 'get',
            data: { depName: depName },
            success: function(data) {
            	$('#detailTableBody').empty();
                $.each(data, function(index, item) {
                    var row = '<tr class="editable" data-dep-code="">';
                    row += '<td>' + item.EMP_NO + '</td>';
                    row += '<td>' + item.EMP_NAME + '</td>';
                    row += '<td>' + item.EMP_LV + '</td>';
                    row += '</tr>';
                    $('#detailTableBody').append(row);
                });
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
        $('#myModal2').modal('show');
    });
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>