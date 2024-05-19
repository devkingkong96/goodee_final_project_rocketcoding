//[advanced form element Javascript]


$(function () {
    "use strict";

    //Initialize Select2 Elements
    $('.select2').select2();

    //Datemask dd/mm/yyyy
    $('#datemask').inputmask('dd/mm/yyyy', {'placeholder': 'dd/mm/yyyy'});
    //Datemask2 mm/dd/yyyy
    $('#datemask2').inputmask('mm/dd/yyyy', {'placeholder': 'mm/dd/yyyy'});
    //Money Euro
    $('[data-mask]').inputmask();

    //Date range picker
    $('#reservation').daterangepicker();
    //Date range picker with time picker
    $('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'});
    //Date range as a button
    $('#daterange-btn').daterangepicker(
        {


            ranges: {
                /*'Today'*/
                '오늘 ': [moment(), moment()],
                /*'Yesterday'*/
                '1일 전 ': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                /*'Last 7 '*/
                '7일 전 ': [moment().subtract(6, 'days'), moment()],
                /*'Last 30 Days'*/
                '30일 전 ': [moment().subtract(29, 'days'), moment()],
                /*'This Month'*/
                '이번 달': [moment().startOf('month'), moment().endOf('month')],
                /*'Last Month'*/
                '마지막 달 ': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
                '1년 전': [moment().subtract(1, 'year').startOf('month'), moment().subtract(1, 'year').endOf('year')]
            },
            locale: {
                format: 'YYYY년 MM월 DD일',
                separator: ' - ',
                applyLabel: '적용',
                cancelLabel: '취소',
                weekLabel: 'W',
                customRangeLabel: '사용자 정의 범위',
                daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                firstDay: 1
            },
            startDate: moment().subtract(3, 'months'),
            endDate: moment(),
            opens: 'right'
        },
        function (start, end) {

            // JavaScript에서 start와 end 값을 hidden 필드에 설정

            var startDateString = start.format('YYYY-MM-DD');  // 또는 다른 원하는 형식으로 변환 가능
            var endDateString = end.format('YYYY-MM-DD');      // 또는 다른 원하는 형식으로 변환 가능

            localStorage.setItem("startDate", startDateString);
            localStorage.setItem("endDate", endDateString);

            $('#start-date-hidden').val(startDateString);
            $('#end-date-hidden').val(endDateString);

            $('#daterange-btn span').html(start.format('YYYY년 MM월 DD일') + ' - ' + end.format('YYYY년 MM월 DD일'));
        }
    );

    //Date picker
    $('#datepicker').datepicker({
        autoclose: true
    });

    //iCheck for checkbox and radio inputs
    $('.ichack-input input[type="checkbox"].minimal, .ichack-input input[type="radio"].minimal').iCheck({
        checkboxClass: 'icheckbox_minimal-blue',
        radioClass: 'icheckbox_minimal-blue'
    });
    //Red color scheme for iCheck
    $('.ichack-input input[type="checkbox"].minimal-red, .ichack-input input[type="radio"].minimal-red').iCheck({
        checkboxClass: 'icheckbox_minimal-red',
        radioClass: 'iradio_minimal-red'
    });
    //Flat red color scheme for iCheck
    $('.ichack-input input[type="checkbox"].flat-red, .ichack-input input[type="radio"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-green',
        radioClass: 'iradio_flat-green'
    });

    //Colorpicker
    $('.my-colorpicker1').colorpicker();
    //color picker with addon
    $('.my-colorpicker2').colorpicker();

    //Timepicker
    $('.timepicker').timepicker({
        showInputs: false
    });

    //Bootstrap-TouchSpin
    $(".vertical-spin").TouchSpin({
        verticalbuttons: true,
        verticalupclass: 'ti-plus',
        verticaldownclass: 'ti-minus'
    });
    var vspinTrue = $(".vertical-spin").TouchSpin({
        verticalbuttons: true
    });
    if (vspinTrue) {
        $('.vertical-spin').prev('.bootstrap-touchspin-prefix').remove();
    }
    $("input[name='demo1']").TouchSpin({
        min: 0,
        max: 100,
        step: 0.1,
        decimals: 2,
        boostat: 5,
        maxboostedstep: 10,
        postfix: '%'
    });
    $("input[name='demo2']").TouchSpin({
        min: -1000000000,
        max: 1000000000,
        stepinterval: 50,
        maxboostedstep: 10000000,
        prefix: '$'
    });
    $("input[name='demo3']").TouchSpin();
    $("input[name='demo3_1']").TouchSpin({
        initval: 40
    });
    $("input[name='demo4']").TouchSpin({
        prefix: "pre",
        postfix: "post"
    });

});