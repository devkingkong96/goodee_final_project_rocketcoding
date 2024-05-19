<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="title" value="마이페이지"/>
</jsp:include>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<style>
    body {
        font-family: 'Nanum Gothic', sans-serif;
        background-color: #f8f9fa;
    }
    .card {
        border-radius: 15px;
        border: none;
        box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.1);
    }
    .card .card-body {
        padding: 1.5rem;
    }
    .card .card-body p,
    .card .card-body h5 {
        color: #6c757d;
    }
    .status-title {
        font-weight: bold;
        color: #343a40;
    }
    .custom-font {
        font-size: 0.9rem;
    }
    .mt-10 {
        margin-top: 10px;
    }
    .user-bg {
        text-align: center;
        margin-bottom: 1.5rem;
    }
    .user-bg img {
        border-radius: 50%;
        border: 4px solid #dee2e6;
        box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.1);
    }
    .clock-container {
    background-color: #9370DB; /* 배경색을 파스텔톤의 보라색으로 변경 */
    color: #fff; /* 글자색 */
    padding: 10px; /* 패딩을 줄임 */
    border-radius: 8px; /* 모서리 둥글기 */
    margin-top: 10px; /* 위쪽 여백 */
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5); /* 그림자 효과 */
    text-align: center; /* 텍스트 중앙 정렬 */
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* 글꼴 */
    font-size: 2em; /* 글자 크기 */
    display: flex; /* Flexbox를 사용하여 내용 중앙 정렬 */
    justify-content: center; /* 가로축에서 중앙 정렬 */
    align-items: center; /* 세로축에서 중앙 정렬 */
    height: 60px; /* 높이를 줄임 */
	}
    #startWorkTime, #endWorkTime {
        font-weight: bold;
        font-size: 1.1em; 
        color: #343a40; 
    }
</style>
<div class="content-wrapper">
    <div class="container-full">
        <section class="content">
            <div class="row">
                <div class="col-lg-5 col-12">
                    <div class="card h-100">
                        <div class="row">
                            <div class="col-lg-3 col-12">
                                <div class="user-bg">
                                    <form action="${path}/upload" method="post" enctype="multipart/form-data">
                                        <input type="file" id="fileUpload" style="display:none" name="file" onchange="form.submit()"/>
                                        <img src="${path}/resources/upload/profile/${loginEmp.empFile}" alt="user" width="200px" height="200px" id="userImage" onclick="document.getElementById('fileUpload').click();"/>
                                    </form>
                                </div>
                            </div>
                            <div class="col-lg-9 col-12">
			                <div class="card-body">
			                    <div class="row text-center mt-10">
			                        <div class="col-md-6 border-end">
			                            <strong>이름</strong>
			                            <p>${loginEmp.empName}</p>
			                        </div>
			                        <div class="col-md-6 border-end">
			                            <strong>부서</strong>
			                            <p>${loginEmp.dep.depName}</p>
			                        </div>
			                    </div>
			                    <hr>
			                    <div class="row text-center mt-10">
			                        <div class="col-md-6 border-end">
			                            <strong>직위</strong>
			                            <p>${loginEmp.empLv}</p>
			                        </div>
			                        <div class="col-md-6 border-end">
			                            <strong>입사일자</strong>
			                            <p><fmt:formatDate value="${loginEmp.empEndate}" pattern="yyyy/MM/dd" /></p>
			                        </div>
			                    </div>
			                </div>
			            </div>
			        </div>
                        <div class="row text-center mt-10">
						    <div class="col-md-12">
						            <strong class="status-title">근태현황</strong> 
						        <table class="table">
						            <tbody>
						            <tr>
						                <td>지각</td>
						                <td>${coomute['지각수']}</td>
						            </tr>
                                    <tr>
                                        <td>출근</td>
                                        <td>${coomute['출근수']}</td>
                                    </tr>
                                    <tr>
                                        <td>조퇴</td>
                                        <td>${coomute['조퇴수']}</td>
                                    </tr>
                                    <tr>
                                        <td>이번달 출근시간</td>
                                        <td>${employee.DWRULES_START}</td>
                                    </tr>		    
                                    <tr>
                                        <td>남은 연차</td>
                                        <td>${employee.HOMOLY}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <hr>
                        <div class="row text-center mt-10">
					    <div class="row justify-content-center mt-4">
					        <div class="col-lg-4 col-12 text-center">
					            <button class="btn btn-primary holiday plus" style="background-color: #9370DB;" data-bs-toggle="modal" data-bs-target="#modal-default">휴가신청</button>
					        </div>
					        <div class="col-lg-4 col-12 text-center">
					            <button type="button" class="btn btn-primary startWorkBtn w-100 mb-2" style="background-color: #9370DB;" id="startWork">출근등록</button>
					            <p id="startWorkTime"></p>
					        </div>
					        <div class="col-lg-4 col-12 text-center">
					            <button class="btn btn-primary endWorkBtn w-100 mb-2" style="background-color: #9370DB;" id="endWork" disabled>퇴근등록</button>
					            <p id="endWorkTime"></p>
					        </div>
					    </div>
                            <div class="col-md-12">
                                <div class="clock-container">
                                    <span id="current-time"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7 col-12">
                    <div class="card h-100">
                        <div class="card-body px-0 pt-0">
                            <div id="calendar" class="dask min-h-400"></div>
                        </div>
                    </div>
                </div>
            </div>
			
		<!-- /.content -->
</section>
</div>
</div>
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
            	<span class="no-holiday" style="display: none;">남은 휴가가 없어요</span>
            </div>
        </div>
    </div>
</div>
<script>
$(function() {
    $('.holiday.plus').click(function(e) {
        var remainingLeave = ${employee.HOMOLY}; 
        var holidayButton = $('.holymoly'); 
        var noHolidayText = $('.no-holiday'); 
        if (remainingLeave <= 0) {
            holidayButton.hide(); 
            noHolidayText.show(); 
            e.preventDefault(); 
        } else {
            holidayButton.show(); 
            noHolidayText.hide(); 
        }
    });
});
</script>
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

// 출근 버튼 클릭 이벤트 리스너
document.getElementById('startWork').addEventListener('click',function(){
    var empNo = getEmpNoFromSession();
    var storedDate = localStorage.getItem('startWork_' + empNo);
    var today = new Date().toISOString().slice(0,10);
    if(storedDate != today) {
        sendData('${path}/startWork');
        localStorage.setItem('startWork_' + empNo, today);
        
        // 출근 시간을 로컬 스토리지에 저장
        var now = new Date();
        var startWorkTimeString = now.getHours().toString().padStart(2, '0') + ':' + now.getMinutes().toString().padStart(2, '0');
        localStorage.setItem('startWorkTime_' + empNo, startWorkTimeString);
        
        // 출근 시간을 화면에 표시합니다.
        document.getElementById('startWorkTime').textContent = '출근시간: ' + startWorkTimeString;
        
        // 출근 버튼을 누른 경우, 퇴근 버튼을 활성화하고 출근 버튼을 숨깁니다.
        document.getElementById('startWork').style.display = 'none';
        document.getElementById('endWork').disabled = false;
    } else {
        alert("오늘은 이미 출근 등록을 하셨습니다.");
    }
});

// 퇴근 버튼 클릭 이벤트 리스너
document.getElementById('endWork').addEventListener('click',function(){
    var empNo = getEmpNoFromSession();
    var storedDate = localStorage.getItem('endWork_' + empNo);
    var today = new Date().toISOString().slice(0,10);
    if(storedDate != today) {
        sendData('${path}/endWork');
        localStorage.setItem('endWork_' + empNo, today);
        
     // 퇴근 시간을 로컬 스토리지에 저장하고 표시합니다.
        var now = new Date();
        var endWorkTimeString = now.getHours().toString().padStart(2, '0') + ':' + now.getMinutes().toString().padStart(2, '0');
        localStorage.setItem('endWorkTime_' + empNo, endWorkTimeString);
        
        // 퇴근 시간을 화면에 표시합니다.
        document.getElementById('endWorkTime').textContent = '퇴근시간: ' + endWorkTimeString;
        
        // 퇴근 버튼을 누른 경우, 퇴근 버튼을 숨깁니다.
        document.getElementById('endWork').style.display = 'none';
    } else {
        alert("오늘은 이미 퇴근 등록을 하셨습니다.");
    }
});

// 서버에 데이터를 보내는 함수
function sendData(url) {
    var empNo = getEmpNoFromSession();
    $.ajax({
        url:url,
        type: 'POST',
        data: {'empNo': empNo },
        success: function(response) {
            var message;
            var now = new Date();
            var timeString = now.getHours().toString().padStart(2, '0') + ':' + now.getMinutes().toString().padStart(2, '0');
            if(url === "${path}/endWork") {
                message = response.time + "시 " + response.message2;
                var userConfirmed = confirm(message);
                if(userConfirmed) {
                    document.getElementById('endWorkTime').textContent = timeString;
                    location.reload();
                }
            } else {
                message = response.time + "시 " + response.message;
                alert(message);
                document.getElementById('startWorkTime').textContent = timeString;
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

    var empNo = getEmpNoFromSession();
    var startWorkDate = localStorage.getItem('startWork_' + empNo);
    var endWorkDate = localStorage.getItem('endWork_' + empNo);
    var today = new Date().toISOString().slice(0,10);
    // 출근 및 퇴근 시간을 로컬 스토리지에서 불러와 표시
    var startWorkTime = localStorage.getItem('startWorkTime_' + empNo);
    var endWorkTime = localStorage.getItem('endWorkTime_' + empNo);

    // 출근 시간 표시
    if (startWorkDate == today && startWorkTime) {
        document.getElementById('startWork').style.display = 'none';
        document.getElementById('endWork').disabled = false;
        document.getElementById('startWorkTime').textContent = '출근시간: ' + startWorkTime;
    } else {
        document.getElementById('startWorkTime').textContent = '';
    }

    // 퇴근 시간 표시
    if (endWorkDate == today && endWorkTime) {
        document.getElementById('endWork').style.display = 'none';
        document.getElementById('endWorkTime').textContent = '퇴근시간: ' + endWorkTime;
    } else {
        document.getElementById('endWorkTime').textContent = '';
    }
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>