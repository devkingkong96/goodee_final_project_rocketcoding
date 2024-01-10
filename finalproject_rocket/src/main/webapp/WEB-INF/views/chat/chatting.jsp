<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
				<div class="col-lg-8 col-8">
					<div class="row">
						<div class="col-xxxl-8 col-lg-8 col-8">
							<div class="box">
							  <div class="box-header">
								<div class="media align-items-top p-0">
								  <a class="avatar avatar-lg status-success mx-0" href="#">
									<img src="${path}/resources/images/avatar/2.jpg" class="rounded-circle" alt="...">
								  </a>
									<div class="d-lg-flex d-block justify-content-between align-items-center w-p100">
										<div class="media-body mb-lg-0 mb-20">
											<p class="fs-16">
											  <a class="hover-primary" href="#"><strong><c:out value="${room.chatRoomName }"/></strong></a>
											</p>
											  <p class="fs-12">채팅방 인원 수 : <c:out value="${room.empCount }"/></p>
										</div>
										<div>
											<ul class="box-controls pull-right">
											  <li class="dropdown">
												<a data-bs-toggle="dropdown" href="#"><i class="ti-more-alt rotate-180"></i></a>
												<div class="dropdown-menu dropdown-menu-end">
												  <a class="dropdown-item" id="dropchatinvite"><i class="mdi mdi-account-plus"></i>초대하기</a>
												  <div class="dropdown-divider"></div>
												  <a class="dropdown-item" href="${path }/chat/list"><i class="mdi mdi-close-box-outline"></i>방 나가기</a>
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
								  <c:choose>
								  <c:when test="${msg.MSG_EMP_NO==empinfo.empNo }">
								  <div class="col-12">
									  <div class="card d-inline-block mb-3 float-end me-2 bg-info max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small"><fmt:formatDate value="${msg.SEND_AT }" type="time" timeStyle="short" /></span>
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
											<span class="text-extra-small text-muted"><fmt:formatDate value="${msg.SEND_AT }" type="time" timeStyle="short" /></span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<strong><p class="mb-0 fs-16 text-dark"><c:out value="${msg.MSG_EMP_NAME }"/></p></strong>
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
										<input class="form-control b-0 py-10" type="text" placeholder="메시지를 작성해주세요." id="msgText"/>
										<div class="d-flex justify-content-between align-items-center mt-md-0 mt-30">
											<!-- 파일 전송 버튼 -->
											<input type="file" id="chatFileUpload" style="display:none" name="file"/>
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
									</div>
							  </div>
							</div>
						</div>
						
						<div class="col-lg-4 col-4">
                        <div class="box">
                            <div class="box-header">
                            	<div class="row">
								<div class="col-lg-6 col-6">
									<span class="fs-20">참석 목록</span>
								</div>
								<div class="col-lg-6 col-6">
									<div class="box-controls pull-right mt-2">
									<div class="box-header-actions">
									  <div class="lookup lookup-sm lookup-right d-none d-lg-block">
										<input type="text" name="s" id="searchEmp" placeholder="Search">
									  </div>
									</div>
								  </div>
								</div>
								</div>
                            </div>
                            <div class="box-body">
                                    <div class="tab-pane" id="contacts" role="tabpanel">	
                                        <div class="chat-box-one-side3">
                                            <div class="media-list media-list-hover">
                                            	<c:if test="${not empty emplist }">
												<c:forEach var="e" items="${emplist }">
                                                <div class="media py-10 px-0 align-items-center">
                                                  <p class="avatar avatar-lg status-success">
                                                    <img src="${path}/resources/images/avatar/1.jpg" alt="...">
                                                  </p>
                                                  <div class="media-body">
                                                    <p class="fs-20" id="chatEmpName">
                                                      <c:out value="${e.EMP_NAME }"/>
                                                    </p>
                                                    <p id="chatEmpLv"><c:out value="${e.EMP_LV }"/></p>
                                                  </div>
                                                  
                                                  	<input type="checkbox" id="${e.EMP_NO }" class="filled-in chk-col-primary" name="empCheck" value="${e.EMP_NO}"/>
													<label for="${e.EMP_NO }"> </label>
                                                  
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
			</div>
		</section>
		<!-- /.content -->
	  </div>
  </div>
  <!-- /.content-wrapper -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
  	<script>
  			/* var today=new Date(); */
  			/* var time=today.toLocaleString(); */
  			/* console.log(time); */
  	
  			var roomId='${room.chatRoomNo }';
  			var username='${empinfo.empName }';
  			var userno='${empinfo.empNo }';
  			
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
  				console.log("수신 확인");
  				
  				var chat=JSON.parse(payload.body);
  				
  				console.log(chat.sendAt);
  				
  				//작성자,메시지 내용,발신 시간 값 가져오기
  				var writer=chat.msgEmpName;
  				var message=chat.message;
  				var sendAt=chat.sendAt;
  				
  				//화면 출력할 태그들 생성하기
  				const $div = document.createElement("div");
					  $div.classList.add("col-12");
  				
				const $card = document.createElement("div");
  				//채팅 작성자가 본인이라면
  				if(writer===username){
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
  				$p.textContent = writer;

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
  				
  			}
  			
  			//통신 실패했을 때 함수
  			function onError(){
  				alert('통신 종료');
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
  				}else{
  				
  				if(stomp && msg){
  					var chatMsg={msgRoomNo:roomId,
  							message:msg.value,
  							msgEmpName:username,
  							msgEmpNo:userno
  							}
  				};
  				//send(path, header,message)로 메세지 발신
  				//StompChatController의 @MessageMapping(value="/chat/message")로 메시지 발신
  				stomp.send('/pub/chat/send',{},JSON.stringify(chatMsg));
  				msg.value='';
  				}
  			}
  			
  			//채팅 파일 업로드
  			
  			
	  		//채팅방에서 초대하기창 모달 띄우기
	  		document.getElementById('dropchatinvite').addEventListener('click',function(){
	  			 var windowFeatures = "width=400,height=300";
	  	        window.open("${path}/chat/list", "_blank", windowFeatures);
	  		});
  			
  	</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>