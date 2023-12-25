<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<title>로켓코딩ERP</title>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="메인페이지"/>
</jsp:include>
<div class="content-wrapper">
	<div class="container-full">
		<!-- Main content -->
		<section class="content">
			<div class="row">
				<!-- 공지사항 row -->
				<div class="col-lg-6 col-12">
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">공지사항</h3>
						</div>
						<div class="box-body">
							<span class="text-muted">최신 목록</span>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-12">
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">자유게시판</h3>
						</div>
						<div class="box-body">
							<span class="text-muted">최신 목록</span>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-12">
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">전자결재</h3>
						</div>
						<div class="box-body">
							<span class="text-muted">결재 목록</span>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-12">
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">캘린더</h3>
						</div>
						<div class="box-body">
						
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>