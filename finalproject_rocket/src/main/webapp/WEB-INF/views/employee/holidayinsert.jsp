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
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>