<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}"/>
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
					  <table id="example" class="table table-striped table-hover display nowrap margin-top-10 w-p100">
						<thead>
							<tr class="editable bt-5 border-primary">
								<th>사원번호</th>
								<th>성명</th>
								<th>부서명</th>
								<th>직위/직급</th>
								<th>이메일</th>
								<th>입사일자</th>
								<th>재직여부</th>					
							</tr>
						</thead>
						<tbody>
						    <c:forEach var="employees" items="${employees}">
								<tr class="editable">
						            <td>${employees.EMP_NO}</td>
									<td><a href="#" data-bs-toggle="modal" data-bs-target="#modal-modify">${employees.EMP_NAME}</a></td>
						          	<td>${employees.DEP_NAME}</td>
						            <td>${employees.EMP_LV}</td>
						            <td>${employees.EMP_EMAIL}</td>
						            <td><fmt:formatDate value="${employees.EMP_ENDATE}" pattern="yyyy-MM-dd"/></td>
						            <td>${employees.EMP_FICATION}</td>
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
		<button class="btn employee plus" data-bs-toggle="modal" data-bs-target="#modal-default">신규</button>
      </section>
   </div>
</div>
<script>
    $(document).ready(function() {
        var depName = '${loginEmp.dep.depName}';
        if (depName === '인사팀') {
            $('.btn.employee.plus').show();
        } else {
            $('.btn.employee.plus').hide();
        }
    });
</script>
<!-- 인사카드 등록 모달창 -->
<div class="modal fade" id="modal-default">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title"><strong>인사카드등록</strong></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="employeeForm" method="post">
      <div class="modal-body">
        <table class="table table-striped-columns">
          <tr>
            <td>지점고유코드</td>
              <td>
                <select id="branchId" name="branchId">
                  <c:forEach items="${branches}" var="employee">
                    <option value="${employee.BRANCH_ID}">${employee.BRANCH_ID}</option>
                  </c:forEach>
                <!-- 추가 지점 옵션 -->
              </select>
            </td>
          </tr>
          <tr>
            <td>비밀번호</td>
            <td><input type="text" id="empPw" name="empPw"/></td>
          </tr>
          <tr>
            <td>사원이름</td>
            <td><input type="text" id="empName" name="empName"/></td>
          </tr>
          <tr>
            <td>직위/직급</td>
            <td><input type="text" id="empLv" name="empLv"/></td>
          </tr>
          <tr>
            <td>이메일</td>
            <td><input type="text" id="empEmail" name="empEmail"/></td>
          </tr>
          <tr>
             <td>부서명</td>
              <td>
                <select id="depCode" name="depCode">
                  <c:forEach items="${departments}" var="employee">
                    <option value="${employee.DEP_CODE}">${employee.DEP_NAME}</option>
                  </c:forEach>
                </select>
              </td>
            </tr>
            <tr>
              <td>출근시간</td>
              <td>
                <select id="dwruleCode" name="dwruleCode">
				  <c:forEach items="${dwrules}" var="employee">
				    <option value="${employee.DWRULES_CODE}">${employee.DWRULES_START}</option>
				  </c:forEach>
				</select>
            </td>
          </tr>
        </table>
        <div id="checkMsg" style="color: red"></div>
      </div>
      <div class="modal-footer">
        <button type="button" id="saveEmployee" class="btn btn-info float-end">저장</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>
    </form>  
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<script>
$(document).ready(function(){
	  $("#saveEmployee").click(function(e){
	    e.preventDefault();

	    var formData = $("#employeeForm").serialize();

	    $.ajax({
	      type: "POST",
	      url: "/employeeinsert", 
	      data: formData,
	      success: function(response){
		        alert("수정이 완료되었습니다.");
		        $('#modal-modify').modal('hide'); 
		        location.reload(); 
		      },
		      error: function(jqXHR, textStatus, errorThrown){
		        alert("수정에 실패하였습니다. 오류 내용: " + errorThrown);
		      }
		    });
		  });
		});
</script>
<!-- 인사카드 수정 모달창 -->
<div class="modal fade" id="modal-modify">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title"><strong>인사카드수정</strong></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="employeeupdateForm" method="post" action="/employeeupdate">
        <table class="table table-striped-columns">
          <tr>
          	<td>사원번호</td>
          	<td><input type="text" id="empNo" name="empNo"/><td>
          </tr>
          <tr>
            <td>비밀번호</td>
            <td><input type="text" id="empPw" name="empPw"/></td>
          </tr>
          <tr>
            <td>사원이름</td>
            <td><input type="text" id="empName" name="empName"/></td>
          </tr>
          <tr>
            <td>직위/직급</td>
            <td><input type="text" id="empLv" name="empLv"/></td>
          </tr>
          <tr>
            <td>이메일</td>
            <td><input type="text" id="empEmail" name="empEmail"/></td>
          </tr>
          <tr>
            <td>부서명</td>
            <td>
            	<select id="depCode" name="depCode">
            		<c:forEach items="${departments}" var="employees">
				        <option value="${employees.DEP_CODE}">${employees.DEP_NAME}</option>
				    </c:forEach>
            	</select>
            </td>
          </tr>
          <tr>
		  <td>재직여부</td>
		  <td>
		    <select id="empFication" name="empFication">
		      <option value="재직자">재직자</option>
		      <option value="퇴사자">퇴사자</option>
		    </select>
		  </td>
		</tr>
          <tr>
            <td>출근시간</td>
            <td>
              <select id="dwrules" name="dwrules">
                <c:forEach items="${dwrules}" var="employees">
				        <option value="${employees.DWRULES_CODE}">${employees.DWRULES_START}</option>
			    </c:forEach>
                <!-- 추가 출근 시간 옵션 -->
              </select>
            </td>
          </tr>
        </table>
        <div id="checkMsg" style="color: red"></div>
      </div>
        </form>
      	<div class="modal-footer">
		  <button type="submit" id="updateEmployee" class="btn btn-info float-end">수정</button>
		  <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
		</div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<script>
$(document).ready(function() {
	$('table tbody .editable').on('click', function() {
		var empNo = $(this).find('td:eq(0)').text();
		var empName = $(this).find('td:eq(1)').text();
		var depName = $(this).find('td:eq(2)').text();
		var empLv = $(this).find('td:eq(3)').text();
		var empEmail = $(this).find('td:eq(4)').text();
		var empEnDate = $(this).find('td:eq(5)').text();
		var empFication = $(this).find('td:eq(6)').text();

		$('#modal-modify #empNo').val(empNo).prop('readOnly', true); // 사원번호
		$('#modal-modify #empName').val(empName); // 사원이름
		 $('#modal-modify #depCode option').filter(function() { // 부서명
	            return $(this).text() === depName;
	        }).prop('selected', true);
		$('#modal-modify #empLv').val(empLv); // 직위/직급
		$('#modal-modify #empEmail').val(empEmail); // 이메일
		$('#modal-modify #empEnDate').val(empEnDate).prop('disabled', true); 
		 $('#modal-modify #empFication option').filter(function() {
		      return $(this).text() === empFication;
		    }).prop('selected', true);

		$('#modal-modify').modal('show');
	});
	$("#updateEmployee").click(function(e){
	    e.preventDefault(); 

	    var formData = $("#employeeupdateForm").serialize(); 

	    $.ajax({
	        type: "POST",
	        url: "/employeeupdate",
	        data: formData,
	        success: function(response){
	          alert("수정이 완료되었습니다.");
	          $('#modal-modify').modal('hide'); 
	          var row = $('table tbody .editable').filter(function() {
	            return $(this).find('td:eq(0)').text() === $('#modal-modify #empNo').val();
	          });
	          row.find('td:eq(1)').text($('#modal-modify #empName').val());
	          row.find('td:eq(2)').text($('#modal-modify #depCode option:selected').text());
	          row.find('td:eq(3)').text($('#modal-modify #empLv').val());
	          row.find('td:eq(4)').text($('#modal-modify #empEmail').val());
	          row.find('td:eq(6)').text($('#modal-modify #empFication option:selected').text());
	        },
	        error: function(jqXHR, textStatus, errorThrown){
	          alert("수정에 실패하였습니다. 오류 내용: " + errorThrown);
	        }
	    });
	  });
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>