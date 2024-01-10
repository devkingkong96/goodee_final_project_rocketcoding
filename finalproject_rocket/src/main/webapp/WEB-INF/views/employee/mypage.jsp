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
<div class="content-wrapper">
	
   <div class="container-full">
      <!-- Main content -->
      <section class="content">
         <div class="content-wrapper">
	  <div class="container-full">
	  		
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
									<li>지각 :</li>
									<li>조퇴 :</li>
									<li>남은연차 :</li>
									<li>사용연차 :</li>
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
					<button class="btn btn-primary w-100 mb-2">휴가신청</button>
				</div>
				<div class="col-lg-3 col-12">
					<button class="btn btn-primary w-100 mb-2">출근등록</button>
				</div>
				<div class="col-lg-3 col-12">
					<button class="btn btn-primary w-100 mb-2">퇴근등록</button>
				</div>
			</div>
		<!-- /.content -->
		<div id="mycal1"></div>
	  </div>
  </div>
      </section>
   </div>
</div>
   <script>
	     document.addEventListener('DOMContentLoaded', function() {
	         var calendarEl = $('#mycal1');
	         var calendar = new FullCalendar.Calendar(calendarEl, {
	                initialView: 'dayGridMonth',
	                events: {
	                    url: '/myPageCalendar',
	                    method: 'GET',
	                    failure: function() {
	                        alert('데이터를 가져오는데 실패하였습니다.');
	                    },
	                }
	            });
	         calendar.render();
	       });
	   </script>
  <!--  function getFormatTime(date){
   var hh=date.getHours();
   hh = hh >= 10 ? hh : '0' +hh;
   var mm =date.getMinutes();
   mm = mm >= 10 ? mm : '0' +mm;
   var ss =date.getSeconds();
   ss = ss >= 10 ? ss : '0' +ss;
   return hh + ':'+mm + ':'+ ss ;
   
}
var time = getFormatTime(new Date()); -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>