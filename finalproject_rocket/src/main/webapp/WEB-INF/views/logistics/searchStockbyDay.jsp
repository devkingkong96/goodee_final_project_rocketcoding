<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-ddHH:mm");
    String formattedNow = now.format(formatter);
%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="일자별 재고 현황 검색"/>
</jsp:include>

<script type="text/javascript"
        src="${path }/resources/assets/vendor_components/moment/moment.js"></script>

</head>

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
        var select2Data = {};

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

            "paging": false,
            "lengthChange": false,
            "searching": false,
            "info": true,
            "editable": false,
            "responsive": true,
            "dom": '<"dt-buttons">Bflirtp',
            "autoWidth": false,
            "fixedHeader": true,
            "drawCallback": function (settings) {
                $('#example1').editableTableWidget();
            },
            columnDefs: [
                {
                    targets: '_all',
                    editable: false
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
                    text: '클립보드에 복사',
                    exportOptions: {
                        columns: ':visible',
                        rows: ':visible',
                        encoding: 'UTF-8'

                    }
                }, {
                    extend: 'csv',

                    title: '입/출고 추가 ' + getCurrentDateTime(),
                    exportOptions: {
                        columns: ':visible',
                        rows: ':visible',
                        encoding: 'UTF-8'
                    }
                }, {
                    extend: 'excel',
                    title: '입/출고 추가 ' + getCurrentDateTime(),
                    exportOptions: {
                        columns: ':visible',
                        rows: ':visible',
                        encoding: 'UTF-8'

                    }
                }, {
                    extend: 'print',
                    title: '입/출고 추가 ' + getCurrentDateTime(),
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
                    "infoEmpty": "데이터 없음",
                    "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
                    "zeroRecords": "일치하는 데이터가 없어요.",
                    "loadingRecords": "로딩중...",
                    "processing": "잠시만 기다려 주세요..."


                },

            }


        });
        $('#example1').editableTableWidget().on('change', function (e, newValue) {
            var cell = $(e.target);
            if (cell.is('select')) {
                return;
            }

            var cell = $(e.target);
            var columnIdx = cell.index();
            var rowIdx = cell.closest('tr').index();
            var table = $('#example1').DataTable();
            var data = table.row(rowIdx).data();


            data[columnIdx] = newValue;

            table.row(rowIdx).data(data).draw();
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
                url: url,
                method: 'GET',
                data: {
                    branchId: branchId
                },
                success: function (response) {
                    console.log(response);
                    populateSelectOptions(response);
                },
                error: function (xhr, status, error) {
                    alert('오류가 발생했습니다: ' + error);
                }
            });

            function populateSelectOptions(empInfo) {
                var selectElement = document.querySelector('.chooseRecieveEmp');
                selectElement.innerHTML = '';

                var option = document.createElement('option');
                empInfo.forEach(emp => {
                    option = document.createElement('option');
                    option.value = emp.EMP_NO;
                    option.textContent = '[' + emp.DEP_NAME + '] [' + emp.EMP_LV + '] ' + emp.EMP_NAME
                    selectElement.appendChild(option);
                });

                $(selectElement).select2();
                $(selectElement).trigger('change');
            }

        });

        $(document).on('change', 'td .chooseBook', function () {

            var select = $(this);
            var prdId = select.val();
            var rowIndex = $(this).closest('tr').index();
            select2Data[rowIndex] = prdId;

            var selectElement = document.querySelector('.chooseBook');
            var selectedValue = selectElement.value;

            var selectedOption = selectElement.querySelector('option[value="' + selectedValue + '"]');

            if (selectedOption) {
                var selectedText = selectedOption.textContent;
                console.log("Selected Text: " + selectedText);
            } else {
                console.log("No option selected");
            }

            var rowData = table.row(rowIndex).data();
            rowData[2] = '<label class="form-label" style="display:none;">도서 선택</label> <select class="chooseBook form-control select2" data-placeholder="도서를 선택하세요" style="width: 100%;"> <option>' + selectedText + '</option><c:forEach var="entry" items="${prdTitleToIdMap }"><c:if test="${entry.key != null}"> <option value="${entry.value}"> ${entry.key}</option></c:if></c:forEach> </select>';
            console.log("rowData[2]: " + rowData[2]);

            var selectedValue = $(this).val();
            var selectId = selectedValue;
            $(this).attr('id', selectId);

            console.log("prdId : " + prdId);
            var selectedTitle = prdTitleToIdMap[prdId];
            var row = select.closest('tr');
            var currentPagePath = window.location.pathname;
            var url = currentPagePath + '/prdinfo';
            console.log("prdId: " + prdId);

            console.log("prdTitleToIdMap: " + prdTitleToIdMap);

            $.ajax({
                url: url,
                method: 'GET',
                data: {
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
                    alert('오류가 발생했습니다: ' + error);
                },

            });
        });

        var table = $('#example1').DataTable();

        var plusButtonCounter = 1;

        $(document).on('click', '[id$="plusButton"]', function () {

            plusButtonCounter++;

            var buttonId = $(this).attr('id');
            console.log("buttonId: " + buttonId);
            var currentRow = $(this).closest('tr');
            console.log("currentRow: " + currentRow);
            var currentRowIndex = currentRow.index();
            console.log("currentRowIndex: " + currentRowIndex);

            var newData = ['<button type="button" id="' + plusButtonCounter + 'plusButton" class="plusButton waves-effect waves-light btn btn-outline btn-primary-light mb-5"></button>', '', '<label class="form-label" style="display:none";>도서 선택</label> <select class="chooseBook form-control select2" data-placeholder="도서를 선택하세요" style="width: 100%;"> <option></option><c:forEach var="entry" items="${prdTitleToIdMap }"><c:if test="${entry.key != null}"> <option value="${entry.value}"> ${entry.key}</option></c:if></c:forEach> </select>', '최소 1 입력', '', '', '메모 입력', '<button type="button" id="delButton" class="waves-effect waves-light btn btn-danger-light btn-flat mb-5">삭제</button>'];


            var firstRowChooseBook = $('#example1 tbody tr:first .choosebook');

            var currentData = table.rows().data().toArray();
            var selectedValues = [];
            $('.chooseBook').each(function () {
                var selectedValue = $(this).val();
                selectedValues.push(selectedValue);
            });

            currentData.splice(currentRowIndex + 1, 0, newData);

            table.clear().rows.add(currentData).draw();

            $('#example1 tbody tr').each(function () {

                $(this).find('td').eq(0).attr('name', 'dontedit');
                $(this).find('td').eq(1).attr('name', 'dontedit').addClass('prdId');
                $(this).find('td').eq(2).attr('name', 'dontedit');
                $(this).find('td').eq(3).addClass('prdIvQuantity');
                $(this).find('td').eq(4).attr('name', 'dontedit');
                $(this).find('td').eq(5).attr('name', 'dontedit');
                $(this).find('td').eq(6).addClass('prdIvMemo');
                $(this).find('td').eq(7).attr('name', 'dontedit');

                var select2Element = $(this).find('.select2');
                var rowIndex = $(this).closest('tr').index();

                $('tbody tr').each(function (index) {

                    var select2Value = $(this).find('.chooseBook').val();
                    var cell = table.cell(index, 1);

                    select2Value = selectedValues[index];

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

                    var dataTable = $('#example1').DataTable();
                    select2Container.each(function () {
                        var row = $(this).closest('tr');
                        var rowIndex = dataTable.row(row).index();
                        dataTable.row(rowIndex).remove().draw();
                    });

                    justones = true;
                }
            });
        });
    });

</script>
<div class="content-wrapper">
    <div class="container-full">

        <section class="content">


            <div class="content-header" style="margin-bottom:10px;">
                <div class="d-flex align-items-center">
                    <div class="me-auto">
                        <h4 class="page-title">재고현황 검색</h4>
                        <div class="d-inline-block align-items-center">
                            <nav>
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${path}/"> <i
                                            class="mdi mdi-home-outline"></i></a></li>
                                    <li class="breadcrumb-item" aria-current="page">재고 관리</li>
                                    <li class="breadcrumb-item active" aria-current="page">재고 현황 검색
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
                              action="${path}/logistics/stock/dayby"
                        <%-- method="post"--%> >
                            <div class="box">
                                <div class="box-header with-border">
                                    <h4 class="box-title"><%--<i class="ti-agenda"></i>--%><strong> 재고 현황 검색</strong>
                                    </h4>

                                    <h6 class="subtitle">검색 기준 항목을 선택 하세요</h6>
                                    <ul class="box-controls pull-right">
                                        <li><a class="box-btn-close" href="#"></a></li>
                                        <li><a class="box-btn-slide" href="#"></a></li>
                                        <li><a class="box-btn-fullscreen" href="#"></a></li>
                                    </ul>
                                </div>

                                <div class="box-body p-12"> <%--action="${path }/logistics/write"--%>

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
                                        var today = new Date();

                                        var formattedDate = today.toISOString().slice(0, 10);

                                        document.getElementById("stkDate").value = formattedDate;
                                    </script>
                                    <input type="hidden" name="branchId" value=""/>
                                    <input type="hidden" name="prdId" value=""/>
                                    <div class="col-lg-5 col-12" style="margin:5px; margin-top:20px" ;><label
                                            class=" form-label">
                                        <i class="si-organization si" style="margin-right:10px;"></i>지점</label>
                                        <select
                                                class="chooseBrc form-control select2" name="branchId"
                                                data-placeholder="지점" style="width: 100%;" multiple="multiple">
                                            <option></option>
                                            <c:forEach var="entry" items="${branchList }">

                                                <option value="${entry.BRANCH_ID}">${entry.BRANCH_NAME}</option>

                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-lg-5 col-12" style="margin:5px; margin-top:20px;">
                                        <label class="form-label"><i class="ti-package"></i>
                                            품목</label>

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

                                            document.getElementById("searchdaybystock").addEventListener("submit", function () {
                                                var branchSelect = document.querySelector('.chooseBrc');
                                                var prdSelect = document.querySelector('.chooseRecieveEmp');

                                                if (branchSelect.value) {
                                                    document.querySelector('input[name="branchId"]').disabled = true;
                                                }

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

                                    <div class="row">
                                        <div class="col-12"
                                             style="margin-top:30px; margin-left:270px; align-items: flex-end; margin-bottom:50px;">

                                            <button type="submit" class="btn btn-primary submitdaybystock">
                                                <i class="ti-save-alt" style="margin-right:10px;"></i> 검색
                                            </button>
                                        </div>
                                    </div>
                        </form>
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