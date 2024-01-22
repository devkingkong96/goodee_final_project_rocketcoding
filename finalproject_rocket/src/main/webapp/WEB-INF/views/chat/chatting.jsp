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
								  <a class="avatar avatar-lg status-success mx-0" href="#">
									<img src="${path}/resources/images/avatar/2.jpg" class="rounded-circle" alt="...">
								  </a>
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
                                                    <img src="${path}/resources/images/avatar/1.jpg" alt="...">
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
                                        <img src="${path}/resources/images/avatar/1.jpg" alt="...">
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
  			/* var today=new Date(); */
  			/* var time=today.toLocaleString(); */
  			/* console.log(time); */
  	
  			var roomId='${room.CHATROOM_NO }';
  			var username='${empinfo.EMP_NAME }';
  			var userno='${empinfo.EMP_NO }';
  			var userlv='${empinfo.EMP_LV}';
  			var userdept='${empinfo.DEP_NAME}';
  			
  			/* console.log("로그인한 직원 번호 : "+userno); */
  			
  			var sockJS=new SockJS("/ws/chat");
  			var stomp=Stomp.over(sockJS);
  			
  			//Stomp 연결 시 실행
  			stomp.connect({},onConnected,onError);
  			
  			//연결 성공했을 때 실행하는 함수
  			function onConnected(){
  				console.log("stomp 연결 성공");
  				
  				//subscribe(path,callback)으로 메세지 받기 가능
  				
  				//sub 할 url -> /sub/chat/room/roomId로 구독 시작
  				stomp.subscribe("/sub/chat/room/"+roomId,onMessageReceived);
  				//StompChatController의 @MessageMapping("/chat/enter")에서 template.convertAndSend()를 통해 메시지 전달받음.
  				 stomp.send("/pub/chat/enter",{},JSON.stringify({
			            msgRoomNo: roomId,
			            msgEmpName: username,
			            type: 'ENTER'
			        })
			    )
  			}
  			
  			//메시지 수신
  			function onMessageReceived(payload){
  				
  				
  				var chat=JSON.parse(payload.body);
  				console.dir(chat.type);
  				
  				if(chat.type==="LEAVEROOM"){
  					var data={roomId:roomId}
  					$.ajax({
  		  				type:'POST',
  		  				url:'${path}/chat/room/numOfChatRoom',
  		  				data:JSON.stringify(data),
  		  				dataType:"json",
						contentType:"application/json",
  		  				success(data){
  		  					document.getElementById('numOfChatRoom').innerHTML="채팅방 인원 수 : " + data;
  		  				},
  		  				error:function(error){
  		  					alert('에러:'+error);
  		  				}
  		  			});
  					var empNo = chat.msgEmpNo;
  					var depName = chat.depName;
  					var empLv = chat.empLv;
  					var empName = chat.msgEmpName;
  					
  					console.log("empNo:"+empNo);
  					
						var delDiv = document.getElementById('attendlist'+empNo);
						console.log("delDiv:"+delDiv);
						/* parentDiv.removeChild(delDiv); */
						
						if(delDiv){
							delDiv.remove();
						}
						
						// 방 나간 직원 초대 목록에 추가
  						var $chatbox = document.createElement('div');
  						$chatbox.classList.add('media-list', 'media-list-hover');
  						$chatbox.id = 'emplist' + empNo;

  						// 내부 요소들 생성

  						var $media = document.createElement('div');
  						$media.classList.add('media', 'py-10', 'px-0', 'align-items-center');

  						var $avatar = document.createElement('p');
  						$avatar.classList.add('avatar', 'avatar-lg', 'status-success');

  						var $avatarImage = document.createElement('img');
  						$avatarImage.src = '${path}/resources/images/avatar/1.jpg';
  						$avatarImage.alt = '...';

  						var $mediaBody = document.createElement('div');
  						$mediaBody.classList.add('media-body');

  						var $empName = document.createElement('p');
  						$empName.classList.add('fs-20');
  						$empName.textContent = empName;

  						var $empLv = document.createElement('p');
  						$empLv.textContent = empLv + " / " + empName;

  						var $checkbox = document.createElement('input');
  						$checkbox.type = 'checkbox';
  						$checkbox.id = 'emp' + empNo;
  						$checkbox.classList.add('filled-in', 'chk-col-primary');
  						$checkbox.name = 'plustempCheck';
  						$checkbox.value = empNo;

  						var $label = document.createElement('label');
  						$label.setAttribute('for', 'emp' + empNo);

  						// 요소들을 적절한 구조로 추가
  						$avatar.appendChild($avatarImage);
  						$mediaBody.appendChild($empName);
  						$mediaBody.appendChild($empLv);
  						$media.appendChild($avatar);
  						$media.appendChild($mediaBody);
  						$media.appendChild($checkbox);
  						$media.appendChild($label);
  						$chatbox.appendChild($media);

  						// 요소를 원하는 위치에 추가
  						var targetElement = document.getElementById('employeeList');
  						targetElement.appendChild($chatbox);
  				}
  				
  				if(chat.type==="ROOMINVITE"){
  					var data={roomId:roomId}
  					$.ajax({
  		  				type:'POST',
  		  				url:'${path}/chat/room/numOfChatRoom',
  		  				data:JSON.stringify(data),
  		  				dataType:"json",
						contentType:"application/json",
  		  				success(data){
  							console.log("꺄아악"+data);
  		  					document.getElementById('numOfChatRoom').innerHTML="채팅방 인원 수 : " + data;
  		  				},
  		  				error:function(error){
  		  					alert('에러:'+error);
  		  				}
  		  			});
  					
  					document.getElementById('emplistDiv').innerHTML="";
  					chat.inPerson.forEach(map=>{
  					// 새로운 div 요소 생성
  						var $chatbox = document.createElement('div');
  						$chatbox.classList.add('chat-box-one-side3');
  						$chatbox.id = 'emplistDiv';

  						// 내부 요소들 생성
  						var $mediaList = document.createElement('div');
  						$mediaList.classList.add('media-list', 'media-list-hover');
  						$mediaList.id = 'attendlist' + map.EMP_NO;

  						var $media = document.createElement('div');
  						$media.classList.add('media', 'py-10', 'px-0', 'align-items-center');

  						var $avatar = document.createElement('p');
  						$avatar.classList.add('avatar', 'avatar-lg', 'status-success');

  						var $avatarImage = document.createElement('img');
  						$avatarImage.src = '${path}/resources/images/avatar/1.jpg';
  						$avatarImage.alt = '...';

  						var $mediaBody = document.createElement('div');
  						$mediaBody.classList.add('media-body');

  						var $empName = document.createElement('p');
  						$empName.classList.add('fs-20');
  						$empName.id = 'chatEmpName'+map.EMP_NO;
  						$empName.textContent = map.EMP_NAME;

  						var $empLv = document.createElement('p');
  						$empLv.id = 'chatEmpLv'+map.EMP_NO;
  						$empLv.textContent = map.EMP_LV + " / " + map.DEP_NAME;


  						// 요소들을 적절한 구조로 추가
  						$avatar.appendChild($avatarImage);
  						$mediaBody.appendChild($empName);
  						$mediaBody.appendChild($empLv);
  						$media.appendChild($avatar);
  						$media.appendChild($mediaBody);
  						$mediaList.appendChild($media);
  						$chatbox.appendChild($mediaList);

  						// 요소를 원하는 위치에 추가
  						var targetElement = document.getElementById('emplistDiv');
  						targetElement.appendChild($chatbox); 
  					});
  					
  					chat.delEmps.forEach((emp)=>{
  						console.log("삭제할 emp 목록"+emp);
  						var parentDiv = document.getElementById('inviteEmpList');
  						var delDiv = document.getElementById('emplist'+emp);
  						console.log("delDiv:"+delDiv);
  						/* parentDiv.removeChild(delDiv); */
  						
  						if(delDiv){
  							delDiv.remove();
  						}
  						
  					});
  				}
  				//chat.forEach((map)=>{
  				//	console.dir(map);
  					/* if(map.get("type")==="ROOMINVITE"){
  						
  					map.delete("type");
  					document.getElementById('emplist').innerHTML="";
  					for(let i=0;i<chat.length;i++){
  						const emp=chat[i];
  					// 새로운 div 요소 생성
  						var $chatbox = document.createElement('div');
  						$chatbox.classList.add('chat-box-one-side3');

  						// 내부 요소들 생성
  						var $mediaList = document.createElement('div');
  						$mediaList.classList.add('media-list', 'media-list-hover');

  						var $media = document.createElement('div');
  						$media.classList.add('media', 'py-10', 'px-0', 'align-items-center');

  						var $avatar = document.createElement('p');
  						$avatar.classList.add('avatar', 'avatar-lg', 'status-success');

  						var $avatarImage = document.createElement('img');
  						$avatarImage.src = '${path}/resources/images/avatar/1.jpg';
  						$avatarImage.alt = '...';

  						var $mediaBody = document.createElement('div');
  						$mediaBody.classList.add('media-body');

  						var $empName = document.createElement('p');
  						$empName.classList.add('fs-20');
  						$empName.id = 'chatEmpName'+emp.EMP_NO;
  						$empName.textContent = emp.EMP_NAME;

  						var $empLv = document.createElement('p');
  						$empLv.id = 'chatEmpLv'+emp.EMP_NO;
  						$empLv.textContent = emp.EMP_LV + " / " + emp.DEP_NAME;


  						// 요소들을 적절한 구조로 추가
  						$avatar.appendChild($avatarImage);
  						$mediaBody.appendChild($empName);
  						$mediaBody.appendChild($empLv);
  						$media.appendChild($avatar);
  						$media.appendChild($mediaBody);
  						$mediaList.appendChild($media);
  						$chatbox.appendChild($mediaList);

  						// 요소를 원하는 위치에 추가
  						var targetElement = document.getElementById('emplist');
  						targetElement.appendChild($chatbox); */
  					//}
  					//}
  				//});
  				
  				
  				//작성자,메시지 내용,발신 시간 값 가져오기
  				var writer=chat.msgEmpNo;
  				var writerName=chat.msgEmpName;
  				var message=chat.message;
  				var sendAt=chat.sendAt;
  				var type=chat.type;
  				var msgFiOriName=chat.msgFiOriName;
  				var msgFiReName=chat.msgFiReName;
  				
  				/* console.log("보낸 사람 : "+writer);
  				console.log("로그인한 사람 : "+userno); */
  				

  				
  				
  				// 결과 출력
  				dayjs.locale('ko');
  				var date = dayjs();
  				var nowDate = date.format("a HH:mm");

  				
  				var sendAt = nowDate;
  				
  				
  				if(type==='TALK'){
  				//화면 출력할 태그들 생성하기
  				const $div = document.createElement("div");
					  $div.classList.add("col-12");
  				
				const $card = document.createElement("div");
  				//채팅 작성자가 본인이라면
  				if(writer==userno){
					$card.classList.add("card", "d-inline-block", "mb-3", "float-end", "me-2", "bg-info", "max-w-p80");
  				}else{
  					$card.classList.add("card", "d-inline-block", "mb-3", "float-start", "me-2", "no-shadow", "bg-lighter", "max-w-p80");
  				}
  				
  				const $positionAbsolute=document.createElement("div");
  				$positionAbsolute.classList.add("position-absolute", "pt-1", "pe-2", "r-0");
  				
  				const $sendAt = document.createElement("span");
  				$sendAt.classList.add("text-extra-small");
  				$sendAt.textContent = sendAt;
  				
  				$positionAbsolute.appendChild($sendAt);
  				$card.appendChild($positionAbsolute);
  				
  				const $cardBody = document.createElement("div");
  				$cardBody.classList.add("card-body");
				
  				const $flexRow = document.createElement("div");
  				$flexRow.classList.add("d-flex", "flex-row", "pb-2");

  				const $flexGrow = document.createElement("div");
  				$flexGrow.classList.add("d-flex", "flex-grow-1", "min-width-zero");

  				const $m2 = document.createElement("div");
  				$m2.classList.add("m-2", "ps-0", "align-self-center", "d-flex", "flex-column", "flex-lg-row", "justify-content-between");

  				const $minWidthZero = document.createElement("div");
  				$minWidthZero.classList.add("min-width-zero");

  				const $strong = document.createElement("strong");
  				const $p = document.createElement("p");
  				$p.classList.add("mb-0", "fs-16");
  				$p.textContent = writerName;

  				$strong.appendChild($p);
  				$minWidthZero.appendChild($strong);
  				$m2.appendChild($minWidthZero);
  				$flexGrow.appendChild($m2);
  				$flexRow.appendChild($flexGrow);
  				$cardBody.appendChild($flexRow);

  				const $chatTextStart = document.createElement("div");
  				$chatTextStart.classList.add("chat-text-start", "ps-20");

  				const $message = document.createElement("p");
  				$message.classList.add("mb-0", "text-semi-muted");
  				$message.textContent = message;

  				$chatTextStart.appendChild($message);
  				$cardBody.appendChild($chatTextStart);

  				$card.appendChild($cardBody);
  				$div.appendChild($card);
  				
  				const startMsg = document.getElementById("startMsg");
  				startMsg.appendChild($div);
  				
  				const scroll=document.querySelector("#scrollStart");
  				scroll.scrollTop = scroll.scrollHeight;
  				
  				}else if(type==='UPLOAD'){
  						const $div = document.createElement("div");
					  	$div.classList.add("col-12");

  						const $card = document.createElement("div");
  		  				//채팅 작성자가 본인이라면
  		  				if(writer==userno){
  							$card.classList.add("card", "d-inline-block", "mb-3", "float-end", "me-2", "bg-info", "max-w-p80");
  		  				}else{
  		  					$card.classList.add("card", "d-inline-block", "mb-3", "float-start", "me-2", "no-shadow", "bg-lighter", "max-w-p80");
  		  				}
  		  				
  		  				const $positionAbsolute=document.createElement("div");
  		  				$positionAbsolute.classList.add("position-absolute", "pt-1", "pe-2", "r-0");
  		  				
  		  				const $sendAt = document.createElement("span");
  		  				$sendAt.classList.add("text-extra-small");
  		  				$sendAt.textContent = sendAt;
  		  				
  		  				$positionAbsolute.appendChild($sendAt);
  		  				$card.appendChild($positionAbsolute);
  		  				
  		  				const $cardBody = document.createElement("div");
  		  				$cardBody.classList.add("card-body");

  		  				const $flexRow = document.createElement("div");
  		  				$flexRow.classList.add("d-flex", "flex-row", "pb-2");

  		  				const $flexGrow = document.createElement("div");
  		  				$flexGrow.classList.add("d-flex", "flex-grow-1", "min-width-zero");

  		  				const $m2 = document.createElement("div");
  		  				$m2.classList.add("m-2", "ps-0", "align-self-center", "d-flex", "flex-column", "flex-lg-row", "justify-content-between");

  		  				const $minWidthZero = document.createElement("div");
  		  				$minWidthZero.classList.add("min-width-zero");

  		  				const $strong = document.createElement("strong");
  		  				const $p = document.createElement("p");
  		  				$p.classList.add("mb-0", "fs-16");
  		  				$p.textContent = writerName;

  		  				$strong.appendChild($p);
  		  				$minWidthZero.appendChild($strong);
  		  				$m2.appendChild($minWidthZero);
  		  				$flexGrow.appendChild($m2);
  		  				$flexRow.appendChild($flexGrow);
  		  				$cardBody.appendChild($flexRow);

  		  				const $chatTextStart = document.createElement("div");
  		  				$chatTextStart.classList.add("chat-text-start", "ps-20");
						//이미지 생성
  		  				const $img = document.createElement("img");
  		  						$img.src = `${path}/resources/upload/chatfile/`+msgFiReName;
  		  						$img.width = "200";
  		  						$img.height = "200";
  		  						$img.alt = "user";
  		  						/* $img.classList.add("chatfile");
  		  						$img.id = "chatfile"; */
						//버튼 생성
  		  				const $button = document.createElement("button");
  		  						$button.classList.add("btn", "fa", "fa-download");
  		  						$button.id = "downBtn";
  		  						$button.name = "downBtn";
  		  						$button.onclick = function() {
  		  							window.location.replace(`${path}/chat/file/download?reName=`+msgFiReName+`&oriName=`+msgFiOriName);
  		  						};
  		  				if(writer==userno){
	  		  				$chatTextStart.appendChild($button);
	  		  				$chatTextStart.appendChild($img);
  		  				}else{
	  		  				$chatTextStart.appendChild($img);
	  		  				$chatTextStart.appendChild($button);
  		  				}

  		  				$cardBody.appendChild($chatTextStart);

  		  				$card.appendChild($cardBody);
  		  				$div.appendChild($card);
  		  				
	  		  			const startMsg = document.getElementById("startMsg");
	  	  				startMsg.appendChild($div);
	  	  				
	  	  				const scroll=document.querySelector("#scrollStart");
	  	  				scroll.scrollTop = scroll.scrollHeight;
  					}
  				
  				
  				}
  			
  			//통신 실패했을 때 함수
  			function onError(){
  				alert('통신 에러');
  			}
  			
  			/* 버튼 클릭 시 메시지 전송 */
  			document.getElementById('sendbtn').addEventListener('click',function(e){
  				sendMsg();
  			});
  			
  			/* 엔터 눌렀을 때 메시지 전송 */
  			window.onload=()=>{
  				document.getElementById('msgText').addEventListener("keyup",e=>{
  					if(e.key=='Enter'){
  						sendMsg();
  					}
  				});
  			}
  			
  			/* 채팅메시지 전송 함수 */
  			const sendMsg=()=>{
  				
				var msg=document.getElementById('msgText');
  				
  				if(msg.value==""||msg.value==null){
  					alert('내용을 적어주세요.');
  					return;
  				}
  				if(stomp && msg.value){
  					var chatMsg={
  							msgRoomNo:roomId,
  							message:msg.value,
  							msgEmpName:username,
  							msgEmpNo:userno,
  							type:'TALK'
  							}
  				//send(path, header,message)로 메세지 발신
  				//StompChatController의 @MessageMapping(value="/chat/message")로 메시지 발신
  				stomp.send('/pub/chat/send',{},JSON.stringify(chatMsg));
  				msg.value='';
  				}
  			}
  			
  			//채팅 업로드 파일 검사
  			// 파일 선택 시 이벤트 핸들러
			document.getElementById('chatFileUpload').addEventListener('change', function(e) {
			  var file = e.target.files[0]; // 선택한 파일 가져오기
			  var filesize = Math.round(file.size/1024); // 파일 크기
			  
			  var reader = new FileReader(); // FileReader 객체 생성
		 	  // 확장자 추출
		      var fileDot = file.name.lastIndexOf('.');
			  
		      // 확장자 검사
		      var fileType = file.name.substring(fileDot + 1, file.name.length);

		      // 파일명
		      var filename = file.name.substring(0,fileDot);
		      
		      if (!(fileType == 'png' || fileType == 'jpg' || fileType == 'jpeg')) {
		         alert('파일 업로드는 png, jpg, jpeg 만 가능합니다');
		         return;
		       }
			  // 파일 로드가 완료되면 미리보기 생성(모달)
			  reader.onload = function(e) {
				var previewImage = document.getElementById("previewImage");
				var fileName = document.getElementById("fileName");
				var fileSize = document.getElementById("fileSize");
				
				previewImage.src = e.target.result; // 미리보기 이미지 소스 설정
			    fileName.textContent = "파일명: " + filename; // 파일명 설정
			    fileSize.textContent = "파일크기: " + filesize + "KB"; // 파일 크기 설정
				
			    var modal = document.getElementById("previewModal");
			    modal.style.display = "block"; // 모달 창 열기
			    document.body.classList.add("modal-open"); // 스크롤 막기
			  }
			
			  // 파일 읽기 시작
			  reader.readAsDataURL(file);
			});
  			
  			//파일 업로드 버튼
  			function sendFile(){
  				
  				var form = $('#chatFileUpload')[0].files[0];
	 			var formData = new FormData();
	 			
	 			formData.append('file',form);
 	 			
  				/* console.log("form 데이터 : "+form);
  				console.log("form 데이터 : "+formData); */
  				
 	 			$.ajax({
 	 				url : '${path}/chat/file/upload',
 	 				type : 'POST',
 	 				enctype: 'multipart/form-data',
 	 				data : formData,
 	 				contentType : false,
 	 				processData : false,
 	 				success : function(data){
 	 				//채팅 메시지 전송(기록용)
 	 				/* console.log("데이터값 : "+data); */
 	 	 	 			if(stomp){
 	 	 	 				var data=data;
 	 	 	 				//모달 종료
 	 	 	 				upModalClose();
 	 	 	 				
 	 	 	  				var chatMsg={
 	 	 	  						msgRoomNo:roomId,
 	 	 	  						msgEmpName:username,
 	 	 	  						msgEmpNo:userno,
 	 	 	  						msgFiOriName:data.msgFiOriName,
 	 	 	  						msgFiReName:data.msgFiReName,
 	 	 	  						type:'UPLOAD'
 	 	 	  						}
 	 	 	  			//send(path, header,message)로 메세지 발신
 	 	 	  			//StompChatController의 @MessageMapping(value="/chat/message")로 메시지 발신
 	 	 	  			stomp.send('/pub/chat/send',{},JSON.stringify(chatMsg));
 	 	  				}
 	 				},
 	 				error: function(error){
 	 					alert("에러 : "+error);
 	 				}
 	 			});
  				}
  			
  			//파일 업로드 모달 닫기
			function upModalClose(){
				var modal = document.getElementById("previewModal");
				modal.style.display = "none"; // 모달 창 닫기
				document.body.classList.remove("modal-open"); // 스크롤 허용
			}
  			
  			//파일 다운로드
  			function downloadFile(ori,re){
  				var data={
  						msgFiOriName:ori,
  						msgFiReName:re
  				}
  				/* console.log(data); */
  				$.ajax({
  					url:'${path}/chat/file/download',
  					type:'POST',
  					data:JSON.stringify(data),
  					dataType:"json",
  					contentType:"application/json",
  					success:function(res){
  						/* console.log(res); */
  						console.log('다운로드 성공');
  					},
  					error:function(error){
  						alert("에러메시지 : "+error);
  					}
  				});
  			}
  			
	  		//채팅방에서 초대하기 모달 띄우기
	  		document.getElementById('modalchatinvite').addEventListener('click',function(){
	  			var modal=document.getElementById("inviteModal");
	  			modal.style.display="block";
	  			document.body.classList.add("modal-open"); // 스크롤 막기
	  			
	  		});
  			
	  		//채팅방에서 초대하기 모달 끄기
			function inviteModalClose(){
				var modal = document.getElementById("inviteModal");
				modal.style.display = "none"; // 모달 창 닫기
				document.body.classList.remove("modal-open"); // 스크롤 허용
			}
	  		
	  		
	  		//방 나가기
	  		function leaveRoom(){
	  			if(confirm('방을 정말 나가겠습니까?')){
	  				/* console.log('방 나감');
	  				console.log(roomId);
	  				console.log(userno); */
	  				var data={
	  						msgRoomNo:roomId,
	  						msgEmpNo:userno,
	  						type:"LEAVEROOM",
	  						empLv:userlv,
	  	  					depName:userdept,
	  	  					msgEmpName:username
	  				}
	  				$.ajax({
	  					url:'${path}/chat/room/'+roomId,
	  					type:'PUT',
	  					data:data,
	  					success:function(res){
	  						alert('방을 나가셨습니다.');
	  						console.log('data값 뭐지? :'+data);
	  						window.location.replace('${path}/chat/list');
	  						stomp.send('/pub/chat/leave',{},JSON.stringify(data));
	  					},
	  					error:function(error){
	  						alert(error);
	  					}
	  				});
	  			}else{
	  				return;
	  			}
	  		}
	  		
	  		//대화방에서 초대하기 버튼 활성화
	  		var invitebtn = document.getElementById('invitebtn');
	  		document.addEventListener("change", function(e) {
	  		  // 이벤트가 발생한 요소를 확인합니다.
	  		  var target = e.target;

	  		  // 원하는 요소를 필터링하고 동작을 수행합니다.
	  		  if (target.matches('.filled-in.chk-col-primary')) {
	  		    // 체크박스가 하나 이상 선택되었을 때 버튼 활성화
	  		    const checkedCheckboxes = document.querySelectorAll('input[name="plustempCheck"]:checked');
	  		    if (checkedCheckboxes.length > 0) {
	  		      invitebtn.disabled = false;
	  		    } else {
	  		      invitebtn.disabled = true;
	  		    }
	  		  }
	  		});
	  		
	  		//방에서 직원 초대하기
	  		function inviteEmployees(){
	  			if(confirm('초대하시겠습니까?')){
	  				
	  				var delEmps = document.querySelectorAll('input[name="plustempCheck"]:checked');
	  				var emps=[];
	  				delEmps.forEach(function(emp){
	  					emps.push(emp.value);
	  				})
	  				console.log("삭제할 애들 : "+emps);
	  				
	  				$.ajax({
		  				type:"POST",
		  				url:"${path}/chat/room",
		  				data:$("#inviteEmpList").serialize(),
		  				dataType:"json",
		  				success:function(res){
		  						alert("채팅방 초대 성공");
		  						/* console.log("초대한 방 이름,직원 이름들"+res); */
		  						inviteModalClose();
		  						
		  						var data={
		  								roomId:roomId,
	 	 	 	  						delEmps:emps,
	 	 	 	  						type:'INVITE'
	 	 	 	  						}
		  						console.log("ajax안에서 emps확인"+data);
		  						stomp.send('/pub/chat/invite',{},JSON.stringify(data));
		  						/* stomp.send('/pub/chat/delete',{},JSON.stringify(res)); */
		  				},
		  				error:function(){
		  					alert("채팅방 초대 실패");
		  				}
		  			});
	  			}else{
	  				return;
	  			}
	  			
	  		}
	  		
	  		//debounce 함수 정의
	  		function debounce(func,delay){
	  			let timerId;
	  			return function(...args){
	  				clearTimeout(timerId);
	  				timerId = setTimeout(()=>{
	  					func.apply(this, args);
	  				}, delay);
	  			};
	  		}
	  		
	  		//초대하기 목록에서 검색 기능
	  		document.getElementById('modalSearchEmp').addEventListener('input',debounce(function(e){
	  			var modalsearchValue=e.target.value;
	  			var data={
	  					modalsearchValue:modalsearchValue,
	  					roomId:roomId
	  			};
	  			
		  			$.ajax({
		  				type:'POST',
		  				url:'${path}/chat/room/modalsearch',
		  				data:JSON.stringify(data),
	  					dataType:"json",
	  					contentType:"application/json",
		  				success(data){
		  					document.getElementById('employeeList').innerHTML = "";
		  					data.forEach((data)=>{
			  						// 새로운 div 요소 생성
			  						var $chatbox = document.createElement('div');
			  						$chatbox.classList.add('media-list', 'media-list-hover');
			  						$chatbox.id = 'emplist' + data.EMP_NO;
		
			  						// 내부 요소들 생성
		
			  						var $media = document.createElement('div');
			  						$media.classList.add('media', 'py-10', 'px-0', 'align-items-center');
		
			  						var $avatar = document.createElement('p');
			  						$avatar.classList.add('avatar', 'avatar-lg', 'status-success');
		
			  						var $avatarImage = document.createElement('img');
			  						$avatarImage.src = '${path}/resources/images/avatar/1.jpg';
			  						$avatarImage.alt = '...';
		
			  						var $mediaBody = document.createElement('div');
			  						$mediaBody.classList.add('media-body');
		
			  						var $empName = document.createElement('p');
			  						$empName.classList.add('fs-20');
			  						$empName.id = 'chatEmpName';
			  						$empName.textContent = data.EMP_NAME;
		
			  						var $empLv = document.createElement('p');
			  						$empLv.id = 'chatEmpLv';
			  						$empLv.textContent = data.EMP_LV + " / " + data.DEP_NAME;
		
			  						var $checkbox = document.createElement('input');
			  						$checkbox.type = 'checkbox';
			  						$checkbox.id = 'emp' + data.EMP_NO;
			  						$checkbox.classList.add('filled-in', 'chk-col-primary');
			  						$checkbox.name = 'plustempCheck';
			  						$checkbox.value = data.EMP_NO;
		
			  						var $label = document.createElement('label');
			  						$label.setAttribute('for', 'emp' + data.EMP_NO);
		
			  						// 요소들을 적절한 구조로 추가
			  						$avatar.appendChild($avatarImage);
			  						$mediaBody.appendChild($empName);
			  						$mediaBody.appendChild($empLv);
			  						$media.appendChild($avatar);
			  						$media.appendChild($mediaBody);
			  						$media.appendChild($checkbox);
			  						$media.appendChild($label);
			  						$chatbox.appendChild($media);
		
			  						// 요소를 원하는 위치에 추가
			  						var targetElement = document.getElementById('employeeList');
			  						targetElement.appendChild($chatbox);
			  					});
		  				},
		  				error:function(error){
		  					alert('에러:'+error);
		  				}
		  			});
		  		},500)
		  		);
	  		
  	</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>