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
<input type="hidden" name="logempNo" value="${logempNo }"/>
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
											  <p class="align-self-center me-0"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/2.jpg" alt="..."></p>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="${path }/chat/room/${c.CHATROOM_NO}"><strong><c:out value="${c.CHATROOM_NAME }"/></strong></a>
												  <span class="float-end fs-10"><fmt:formatDate value="${c.CREATED_AT }" pattern="yyyy.MM.dd" /></span>
												</p>
												<%-- <p>참여 인원 수 : <c:out value="${c.EMP_COUNT }"/></p> --%>
												<p>마지막 채팅 내역 : </p>
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
	                                                    <img src="${path}/resources/images/avatar/1.jpg" alt="...">
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

var userno = '${logempNo}';

var sockJS=new SockJS("/ws/list");
var stomp=Stomp.over(sockJS);

//Stomp 연결 시 실행
stomp.connect({},onConnected,onError);

//연결 성공했을 때 실행하는 함수
function onConnected(){
	console.log("stomp 연결 성공");
	
	//subscribe(path,callback)으로 메세지 받기 가능
	stomp.subscribe("/sub/chat/list",onMessageReceived);
}

function onMessageReceived(payload){
	console.log("list 수신 확인");
	
	var userno = '${logempNo }';
	
	var list=JSON.parse(payload.body);
	
	if(list.type==="CREATEROOM"){
		list.inviteemps.forEach((emp)=>{
			if(userno==emp){
				var data={
						roomsearchValue:"",
						empNo:emp
				};
				$.ajax({
	  				type:'POST',
	  				url:'${path}/chat/list/roomListSearch',
	  				data:JSON.stringify(data),
					dataType:"json",
					contentType:"application/json",
	  				success(data){
	  					document.getElementById('chatroomListDiv').innerHTML = "";
	  					data.forEach((data)=>{
	  						// 부모 요소를 선택합니다.
	  						var parentElement = document.getElementById("chatroomListDiv");

	  						// 새로운 div 요소를 생성합니다.
	  						var newDiv = document.createElement("div");
	  						newDiv.classList.add("media-list", "media-list-hover");
	  						newDiv.id = "listroom" + data.CHATROOM_NO;

	  						// 내부의 media 요소를 생성합니다.
	  						var mediaDiv = document.createElement("div");
	  						mediaDiv.classList.add("media");

	  						// avatar를 감싸는 p 요소를 생성합니다.
	  						var avatarWrapper = document.createElement("p");
	  						avatarWrapper.classList.add("align-self-center", "me-0");

	  						// avatar 요소를 생성합니다.
	  						var avatar = document.createElement("img");
	  						avatar.classList.add("avatar", "avatar-lg");
	  						avatar.src = "${path}/resources/images/avatar/2.jpg";
	  						avatar.alt = "...";
	  						avatarWrapper.appendChild(avatar);

	  						mediaDiv.appendChild(avatarWrapper);

	  						// media-body 요소를 생성합니다.
	  						var mediaBodyDiv = document.createElement("div");
	  						mediaBodyDiv.classList.add("media-body");

	  						// 첫 번째 p 요소를 생성합니다.
	  						var firstParagraph = document.createElement("p");

	  						// a 요소를 생성합니다.
	  						var link = document.createElement("a");
	  						link.classList.add("hover-primary");
	  						link.href = "${path}/chat/room/" + data.CHATROOM_NO;

	  						// strong 요소를 생성합니다.
	  						var strong = document.createElement("strong");
	  						strong.textContent = data.CHATROOM_NAME;
	  						link.appendChild(strong);

	  						firstParagraph.appendChild(link);

	  						// span 요소를 생성합니다.
	  						var span = document.createElement("span");
	  						span.classList.add("float-end", "fs-10");
	  						span.textContent = data.CREATED_AT;

	  						firstParagraph.appendChild(span);

	  						mediaBodyDiv.appendChild(firstParagraph);

	  						// 두 번째 p 요소를 생성합니다.
	  						var secondParagraph = document.createElement("p");
	  						secondParagraph.textContent = "참여 인원 수 : " + data.EMP_COUNT;

	  						mediaBodyDiv.appendChild(secondParagraph);

	  						mediaDiv.appendChild(mediaBodyDiv);

	  						// checkbox 요소를 생성합니다.
	  						var checkbox = document.createElement("input");
	  						checkbox.type = "checkbox";
	  						checkbox.id = "ch" + data.CHATROOM_NO;
	  						checkbox.classList.add("filled-in", "chk-col-danger");
	  						checkbox.name = "roomCheck";
	  						checkbox.value = data.CHATROOM_NO;
	  						mediaDiv.appendChild(checkbox);

	  						// checkbox와 연결된 label 요소를 생성합니다.
	  						var label = document.createElement("label");
	  						label.htmlFor = "ch" + data.CHATROOM_NO;
	  						mediaDiv.appendChild(label);

	  						newDiv.appendChild(mediaDiv);

	  						// 부모 요소에 새로운 div를 추가합니다.
	  						parentElement.appendChild(newDiv);
		  					});
	  				},
	  				error:function(error){
	  					alert('에러:'+error);
	  				}
	  			});
				
				
			}
		});
	}
	
}

function onError(){
	alert("대화방 리스트 통신 에러");
}
	//체크했을 때 버튼이 활성화하게 하는 함수
	var empcheck = document.getElementsByName('empCheck');
	var roomcheck = document.getElementsByName('roomCheck');
	var roomcreatebtn = document.getElementById('chatRoomCreate');
	var deletebtn = document.getElementById('chatRoomDelete');
	var createbtn = document.getElementById('createBtn');
	
	//채팅방 생성 버튼 활성화
	document.addEventListener("change", function(e) {
	  // 이벤트가 발생한 요소를 확인합니다.
	  var target = e.target;
	  // 원하는 요소를 필터링하고 동작을 수행합니다.
	  if (target.matches('.filled-in.chk-col-primary')) {
	  // 체크박스가 하나 이상 선택되었을 때 버튼 활성화
	  const checkedCheckboxes = document.querySelectorAll('input[name="empCheck"]:checked');
	  if (checkedCheckboxes.length > 0) {
		  	roomcreatebtn.disabled = false;
	  } else {
		  	roomcreatebtn.disabled = true;
      }
	  }
	});
	
	//방 나가기 버튼 활성화
	document.addEventListener("change", function(e) {
	  // 이벤트가 발생한 요소를 확인합니다.
	  var target = e.target;
	  // 원하는 요소를 필터링하고 동작을 수행합니다.
	  if (target.matches('.filled-in.chk-col-danger')) {
	  // 체크박스가 하나 이상 선택되었을 때 버튼 활성화
	  const checkedCheckboxes = document.querySelectorAll('input[name="roomCheck"]:checked');
	  if (checkedCheckboxes.length > 0) {
		  deletebtn.disabled = false;
	  } else {
		  deletebtn.disabled = true;
      }
	  }
	});
	
	//채팅방 생성 버튼 활성화
	var roomNameInput = document.getElementById('roomName');
	roomNameInput.addEventListener('input',function(){
		var roomName = roomNameInput.value;
		if(roomName){
			createbtn.disabled = false;
		}else{
			createbtn.disabled = true;
		}
	});
	
	//채팅방 생성 모달 끄기
	function closeModal() {
		  var modal = document.getElementById('modal-default');
		  var bootstrapModal = bootstrap.Modal.getInstance(modal);
		  bootstrapModal.hide();
		}

	//채팅방 생성
	document.getElementById('createBtn').addEventListener('click',function(){
		var result=confirm('방을 생성하시겠습니까?');
		if(result){
		$.ajax({
			type:"POST",
			url:"${path}/chat/room",
			data:$("#Roomfrm").serialize(),
			dataType:"json",
			success:function(res){
					alert("채팅방 생성 성공");
					console.log("초대한 멤버 번호 리스트 : "+res);
						stomp.send('/pub/list/invite',{},JSON.stringify(res));
						//채팅방 생성 모달 닫기
						closeModal();
			},
			error:function(){
				alert("채팅방 생성 실패");
			}
		});
		}
	});
	
	//채팅방 나가기
	document.getElementById('chatRoomDelete').addEventListener('click',function(){
		var checkboxes = document.getElementsByName('roomCheck');

		if(confirm("채팅방을 나가시겠습니까?")){
			var delUserRoom = document.querySelectorAll('input[name="roomCheck"]:checked');
			var rooms=[];
			delUserRoom.forEach(function(room){
				rooms.push(room.value);
			});
			
			$.ajax({
				type:"DELETE",
				url:"${path}/chat/room",
				data:$("#Roomfrm").serialize(),
				success:function(res){
					alert("방 나가기 성공");
					var parendDiv = document.getElementById('roomParentDiv');
					console.log("parendDiv"+parendDiv);
					console.log("rooms"+rooms);
					
						rooms.forEach(function(room){
							var childDiv = document.getElementById('listroom'+room);
							console.log("childDiv:"+childDiv);
							childDiv.parentNode.removeChild(childDiv);
							})
					
				},
				error:function(){
					alert("방 나가기 실패");
				}
			});
		}else{
			return;
		}
	});
	
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
		
		//채팅 리스트에서 검색 채팅방목록 기능 ajax
		document.getElementById('searchRoom').addEventListener('input',debounce(function(e){
			var roomsearchValue=e.target.value;
			var data={
					roomsearchValue:roomsearchValue,
					empNo:userno
			};
			
  			$.ajax({
  				type:'POST',
  				url:'${path}/chat/list/roomListSearch',
  				data:JSON.stringify(data),
				dataType:"json",
				contentType:"application/json",
  				success(data){
  					document.getElementById('chatroomListDiv').innerHTML = "";
  					data.forEach((data)=>{
  						// 부모 요소를 선택합니다.
  						var parentElement = document.getElementById("chatroomListDiv");

  						// 새로운 div 요소를 생성합니다.
  						var newDiv = document.createElement("div");
  						newDiv.classList.add("media-list", "media-list-hover");
  						newDiv.id = "listroom" + data.CHATROOM_NO;

  						// 내부의 media 요소를 생성합니다.
  						var mediaDiv = document.createElement("div");
  						mediaDiv.classList.add("media");

  						// avatar를 감싸는 p 요소를 생성합니다.
  						var avatarWrapper = document.createElement("p");
  						avatarWrapper.classList.add("align-self-center", "me-0");

  						// avatar 요소를 생성합니다.
  						var avatar = document.createElement("img");
  						avatar.classList.add("avatar", "avatar-lg");
  						avatar.src = "${path}/resources/images/avatar/2.jpg";
  						avatar.alt = "...";
  						avatarWrapper.appendChild(avatar);

  						mediaDiv.appendChild(avatarWrapper);

  						// media-body 요소를 생성합니다.
  						var mediaBodyDiv = document.createElement("div");
  						mediaBodyDiv.classList.add("media-body");

  						// 첫 번째 p 요소를 생성합니다.
  						var firstParagraph = document.createElement("p");

  						// a 요소를 생성합니다.
  						var link = document.createElement("a");
  						link.classList.add("hover-primary");
  						link.href = "${path}/chat/room/" + data.CHATROOM_NO;

  						// strong 요소를 생성합니다.
  						var strong = document.createElement("strong");
  						strong.textContent = data.CHATROOM_NAME;
  						link.appendChild(strong);

  						firstParagraph.appendChild(link);

  						// span 요소를 생성합니다.
  						var span = document.createElement("span");
  						span.classList.add("float-end", "fs-10");
  						span.textContent = data.CREATED_AT;

  						firstParagraph.appendChild(span);

  						mediaBodyDiv.appendChild(firstParagraph);

  						// 두 번째 p 요소를 생성합니다.
  						var secondParagraph = document.createElement("p");
  						/* secondParagraph.textContent = "참여 인원 수 : " + data.EMP_COUNT; */
						secondParagraph.textContent = "마지막 채팅 내역 : ";
  						mediaBodyDiv.appendChild(secondParagraph);

  						mediaDiv.appendChild(mediaBodyDiv);

  						// checkbox 요소를 생성합니다.
  						var checkbox = document.createElement("input");
  						checkbox.type = "checkbox";
  						checkbox.id = "ch" + data.CHATROOM_NO;
  						checkbox.classList.add("filled-in", "chk-col-danger");
  						checkbox.name = "roomCheck";
  						checkbox.value = data.CHATROOM_NO;
  						mediaDiv.appendChild(checkbox);

  						// checkbox와 연결된 label 요소를 생성합니다.
  						var label = document.createElement("label");
  						label.htmlFor = "ch" + data.CHATROOM_NO;
  						mediaDiv.appendChild(label);

  						newDiv.appendChild(mediaDiv);

  						// 부모 요소에 새로운 div를 추가합니다.
  						parentElement.appendChild(newDiv);
	  					});
  				},
  				error:function(error){
  					alert('에러:'+error);
  				}
  			});
  		},500)
  		);
		
		
		//채팅 리스트에서 직원 목록 검색 기능 ajax
		document.getElementById('searchEmp').addEventListener('input',debounce(function(e){
			var empsearchValue=e.target.value;
			var data={
					empsearchValue:empsearchValue,
					empNo:userno
			};
			
  			$.ajax({
  				type:'POST',
  				url:'${path}/chat/list/empListSearch',
  				data:JSON.stringify(data),
				dataType:"json",
				contentType:"application/json",
  				success(data){
  					document.getElementById('empParentDiv').innerHTML = "";
  					data.forEach((data)=>{
  						// 부모 요소를 선택합니다.
  						var parentElement = document.getElementById("empParentDiv");

  						// 새로운 div 요소를 생성합니다.
  						var newDiv = document.createElement("div");
  						newDiv.classList.add("media-list", "media-list-hover");
  						newDiv.id = "empslist" + data.EMP_NO;

  						// 내부의 media 요소를 생성합니다.
  						var mediaDiv = document.createElement("div");
  						mediaDiv.classList.add("media", "py-10", "px-0", "align-items-center");

  						// avatar 요소를 생성합니다.
  						var avatar = document.createElement("p");
  						avatar.classList.add("avatar", "avatar-lg", "status-success");

  						// avatar 내부의 img 요소를 생성합니다.
  						var img = document.createElement("img");
  						img.src = "${path}/resources/images/avatar/1.jpg";
  						img.alt = "...";
  						avatar.appendChild(img);

  						mediaDiv.appendChild(avatar);

  						// media-body 요소를 생성
  						var mediaBodyDiv = document.createElement("div");
  						mediaBodyDiv.classList.add("media-body");
  						
  						// media-body 내부의 p 요소를 생성합니다.
  						var empNameParagraph = document.createElement("p");
  						empNameParagraph.classList.add("fs-20");
  						empNameParagraph.textContent = data.EMP_NAME;
  						mediaBodyDiv.appendChild(empNameParagraph);

  						// chatEmpLv 내부의 p 요소를 생성합니다.
  						var chatEmpLvParagraph = document.createElement("p");
  						chatEmpLvParagraph.innerHTML = data.EMP_LV+' / '+data.DEP_NAME;
  						mediaBodyDiv.appendChild(chatEmpLvParagraph);

  						mediaDiv.appendChild(mediaBodyDiv);

  						// checkbox 요소를 생성합니다.
  						var checkbox = document.createElement("input");
  						checkbox.type = "checkbox";
  						checkbox.id = "emp" + data.EMP_NO;
  						checkbox.classList.add("filled-in", "chk-col-primary");
  						checkbox.name = "empCheck";
  						checkbox.value = data.EMP_NO;
  						mediaDiv.appendChild(checkbox);

  						// checkbox와 연결된 label 요소를 생성합니다.
  						var label = document.createElement("label");
  						label.htmlFor = "emp" + data.EMP_NO;
  						mediaDiv.appendChild(label);
						
						newDiv.appendChild(mediaDiv);
  						// 부모 요소에 새로운 div를 추가합니다.
  						parentElement.appendChild(newDiv);
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