function CalendarApp(calendarId, isDateSelectable) {
    this.$calendar = $(calendarId);
    this.$calendarObj = null;
    this.isDateSelectable = isDateSelectable;
}

CalendarApp.prototype.enableDrag = function() {
    //드래그 가능성을 활성화
};

CalendarApp.prototype.onDrop = function(source, date) {
    //드래그 앤 드롭 이벤트
};

CalendarApp.prototype.onSelect = function(start, end, allDay) {
    //캘린더의 날짜/시간 선택을 처리
    this.selectedRange = {
        start: start,
        end: start==end?end:end.subtract(1, 'days') 
    };
    var startDate = this.selectedRange.start.format('YYYY-MM-DD');
    var endDate = this.selectedRange.end.format('YYYY-MM-DD');

    let prevForm=document.querySelector("#holy");
    if(prevForm==null) {
		prevForm=document.createElement("form");
		prevForm.setAttribute("id","holy");
  	 	prevForm.setAttribute("method", "get");
    	prevForm.setAttribute("action", path+`/docu/insertaprv`);
	}
	prevForm.innerHTML="";
    // form 생성
/*    var form = document.createElement("form");
    form.setAttribute("id","holy");
    form.setAttribute("method", "post");
    form.setAttribute("action", `/docu/insertaprv`);*/

    // startDate input 생성
    var startDateInput = document.createElement("input");
    startDateInput.setAttribute("type", "hidden");
    startDateInput.setAttribute("name", "startDate");
    startDateInput.setAttribute("value", startDate);
    prevForm.appendChild(startDateInput);

    // endDate input 생성
    var endDateInput = document.createElement("input");
    endDateInput.setAttribute("type", "hidden");
    endDateInput.setAttribute("name", "endDate");
    endDateInput.setAttribute("value", endDate);
    prevForm.appendChild(endDateInput);
 	
 	console.log(prevForm); // 생성된 form 출력
    
   document.body.appendChild(prevForm);

    // form 객체 반환
    return prevForm;
};

CalendarApp.prototype.onEventClick = function(calEvent, jsEvent, view) {
    //캘린더 이벤트 클릭
};

CalendarApp.prototype.init = function() {
    this.enableDrag();

    var $this = this;
    var today = new Date($.now());

    $this.$calendarObj = $this.$calendar.fullCalendar({
        handleWindowResize: true,
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
       	events: this.$calendar[0].id === 'mycal1' ? null : path+"/myevents",
        eventDataTransform: function(eventData) {
			
    console.log(eventData);

    var color;
    switch(eventData.STATUS) {
        case '지각':
            color = 'red';
            break;
        case '조퇴':
            color = 'orange';
            break;
        case '출근':
            color = 'green';
            break;
        case '휴가승인':
            color = 'blue';
            break;
        default:
            color = 'gray'; 
    }

    var startMoment = moment(eventData.START_DAY);
    var endMoment = moment(eventData.END_DAY);

    // 여러 날에 걸친 이벤트인 경우, 종료 날짜의 자정이 아닌 다음 날 자정까지 포함되도록 수정합니다.
    if (startMoment.isBefore(endMoment, 'day')) {
        endMoment.add(1, 'days');
    }

    return {
        title: eventData.STATUS,
        start: startMoment.format('YYYY-MM-DD'),
        end: endMoment.format('YYYY-MM-DD'),
        allDay: true,
        backgroundColor: color,
        borderColor: color,
        textColor: 'white',
        className: 'custom-event'
    };
},
        
        editable: false,
        droppable: true,
        eventLimit: false,
        selectable: this.isDateSelectable,
        select: this.isDateSelectable ? function (start, end, allDay) {
            $("td").removeClass('selected');
            $this.onSelect(start, end, allDay); 
        } : null,
        selectAllow: function(selectInfo) {
    var start = selectInfo.start;
    var today = moment().startOf('day');
    if (selectInfo.start < today) return false;

    var end = selectInfo.end.clone().subtract(1, 'days');
    var diffDays = end.diff(start, 'days');

    if (diffDays > 14) {
        return false;
    }

    while(end >= start) {
        $("td[data-date='" + start.format('YYYY-MM-DD') + "']")
            .addClass('selected')
            .css({"background-color": "black", "color": "white"});
        start.add(1, 'days');
    }
    return true;
        },
        drop:  function(date) { $this.onDrop($(this), date); },
        eventClick: function(calEvent, jsEvent, view) { $this.onEventClick(calEvent, jsEvent, view); }	
    });
};

// CalendarApp 인스턴스 생성
$.CalendarApp1 = new CalendarApp('#calendar', false); 
$.CalendarApp1.Constructor = CalendarApp;

$.CalendarApp2 = new CalendarApp('#mycal1', true); 
$.CalendarApp2.Constructor = CalendarApp;

// 초기화
(function($) {
    "use strict";
    $.CalendarApp1.init();
    $.CalendarApp2.init();
})(window.jQuery);
