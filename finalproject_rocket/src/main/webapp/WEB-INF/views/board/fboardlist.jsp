<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="$${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="" />
</jsp:include>
<div class="content-wrapper">
	<div class="container-full">
		<!-- Main content -->
		<section class="content">
			<div headclass="box-er with-border"></div>
			<div class="box">
				<div class="box-body with-border">
					<div class="table-responsive">
						<table id="example"
							class="table table-bordered table-hover display nowrap margin-top-10 w-p100">
							<body>
							<thead>
								<h1>공지사항</h1>
								<hr color="black" size="7">
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>조회수</th>
									<th>작성일</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			</body>
		</section>
	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />