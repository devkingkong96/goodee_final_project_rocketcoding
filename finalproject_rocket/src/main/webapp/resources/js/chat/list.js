/**
 * 
 */
 
var sockJS=new SockJS(path+"/ws/list");
var stomp=Stomp.over(sockJS);

 //Stomp 연결 시 실행
stomp.connect({},onConnected,onError);

//연결 성공했을 때 실행하는 함수
function onConnected(){
	console.log("채팅방 리스트 stomp 연결 성공");
	
	//subscribe(path,callback)으로 메세지 받기 가능
	stomp.subscribe("/sub/chat/list",onMessageReceived);
}

function onMessageReceived(payload){
	console.log("list 수신 확인");
	
	
	var list=JSON.parse(payload.body);
	
	if(list.type==="REFRESHROOM"){
		list.refreshemps.forEach((emp)=>{
			if(userno==emp){
				var data={
					roomsearchValue:"",
					empNo:emp
				};
				roomListSearch(data);
			}
		});
	}
	
	if(list.type==="CREATEROOM"){
		list.inviteemps.forEach((emp)=>{
			console.log("초대한 애들 실시간 : "+emp);
			if(userno==emp){
				var data={
						roomsearchValue:"",
						empNo:emp
				};
				//ajax 채팅방 새로고침
				roomListSearch(data);
				
				
			}
		});
	}
	
}

function onError(){
	alert("대화방 리스트 통신 에러");
}
	//체크했을 때 버튼이 활성화하게 하는 함수
	
	
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
			url:path+"/chat/room",
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
				url:path+"/chat/room",
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
							
							//리스트에서 채팅 나갔을 때 채팅방에 send
							var data={
  				  						msgRoomNo:room,
  				  						msgEmpNo:userno,
  				  						type:"LEAVEROOM",
  				  						empLv:userlv,
  				  	  					depName:userdept,
  				  	  					msgEmpName:username
  				  				}
					
							stomp.send('/pub/chat/leave',{},JSON.stringify(data));
							
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
  				url:path+"/chat/list/roomListSearch",
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
  						/* var avatarWrapper = document.createElement("p");
  						avatarWrapper.classList.add("align-self-center", "me-0");

  						// avatar 요소를 생성합니다.
  						var avatar = document.createElement("img");
  						avatar.classList.add("avatar", "avatar-lg");
  						avatar.src = "${path}/resources/images/avatar/2.jpg";
  						avatar.alt = "...";
  						avatarWrapper.appendChild(avatar);

  						mediaDiv.appendChild(avatarWrapper); */

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
  						/* var secondParagraph = document.createElement("p");
  						secondParagraph.textContent = "참여 인원 수 : " + data.EMP_COUNT;
						secondParagraph.textContent = "마지막 채팅 내역 : ";
  						mediaBodyDiv.appendChild(secondParagraph); */

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
  				url:path+"/chat/list/empListSearch",
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
  						img.src = path + "/resources/upload/profile/" + data.EMP_FILE;
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
	
		function roomListSearch(data){
			$.ajax({
  				type:'POST',
  				url:path+"/chat/list/roomListSearch",
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
  						/* var avatarWrapper = document.createElement("p");
  						avatarWrapper.classList.add("align-self-center", "me-0");

  						// avatar 요소를 생성합니다.
  						var avatar = document.createElement("img");
  						avatar.classList.add("avatar", "avatar-lg");
  						avatar.src = "${path}/resources/images/avatar/2.jpg";
  						avatar.alt = "...";
  						avatarWrapper.appendChild(avatar);

  						mediaDiv.appendChild(avatarWrapper); */

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
  						/* var secondParagraph = document.createElement("p");
  						secondParagraph.textContent = "참여 인원 수 : " + data.EMP_COUNT;

  						mediaBodyDiv.appendChild(secondParagraph); */

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