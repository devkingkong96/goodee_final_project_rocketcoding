function roomCreate(emp){
	console.log("되냐? : "+emp);
	stomp.send('/pub/list/refresh',{},JSON.stringify(emp));
}

function roomListSearch(data){
			$.ajax({
  				type:'POST',
  				url:path+"/chat/list/roomListSearch",
  				data:JSON.stringify(data),
				dataType:"json",
				contentType:"application/json",
  				success(data){
  					console.log("받았냐?:"+data);
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
  						avatar.src = path+"/resources/images/avatar/2.jpg";
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
  						link.href = path+"/chat/room/" + data.CHATROOM_NO;

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