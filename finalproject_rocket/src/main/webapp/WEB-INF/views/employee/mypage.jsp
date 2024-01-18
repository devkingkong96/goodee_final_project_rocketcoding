<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
	.box-body .row div {
	    padding: 5px 0; /* 상하 패딩 */
	}
	.box-body .row {
	    align-items: center; /* 세로축에서 중앙 정렬 */
	}
    .clock-container {
	    background-color: #333; /* 배경색 */
	    color: #fff; /* 글자색 */
	    padding: 20px; /* 패딩 */
	    border-radius: 8px; /* 모서리 둥글기 */
	    margin-top: 10px; /* 위쪽 여백 */
	    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5); /* 그림자 효과 */
	    text-align: center; /* 텍스트 중앙 정렬 */
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* 글꼴 */
	    font-size: 2em; /* 글자 크기 */
	    display: flex; /* Flexbox를 사용하여 내용 중앙 정렬 */
	    justify-content: center; /* 가로축에서 중앙 정렬 */
	    align-items: center; /* 세로축에서 중앙 정렬 */
	    height: 100px; /* 높이 설정 */
	}
	.custom-font {
        font-size: 1.1em; /* 이 값을 조절하여 원하는 크기로 설정하세요. */
        font-weight: bold; /* 'bold'는 두껍게, 'normal'은 일반적으로 설정합니다. */
    }
    .custom-table {
        border-collapse: collapse;
        width: 100%;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .custom-table thead {
        background-color: #f2f2f2;
    }
    .custom-table th, .custom-table td {
        border: 1px solid #ddd;
        padding: 8px;
    }
    .custom-table th {
        padding-top: 12px;
        padding-bottom: 12px;
        text-align: left;
        color: #333;
    }
}
</style>
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
			                    <img src="${path}/resources/upload/profile/${loginEmp.empFile}" alt="user" width="200px" height="200px" id="userImage" onclick="document.getElementById('fileUpload').click();"/>
			                </form>
			            </div>
			           <div class="box-body">
			    <div class="row text-center mt-10 custom-font">
			        <div class="col-md-6 border-end">
			            <strong>이름</strong>
			            <p>${loginEmp.empName}</p>
			        </div>
			        <div class="col-md-6">
			            <strong>부서</strong>
			            <p>${loginEmp.dep.depName}</p>
			        </div>
			    </div>
			    <hr>
			    <div class="row text-center mt-10 custom-font">
			        <div class="col-md-6 border-end">
			            <strong>직위</strong>
			            <p>${loginEmp.empLv}</p>
			        </div>
			        <div class="col-md-6">
			            <strong>입사일자</strong>
			            <p><fmt:formatDate value="${loginEmp.empEndate}" pattern="yyyy/MM/dd" /></p>
			        </div>
			    </div>
			    <hr>
			    <div class="row text-center mt-10 custom-font">
    <div class="col-md-12 custom-font">
        <strong>근태현황</strong>
		        <table class="custom-table custom-font">
		  <thead>
		    <tr>
		      <th scope="col"></th>
		      <th scope="col">항목</th>
		      <th scope="col">수치</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th scope="row">1</th>
		      <td>지각</td>
		      <td>${coomute['지각수']}</td>
		    </tr>
		    <tr>
		      <th scope="row">2</th>
		      <td>출근</td>
		      <td>${coomute['출근수']}</td>
		    </tr>
		    <tr>
		      <th scope="row">3</th>
		      <td>조퇴</td>
		      <td>${coomute['조퇴수']}</td>
		    </tr>
		    <tr>
		      <th scope="row">4</th>
		      <td>이번달 출근시간</td>
		      <td>${employee.DWRULES_START}</td>
		    </tr>		    
		    <tr>
		      <th scope="row">5</th>
		      <td>남은 연차</td>
		      <td>${employee.HOMOLY}</td>
		    </tr>
		  </tbody>
		</table>
    </div>
</div>
                <hr>
                <div class="row text-center mt-10">
                    <div class="col-md-12">
                        <div class="clock-container">
                            <span id="current-time"></span>
                        </div>
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
        // form 제출
        document.querySelector("#holy").submit();
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
function updateClock() {
    var now = new Date(); 
    var hours = now.getHours().toString().padStart(2, '0'); 
    var minutes = now.getMinutes().toString().padStart(2, '0'); 
    var seconds = now.getSeconds().toString().padStart(2, '0'); 
    var timeString = hours + ':' + minutes + ':' + seconds;
    document.getElementById('current-time').textContent = timeString;
}

window.onload = function() {
    updateClock();
    setInterval(updateClock, 1000);
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>