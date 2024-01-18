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
        font-size: 1.2em; /* 이 값을 조절하여 원하는 크기로 설정하세요. */
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
  <!-- 검색창 추가 -->
  <div class="row">
    <div class="col-4">
      <div class="box">
        <div class="box-body">
          <form id="search-form">
		    <div class="input-group">
		        <input id="search-input" type="text" autocomplete="off"
		        list="search-dropdown" class="form-control" placeholder="사원이름을 입력하세요" name="employeeName">
		        <div class="input-group-append">
		            <button id="search-button" class="btn btn-secondary" type="submit">검색</button>
		        </div>
		    </div>
		    <datalist id="search-dropdown"></datalist> <!-- 드롭다운 메뉴 위치 추가 -->
		</form>
		<!-- <form id="search-form">
		    <div class="input-group">
		        <input id="search-input" type="text" class="form-control" placeholder="사원이름을 입력하세요" name="employeeName">
		        <div class="input-group-append">
		            <button id="search-button" class="btn btn-secondary" type="submit">검색</button>
		        </div>
		    </div>
		    <select id="search-dropdown"></select> 드롭다운 메뉴 위치 추가
		</form> -->
        </div>
      </div>
    </div>
  </div>

  <!-- 기존 코드 -->
  <div class="row"> 
    <div class="col-lg-5 col-12">
      <div class="box">  
        <div class="box-body">
          <div class="row text-center mt-10 custom-font">
            <div class="col-md-12 custom-font">
            <strong>사원정보</strong>
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
				    <td>사원이름</td>
				    <td id="empName"></td>
				  </tr>
				  <tr>
				    <th scope="row">2</th>
				    <td>부서이름</td>
				    <td id="depName"></td>
				  </tr>
				  <tr>
				    <th scope="row">3</th>
				    <td>직급</td>
				    <td id="empLv"></td>
				  </tr>
				  <tr>
				    <th scope="row">4</th>
				    <td>사원이메일</td>
				    <td id="empEmail"></td>
				  </tr>
				  <tr>
				    <th scope="row">5</th>
				    <td>입사일자</td>
				    <td id="empEndate"></td>
				  </tr>
				</tbody>
              </table>
              <hr>
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
				    <td id="lateCount"></td>
				  </tr>
				  <tr>
				    <th scope="row">2</th>
				    <td>출근</td>
				    <td id="attendanceCount"></td>
				  </tr>
				  <tr>
				    <th scope="row">3</th>
				    <td>조퇴</td>
				    <td id="earlyLeaveCount"></td>
				  </tr>
				  <tr>
				    <th scope="row">4</th>
				    <td>남은 연차</td>
				    <td id="remainingLeave"></td>
				  </tr>
				</tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-7 col-12">
      <div class="box">
        <div class="box-body px-0 pt-0">
          <div id="employeecalendar" class="dask min-h-400"></div>
        </div>
      </div>
    </div>
  </div> 
</section>
<script>
$(document).ready(function() {
    $('#search-input').on('keyup', function(e) {
        var employeeName = $(this).val();

        $.ajax({
            url: '/employeesearch',
            method: 'get',
            data: { employeeName: employeeName },
            success: function(byname) {
                var dropdownMenu = $('#search-dropdown');
                dropdownMenu.empty();

                for (var i = 0; i < byname.length; i++) {
                    var employee = byname[i];
                    dropdownMenu.append('<option>' + employee.EMP_NAME + ' (' + employee.DEP_NAME + ', ' + employee.EMP_LV + ', ' + employee.EMP_NO + ')</option>');
                }
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    });
});
</script>
<script>
$(document).ready(function() {
	  $('#search-form').on('submit', function(e) {
	    e.preventDefault();
	    var employeeName = $('#search-input').val();
	    var index = employeeName.indexOf(" ");
        var dataToSend = { employeeName: index >= 0 ? employeeName.substring(0, index) : employeeName };
		
        console.log(dataToSend);  

        $.ajax({
            url: '/employeeCalendar',
            method: 'get',
            data: dataToSend,
            success: function(byname) {
                console.log(byname);
                $('#empName').text(byname['EMP_NAME']);
                $('#depName').text(byname['DEP_NAME']);
                $('#empLv').text(byname['EMP_LV']);
                $('#empEmail').text(byname['EMP_EMAIL']);
                var date = new Date(byname['EMP_ENDATE']);
                $('#empEndate').text(date.toLocaleDateString());
                $('#lateCount').text(byname['지각수']);
                $('#attendanceCount').text(byname['출근수']);
                $('#earlyLeaveCount').text(byname['조퇴수']);
                $('#remainingLeave').text(byname['HOMOLY']);
                $('#search-input').val('');
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    });
});
</script>
<script>
var employeeName = '';

$(document).ready(function() {
    $('#employeecalendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultDate: new Date(),
        navLinks: false,
        editable: false,
        eventLimit: true,
        events: function(start, end, timezone, callback) {
            $.ajax({
                url: '/myevents/' + employeeName,
                method: 'GET',
                success: function(data) {
                	var events = data.map(function(event) {
                        var color;
                        switch(event.STATUS) {
                            case '지각':
                                color = 'red';
                                break;
                            case '조퇴':
                                color = 'orange';
                                break;
                            case '출근':
                                color = 'green';
                                break;
                            case '휴가승인':
                                color = 'blue';
                                break;
                            default:
                                color = 'gray'; 
                        }
                        return {
                            title: event.STATUS,
                            start: event.START_DAY,
                            end: event.END_DAY,
                            color: color
                        };
                    });
                    callback(events);
                },
            });
        },
        loading: function(bool) {
            $('#loading').toggle(bool);
        }
    });

    $('#search-form').on('submit', function(e) {
        e.preventDefault();
        var inputName = $('#search-input').val();
        var index = inputName.indexOf(" ");
        employeeName = index >= 0 ? inputName.substring(0, index) : inputName;
        $('#employeecalendar').fullCalendar('refetchEvents');
        $('#search-input').val('');
    });
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>