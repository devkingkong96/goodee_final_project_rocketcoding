<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
   <footer class="main-footer">
	  &copy; <script>document.write(new Date().getFullYear())</script> All Rights Reserved.
  </footer>
  	<!-- Vendor JS -->
	<script src="${path}/resources/js/vendors.min.js"></script>
	<script src="${path}/resources/js/pages/chat-popup.js"></script>
	<script src="${path}/resources/assets/icons/feather-icons/feather.min.js"></script>
	
	<script src="${path}/resources/assets/vendor_components/moment/min/moment.min.js"></script>
	<script src="${path}/resources/assets/vendor_components/fullcalendar/fullcalendar.js"></script>
	<script src="${path}/resources/assets/vendor_components/ckeditor/ckeditor.js"></script>
	<!-- CRMi App -->
	<script src="${path}/resources/js/template.js"></script>
	<script src="${path}/resources/js/pages/calendar.js"></script>
	<script src="${path}/resources/js/pages/editor.js"></script>
  </body>
</html>