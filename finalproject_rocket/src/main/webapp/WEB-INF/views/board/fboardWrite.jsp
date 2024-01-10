<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="" />
</jsp:include>
<body>
	<div class="content-wrapper">
		<div class="container-full">
			<!-- Main content -->
			<h3 class="box-title">글 작성</h3>
			<hr color="black" size="7">

			<form id="boardfrm" method="post" action="">
				<taber>

				</taber>						     
			</form>

			<!-- Vendor JS -->
			<script src="src/resources/js/vendors.min.js"></script>
			<script src="src/resources/js/pages/chat-popup.js"></script>
			<script
				src="src/resources/js/assets/icons/feather-icons/feather.min.js"></script>
			<script
				src="src/resources/js/assets/vendor_components/datatable/datatables.min.js"></script>

			<!-- CRMi App -->
			<script src="src/resources/js/template.js"></script>

			<script src="src/resources/js/pages/data-table.js"></script>
</body>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />