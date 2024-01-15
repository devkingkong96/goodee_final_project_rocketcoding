<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="loginmember" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<head>
    <meta charset='utf-8' />
   
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
</head>

 <style>
     #calendar {
         width: 80vw;
         height: 80vh;
     }
   #Modal {
  display: none;
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

#cont {
  background-color: #f9f9f9;
  margin: 10% auto;
  padding: 20px;
  border-radius: 5px;
  width: 70%;
  max-width: 500px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

#cont h1 {
  font-size: 24px;
  margin-bottom: 20px;
  text-align: center;
}

#cont input[type="text"],
#cont select {
  width: 90%;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

#cont input[type="checkbox"] {
  margin-bottom: 10px;
}

#cont button {
  background-color: #4CAF50;
  color: white;
  padding: 10px 20px;
  border: none;
  cursor: pointer;
  margin-right: 10px;
  border-radius: 3px;
}

#cont button:last-child {
  background-color: #f44336;
}

#cont button:hover {
  opacity: 0.8;
}
 #cont select {
  width: 30%;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
  appearance: none;
  background-repeat: no-repeat;
  background-position: right center;
  background-size: 10px;
} 
#calContent {
  width: 90%;
  height: 100px;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
  resize: none;
}
input[type="datetime-local"] {
  padding: 5px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
}
.colflex{
  display: flex;
  flex-direction: column;
}
.colflex>div{
  display: flex;
}
.colflex>div:last-child{
  justify-content: center;
}
.colflex>div>span:first-child,.colflex>div>h3:first-child{
  width:30%;
}
#delBtn{
   display: none;
}
/* 일요일 날짜 빨간색 */
.fc-day-sun a {
  color: red;
  text-decoration: none;
}
.fc-day-sat a {
  color: blue;
  text-decoration: none;
}
#calType[readonly] {
  background-color: #ddd;
  pointer-events: none;
}
#calColor[readonly] {
  background-color: #ddd;
  pointer-events: none;
}
#calContent[readonly]{
  pointer-events: none;
}
    </style>
</head>


<!-- <head>
    <meta charset='utf-8' />
 
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
</head>
 -->
<body>

    <!-- 모달은 메인 영역 밖으로 빼어 놓는게 좋음-->
    <div id="Modal">
        <div id="cont" style="text-align: center;">
            <br>
            <h1>일정 상세페이지</h1>
            <div class="colflex">
            
              <div>
              <input type="text" id="empId" > 
              <input type="text" id="calNo" > 
                <span>제목</span> <input type="text" id="calTitle" class="modalV" readonly >
              </div>
               <div>
              <span>타입</span>
               <select id="calType" class="modalV" readonly>
                  <option value="MY">개인</option>
                  <option value="DEPT">부서</option>
                  <option value="ALL">전체</option>
                </select>
              </div>
              <div>
                <span>시작시간</span> <input type="datetime-local" id="calStart" class="modalV" />
              </div>
              <div>
                <span>종료시간</span> <input type="datetime-local" id="calEnd" class="modalV" />
              </div>
              <div>
                <h3>내용</h3> <textarea id="calContent" class="modalV" readonly> </textarea>
              </div>
              
              <div>
              <span>일정색상</span>
               <select id="calColor" class="modalV" readonly >
                  <option value="yellow">노랑색</option>
                  <option value="red">빨강색</option>
                  <option value="orange">주황색</option>
                  <option value="green">초록색</option>
                  <option value="blue">파랑색</option>
                  <option value="indigo">남색</option>
                  <option value="purple">보라색</option>
                </select>
              </div>
              
              
              <div>
              
                <button onclick="fCalAdd()">저장하기</button>
                <button onclick="fMClose()">취소하기</button>
                <button onclick="delClose()" id="delBtn">삭제하기</button>
         
              </div>
            </div>
        </div>
    </div>
    <!-- 실제 화면을 담을 영역 -->
        <div>              
                <button onclick="fcDept()">부서별</button>      
                          
         </div>
         <div>             
             <input type="hidden" id="calId" value="MY" >
             </div>
    <div id="Wrapper">
        <div id='calendar'>
        
        </div>
    </div>
    <script>
       const loginmemberEmpId = '${loginmember.empId}';
           const delBtn = document.querySelector("#delBtn");
          const calNo = document.querySelector("#calNo");
        const Modal = document.querySelector("#Modal");
        const calendarEl = document.querySelector('#calendar');
        const calStart = document.querySelector("#calStart");
        const calEnd = document.querySelector("#calEnd");
        const calTitle = document.querySelector("#calTitle");
        const calColor = document.querySelector("#calColor");      
        const calContent = document.querySelector("#calContent");
        const calType = document.querySelector("#calType");
      const empId = document.querySelector("#empId");
      
      const calId =document.querySelector("#calId");
      const eventSources = getEventSources(calId);
        //캘린더 헤더 옵션
        const headerToolbar = {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,dayGridWeek,timeGridDay'
        }

        function getEventSources(calId) {
             var eventSource1 = {
                 id: 'default',
                 events: function(fetchInfo, successCallback, failureCallback) {
                   $.ajax({
                     url: "calendar/calendar.do",
                     method: "GET",
                     dataType: "JSON",
                     success: function(data) {
                       var events = [];
                       $.each(data, function(index, event) {
                         events.push({
                           id:'default',
                           title: event.calTitle,
                           start: event.calStart,
                           end: event.calEnd,
                           backgroundColor: event.calColor,
                           extendedProps: {
                             calContent: event.calContent,
                             empId: event.empId,
                             calType: event.calType,
                             calNo: event.calNo
                           }
                         });
                       });
                       successCallback(events);
                     
                     },
                     error: function() {
                       failureCallback('이벤트를 가져오는 도중 오류가 발생했습니다!');
                     }
                   });
                 }
               };

             var eventSource2 = {
                 id: 'dept2',
                 events: function(fetchInfo, successCallback, failureCallback) {
                   $.ajax({
                     url: "/calendar/calendarDept",
                     method: 'POST',
                     dataType: 'json',
                     contentType: 'application/json; charset=utf-8',
                     data: JSON.stringify({
                       empId: loginmemberEmpId
                     }),
                     success: function(data) {
                       var events = [];
                       data.forEach(event => {
                         events.push({
                           id:'dept2',
                           title: event.calTitle,
                           start: event.calStart,
                           end: event.calEnd,
                           backgroundColor: event.calColor,
                           extendedProps: {
                             calContent: event.calContent,
                             empId: event.empId,
                             calType: event.calType,
                             calNo: event.calNo
                           }
                         });
                       });
                       successCallback(events);
                       
                     },
                     error: function() {
                       failureCallback('이벤트를 가져오는 도중 오류가 발생했습니다!');
                     }
                   });
                 }
               };

             if (calId.value === 'MY') {
               // 첫 번째 이벤트 소스만 사용
               return [eventSource1];
             } else if(calId.value==="DEPT"){
               // 두 번째 이벤트 소스 추가 사용
               return [eventSource2];
             }
           }

       
        
        // 캘린더 생성 옵션(참고)
        const calendarOption = {
              //일정우선순위 옵션 찾기
            eventSources: eventSources,
            height: '700px', // calendar 높이 설정
            expandRows: true, // 화면에 맞게 높이 재설정
            slotMinTime: '09:00', // Day 캘린더 시작 시간
            slotMaxTime: '18:00', // Day 캘린더 종료 시간
            // 맨 위 헤더 지정
            headerToolbar: headerToolbar,
            initialView: 'dayGridMonth',  // default: dayGridMonth 'dayGridWeek', 'timeGridDay', 'listWeek'
            firstDay: 1,
            locale: 'kr',        // 언어 설정
            selectable: true,    // 영역 선택
            selectMirror: true,  // 오직 TimeGrid view에만 적용됨, default false
            navLinks: true,      // 날짜,WeekNumber 클릭 여부, default false
            // weekNumbers: true,   // WeekNumber 출력여부, default false
            editable: false,      // event(일정) // 바 컨트롤
            /* 시작일 및 기간 수정가능여부
            eventStartEditable: false,
            eventDurationEditable: true,
            */
            dayMaxEvents: true,  // Row 높이보다 많으면 +숫자 more 링크 보임
            
            /* views: {
                dayGridMonth: {
                    dayMaxEventRows: 3
                }
            }, */
            
            nowIndicator: true,
 
                   
               }
       
      
        // 캘린더 생성
        let calendar;
        calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
  
        calendar.render();
      
        // 캘린더 이벤트 등록
        function handleEventAdd(info) {
    console.log("Add:", info);
}
        calendar.on("eventAdd", handleEventAdd);        
    /*     calendar.on("eventAdd", info => console.log("Add:", info)); */
         /*  calendar.on("eventChange", info => console.log("Change:", info));
        calendar.on("eventRemove", info => console.log("Remove:", info)); */
            
   
        function handleEventClick(info){
           console.log(info);
       /*  }
        calendar.on("eventClick", info => {
            */
           console.log("이거이거: ",info.id);
            // console.log("eClick:", info);
             /*console.log('Event: ', info.event.extendedProps);
            console.log('Coordinates: ', info.jsEvent);
            console.log('View: ', info.view);  */
            console.log('요거요거:',info.event.title);
            calTitle.value= info.event.title;
            calNo.value= info.event.extendedProps.calNo;
            calContent.value=info.event.extendedProps.calContent; 
            calType.value=info.event.extendedProps.calType;
            console.log(info.event.extendedProps.empId); //COMA_1 이렇게 나옴
            empId.value=info.event.extendedProps.empId[0].empId; //[object Object]이렇게 넘어옴 ;;
         
            let dateEnd = new Date(info.event.endStr);          
         let localOffsetEnd = dateEnd.getTimezoneOffset() * 60000;
         let localISOTimeEnd = (new Date(dateEnd - localOffsetEnd)).toISOString().slice(0,16);
         calEnd.value =  localISOTimeEnd; //여기서 형변환 시도 해볼까 ?
                  
         let date = new Date(info.event.startStr);
         let localOffset = date.getTimezoneOffset() * 60000;
         let localISOTime = (new Date(date - localOffset)).toISOString().slice(0,16);
         calStart.value = localISOTime;
   
         calColor.value = info.event.backgroundColor;
   

         if(loginmemberEmpId===empId.value){         
      $(".modalV").removeAttr("readonly");
      delBtn.style.display="block";   
         }else{
      $(".modalV").attr("readonly",true);   
      delBtn.style.display="none";   
         };
            Modal.style.display = "block"; 
        };
        
        calendar.on("eventClick",handleEventClick);
        /* calendar.on("eventMouseEnter", info => console.log("eEnter:", info));
        calendar.on("eventMouseLeave", info => console.log("eLeave:", info)); */ 
        function handleDateClick(info){           
       /*  }
        calendar.on("dateClick", info => { */
           console.log("dateClick: "+info);
           console.log("dateClick:", info.dateStr);
     delBtn.style.display="none";
           calStart.value=info.dateStr+" 09:00:00";
           calEnd.value=info.dateStr+" 18:00:00";
           calTitle.value="";
       $(".modalV").removeAttr("readonly");
         
            calContent.value="";
            calNo.value="";
            empId.value="${loginmember.empId}";    
        }; 
        calendar.on("dateClick",handleDateClick);
        
        function handleSelect(info){          
      /*   }
         calendar.on("select", info => {   */          
     delBtn.style.display="none";
            calStart.value=info.startStr+" 09:00:00";
           var endData=new Date(info.endStr.substr(0,4),info.endStr.substr(5,2)-1,info.endStr.substr(8,2));
           var dateString = endData.toISOString();
           dateString = dateString.split("T")[0] + " 18:00:00";
           calEnd.value=  dateString;
       $(".modalV").removeAttr("readonly");
           info.endStr=calEnd.value; 
           info.end=dateString;
           calTitle.value="";
           calContent.value="";
           empId.value="${loginmember.empId}";
            Modal.style.display = "block";         
        };
        calendar.on("select",handleSelect);
        
         //부서일정으로 ㄱㄱ
         function fcDept() {
               console.log(calId);
               calId.value = "DEPT";
               console.log("dlrj", calId);         
               
               // 캘린더를 제거합니다.
               calendar.destroy();
               // 새로운 이벤트 소스를 가져옵니다.
               const newEventSources = getEventSources(calId);

               // 캘린더 옵션을 업데이트합니다.
               calendarOption.eventSources = newEventSources;

               // 캘린더를 다시 생성합니다.
               calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
               calendar.render();
               
               calendar.on("eventClick",handleEventClick);
               calendar.on("dateClick",handleDateClick);
               calendar.on("select",handleSelect);
         }
         
        // 일정(이벤트) 추가하기
        function fCalAdd() {
            if (!calTitle.value) {
                alert("제목을 입력해주세요")
                calTitle.focus();
                return;
                
            }
             let event = {
                  calNo: calNo.value,
                    empId: empId.value, //추가
                    calTitle: calTitle.value, 
                    calContent: calContent.value, // 추가
                  calStart: calStart.value,
                    calEnd: calEnd.value,
                    calType: calType.value, //추가
                    calColor: calColor.value
            }; 
            if(!calNo.value){
            $.ajax({
                url: "/calendar/calendarInsert",
                method: "POST",
                dataType: "json",
                data: JSON.stringify(event),
                contentType: 'application/json',
                success: function(data){
                 // calendar.addEvent(data); 
                 // location.href='/calendar';
                 calendar.refetchEvents();
                },
                error: function(e){
                   alert('일정등록중 오류가 발생하였습니다 다시 시도하십시오');
                   console.log(e);
                }
            })
            }else{
               $.ajax({
                  url: "/calendar/calendarUpdate",
                  method: "POST",
                  dataType: "json",
                  data: JSON.stringify(event),
                  contentType: 'application/json',
                  success: function(data){
                     calendar.refetchEvents();
                  },
                  error: function(e){
                     alert('일정 수정중 요류가 발생하였습니다. 다시 입력 하십시오');
                     console.log(e);
                  }
               })
            }
               
               fMClose();
           }       
       
      //일정 (이벤트) 삭제하기
       function delClose(){
          let event = {
                  calNo: calNo.value
            };
          $.ajax({
              url: "/calendar/calendarDelete",
              method: "POST",
              dataType: "json",
              data: JSON.stringify(event),
              contentType: 'application/json',
              success: function(data){
                 calendar.refetchEvents();
              },
              error: function(e){
                 alert('일정 삭제중 요류가 발생하였습니다. 다시 입력 하십시오');             
              }
           })
            fMClose();
        }
           
        // 모달 닫기
        function fMClose() {
            Modal.style.display = "none";
        }
      
    </script>
</body>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>