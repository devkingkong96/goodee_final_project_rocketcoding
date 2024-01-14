<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%-- <%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %> --%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-ddHH:mm");
    String formattedNow = now.format(formatter);
%>

<%--<title>로켓코딩ERP</title>--%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="입/출고 등록"/>
</jsp:include>

<script type="text/javascript"
        src="${path }/resources/assets/vendor_components/moment/moment.js"></script>

</head>

<!-- extract 버튼 가져오기 -->
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
        src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script
        src="https://cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
<script
        src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.colVis.min.js"></script>
<script
        src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
<script
        src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
<script
        src="https://cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>
<script
        src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.bootstrap.min.js"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
<script
        src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
<script
        src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
<script
        src="https://cdn.datatables.net/fixedheader/3.1.2/js/dataTables.fixedHeader.min.js"></script>

<style>
    .dt-button-background {
        display: none !important;
    }

    .dt-buttons.btn-group {
        display: block;
    }

    .dataTables_length {
        display: block;
        justify-content: flex-end;
        margin-left: 0;
    }

    .dataTables_info {
        display: block;
        justify-content: flex-end;
    }

    #example1_filter, #example1_info {
        display: block;
        justify-content: flex-end;
    }

    .col-lg-6 col-6.connectedSortable div {
        margin-bottom: 20px;
        /*        margin-right: 20px;
                margin-left: 20px;*/
    }

    .dataTables_wrapper .dataTable td {
        white-space: normal;
        word-wrap: break-word;
    }

    .plusButton::after {
        content: "+";
    }

    .box-table {
        margin-bottom: 400px;
        /*margin-left: 50px;*/
        /*width: 95%;*/
        align-content: center;
    }

    .col-lg-6 col-6 connectedSortable ui-sortable {
        margin-right: 50px;
        margin-left: 50px;
    }

    textarea.form-control {
        width: 200px;
        height: 150px;
        resize: none;
    }

    .input-group-text1 {
        vertical-align: middle;
        position: relative;
        top: 10px;
    }
</style>
<script>
    // alert("script");
    var firstValue;
    var justones = false;


    function getCurrentDateTime() {
        var now = new Date();
        var year = now.getFullYear();
        var month = ('0' + (now.getMonth() + 1)).slice(-2);
        var day = ('0' + now.getDate()).slice(-2);
        var hour = ('0' + now.getHours()).slice(-2);
        var minute = ('0' + now.getMinutes()).slice(-2);
        var second = ('0' + now.getSeconds()).slice(-2);
        return year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
    }


    $(document).ready(function () {
        // alert("ready");
        var select2Data = {};

        /*         CKEDITOR.replace('editorElementId'); */
        var path = "${path}";
        var chooseBookElements = $('.chooseBook');

        $(function () {
            $("#min").datepicker();
            $("#max").datepicker();
        })

        chooseBookElements.select2({
            placeholder: "도서를 선택하세요",
            allowClear: true
        });

        $('#example1').DataTable({

            // 기본 DataTables 설정
            "paging": false,
            "lengthChange": false,
            "searching": false,
            // "order": [[3, 'desc']],
            "info": true,
            "editable": false,
            "responsive": true,
            /*            "dateFormat": 'YYYY-MM-DD HH:mm',*/
            "dom": '<"dt-buttons">Bflirtp',
            "autoWidth": false,
            "fixedHeader": true,
            "drawCallback": function (settings) {
                // DataTables가 다시 그려질 때마다 실행됩니다.
                $('#example1').editableTableWidget();

            },
            columnDefs: [
                {
                    targets: '_all', // 모든 열을 대상으로 함
                    editable: false // 모든 열을 수정 불가능하게 설정
                }
            ],

            "buttons": [{
                extend: 'colvis',
                text: '일부 컬럼 보기'

            },
                {
                    extend: 'colvisRestore',
                    text: '컬럼 복원'

                }, {

                    extend: 'copy',

                    /*            exportData: {decodeEntities: true}, */
                    text: '클립보드에 복사',
                    exportOptions: {
                        columns: ':visible',
                        rows: ':visible',
                        encoding: 'UTF-8'

                    }
                }, {
                    extend: 'csv',

                    /*                 exportData: {decodeEntities: true}, */
                    title: '입/출고 추가 ' + getCurrentDateTime(),
                    exportOptions: {
                        columns: ':visible',
                        rows: ':visible',
                        encoding: 'UTF-8'
                    }
                }, {
                    extend: 'excel',
                    title: '입/출고 추가 ' + getCurrentDateTime(),
                    /*                 exportData: {decodeEntities: true}, */
                    exportOptions: {
                        columns: ':visible',
                        rows: ':visible',
                        encoding: 'UTF-8'

                    }
                }, {
                    extend: 'pdfHtml5',
                    /*          exportData: {decodeEntities: true}, */
                    text: 'PDF',
                    title: '입/출고 추가 ' + getCurrentDateTime(),
                    font: 'hangul',
                    exportOptions: {
                        columns: ':visible',
                        rows: ':visible',
                        encoding: 'UTF-8',

                        /*font: 'hangul',*/
                        customize: function (doc) {
                            // 폰트 설정 추가
                            /*                       doc.defaultStyle.styles.tableBodyEven.font = 'Roboto';*/
                            font: 'Roboto';
                            doc.defaultStyle.fonts = 'Roboto';
                            doc.defaultStyle.font = 'Roboto';
                            modifier: {
                                page: 'current'
                            }

                        },

                    }

                }, {
                    extend: 'print',
                    title: '입/출고 추가 ' + getCurrentDateTime(),
                    /*           exportData: {decodeEntities: true}, */
                    exportOptions: {
                        columns: ':visible',
                        rows: ':visible',
                        encoding: 'UTF-8'
                    }
                }

            ],

            "language": {
                "lengthMenu": "표시할 항목 수: _MENU_",
                "info": "총 _TOTAL_개 중 _START_부터 _END_까지 표시",
                "search": "검색:",
                "paginate": {
                    "first": "처음",
                    "last": "마지막",
                    "next": "다음",
                    "previous": "이전",
                    "emptyTable": "데이터가 없어요.",
                    "lengthMenu": "페이지당 _MENU_ 개씩 보기",
                    // "info": "현재 _START_ - _END_ / _TOTAL_건",
                    "infoEmpty": "데이터 없음",
                    "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
                    // "search": "에서 검색: ",
                    "zeroRecords": "일치하는 데이터가 없어요.",
                    "loadingRecords": "로딩중...",
                    "processing": "잠시만 기다려 주세요..."


                },

            }


        });
        $('#example1').editableTableWidget().on('change', function (e, newValue) {
            // alert("change");

            var cell = $(e.target);
            // <select> 요소의 변경은 무시
            if (cell.is('select')) {
                return;
            }

            // 셀의 데이터가 변경되었을 때의 처리
            var cell = $(e.target);
            var columnIdx = cell.index();
            var rowIdx = cell.closest('tr').index();
            var table = $('#example1').DataTable();
            var data = table.row(rowIdx).data();


            data[columnIdx] = newValue; // 데이터 배열 업데이트

            /*            // 검색 색인 업데이트 없이 데이터만 업데이트
                        table.row(rowIdx).data(data);*/
            table.row(rowIdx).data(data).draw(); // 검색 색인 업데이트
        });
        var prdTitleToIdMapString = '${jsonMap}';
        var prdTitleToIdMap = JSON.parse(prdTitleToIdMapString);

        var table = $('#example1').DataTable();
        console.log("prdTitleToIdMap: " + prdTitleToIdMap);

        $(document).on('change', '.chooseBrc', function () {

            var currentPagePath = window.location.pathname;
            var url = currentPagePath + '/branchempinfo';

            var select = $(this);
            var branchId = select.val();

            $.ajax({
                url: url, // 서버 URL
                method: 'GET',
                data: {
                    /* bookName: selectedBook,*/
                    branchId: branchId
                },
                success: function (response) {
                    console.log(response);
                    populateSelectOptions(response);
                },
                error: function (xhr, status, error) {
                    // 에러 처리
                    alert('오류가 발생했습니다: ' + error);
                }
            });

            function populateSelectOptions(empInfo) {
                var selectElement = document.querySelector('.chooseRecieveEmp');
                selectElement.innerHTML = ''; // 기존 옵션 제거

                // 서버로부터 받은 데이터를 이용하여 새로운 옵션 생성
                var option = document.createElement('option');
                empInfo.forEach(emp => {
                    option = document.createElement('option');
                    option.value = emp.EMP_NO; // 예: 직원 ID
                    option.textContent = '[' + emp.DEP_NAME + '] [' + emp.EMP_LV + '] ' + emp.EMP_NAME // 예: 직원 이름
                    selectElement.appendChild(option);
                });

                // select2 업데이트를 위해 'change' 이벤트를 트리거합니다.
                $(selectElement).select2();
                $(selectElement).trigger('change');
            }

        });

        $(document).on('change', 'td .chooseBook', function () {
            /*       var select = $(this);
                   var selectedBook = select.val(); // 선택된 도서명*/

            var select = $(this);
            var prdId = select.val();
            var rowIndex = $(this).closest('tr').index();
            select2Data[rowIndex] = prdId;

            var selectElement = document.querySelector('.chooseBook');
            var selectedValue = selectElement.value; // 선택된 옵션의 밸류값 가져오기

// 선택된 밸류값과 일치하는 옵션 찾기
            var selectedOption = selectElement.querySelector('option[value="' + selectedValue + '"]');

            if (selectedOption) {
                var selectedText = selectedOption.textContent; // 선택된 옵션의 텍스트 가져오기
                console.log("Selected Text: " + selectedText);
            } else {
                console.log("No option selected");
            }

            // selectedText에 선택한 옵션의 텍스트 값이 들어 있습니다.
            // console.log(selectedText);

            /*            var some = document.querySelector('.selectbook-form-label').textContent = selectedBook;
                        console.log(some);*/

            var rowData = table.row(rowIndex).data();
            rowData[2] = '<label class="form-label" style="display:none;">도서 선택</label> <select class="chooseBook form-control select2" data-placeholder="도서를 선택하세요" style="width: 100%;"> <option>' + selectedText + '</option><c:forEach var="entry" items="${prdTitleToIdMap }"><c:if test="${entry.key != null}"> <option value="${entry.value}"> ${entry.key}</option></c:if></c:forEach> </select>';
            console.log("rowData[2]: " + rowData[2]);

            var selectedValue = $(this).val(); // 선택된 값 가져오기
            var selectId = selectedValue; // 새로운 ID 생성
            $(this).attr('id', selectId); // ID를 변경된 값으로 설정

            console.log("prdId : " + prdId);
            var selectedTitle = prdTitleToIdMap[prdId];
            var row = select.closest('tr'); // 현재 행 찾기
            var currentPagePath = window.location.pathname;
            var url = currentPagePath + '/prdinfo';
            console.log("prdId: " + prdId);

            console.log("prdTitleToIdMap: " + prdTitleToIdMap);
            // AJAX 요청
            $.ajax({
                url: url, // 서버 URL
                method: 'GET',
                data: {
                    /* bookName: selectedBook,*/
                    prdId: prdId
                },
                success: function (response) {

                    console.log("response.PRD_PRICE: " + response.PRD_PRICE);
                    var rowIndex = table.row(row).index();

                    table.cell(rowIndex, 1).data(response.PRD_ID);
                    table.cell(rowIndex, 4).data(response.PRD_PRICE);
                    table.cell(rowIndex, 5).data(response.PRICE_IN_STK);

                    table.draw();

                },
                error: function (xhr, status, error) {
                    // 에러 처리
                    alert('오류가 발생했습니다: ' + error);
                },

            });
        });

        var table = $('#example1').DataTable();

        var plusButtonCounter = 1;

        $(document).on('click', '[id$="plusButton"]', function () {

            plusButtonCounter++; // 카운터 증가
            // alert("하이");
            var buttonId = $(this).attr('id'); // 클릭된 버튼의 ID
            console.log("buttonId: " + buttonId);
            var currentRow = $(this).closest('tr');
            console.log("currentRow: " + currentRow);
            var currentRowIndex = currentRow.index();
            console.log("currentRowIndex: " + currentRowIndex);
            /*            var currentButtonRow = $(this).attr('id').closest('tr');*/


            var newData = ['<button type="button" id="' + plusButtonCounter + 'plusButton" class="plusButton waves-effect waves-light btn btn-outline btn-primary-light mb-5"></button>', '', '<label class="form-label" style="display:none";>도서 선택</label> <select class="chooseBook form-control select2" data-placeholder="도서를 선택하세요" style="width: 100%;"> <option></option><c:forEach var="entry" items="${prdTitleToIdMap }"><c:if test="${entry.key != null}"> <option value="${entry.value}"> ${entry.key}</option></c:if></c:forEach> </select>', '최소 1 입력', '', '', '메모 입력', '<button type="button" id="delButton" class="waves-effect waves-light btn btn-danger-light btn-flat mb-5">삭제</button>'];


            var firstRowChooseBook = $('#example1 tbody tr:first .choosebook');
            // alert(firstRowChooseBook.val());

            var currentData = table.rows().data().toArray();
            // console.log("currentData: " + currentData);
            var selectedValues = [];
            $('.chooseBook').each(function () {
                var selectedValue = $(this).val();
                selectedValues.push(selectedValue);
            });


            // 현재 클릭한 행 아래로 데이터를 밀어냄
            currentData.splice(currentRowIndex + 1, 0, newData);

            table.clear().rows.add(currentData).draw();

            // 다시 그린 모든 행의 특정 셀에 'name' 속성 추가
            $('#example1 tbody tr').each(function () {
                // 이전에 선택된 값을 저장
                // var prevSelectedValue = $(this).find('.select2').val();

                $(this).find('td').eq(0).attr('name', 'dontedit');
                $(this).find('td').eq(1).attr('name', 'dontedit').addClass('prdId');
                $(this).find('td').eq(2).attr('name', 'dontedit');
                $(this).find('td').eq(3).addClass('prdIvQuantity');
                $(this).find('td').eq(4).attr('name', 'dontedit');
                $(this).find('td').eq(5).attr('name', 'dontedit');
                $(this).find('td').eq(6).addClass('prdIvMemo');
                $(this).find('td').eq(7).attr('name', 'dontedit');

                // 모든 행에 있는 '.select2' 요소 초기화
                var select2Element = $(this).find('.select2');
                var rowIndex = $(this).closest('tr').index();

                $('tbody tr').each(function (index) {

                    var select2Value = $(this).find('.chooseBook').val(); // .chooseBook 클래스를 가진 요소의 선택된 값을 가져옴
                    var cell = table.cell(index, 1);

                    select2Value = selectedValues[index];
                    /*                    cell.data(select2Value); // 선택된 값을 셀에 할당
                                        cell.draw(); // 변경된 데이터를 테이블에 그리기*/

                    /*$(this).next().find('.chooseBook').val(selectedValues[index]).trigger('change');*/ // 선택된 값을 .chooseBook 클래스를 가진 요소에 설정
                    if (index > currentRowIndex) {
                        $(this).next().find('.chooseBook').val(select2Value);
                    }
                    if (index <= currentRowIndex) {
                        $(this).find('.chooseBook').val(select2Value);
                    }

                    if (index === 0) {

                        select2Element.select2({

                            allowClear: true
                        });

                    }
                });

                table.draw();
                if (justones === false) {
                    var lastTr = $('#example1 tbody tr:last')
                    var select2Container = lastTr.find('.select2.select2-container.select2-container--default');
                    // var select2Container = $('.select2.select2-container.select2-container--default');

                    // select2Container가 속해 있는 DataTables의 행 삭제
                    var dataTable = $('#example1').DataTable(); // DataTables 초기화
                    select2Container.each(function () {
                        var row = $(this).closest('tr');
                        var rowIndex = dataTable.row(row).index(); // 행의 인덱스 가져오기
                        dataTable.row(rowIndex).remove().draw(); // 행 삭제 및 테이블 다시 그리기
                        /*         dataTable.row(0).data(currentData[0]).draw();
                                 rowselect2 = row.find('.select2');*/
                    });

                    justones = true;
                }
            });
        });
    });

</script>
<div class="content-wrapper">
    <div class="container-full">
        <!-- Main content -->
        <section class="content">

            <%--            <!-- 모달 -->
                        <div class="col-lg-4 col-12">
                            <div class="box">
                                <div class="box-body">
                                    <h4 class="box-title d-block">Large modal</h4>
                                    <button type="button" class="btn btn-primary"
                                            data-bs-toggle="modal" data-bs-target=".bs-example-modal-lg">
                                        Large modal
                                    </button>
                                </div>
                            </div>
                        </div>
                        <!-- /.col -->

                        <div class="modal fade bs-example-modal-lg" tabindex="-1"
                             role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"
                             style="display: none;">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myLargeModalLabel">Large modal</h4>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <h4>Overflowing text to show scroll behavior</h4>
                                        <p>Praesent commodo cursus magna, vel scelerisque nisl
                                            consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum
                                            faucibus dolor auctor.</p>
                                        <p>Aenean lacinia bibendum nulla sed consectetur. Praesent
                                            commodo cursus magna, vel scelerisque nisl consectetur et. Donec
                                            sed odio dui. Donec ullamcorper nulla non metus auctor
                                            fringilla.</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger text-start"
                                                data-bs-dismiss="modal">Close
                                        </button>
                                    </div>
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                        </div>--%>

            <!-- Content Header (Page header) -->
            <div class="content-header" style="margin-bottom:10px;">
                <div class="d-flex align-items-center">
                    <div class="me-auto">
                        <h4 class="page-title">지점별 재고 현황 검색</h4>
                        <div class="d-inline-block align-items-center">
                            <nav>
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${path}/"> <i
                                            class="mdi mdi-home-outline"></i></a></li>
                                    <li class="breadcrumb-item" aria-current="page">물류 관리</li>
                                    <li class="breadcrumb-item active" aria-current="page">지점별 재고 현황 검색
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-12">
                    <div class=" connectedSortable">
                        <form name="searchdaybystock" id="searchdaybystock" method="get"
                              action="${path}/logistics/stock/branchbyheigt"
                        <%-- method="post"--%> >
                            <div class="box">
                                <div class="box-header with-border">
                                    <h4 class="box-title"><%--<i class="ti-agenda"></i>--%><strong> 지점별 재고 현황
                                        검색</strong>
                                    </h4>

                                    <h6 class="subtitle">검색 기준 항목을 선택 하세요</h6>
                                    <ul class="box-controls pull-right">
                                        <li><a class="box-btn-close" href="#"></a></li>
                                        <li><a class="box-btn-slide" href="#"></a></li>
                                        <li><a class="box-btn-fullscreen" href="#"></a></li>
                                    </ul>
                                </div>

                                <div class="box-body p-12"> <%--action="${path }/logistics/write"--%>


                                    <%--    <div class="col-6
                                            " style="margin-bottom: 20px;">
                                            <div class="col-12" style="margin-bottom: 5px;">
                                                <label class="form-label" style="margin:5px;">
                                                    <i class="si-note si"></i>
                                                    기안 종류</label>
                                            </div>
                                            <input name="ivType" type="radio" id="ivType_Option_1" checked value="입고"
                                                   class="with-gap radio-col-primary">
                                            <label for="ivType_Option_1">입고</label>
                                            <input name="ivType" type="radio" id="ivType_Option_2" value="출고"
                                                   class="with-gap radio-col-primary">
                                            <label for="ivType_Option_2">출고</label>
                                        </div>--%>

                                    <div class="col-6
                                        " style="margin-bottom: 20px;">
                                        <div class="col-12" style="margin-bottom: 5px;">
                                            <label class="form-label" style="margin:5px;">
                                                <i class="si-note si"></i>
                                                타입</label>
                                        </div>
                                        <input name="tableType" type="radio" id="ivType_Option_1" checked
                                               value="product"
                                               class="with-gap radio-col-primary">
                                        <label for="ivType_Option_1">종(도서명 기준)</label>
                                        <input name="tableType" type="radio" id="ivType_Option_2" value="branch"
                                               class="with-gap radio-col-primary">
                                        <label for="ivType_Option_2">횡(지점 기준)</label>
                                    </div>
                                    <div class="col-lg-5 col-12">
                                        <label class="form-label" style="margin:5px;"
                                               for="stkDate"><i
                                                class="si-calendar si"
                                                style="margin-right:10px;"></i>
                                            기준 날짜</label>
                                        <input class="form-control" id="stkDate" name="stkDate"
                                               type="date"
                                               id="example-datetime-local-input" required>

                                    </div>
                                    <script>
                                        // 오늘 날짜를 가져오는 JavaScript 코드
                                        var today = new Date();

                                        // "YYYY-MM-DD" 형식으로 오늘 날짜를 문자열로 변환
                                        var formattedDate = today.toISOString().slice(0, 10);

                                        // 오늘 날짜를 input 요소에 설정
                                        document.getElementById("stkDate").value = formattedDate;
                                    </script>
                                    <%--                              <div class="col-lg-2 col-5">
                                                                      <label class="form-label" style="margin:5px;"><i class="si-calendar si"
                                                                                                                       style="margin-right:10px;"></i>
                                                                          요청 기한</label>
                                                                      <input class="form-control" name="ivDeadline" type="datetime-local"
                                                                             id="example-datetime-local-input" required>
                                                                  </div>--%>

                                    <%--                                    <div class="row">--%>
                                    <input type="hidden" name="branchId" value=""/>
                                    <input type="hidden" name="prdId" value=""/>
                                    <div class="col-lg-5 col-12" style="margin:5px; margin-top:20px" ;><label
                                            class=" form-label">
                                        <i class="si-organization si" style="margin-right:10px;"></i>지점</label>
                                        <%--               <select
                                                               class="form-control select2" name="recieveBrcId" multiple="multiple"
                                                               data-placeholder="Select a State" style="width: 100%;">--%>
                                        <select
                                                class="chooseBrc form-control select2" name="branchId"
                                                data-placeholder="지점" style="width: 100%;" multiple="multiple">
                                            <option></option>
                                            <c:forEach var="entry" items="${branchList }">

                                                <option value="${entry.BRANCH_ID}">${entry.BRANCH_NAME}</option>

                                            </c:forEach>
                                        </select>
                                    </div>
                                    <%--                                        ${empListByemployeeId }--%>

                                    <div class="col-lg-5 col-12" style="margin:5px; margin-top:20px;">
                                        <label class="form-label"><i class="si-user si"></i>
                                            품목</label>
                                        <%--    <select
                                                    class="form-control select2" name="recieveEmpId" multiple="multiple"
                                                    data-placeholder="Select a State" style="width: 100%;">--%>
                                        <select class="chooseRecieveEmp form-control select2" name="prdId"
                                                data-placeholder="품목" style="width: 100%;" multiple="multiple">
                                            <option></option>
                                            <c:forEach var="entry" items="${productList }">

                                                <option value="${entry.PRD_ID}">${entry.PRD_TITLE}</option>

                                            </c:forEach>
                                        </select>
                                    </div>
                                    <script>
                                        $(document).ready(function () {


                                            // 폼 제출 이벤트 핸들러
                                            document.getElementById("searchdaybystock").addEventListener("submit", function () {
                                                var branchSelect = document.querySelector('.chooseBrc');
                                                var prdSelect = document.querySelector('.chooseRecieveEmp');

                                                // 지점 선택 필드에서 선택된 값이 있는 경우 숨겨진 필드를 비활성화
                                                if (branchSelect.value) {
                                                    document.querySelector('input[name="branchId"]').disabled = true;
                                                }

                                                // 품목 선택 필드에서 선택된 값이 있는 경우 숨겨진 필드를 비활성화
                                                if (prdSelect.value) {
                                                    document.querySelector('input[name="prdId"]').disabled = true;
                                                }
                                            });


                                            $('#searchdaybystock').submit(function () {
                                                if (!$('.chooseBrc').val()) {
                                                    $('<input>').attr({
                                                        type: 'hidden',
                                                        name: 'branchId',
                                                        value: ''
                                                    }).appendTo('#searchdaybystock');
                                                    $('<input>').attr({
                                                        type: 'hidden',
                                                        name: 'prdId',
                                                        value: ''
                                                    }).appendTo('#searchdaybystock');
                                                }
                                            });
                                        });
                                    </script>
                                    <%--                                    </div>--%>

                                    <%--   <div class="col-lg-4 col-5" style="margin:5px; margin-top:20px" ;><label
                                               class=" form-label">
                                           <i class="si-organization si" style="margin-right:10px;"></i>결재자 선택</label>
                                           &lt;%&ndash;               <select
                                                                  class="form-control select2" name="recieveBrcId" multiple="multiple"
                                                                  data-placeholder="Select a State" style="width: 100%;">&ndash;%&gt;
                                           <select
                                                   class="form-control select2" name="aprvEmp" multiple="multiple"
                                                   data-placeholder="Select a State" style="width: 100%;">
                                               <option></option>
                                               <c:forEach var="entry" items="${empListByemployeeId }">
                                                   <option value="${entry.EMP_NO}">
                                                       [${entry.DEP_NAME}] [${entry.EMP_LV}] ${entry.EMP_NAME}</option>
                                               </c:forEach>
                                           </select>
                                       </div>--%>

                                    <%--				<div class="dropzone" id="myDropzone">
                                                        <div class="fallback">
                                                            <input name="file" type="file" multiple/>
                                                        </div>
                                                    </div>--%>
                                    <%--                              <div class="row">
                                                                      <div style="margin-top: 30px;">
                                                                          <div class="col-12" style="margin:5px;"><i class="si-calculator si"
                                                                                                                     style="margin-right:10px;"></i>
                                                                              부가세
                                                                              포함
                                                                              여부
                                                                          </div>
                                                                          <input name="ivVatType" type="radio"
                                                                                 id="vat_Option_1"
                                                                                 checked value="Y" class="with-gap radio-col-primary">
                                                                          <label for="vat_Option_1">포함</label>
                                                                          <input name="ivVatType" type="radio" id="vat_Option_2" value="N"
                                                                                 class="with-gap radio-col-primary">
                                                                          <label for="vat_Option_2">제외</label>
                                                                      </div>

                                                                      <div id="file-container">
                                                                          <div class="input-group mb-3"
                                                                               style="padding: 0px; margin-top: 10px; margin-left: -10px;">
                                                                              <div class="input-group-prepend" style="padding: 0px; ">
                                                                                  <button type="button"
                                                                                          class="waves-effect waves-light btn btn-info-light btn-flat mb-3"
                                                                                          onclick="fn_addFileForm();" style="margin:10px;">첨부파일 추가
                                                                                  </button>
                                                                                  <button type="button"
                                                                                          class="waves-effect waves-light btn btn-danger-light btn-flat mb-3"
                                                                                          onclick="fn_deleteFileForm();" style="margin:10px;">첨부파일 삭제
                                                                                  </button>
                                                                              </div>
                                                                          </div>
                                                                          <div id="basicFileForm" class="input-group mb-3"
                                                                               style="padding: 0; margin-top:-20px;">
                                                                              <div>
                                                                                  <div>
                                                                                  <span class="input-group-text1"><i
                                                                                          class="fa fa-fw fa-file-o"
                                                                                          style="margin-right:10px;"></i> 첨부파일 1</span>
                                                                                  </div>
                                                                                  <input type="file" class="custom-file-input" name="upFile"
                                                                                         id="upFile1" style="display: none;"
                                                                                         onchange="changeFileFunc(event);">
                                                                                  <label
                                                                                          class="custom-file-label waves-effect waves-light btn btn-primary-light btn-flat mb-3"
                                                                                          for="upFile1" style="margin:10px;">파일을
                                                                                      선택하세요</label>

                                                                                  &lt;%&ndash;                                                    <div name="fileButton"></div>&ndash;%&gt;
                                                                              </div>
                                                                          </div>

                                                                          <div class="col-lg-2 col-5">
                                                                              <label>
                                                                                  <!--  <textarea id="editorElementId" class="form-control" name="iv_memo"
                                                                                             placeholder="적요"></textarea> -->

                                                                                  <textarea class="col-lg-2 col-5 form-control" name="ivMemo"
                                                                                            placeholder="&#128221;적요"></textarea>
                                                                              </label>
                                                                          </div>
                                                                      </div>
                                                                      <br/>

                                                                  </div>--%>
                                    <div class="row">
                                        <div class="col-12"
                                             style="margin-top:30px; margin-left:270px; align-items: flex-end; margin-bottom:50px;">
                                            <%--  <input type="hidden" id="tableData" name="tableData" value="">--%>
                                            <%--                                   <input type="hidden" id="ivIsdel" name="ivIsdel" value="N">
                                                                               <input type="hidden" id="sendBrcId" name="sendBrcId" value="1">--%>
                                            <!-- 받는 담당 직원도 넣어주면 좋은데 아직은 필요없는 느낌 -->
                                            <!-- TODO docNo는 지금 안보낼거임-->
                                            <%--                                            <input type="hidden" id="docNo" name="docNo" value="null">--%>
                                            <button type="submit" class="btn btn-primary submitdaybystock">
                                                <i class="ti-save-alt" style="margin-right:10px;"></i> 검색
                                            </button>
                                        </div>
                                    </div>
                                    <%--                                        <input type="submit" class="btn btn-outline-success" value="저장">--%>
                        </form>

                        <script>


                            document.addEventListener("DOMContentLoaded", function () {
                                // 페이지가 로드될 때 실행할 코드

                                // 라디오 버튼 요소 가져오기
                                var radioButtons = document.querySelectorAll('input[name="tableType"]');

                                // 폼 요소 가져오기
                                var form = document.getElementById('searchdaybystock');

                                // 라디오 버튼에 이벤트 리스너 추가
                                radioButtons.forEach(function (radioButton) {
                                    radioButton.addEventListener("change", function () {
                                        var selectedType = document.querySelector('input[name="tableType"]:checked').value;

                                        if (selectedType === 'branch') {
                                            form.action = "${path}/logistics/stock/branchby";
                                        } else if (selectedType === 'product') {
                                            form.action = "${path}/logistics/stock/branchbyheigt";
                                        }
                                    });
                                });
                            });


                            /*                 $('#insertinventory').on('submit', function (e) {
                                                 e.preventDefault(); // 기본 submit 동작 방지

                                                 // 폼 데이터 가져오기
                                                 var formData = $(this).serialize();
                                                 console.log("폼 데이터: ", formData);

                                                 // 데이터 테이블 데이터 가져오기 (예시로 'getAllRowData' 함수 사용)
                                                 var tableData = getAllRowData();
                                                 console.log("데이터 테이블 데이터: ", tableData);

                                                 // 가져온 데이터를 서버로 전송하거나 원하는 작업을 수행하세요.
                                                 $.ajax({
                                                     method: "POST",
                                                     url: "your_server_url_here",
                                                     data: {formData: formData, tableData: JSON.stringify(tableData)},
                                                     success: function (response) {
                                                         // 성공적으로 서버에 데이터를 전송한 후 수행할 작업
                                                         console.log("데이터 전송 성공");
                                                     },
                                                     error: function (error) {
                                                         // 데이터 전송 중 오류 발생 시 수행할 작업
                                                         console.error("데이터 전송 오류: " + error);
                                                     }
                                                 });
                                             });*/

                            /*  const saveButton = document.querySelector('.submitdaybystock');

                              // 이벤트 리스너 추가
                              saveButton.addEventListener('click', function (event) {

                                  event.preventDefault(); // 기본 동작 방지
                                  // alert("무야호");
                                  searchdaybystock();
                                  // alert(a);
                                  // console.log(a);// insertInventory 함수 호출
                              });*/

                            /*        function getCellValue(rowIndex, columnIndex) {
                                        var table = document.querySelector('#example1 tbody tr:nth-child(' + (rowIndex + 1) + ') td:nth-child(' + columnIndex + ')');
                                        alert(table);
                                        if (table) {
                                            return table.textContent;
                                        }

                                        return null; // 요소가 존재하지 않으면 null 반환
                                    }*/


                            function searchdaybystock() {
                                // var table = $('#example1').DataTable();


                                // alert("tableData : " + tableData[0]['prdId']);
                                /*            var tableData = table.rows().data().toArray();
                                            console.log("데이터 테이블 데이터: ", tableData);*/

                                // const form = document.querySelector("#searchdaybystock");

                                // var serializedData = $("#searchdaybystock").serialize();

                                /*                        let formData = new FormData(form);
                                                        let entries = formData.entries();
                                                        console.log(entries);
                                                        for (const pair of entries) {
                                                            console.log(pair[0] + " : " + pair[1]);
                                                        }*/

                                // var formData = new FormData(form); // 폼 요소를 기반으로 FormData 객체 생성
                                // 'ivDeadline' 필드의 값을 가져온다
                                /*       var ivDeadlineValue = formData.get('ivDeadline');


                                       var ivDeadline = document.getElementById('example-datetime-local-input').value;
                                       if (!ivDeadline) {
                                           alert('요청 기한을 입력해주세요.');
                                           return; // 함수 실행을 중단합니다.
                                       }
                                       if (!document.querySelector('select[name="recieveEmpId"]').value) {
                                           alert('거래처와 직원을 선택해 주세요');
                                           return; // 함수 실행을 중단합니다.
                                       }
       */
                                /*                      function getAllRowData() {
                                                          var table = $('#example1').DataTable();
                                                          var rowDataArray = [];
                                                          choosePrdCount2 = 0;
                                                          table.rows().every(function (index) {
                                                              var rowData = {}; // 각 행의 데이터를 담을 객체 초기화
                                                              var row = this.data(); // 현재 행의 데이터 가져오기

                                                              // 열 이름 배열 가져오기
                                                              var list = [];
                                                              var columnNames = table.columns().header().toArray();
                                                              // var cellValue;
                                                              /!*                // 각 열 순회
                                                                              var rowNode = this.node(); // 현재 행의 DOM 요소 가져오기

                                                                              // 2번째 열의 데이터를 가져오기
                                                                              var secondCellData = rowNode.querySelector('td:nth-child(2)').textContent;*!/

                                                              var choosePrdCount = 0;
                                                              for (var i = 0; i < columnNames.length; i++) {

                                                                  var columnName = columnNames[i].innerText; // 열 이름 가져오기
                                                                  if (i === 1) {

                                                                      // cellValue = row[i];

                                                                      /!*                   var prdIdElement = document.querySelector('#example1 td.prdId');
                                                                                         if (prdIdElement) {
                                                                                             var prdIdValue = prdIdElement.textContent;
                                                                                             alert(prdIdValue);
                                                                                         } else {
                                                                                             alert("요소를 찾을 수 없습니다.");
                                                                                         }*!/


                                                                      // alert(document.querySelector('#example1 td.prdId'));
                                                                      rowData["prdId"] = document.querySelectorAll('#example1 td.prdId')[index].textContent;
                                                                      if (rowData["prdId"] === "" && choosePrdCount == 0) {

                                                                          alert("상품을 선택해주세요 : " + index);
                                                                          return;
                                                                      }

                                                                      // rowData["prdId"] = document.querySelector('#example1 td.prdId').textContent;
                                                                      /!*       list.push(rowData["prdId"]);*!/
                                                                      console.log("rowData[prdId] : " + rowData["prdId"]);

                                                                  } else if (i === 3) {
                                                                      cellValue = row[i];

                                                                      console.log("Before setting prdIvQuantity: " + rowData["prdIvQuantity"]);
                                                                      // rowData["prdIvQuantity"] = 3;
                                                                      rowData["prdIvQuantity"] = document.querySelectorAll('#example1 td.prdIvQuantity')[index].textContent;

                                                                      if (rowData["prdIvQuantity"].includes("최소 1 입력") && choosePrdCount == 0) {
                                                                          alert("도서/수량을 입력 해주세요");
                                                                          return;
                                                                      } else if (isNaN(rowData["prdIvQuantity"]) && choosePrdCount == 0) {
                                                                          alert("도서의 수량은 숫자만 입력 가능합니다.");
                                                                          return;
                                                                      }


                                                                      // rowData["prdIvQuantity"] = document.querySelector('#example1 td.prdIvQuantity').textContent;
                                                                      console.log("After setting prdIvQuantity: " + rowData["prdIvQuantity"]);

                                                                      /!*              list.push(rowData["prdIvQuantity"]);*!/
                                                                      // console.log("rowData[prdIvQuantity] : " + rowData["prdIvQuantity"]);

                                                                  } else if (i === 6) {
                                                                      cellValue = row[i];
                                                                      rowData["prdIvMemo"] = document.querySelectorAll('#example1 td.prdIvMemo')[index].textContent;
                                                                      if (rowData["prdIvMemo"].includes("메모 입력")) {
                                                                          rowData["prdIvMemo"] = null;
                                                                      }


                                                                      // rowData["prdIvMemo"] = document.querySelector('#example1 td.prdIvMemo').textContent;
                                                                      /!*                 list.push(rowData["prdIvMemo"]);*!/
                                                                      console.log("rowData[prdIvMemo] : " + rowData["prdIvMemo"]);
                                                                  }
                                                                  choosePrdCount++;
                                                              }
                                                              choosePrdCount2++;

                                                              /!*  for (var i = 0; i < columnNames.length; i++) {
                                                                    var columnName = columnNames[i].innerText; // 열 이름 가져오기
                                                                    if (i === 2) {
                                                                        columneNametoHtml = columnNames[i].innerHTML;

                                                                        var Value = columneNametoHtml.find('.chooseBook').attr('id');
                                                                        console.log("row[i]의 도서 태그 id : : " + cellValue);
                                                                        cellvalue = Value;
                                                                        rowData[columnName] = columnName;
                                                                    } else {
                                                                        cellValue = row[i]; // 현재 열의 값을 가져오기
                                                                        rowData[columnName] = cellValue;
                                                                    }
                                                                    // cellValue = row[i];

                                                                    // 객체에 열 이름을 키로, 해당 열의 값을 값으로 추가
                                                                    // rowData[columnName] = cellValue;
                                                                    console.log("rowData[columnName] : " + rowData[columnName]);
                                                                }*!/

                                                              // 행 데이터 배열에 추가
                                                              var keys = Object.keys(rowData);

                                                              // 키 배열의 길이를 통해 속성의 개수 확인
                                                              var numberOfProperties = keys.length;

                                                              console.log("rowData에는 총 " + numberOfProperties + "개의 속성이 있습니다.");
                                                              rowDataArray.push(rowData);
                                                              console.log("rowData[prdIvQuantity]" + rowData["prdIvQuantity"])
                                                              // 겉데이터1[속데이터[prdid]]
                                                          });
                                                          console.log("야!!!!!!!!!!!!!!!!!!!!!!!!" + rowDataArray.length);
                                                          return rowDataArray;
                                                      }

                                                      var prdInventory = getAllRowData();*/

                                /*            if (prdInventory.length === 0 ) {
                                                alert("상품을 선택해주세요");
                                                return;
                                            }*/

                                /*      if (prdInventory.length === 0) {
                                          // alert("상품을 선택해주세요");
                                          // alert("1");
                                          return;
                                      }

                                      for (var i = 0; i < prdInventory.length; i++) {
                                          if (prdInventory[i]["prdIvQuantity"].includes("최소 1 입력") && choosePrdCount2 >= 0) {
                                              prdInventory.splice(i, 1);
                                              alert("도서의 수량을 입력하거나 사용하지 않는 도서를 삭제 해주세요.");
                                              // alert("3");

                                              return;
                                          } else if (isNaN(prdInventory[i]["prdIvQuantity"]) && choosePrdCount2 >= 0) {
                                              prdInventory.splice(i, 1);
                                              alert("도서의 수량은 숫자만 입력 가능합니다.");
                                              // alert("4");
                                              return;
                                          } else if (prdInventory[i]["prdIvQuantity"].includes("최소 1 입력")) {
                                              prdInventory.splice(i, 1);
                                              // alert("도서/수량을 입력 해주세요");
                                              // alert("3");

                                              break;
                                          }

                                          if (isNaN(prdInventory[i]["prdIvQuantity"])) {
                                              prdInventory.splice(i, 1);
                                              // alert("도서의 수량은 숫자만 입력 가능합니다.");
                                              // alert("4");
                                              break;
                                          } else if (prdInventory[i]["prdIvQuantity"].includes("최소 1 입력")) {
                                              prdInventory.splice(i, 1);
                                              // alert("도서/수량을 입력 해주세요");
                                              // alert("3");

                                              break;
                                          }
                                      }*/


                                /*  for (var item in prdInventory) {
                                      // alert("item.prdIvQuantity : " + item["prdIvQuantity"]);
                                      if (item.prdIvQuantity.includes("최소 1 입력")) {
                                          alert("도서/수량을 입력 해주세요");
                                          return;
                                      } else if (isNaN(item.prdIvQuantity)) {
                                          alert("도서의 수량은 숫자만 입력 가능합니다.");
                                          return;
                                      }
                                  }*/


                                /*       var jsonData = JSON.stringify(prdInventory);
                                       formData.append('prdInventory', jsonData);*/

                                /* for (var i = 0; i < prdInventory.length; i++) {
                                     var item = prdInventory[i];
                                     console.log("item.prdId : " + item.prdId);
                                     console.log("item.prdIvQuantity : " + item.prdIvQuantity);
                                     console.log("item.prdIvMemo : " + item.prdIvMemo);
                        /!*                if ("prdIvQuantity" in item) {
                                                           if (item["prdIvQuantity"].includes("최소 1 입력")) {
                                                                 alert("도서/수량을 입력 해주세요");
                                                                 return;
                                                             } else if (isNaN(item["prdIvQuantity"])) {
                                                                 alert("도서의 수량은 숫자만 입력 가능합니다.");
                                                                 return;
                                                             }
                                     }*!/
                                     formData.append('prdInventory', prdInventory[i]);
                                 }*/

                                /*            for (var i = 0; i < prdInventory.length; i++) {
                                                var item = prdInventory[i];

                                                // 유효성 검증
                                                if ("prdIvQuantity" in item) {
                                                    if (item["prdIvQuantity"].includes("최소 1 입력")) {
                                                        alert("도서/수량을 입력 해주세요");
                                                        return;
                                                    } else if (isNaN(item["prdIvQuantity"])) {
                                                        alert("도서의 수량은 숫자만 입력 가능합니다.");
                                                        return;
                                                    }
                                                }
                                                formData.append('prdInventory', prdInventory[i]);
                                                // FormData에 항목 추가

                                            }*/


                                /*




                                for (var i = 0; i < prdInventory.length; i++) {
                                    var rowData = prdInventory[i];

                                    for (var key in rowData) {
                                        if (rowData.hasOwnProperty(key)) {
                                            // 도서 수량 체크 로직
                                            if (key === "prdIvQuantity" && rowData[key].includes("최소 1 입력")) {
                                                alert("도서/수량을 입력 해주세요");
                                                return;
                                            } else if (key === "prdIvQuantity" && isNaN(rowData[key])) {
                                                alert("도서의 수량은 숫자만 입력 가능합니다.");
                                                return;
                                            }

                                            // 'prdInventories[i].key' 형식으로 FormData에 추가
                                            alert("key : " + prdInventory[i].key + " value : " + rowData[key]);

                                            formData.append(prdInventory[i].rowData[key]);

                                            console.log("key : " + key + " value : " + rowData[key]);
                                        }
                                    }
                                }*/


                                /*            for (var i = 0; i < tableData.length; i++) {
                                                var rowData = tableData[i];
                                                // alert("하이");
                                                for (var key in rowData) {
                                                    if (rowData.hasOwnProperty(key)) {
                                                        // alert[rowData['prdIvQuantity']];
                                                        if (key === "prdIvQuantity" && rowData[key].includes("최소 1 입력")) {

                                                            alert("도서/수량을 입력 해주세요");
                                                            return;
                                                        } else if (key === "prdIvQuantity" && isNaN(rowData[key])) {

                                                            alert("도서의 수량은 숫자만 입력 가능합니다.");
                                                            return;
                                                        }
                                                        formData.append(key, rowData[key]);

                                                        console.log("key : " + key + " value : " + rowData[key]);
                                                    }
                                                }
                                            }*/
                                /*            for (var i = 0; i < tableData.length; i++) {
                                                var rowData = tableData[i];
                                                for (var key in rowData) {
                                                    if (rowData.hasOwnProperty(key)) {
                                                        if (key === "prdIvQuantity" && rowData[key].includes("최소 1 입력")) {
                                                            alert("도서/수량을 입력 해주세요");
                                                            return;
                                                        } else if (key === "prdIvQuantity" && isNaN(Number(rowData[key]))) {
                                                            alert("도서의 수량은 숫자만 입력 가능합니다.");
                                                            return;
                                                        }
                                                        // 다른 필드에 대한 유효성 검사를 추가하려면 위와 유사한 방식으로 처리합니다.

                                                        // 값이 숫자인 경우, Number() 함수를 사용하여 숫자로 변환합니다.
                                                        formData.append(key, isNaN(Number(rowData[key])) ? rowData[key] : Number(rowData[key]));

                                                        console.log("key : " + key + " value : " + rowData[key]);
                                                    }
                                                }
                                            }*/

                                // 콘솔에 출력한다
                                /*     console.log('ivDeadline:', ivDeadlineValue);
                                     console.log(formData);

                                     // formData.append('tableData', tableData);
                                     // 파일을 FormData 객체에 추가


                                     var fileInputs = document.querySelectorAll('input[name=upFile]');
                                     fileInputs.forEach(function (input) {
                                         var files = input.files;
                                         if (files.length > 0) {
                                             for (var i = 0; i < files.length; i++) {
                                                 table.draw();
                                                 formData.append('files', files[i]);
                                                 // alert(files[i]);
                                             }
                                         }
                                     });*/


                                /*            var files = document.querySelector('input[name=upFile]').files;

                                            for (var i = 0; i < files.length; i++) {
                                                formData.append('files', files[i]);
                                            }*/
                                /*    console.log("formdata files: " + formData.get('files'));*/
                                /*// 첫 번째 파일 입력 필드 처리
                                                        var upFile1 = document.querySelector('input[name="upFile1"]').files;
                                                        if (upFile1.length > 0) {
                                                            formData.append('upFile1', upFile1[0]);
                                                        }*/

                                /*// 나머지 파일 입력 필드 처리 (최대 4개 추가)
                                                        for (var i = 2; i <= 5; i++) {
                                                            var fileInput = document.querySelector('input[name="upFile' + i + '"]');
                                                            if (fileInput && fileInput.files.length > 0) {
                                                                formData.append('upFile' + i, fileInput.files[0]);
                                                            }
                                                        }*/
                                // console.log("formdata: " + formData);

                                // evt = new Event('click');

                                // if (formData.get('files')) {

                                /*                                var serializedData = $("#searchdaybystock").serialize();

                                                                fetch(`
























                                ${path}/logistics/stock/daybystock?
























                                ${serializedData}`, {
                                    method: "GET",
                                    headers: {
                                        /!*             "Content-Type": "multipart/form-data",*!/
                                    }
                                    /!*                 tableData: JSON.stringify(tableData)*!/

                                }).then(response => {
                                    if (response.ok) {
                                        return response.json(); // 응답 데이터를 JSON으로 파싱
                                    } else {
                                        throw new Error('Request failed'); // 응답이 실패할 경우 에러 처리
                                    }
                                })
                                    .then(data => {
                                        // 성공적으로 데이터를 받아온 경우 처리
                                        console.log(data);
                                    })
                                    .catch(error => {
                                        console.error(error);
                                        alert('Error: ' + error.message); // 오류 발생 시 alert 창에 표시
                                    });*/


                                /*                .then(response => response.json())*/
                                /* .then(data => alert(data))*/

                                /*                      .then((res) => {
                                                      if (res.ok) {
                                                          return res.text();
                                                      } else {
                                                          throw new Error("HTTP error");
                                                      }
                                                  })*/
                                /*.then((text) => {
                                alert(text);
                                active.text(text).trigger(evt, text);
                            }).catch((error) => {
                                alert(error);
                                /!*active.html(originalContent);*!/
                            })*/
                                /*} else {
                                    fetch("






























                                ${path}/logistics/stock/daybystock", {
                                        method: "GET",
                                        headers: {
                                            /!*             "Content-Type": "multipart/form-data",*!/
                                        },
                                        body: formData,
                                        /!*                 tableData: JSON.stringify(tableData)*!/
                                        processData: false,
                                        contentType: false,
                                    }).then(response => {
                                        if (response.ok) {
                                            return response.json(); // JSON 응답을 파싱
                                            // return response.message(); // 응답이 성공적일 때 텍스트 추출
                                        } else {
                                            throw new Error('Request failed'); // 응답이 실패할 경우 에러 처리
                                        }
                                    })
                                        .then(data => {
                                            if (data.status.toString() === "success") {
                                                alert(data.message); // "입고 등록 성공" 메시지를 표시
                                            } else {
                                                alert('입고 등록 실패'); // "입고 등록 실패" 메시지를 표시
                                            }
                                        })
                                        .catch(error => {
                                            console.error(error);
                                            alert('Error: ' + error.message); // 오류 발생 시 에러 메시지를 표시
                                        });
                                }*/
                            }

                            /*
                                                        $('#insertinventory').on('submit', function (e) {
                                                            e.preventDefault(); // 기본 submit 동작 방지


                                                    /!*        // 폼 데이터 가져오기
                                                            var formData = $(this).serialize();
                                                            console.log("폼 데이터: ", formData);*!/

                                                            // 데이터 테이블 데이터 가져오기 (예시로 'getAllRowData' 함수 사용)
                                                            var tableData = getAllRowData();
                                                            console.log("데이터 테이블 데이터: ", tableData);


                                                            // 가져온 데이터를 서버로 전송하거나 원하는 작업을 수행하세요.
                                                            // 예를 들어, AJAX를 사용하여 서버로 데이터를 전송할 수 있습니다.
                                                            // $.ajax({
                                                            //     method: "POST",
                                                            //     url: "your_server_url_here",
                                                            //     data: { allData: JSON.stringify(allData) },
                                                            //     success: function (response) {
                                                            //         // 성공적으로 서버에 데이터를 전송한 후 수행할 작업
                                                            //         console.log("데이터 전송 성공");
                                                            //     },
                                                            //     error: function (error) {
                                                            //         // 데이터 전송 중 오류 발생 시 수행할 작업
                                                            //         console.error("데이터 전송 오류: " + error);
                                                            //     }
                                                            // });

                                                            $.ajax({

                                                                url: "${path }/logistics/endwrite",
                                                    method: 'POST',
                                                    data: {
                                                        formData: formData,
                                                        tableData: JSON.stringify(tableData)
                                                    },
                                                    success: function (response) {
                                                        alert(response);
                                                        active.text(text).trigger(evt, text);

                                                    },
                                                    error: function (jqXHR, textStatus, errorThrown, error, response, body) {

                                                        /!*alert(jqXHR.responseText);*!/
                                                        /!*  alert((JSON.stringify(error)));*!/
                                                        alert(jqXHR.responseText);
                                                        /!*alert(xhr.responseText);*!/
                                                        /!* alert(JSON.stringify(response));*!/
                                                        active.html(originalContent);
                                                    }
                                                });


                                                // 모든 행 데이터를 배열 형태로 사용하여 원하는 작업을 수행하십시오.
                                                console.log("모든 행 데이터: ", tableData);
                                            });
                */


                        </script>
                    </div>
                </div>

            </div>


        </section>
    </div>
</div>

<footer class="main-footer">
    &copy;
    <script>document.write(new Date().getFullYear())</script>
    All Rights Reserved.
</footer>
<!-- Vendor JS -->
<script src="${path}/resources/js/vendors.min.js"></script>
<script src="${path}/resources/js/pages/chat-popup.js"></script>
<script src="${path}/resources/assets/icons/feather-icons/feather.min.js"></script>
<script src="${path}/resources/assets/vendor_components/datatable/datatables.min.js"></script>
<script src="${path }/resources/assets/vendor_components/tiny-editable/mindmup-editabletable.js"></script>
<script src="${path }/resources/assets/vendor_components/tiny-editable/numeric-input-example.js"></script>
<script src="${path }/resources/assets/vendor_components/jquery-ui/jquery-ui.js"></script>
<script src="${path }/resources/assets/vendor_components/dropzone/dropzone.js"></script>

<script src="${path}/resources/assets/vendor_components/moment/min/moment.min.js"></script>
<script src="${path}/resources/assets/vendor_components/fullcalendar/fullcalendar.js"></script>

<script src="${path}/resources/assets/vendor_components/bootstrap-select/dist/js/bootstrap-select.js"></script>
<script src="${path}/resources/assets/vendor_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.js"></script>
<script src="${path}/resources/assets/vendor_components/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"></script>
<script src="${path}/resources/assets/vendor_components/select2/dist/js/select2.full.js"></script>
<script src="${path}/resources/assets/vendor_plugins/input-mask/jquery.inputmask.js"></script>
<script src="${path}/resources/assets/vendor_plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="${path}/resources/assets/vendor_plugins/input-mask/jquery.inputmask.extensions.js"></script>
<script src="${path}/resources/assets/vendor_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="${path}/resources/assets/vendor_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script src="${path}/resources/assets/vendor_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
<script src="${path}/resources/assets/vendor_plugins/timepicker/bootstrap-timepicker.min.js"></script>
<script src="${path}/resources/assets/vendor_plugins/iCheck/icheck.min.js"></script>


<!-- CRMi App -->
<script src="${path}/resources/js/template.js"></script>
<script src="${path}/resources/js/pages/calendar.js"></script>
<script src="${path}/resources/js/pages/editor.js"></script>
<script src="${path}/resources/js/pages/data-table.js"></script>
<script src="${path }/resources/js/pages/editable-tables.js"></script>


<script src="${path}/resources/js/jquery.smartmenus.js"></script>
<script src="${path}/resources/js/menus.js"></script>
<script src="${path}/resources/js/pages/extra_taskboard.js"></script>
<script src="${path}/resources/js/pages/advanced-form-element.js"></script>

<%-- <script src="${path}/resources/assets/vendor_components/ckeditor/ckeditor.js"></script> --%>

<script>
    $.widget.bridge('uibutton', $.ui.button);
</script>

</body>
</html>