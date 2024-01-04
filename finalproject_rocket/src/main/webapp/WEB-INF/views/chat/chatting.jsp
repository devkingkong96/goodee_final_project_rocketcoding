<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<title>채팅 페이지</title>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="채팅 페이지" value=""/>
</jsp:include>
<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
	  <div class="container-full">
		<!-- Main content -->
		<section class="content">
			<div class="row">
				<div class="col-lg-6 col-12">
					<div class="row">
						<div class="col-xxxl-8 col-lg-12 col-12">
							<div class="box">
							  <div class="box-header">
								<div class="media align-items-top p-0">
								  <a class="avatar avatar-lg status-success mx-0" href="#">
									<img src="${path}/resources/images/avatar/2.jpg" class="rounded-circle" alt="...">
								  </a>
									<div class="d-lg-flex d-block justify-content-between align-items-center w-p100">
										<div class="media-body mb-lg-0 mb-20">
											<p class="fs-16">
											  <a class="hover-primary" href="#"><strong><c:out value="${room.CHATROOM_NO }"/></strong></a>
											</p>
											  <p class="fs-12">채팅방 인원 수 : <c:out value="${room.EMP_COUNT }"/></p>
										</div>
										<div>
											<ul class="list-inline mb-0 fs-18">
												<!-- <li class="list-inline-item"><a href="#" class="hover-primary"><i class="fa fa-ellipsis-h"></i></a></li> -->
											</ul>
										</div>
									</div>				  
								</div>             
							  </div>
							  <div class="box-body">
								  <div class="chat-box-one2">
								  	<div class="row">
								  <c:if test="${not empty messages }">
								  <c:forEach var="msg" items="${messages }">
								  <c:choose>
								  <c:when test="${msg.MSG_EMP_NO==empinfo.empNo }">
								  <div class="col-12">
									  <div class="card d-inline-block mb-3 float-end me-2 bg-info max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small"><c:out value="${msg.SEND_AT }"/></span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<strong><p class="mb-0 fs-16"><c:out value="${empinfo.empName }"/></p></strong>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-20">
												<p class="mb-0 text-semi-muted"><c:out value="${msg.MESSAGE }"/></p>
											</div>
										</div>
									  </div>
								  </div>
									  </c:when>
									  <c:otherwise>
									  	<div class="col-12">
									  <div class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small text-muted"><c:out value="${msg.SEND_AT }"/></span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<strong><p class="mb-0 fs-16 text-dark"><c:out value="${msg.MSG_EMP_NO }"/></p></strong>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-20">
												<p class="mb-0 text-semi-muted"><c:out value="${msg.MESSAGE }"/></p>
											</div>
										</div>
									  </div>
									  </div>
									  </c:otherwise>
								  </c:choose>
								  </c:forEach>
								  </c:if>
								  </div>
								  </div>
							  </div>
							  <div class="box-footer no-border">
								 <div class="d-md-flex d-block justify-content-between align-items-center bg-white p-5 rounded10 b-1 overflow-hidden">
										<input class="form-control b-0 py-10" type="text" placeholder="메시지를 작성해주세요." id="msgText">
										<div class="d-flex justify-content-between align-items-center mt-md-0 mt-30">
											<!-- 파일 전송 버튼 -->
											<button type="button" class="waves-effect waves-circle btn btn-circle me-10 btn-outline-secondary">
												<i class="mdi mdi-link"></i>
											</button>
											<!-- <button type="button" class="waves-effect waves-circle btn btn-circle me-10 btn-outline-secondary">
												<i class="mdi mdi-face"></i>
											</button> -->
											<!-- 채팅 전송 버튼 -->
											<button type="button" class="waves-effect waves-circle btn btn-circle btn-primary" id="sendbtn">
												<i class="mdi mdi-send"></i>
											</button>
										</div>
									</div>
							  </div>
							</div>
						</div>
						
					</div>

				</div>
			</div>
		</section>
		<!-- /.content -->
	  </div>
  </div>
  <!-- /.content-wrapper -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
  



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>