<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<title>채팅방 목록</title>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="채팅방 목록" value=""/>
</jsp:include>
<!-- Content Wrapper. Contains page content -->
<%-- <form action="${path }/chat/room" method="post"> --%>
<form id="Roomfrm">
<input type="hidden" name="logempNo" value="${logempNo.EMP_NO }"/>
  <div class="content-wrapper">
	  <div class="container-full">
		<!-- Main content -->
		<section class="content">
			<div class="row">
				<div class="col-lg-6 col-12">
					<div class="box">
						<div class="box-header">
						<div class="row">
							<div class="col-lg-6 col-12">
								<span class="fs-20">채팅방 목록</span>
							</div>
							<div class="col-lg-6 col-12">
								<button type="button" class="btn btn-danger float-end" id="chatRoomDelete" disabled>방 나가기</button>
							</div>
						</div>
						<div class="col-lg-12 col-12">
						<div class="box-controls pull-right mt-2">
							<div class="box-header-actions">
							  <div class="lookup lookup-sm lookup-right d-none d-lg-block">
								<input type="text" name="s" id="searchRoom" placeholder="Search">
							  </div>
							</div>
					  	</div>
					  	</div>
						</div>
						<div class="box-body">
							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane active" id="messages" role="tabpanel">
									<div class="chat-box-one-side3" id="chatroomListDiv">
									<c:if test="${not empty chatlist }">
									<c:forEach var="c" items="${chatlist }">
										<div class="media-list media-list-hover" id="listroom${c.CHATROOM_NO }">
											<div class="media">
											  <%-- <p class="align-self-center me-0"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/2.jpg" alt="..."></p> --%>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="${path }/chat/room/${c.CHATROOM_NO}"><strong><c:out value="${c.CHATROOM_NAME }"/></strong></a>
												  <span class="float-end fs-10"><fmt:formatDate value="${c.CREATED_AT }" pattern="yyyy.MM.dd" /></span>
												</p>
												<%-- <p>참여 인원 수 : <c:out value="${c.EMP_COUNT }"/></p> --%>
												<!-- <p>마지막 채팅 내역 : </p> -->
											  </div>
											  <input type="checkbox" id="ch${c.CHATROOM_NO }" class="filled-in chk-col-danger" name="roomCheck" value="${c.CHATROOM_NO}"/>
												<label for="ch${c.CHATROOM_NO }"> </label>
											</div>
											
											</div>
											</c:forEach>
											</c:if>
											
										</div>
									</div>
								</div>
								
								
								
							</div>
						</div>
						
					</div>
				
                    <div class="col-lg-4 col-12">
                        <div class="box">
                            <div class="box-header">
                            	<div class="row">
								<div class="col-lg-6 col-12">
									<span class="fs-20">직원 목록</span>
								</div>
								<div class="col-lg-6 col-12">
									<button type="button" class="btn btn-primary float-end" id="chatRoomCreate"  data-bs-toggle="modal" data-bs-target="#modal-default" disabled>채팅방 생성</button>
								</div>
								</div>
								<div class="col-lg-12 col-12">
								  <div class="box-controls pull-right mt-2">
									<div class="box-header-actions">
									  <div class="lookup lookup-sm lookup-right d-none d-lg-block">
										<input type="text" name="s" id="searchEmp" placeholder="Search">
									  </div>
									</div>
								  </div>
								</div>
                            </div>
                            <div class="box-body">
                                    <div class="tab-pane" id="contacts" role="tabpanel">
                                        <div class="chat-box-one-side3" id="empParentDiv">
                                            <c:if test="${not empty emplist }">
												<c:forEach var="e" items="${emplist }">
	                                              <div class="media-list media-list-hover" id="empslist${e.EMP_NO }">
	                                                <div class="media py-10 px-0 align-items-center">
	                                                  <p class="avatar avatar-lg status-success">
	                                                    <img src="${path}/resources/upload/profile/${e.EMP_FILE}" alt="...">
	                                                  </p>
	                                                  <div class="media-body">
	                                                    <p class="fs-20">
	                                                      <c:out value="${e.EMP_NAME }"/>
	                                                    </p>
	                                                    <p><c:out value="${e.EMP_LV }"/> / <c:out value="${e.DEP_NAME }"/></p>
	                                                  </div>
	                                                  
	                                                  	<input type="checkbox" id="emp${e.EMP_NO }" class="filled-in chk-col-primary" name="empCheck" value="${e.EMP_NO}"/>
														<label for="emp${e.EMP_NO }"> </label>
	                                                  
	                                                </div>
	                                              </div>
                                             </c:forEach>
                                           </c:if>
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
<!-- modal Area -->              
  <div class="modal fade" id="modal-default">
	  <div class="modal-dialog" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h4 class="modal-title" ><strong>채팅방 생성하기</strong></h4>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div class="modal-body">
		  	<table class="table table-striped-columns">
				<tr>
					<td>채팅방 이름</td>
					<td><input type="text" id="roomName" name="roomName"/></td>
				</tr>
				<!-- <tr>
					<td>채팅방 인원수</td>
					<td><input type="text" id="count" name="count"/></td>
				</tr>  -->
			</table>
		  </div>
		  <div class="modal-footer">
			<button type="button" id="createBtn" class="btn btn-info float-end" disabled>생성</button>
			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		  </div>
		</div>
		<!-- /.modal-content -->
	  </div>
	  <!-- /.modal-dialog -->
  </div>
</form>
  <!-- /.modal -->
  
  
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>
	var userno = '${logempNo.EMP_NO}';
	var username='${logempNo.EMP_NAME }';
	var userlv='${logempNo.EMP_LV}';
	var userdept='${logempNo.DEP_NAME}';
	var empcheck = document.getElementsByName('empCheck');
	var roomcheck = document.getElementsByName('roomCheck');
	var roomcreatebtn = document.getElementById('chatRoomCreate');
	var deletebtn = document.getElementById('chatRoomDelete');
	var createbtn = document.getElementById('createBtn');
	var path = "${path}";
	console.log(path);
</script>
<script src="${path }/resources/js/chat/list.js" type="text/javascript"></script>
<script src="${path }/resources/js/chat/common.js" type="text/javascript"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>