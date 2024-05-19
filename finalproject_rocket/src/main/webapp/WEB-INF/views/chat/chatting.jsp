<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
/* 모달 스타일 */
.modal {
  display: none; /* 모달 초기에는 보이지 않도록 설정 */
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto; /* 내용이 넘칠 경우 스크롤 가능하게 설정 */
  background-color: rgba(0, 0, 0, 0.5); /* 배경을 어둡게 표시 */
}

.modal-open {
  overflow: hidden;
}

.user-modal-content {
  background-color: #fefefe;
  margin: 5% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  max-width: 400px;
}

#employeeList{
	height: 400px; /* 원하는 높이 값으로 설정 */
	overflow-y: auto; /* 내용 넘칠 경우 스크롤 설정 */
}

.employees-modal-content {
  background-color: #fefefe;
  margin: 1% auto; /* 모달 화면 중앙으로 배치 */
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  max-height: 100%;
  max-width: 600px;
}

.span-div{
	text-align: right;
}

.close {
  color: #aaa;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  cursor: pointer;
}

</style>
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
				<div class="col-lg-10 col-12">
					<div class="row">
						<div class="col-xxxl-8 col-lg-8 col-12">
							<div class="box">
							  <div class="box-header">
								<div class="media align-items-top p-0">
								  <%-- <a class="avatar avatar-lg status-success mx-0" href="#">
									<img src="${path}/resources/images/avatar/2.jpg" class="rounded-circle" alt="...">
								  </a> --%>
									<div class="d-lg-flex d-block justify-content-between align-items-center w-p100">
										<div class="media-body mb-lg-0 mb-20">
											<p class="fs-16">
											  <a class="hover-primary" href="#"><strong><c:out value="${room.CHATROOM_NAME }"/></strong></a>
											</p>
											  <p class="fs-12" id="numOfChatRoom">채팅방 인원 수 : <c:out value="${num}"/></p>
										</div>
										<div>
											<ul class="box-controls pull-right">
											  <li class="dropdown">
												<a data-bs-toggle="dropdown" href="#"><i class="ti-more-alt rotate-180"></i></a>
												<div class="dropdown-menu dropdown-menu-end">
												  <a class="dropdown-item" id="modalchatinvite"><i class="mdi mdi-account-plus"></i>초대하기</a>
												  <div class="dropdown-divider"></div>
												  <a class="dropdown-item" onclick="leaveRoom()"><i class="mdi mdi-close-box-outline"></i>방 나가기</a>
												</div>
											  </li>
											</ul>
										</div>
									</div>				  
								</div>             
							  </div>
							  <div class="box-body">
								  <div class="chat-box-one2" id="scrollStart">
								  	<div class="row" id="startMsg">
								  <c:if test="${not empty messages }">
								  <c:forEach var="msg" items="${messages }">
								  <div class="col-12">
								  <c:choose>
								  <c:when test="${msg.MSG_EMP_NO==empinfo.EMP_NO }">
									  <div class="card d-inline-block mb-3 float-end me-2 bg-info max-w-p80">
								  </c:when>
								  <c:otherwise>
									  <div class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80">
								  </c:otherwise>
								  </c:choose>
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small"><fmt:formatDate value="${msg.SEND_AT }" type="time" timeStyle="short" /> </span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<strong><p class="mb-0 fs-16"><c:out value="${msg.MSG_EMP_NAME }"/></p></strong>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-20">
											<c:choose>
												<c:when test="${not empty msg.MESSAGE }">
														<p class="mb-0 text-semi-muted"><c:out value="${msg.MESSAGE }"/></p>
												</c:when>
												<c:when test="${not empty msg.MSG_FI_RENAME && msg.MSG_EMP_NO!=empinfo.EMP_NO}">
													<img src="${path}/resources/upload/chatfile/${msg.MSG_FI_RENAME}" width="200" height="200" alt="user" class="chatUpFile" id="chatUpFile${msg.MESSAGE_ID }">
													<button class="btn fa fa-download" id="downBtn" name="downBtn" onclick="window.location.replace('${path}/chat/file/download?reName=${msg.MSG_FI_RENAME }&oriName=${msg.MSG_FI_ORINAME }')"></button>
												</c:when>
												<c:otherwise>
													<button class="btn fa fa-download" id="downBtn" name="downBtn" onclick="window.location.replace('${path}/chat/file/download?reName=${msg.MSG_FI_RENAME }&oriName=${msg.MSG_FI_ORINAME }')"></button>
													<img src="${path}/resources/upload/chatfile/${msg.MSG_FI_RENAME}" width="200" height="200" alt="user" class="chatUpFile" id="chatUpFile${msg.MESSAGE_ID }">
												</c:otherwise>
											</c:choose>
											</div>
										</div>
									  </div>
								  </div>
								  </c:forEach>
								  </c:if>
								  </div>
								  <div id="inputtingDiv" style="display:none;">메시지 입력중입니다...</div>
								  </div>
							  </div>
							  <div class="box-footer no-border">
								 <div class="d-md-flex d-block justify-content-between align-items-center bg-white p-5 rounded10 b-1 overflow-hidden">
										<input class="form-control b-0 py-10" type="text" placeholder="메시지를 작성해주세요." id="msgText"/>
											<form id="fileUploadfrm" name="fileUploadfrm" enctype="multipart/form-data">
										<div class="d-flex justify-content-between align-items-center mt-md-0 mt-30">
											<!-- 파일 전송 버튼 -->
												<input type="file" id=chatFileUpload name="chatFileUpload" style="display:none"/>
												<button type="button" class="waves-effect waves-circle btn btn-circle me-10 btn-outline-secondary" onclick="document.getElementById('chatFileUpload').click();">
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
											</form>
									</div>
							  </div>
							</div>
						</div>
						<div class="col-lg-4 col-12">
                        <div class="box">
                            <div class="box-header">
                            	<div class="row">
									<p class="fs-20">참석 목록</p>
								</div>
                            </div>
                            <div class="box-body">
                            	<div class="tab-pane" id="contacts" role="tabpanel">
                                        <div class="chat-box-one-side3" id="emplistDiv">
                                            	<c:if test="${not empty emplist }">
												<c:forEach var="e" items="${emplist }">
                                            <div class="media-list media-list-hover" id="attendlist${e.EMP_NO }">
                                                <div class="media py-10 px-0 align-items-center">
                                                  <p class="avatar avatar-lg status-success">
                                                    <img src="${path}/resources/upload/profile/${e.EMP_FILE}" alt="...">
                                                  </p>
                                                  <div class="media-body">
                                                    <p class="fs-20" id="chatEmpName${e.EMP_NO }">
                                                      <c:out value="${e.EMP_NAME }"/>
                                                    </p>
                                                    <p id="chatEmpLv${e.EMP_NO }"><c:out value="${e.EMP_LV }"/> / <c:out value="${e.DEP_NAME }"/></p>
                                                  </div>
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
				</div>
			</div>
		</section>
		<!-- /.content -->
	  </div>
  </div>
  <!-- 파일전송 모달 창 -->
	<div id="previewModal" class="modal">
	  <div class="user-modal-content">
	  <div class="span-div">
	    <span id="upModalClose" class="close" onclick="upModalClose()">&times;</span>
	  </div>
	    <p><strong>파일 전송</strong></p>
	    <img width='300' height='300' id="previewImage" src="" alt="미리보기 이미지">
	    <p id="fileName"></p>
	    <p id="fileSize"></p>
	    <button onclick="sendFile()">전송</button>
	  </div>
	</div>
	<!-- 방 직원 초대 모달 창 -->
	<div id="inviteModal" class="modal">
		<div class="employees-modal-content">
			<div class="span-div">
		    	<span id="inviteModalClose" class="close" onclick="inviteModalClose()">&times;</span>
		  	</div>
			<h3>대화 상대 초대하기</h3>
			<div class="box-controls mt-2">
				<div class="box-header-actions">
					<div class="lookup lookup-sm lookup-left d-none d-lg-block">
						<input type="text" name="modalSearchEmp" id="modalSearchEmp" placeholder="Search">
					</div>
				</div>
			</div>
			<form id="inviteEmpList">
			<input type="hidden" name="roomId" id=roomId value="${room.CHATROOM_NO }"/>
			<div id="employeeList">
               <c:if test="${not empty emplistAll }">
					<c:forEach var="e" items="${emplistAll }">
                    	<div class="media-list media-list-hover" id="emplist${e.EMP_NO }">
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
                                   <input type="checkbox" id="emp${e.EMP_NO }" class="filled-in chk-col-primary" name="plustempCheck" value="${e.EMP_NO}"/>
								   <label for="emp${e.EMP_NO }"> </label>
                                </div>
                        	</div>
                           </c:forEach>
                          </c:if>
			</div>
			</form>
				<button type="button" class="btn btn-primary float-right" id="invitebtn" onclick="inviteEmployees()" disabled>초대</button>
				<button type="button" class="btn btn-light float-right" onclick="inviteModalClose()">취소</button>
		</div>
	</div>
	
  <!-- /.content-wrapper -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.10.7/dayjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.10.7/locale/ko.min.js"></script>
  	<script>
  		dayjs.locale('ko');
  		var roomId='${room.CHATROOM_NO }';
  		var username='${empinfo.EMP_NAME }';
  		var userno='${empinfo.EMP_NO }';
  		var userlv='${empinfo.EMP_LV}';
  		var userdept='${empinfo.DEP_NAME}';
  		var userfile='${empinfo.EMP_FILE}';
  		var path = '${path}';
		var date = dayjs();
		var nowDate = date.format("a HH:mm");
		
		
  	</script>

	<script src="${path }/resources/js/chat/room.js" type="text/javascript"></script>
	<script src="${path }/resources/js/chat/common.js" type="text/javascript"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>