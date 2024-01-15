<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <%
	if(request.getRequestURI().contains("/upload")){
		out.print("<script> location.href = '/mypage'</script>");
	}

%>
 --%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="title" value="마이페이지"/>
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
				<div class="col-lg-5 col-12">
					<div class="box">
						<div class="user-bg">
						    <form action="/upload" method="post" enctype="multipart/form-data">
						        <input type="file" id="fileUpload" style="display:none" name="file" onchange="form.submit()"/>
						        <img src="${path }/resources/upload/profile/${loginEmp.empFile}" alt="user" width="200px" height="200px" id="userImage" onclick="document.getElementById('fileUpload').click();"/>
						    </form>
						</div>
						<div class="box-body">
							<div class="row text-center mt-10">
								<div class="col-md-6 border-end">
									<strong>이름</strong>
									<p>${loginEmp.empName}</p>
								</div>
								<div class="col-md-6"><strong>부서</strong>
									<p>${loginEmp.dep.depName}</p>
								</div>
							</div>
							<hr>
							<div class="row text-center mt-10">
								<div class="col-md-6 border-end"><strong>직위</strong>
									<p>${loginEmp.empLv}</p>
								</div>
								<div class="col-md-6"><strong>입사일자</strong>
									<p><fmt:formatDate value="${loginEmp.empEndate}" pattern="yyyy/MM/dd" /></p>
								</div>
							</div>
							<hr>
							<div class="row text-center mt-10">
								<div class="col-md-12"><strong>근태현황</strong>
									<li>지각 : ${coomute['지각수']}</li>
									<li>출근 : ${coomute['출근수']}</li>
									<li>조퇴 : ${coomute['조퇴수']}</li>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-7 col-12">
					<div class="box">
						<div class="box-body px-0 pt-0">
							<div id="calendar" class="dask min-h-400"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row justify-content-center mt-4">
				<div class="col-lg-3 col-12">
					<button class="btn btn-primary holiday plus" data-bs-toggle="modal" data-bs-target="#modal-default">휴가신청</button>
				</div>
				<div class="col-lg-3 col-12">
					<button type="button" class="btn btn-primary startWorkBtn w-100 mb-2" id="startWork">출근등록</button>
				</div>
				<div class="col-lg-3 col-12">
					<button class="btn btn-primary endWorkBtn w-100 mb-2" id="endWork">퇴근등록</button>
				</div>
			</div>
		<!-- /.content -->
		<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="calendarModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="calendarModalLabel">휴가신청</h5>
            </div>
            <div class="modal-body">
                <div id="mycal1"></div>
            </div>
            <div class="modal-footer">
        		<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary holymoly">신청</button>
            </div>
        </div>
    </div>
</div>
</section>
</div>
</div>
<script>
$(document).ready(function() {
    $('.holiday.plus').click(function() {
        $('#calendarModal').modal('show');
    });

    $('.holymoly').click(function() {
        var start = CalendarApp2.selectedRange.start;
        var end = CalendarApp2.selectedRange.end;

        CalendarApp2.onSelect(start, end, false);
    });
});
//세션에서 사용자 정보(empNo)를 가져오는 함수
function getEmpNoFromSession() {
    return ${loginEmp.empNo};
}

document.getElementById('startWork').addEventListener('click',function(){
    var empNo = getEmpNoFromSession();
    var storedDate = localStorage.getItem('startWork_' + empNo);
    var today = new Date().toISOString().slice(0,10);
    if(storedDate != today) {
        sendData('/startWork');
        localStorage.setItem('startWork_' + empNo, today);
    } else {
        alert("오늘은 이미 출근 등록을 하셨습니다.");
    }
});

document.getElementById('endWork').addEventListener('click',function(){
    var empNo = getEmpNoFromSession();
    var storedDate = localStorage.getItem('endWork_' + empNo);
    var today = new Date().toISOString().slice(0,10);
    if(storedDate != today) {
        sendData('/endWork');
        localStorage.setItem('endWork_' + empNo, today);
    } else {
        alert("오늘은 이미 퇴근 등록을 하셨습니다.");
    }
});


function sendData(url) {
    var empNo = getEmpNoFromSession();
    $.ajax({
        url:url,
        type: 'POST',
        data: {'empNo': empNo },
        success: function(response) {
            var message;
            if(url === "/endWork") {
                message = response.time + "시 " + response.message2;
                var userConfirmed = confirm(message);
                if(userConfirmed) {
                    location.reload();
                }
            } else {
                message = response.time + "시 " + response.message;
                alert(message);
            }
        },
        error: function(error) {
            console.error(error);
        }
    });
};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>