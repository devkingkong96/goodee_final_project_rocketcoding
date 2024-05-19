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
    <jsp:param name="title" value="출판사 리스트"/>
</jsp:include>
<script type="text/javascript"
        src="${path }/resources/assets/vendor_components/moment/moment.js"></script>

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

    .col-lg-6 col-6 connectedSortable ui-sortable {
        margin-right: 50px;
        margin-left: 50px;
    }

    .dataTables_wrapper .dataTable td {
        white-space: normal;
        word-wrap: break-word;
    }

    .box-table {
        margin-bottom: 400px;
        align-content: center;
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

    .error-border {
        border: 2px solid red !important;
    }
</style>


<div class="content-wrapper">
    <div class="container-full">
        <section class="content">

            <div class="content-header" style="margin-bottom:10px;">
                <div class="d-flex align-items-center">
                    <div class="me-auto">
                        <h5 class="page-title">출판사 목록</h5>
                        <div class="d-inline-block align-items-center">
                            <nav>
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${path}/"> <i
                                            class="mdi mdi-home-outline"></i></a></li>
                                    <li class="breadcrumb-item" aria-current="page">출판사 목록</li>
                                    <li class="breadcrumb-item active" aria-current="page">출판사
                                        관리
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12 col-12">
                    <div class=" connectedSortable">
                        <form name="insertpublisher" id="insertpublisher"
                        <%-- method="post"--%> enctype="multipart/form-data">
                            <div class="box box-slided-up">
                                <div class="box-header with-border">
                                    <h4 class="box-title"><i class="ti-agenda"></i> 출판사 등록</h4>

                                    <ul class="box-controls pull-right">
                                        <li><a class="box-btn-close" href="#"></a></li>
                                        <li><a class="box-btn-slide" href="#"></a></li>
                                        <li><a class="box-btn-fullscreen" href="#"></a></li>
                                    </ul>
                                </div>

                                <div class="box-body p-12"> <%--action="${path }/logistics/write"--%>

                                    <div class="row">
                                        <div class="col-2
                                        " style="margin-bottom: 20px;">
                                            <div class="col-12" style="margin-bottom: 5px;">
                                                <label class="form-label" style="margin:5px;">
                                                    <i class="si-note si" for="pubName"></i>
                                                    출판사명</label>
                                            </div>
                                            <input name="pubName" id="pubName" class="form-control" type="text"
                                                   placeholder="출판사명" required>
                                        </div>

                                        <div class="col-2
                                        " style="margin-bottom: 20px;">
                                            <div class="col-12" style="margin-bottom: 5px;">
                                                <label class="form-label" style="margin:5px;" for="pubAddr">
                                                    <i class="si-location-pin si"></i>
                                                    주소</label>
                                            </div>
                                            <input name="pubAddr" id="pubAddr" class="form-control" type="text"
                                                   placeholder="주소" required>

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-2
                                        " style="margin-bottom: 20px;">

                                            <div class="form-group">
                                                <div class="col-12" style="margin-bottom: 5px;">
                                                    <label class="form-label" style="margin:5px;" for="pubPhone">
                                                        <i class="si-earphones-alt si"></i>
                                                        연락처</label>
                                                </div>
                                                <div class="controls">
                                                    <input name="pubPhone" id="pubPhone" class="form-control"
                                                           type="text"
                                                           placeholder="연락처" required
                                                           data-validation-containsnumber-regex="(\d)+"
                                                           data-validation-containsnumber-message="숫자만 입력 가능합니다.">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-2
                                        " style="margin-bottom: 20px;">
                                            <div class="col-12" style="margin-bottom: 5px;">
                                                <label class="form-label" style="margin:5px;" for="pubRepresentative">
                                                    <i class="mdi mdi-account-location"></i>
                                                    대표자명</label>
                                            </div>
                                            <input name="pubRepresentative" id="pubRepresentative" class="form-control"
                                                   type="text"
                                                   placeholder="대표자명" required>
                                        </div>
                                    </div>

                                    <div class="col-lg-2 col-5">
                                        <label class="form-label" style="margin:5px;" for="pubBank"><i
                                                class="mdi mdi-bank"
                                                style="margin-right:10px;"></i>
                                            이체 정보</label>
                                        <div class="input-group">
                                            <button type="button" class="btn btn-info btn-sm dropdown-toggle"
                                                    data-bs-toggle="dropdown">은행
                                            </button>
                                            <div class="dropdown-menu">
                                                <a href="#" class="dropdown-item">국민</a>
                                                <a href="#" class="dropdown-item">농협</a>
                                                <a href="#" class="dropdown-item">우리</a>
                                                <a href="#" class="dropdown-item">축협</a>
                                            </div>
                                            <input name="pubBank" id="pubBank" type="text" class="form-control"
                                                   placeholder="은행 선택" required>
                                        </div>
                                    </div>

                                    <div>
                                        <div class="col-12"
                                             style="margin-top:30px; margin-left:430px; align-items: flex-end">
                                            <input type="hidden" id="pubIsdel" name="pubIsdel" value="N">

                                            <button type="submit" class="btn btn-primary submitpublisher">
                                                <i class="ti-save-alt" style="margin-right:10px;"></i> 저장
                                            </button>
                                        </div>
                                    </div>
                                    <script>
                                        const adddelFunction = (function () {
                                            let count = 2;
                                            const addFile = () => {
                                                if (count <= 5) {

                                                    const fileForm = $("#basicFileForm").clone(true);
                                                    fileForm.find("span.input-group-text1").html('<i class="fa fa-fw fa-file-o" style="margin-right:10px;"></i> 첨부파일 ' + count);
                                                    fileForm.find("label.custom-file-label").text("파일을 선택하세요")
                                                        .attr("for", "upFile" + count);
                                                    fileForm.find("input[type=file]").attr("id", "upFile" + count).val("").change(changeFileFunc);
                                                    $("textarea[name=ivMemo]").before(fileForm);
                                                    count++;

                                                } else {
                                                    alert("첨부파일은 5개까지 가능합니다.");
                                                }
                                            };
                                            const delFile = () => {
                                                if (count != 2) {
                                                    $("textarea[name=ivMemo]").prev().remove();
                                                    count--;
                                                }
                                            };
                                            return [addFile, delFile];
                                        })();

                                        const fn_addFileForm = adddelFunction[0];
                                        const fn_deleteFileForm = adddelFunction[1];

                                        const changeFileFunc = e => {
                                            const fileName = e.target.files[0].name;
                                            $(e.target).next(".custom-file-label").text(fileName);
                                        };
                                    </script>

                        </form>
                    </div>
                </div>

                <div class="col-lg-12 col-12">
                    <script>


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

                        $(function () {
                            $("#min").datepicker();
                            $("#max").datepicker();
                        });
                        $(document).ready(function () {

                            var path = "${path}";
                            var select2Data = {};

                            $('#example1').DataTable({
                                "paging": true,
                                "lengthChange": true,
                                "searching": true,
                                "info": true,
                                ordering: true,
                                order: [[0, "desc"]],
                                "responsive": true,
                                "dom": '<"dt-buttons">Bflirtp',
                                "autoWidth": false,
                                "fixedHeader": true,
                                "drawCallback": function (settings) {
                                    $('#example1').editableTableWidget();
                                },

                                columnDefs: [
                                    {targets: '_all', editable: true, orderable: true},
                                ],

                                createdRow: function (row, data, dataIndex) {
                                    if (dataIndex === 6 || dataIndex === 8 || dataIndex === 9) {
                                        $(row).addClass('not-editable');
                                    }
                                },
                                "buttons": [{
                                    extend: 'colvis',
                                    text: '일부 컬럼 보기'
                                }, {
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
                                    title: '출판사 리스트 ' + getCurrentDateTime(),
                                    exportOptions: {
                                        columns: ':visible',
                                        rows: ':visible',
                                        encoding: 'UTF-8'
                                    }
                                }, {
                                    extend: 'excel',
                                    title: '출판사 리스트 ' + getCurrentDateTime(),
                                    exportOptions: {
                                        columns: ':visible',
                                        rows: ':visible',
                                        encoding: 'UTF-8'

                                    }
                                },{
                                    extend: 'print',
                                    title: '출판사 리스트 ' + getCurrentDateTime(),
                                    exportOptions: {
                                        columns: ':visible',
                                        rows: ':visible',
                                        encoding: 'UTF-8'
                                    }
                                }
                                ],
                                "lengthMenu": [[10, 25, 50, 100, -1],
                                    [10, 25, 50, 100, "All"]],
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

                            $('.dropdown-menu a').click(function () {
                                var selectedBank = $(this).text();
                                $('input[name="pubBank"]').val(selectedBank + " ");
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
                                        option.textContent = emp.EMP_NAME;
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

                                var newData = ['<button type="button" id="' + plusButtonCounter + 'plusButton" class="plusButton waves-effect waves-light btn btn-outline btn-primary-light mb-5"></button>', '', '<label class="form-label">도서 선택</label> <select class="chooseBook form-control select2" data-placeholder="도서를 선택하세요" style="width: 100%;"> <option></option><c:forEach var="entry" items="${prdTitleToIdMap }"><c:if test="${entry.key != null}"> <option value="${entry.value}"> ${entry.key}</option></c:if></c:forEach> </select>', '최소 1 입력', '', '', '메모 입력', '<button type="button" id="delButton" class="waves-effect waves-light btn btn-danger-light btn-flat mb-5">삭제</button>'];


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
                    <script>

                        const saveButton = document.querySelector('.submitpublisher');

                        saveButton.addEventListener('click', function (event) {
                            event.preventDefault();
                            insertPublisher();

                        });


                        function insertPublisher() {
                            var table = $('#example1').DataTable();

                            const inputElement = document.querySelector('input[name="pubPhone"]');
                            const inputValue = inputElement.value;

                            let form = document.getElementById('insertpublisher');
                            let inputs = form.querySelectorAll('input');
                            let ones = false;
                            for (let input of inputs) {

                                if (input.value.trim() === '') {
                                    input.classList.add('error-border');
                                    input.addEventListener('blur', () => {
                                        if (input.value.trim() === '') {
                                            input.classList.add('error-border');
                                        } else {
                                            input.classList.remove('error-border');
                                        }
                                    });

                                    let placeholder = input.placeholder;
                                    if (ones === false) {
                                        alert(placeholder + '을(를) 입력해주세요.');
                                        ones = true;
                                    }
                                }
                            }
                            if (ones === true) {
                                return;
                            }

                            const regex = /(\d)+/;
                            if (!regex.test(inputValue) || inputElement.value.trim() === '') {
                                inputElement.classList.add('error-border');
                                inputElement.addEventListener('blur', () => {
                                    if (inputElement.value.trim() === '' || !regex.test(inputValue)) {
                                        inputElement.classList.add('error-border');
                                    } else {
                                        inputElement.classList.remove('error-border');
                                    }
                                });

                                alert("연락처는 숫자만 입력 가능합니다.");
                                return;
                            }

                            var formdata1 = $("#insertpublisher").serialize();
                            console.log(formdata1);

                            function getAllRowData() {
                                var table = $('#example1').DataTable();
                                var rowDataArray = [];
                                choosePrdCount2 = 0;
                                table.rows().every(function (index) {
                                    var rowData = {};
                                    var row = this.data();

                                    var list = [];
                                    var columnNames = table.columns().header().toArray();

                                    var choosePrdCount = 0;
                                    for (var i = 0; i < columnNames.length; i++) {

                                        var columnName = columnNames[i].innerText;
                                        if (i === 1) {

                                            rowData["prdId"] = document.querySelectorAll('#example1 td.prdId')[index].textContent;
                                            if (rowData["prdId"] === "" && choosePrdCount == 0) {

                                                alert("상품을 선택해주세요 : " + index);
                                                return;
                                            }

                                            console.log("rowData[prdId] : " + rowData["prdId"]);

                                        } else if (i === 3) {
                                            cellValue = row[i];

                                            console.log("Before setting prdIvQuantity: " + rowData["prdIvQuantity"]);
                                            rowData["prdIvQuantity"] = document.querySelectorAll('#example1 td.prdIvQuantity')[index].textContent;

                                            if (rowData["prdIvQuantity"].includes("최소 1 입력") && choosePrdCount == 0) {
                                                alert("도서/수량을 입력 해주세요");
                                                return;
                                            } else if (isNaN(rowData["prdIvQuantity"]) && choosePrdCount == 0) {
                                                alert("도서의 수량은 숫자만 입력 가능합니다.");
                                                return;
                                            }

                                            console.log("After setting prdIvQuantity: " + rowData["prdIvQuantity"]);

                                        } else if (i === 6) {
                                            cellValue = row[i];
                                            rowData["prdIvMemo"] = document.querySelectorAll('#example1 td.prdIvMemo')[index].textContent;
                                            if (rowData["prdIvMemo"].includes("메모 입력")) {
                                                rowData["prdIvMemo"] = null;
                                            }

                                            console.log("rowData[prdIvMemo] : " + rowData["prdIvMemo"]);
                                        }
                                        choosePrdCount++;
                                    }
                                    choosePrdCount2++;

                                    var keys = Object.keys(rowData);

                                    var numberOfProperties = keys.length;

                                    console.log("rowData에는 총 " + numberOfProperties + "개의 속성이 있습니다.");
                                    rowDataArray.push(rowData);
                                    console.log("rowData[prdIvQuantity]" + rowData["prdIvQuantity"])
                                });
                                return rowDataArray;
                            }

                            var parsedData;
                            var selectKey;

                            fetch("${path}/logistics/publisher/list/insert", {
                                method: 'POST',
                                headers: {
                                    "Content-Type": "application/x-www-form-urlencoded",
                                },
                                body: formdata1,
                            }).then(response => response.json())
                                .then(data => {

                                    alert(data.message);
                                    console.log(data.status);
                                    parsedData = Object.fromEntries(new URLSearchParams(formdata1));
                                    selectKey = data.selectKey;


                                    var currentData = table.rows().data().toArray();
                                    currentData.splice(0, 0, [selectKey, parsedData.pubName, parsedData.pubAddr, parsedData.pubPhone, parsedData.pubRepresentative, parsedData.pubBank, '<form id="deleteForm" action="${path}/logistics/inventory/list/delete" method="post" style="display: none;"> <input type="hidden" name="pub_id" id="deleteId"> </form> <button type="button" onclick="confirmDeletion(this,' + selectKey + ')" class="waves-effect waves-light btn btn-danger-light btn-flat mb-5">삭제 </button>']);
                                    table.clear().rows.add(currentData).draw(true);
                                    table.columns().every(function () {
                                        var currentColumn = this;
                                        var searchData = currentColumn.search();
                                        table.column(currentColumn.index()).search(searchData);
                                    });

                                    table.draw();


                                    $('#example1 tbody tr').each(function () {

                                        $(this).find('td').eq(0).attr({
                                            'name': 'dontedit',
                                            'data-column-name': 'PUB_ID',
                                            'data-table-name': 'PUBLISHER',
                                            'data-parent-column': 'PUB_ID'
                                        });
                                        $(this).find('td').eq(1).attr({
                                            'data-column-name': 'PUB_NAME',
                                            'data-table-name': 'PUBLISHER',
                                            'data-parent-column': 'PUB_NAME'
                                        });
                                        $(this).find('td').eq(2).attr({
                                            'data-column-name': 'PUB_REPRESENTATIVE',
                                            'data-table-name': 'PUBLISHER',
                                            'data-parent-column': 'PUB_REPRESENTATIVE'
                                        });
                                        $(this).find('td').eq(3).attr({
                                            'data-column-name': 'PUB_PHONE',
                                            'data-table-name': 'PUBLISHER',
                                            'data-parent-column': 'PUB_PHONE'
                                        });
                                        $(this).find('td').eq(4).attr({
                                            'data-column-name': 'PUB_ADDR',
                                            'data-table-name': 'PUBLISHER',
                                            'data-parent-column': 'PUB_ADDR'
                                        });
                                        $(this).find('td').eq(5).attr({
                                            'data-column-name': 'PUB_BANK',
                                            'data-table-name': 'PUBLISHER',
                                            'data-parent-column': 'PUB_BANK'
                                        });
                                        $(this).find('td').eq(6).attr({
                                            'name': 'dontedit'
                                        });

                                    });
                                    table.draw();


                                })
                                .catch(error => {
                                    alert(error.message);
                                    console.error(error);
                                });
                        }


                    </script>
                    <div class="box">
                        <div class="box-header">


                            <h4 class="box-title"><strong>출판사 목록</strong>
                            </h4>
                            <h6 class="subtitle">수정할 row를 선택하세요</h6>
                        </div>


                        <div class="box-body">
                            <div class="table-responsive">

                                <table id="example1"
                                       class="table table-striped">
                                    <thead>
                                    <tr class="bt-5 border-primary">
                                        <th>출판사 코드</th>
                                        <th>출판사명</th>
                                        <th>대표자명</th>
                                        <th>연락처</th>
                                        <th>주소</th>
                                        <th>이체 정보</th>
                                        <th>삭제</th>
                                    </thead>

                                    <tbody>
                                    <%--	<c:if test="받는 거래처가 로그인 직원의 해당 지점일 시">--%>
                                    <c:forEach var="pub" items="${publisherList }">
                                        <tr class="bt-5 border-primary">
                                            <td name="dontedit" data-column-name="PUB_ID" data-parent-column="PUB_ID"
                                                data-table-name="PUBLISHER">${pub.PUB_ID}</td>
                                            <td data-column-name="PUB_NAME" data-parent-column="PUB_NAME"
                                                data-table-name="PUBLISHER">${pub.PUB_NAME}</td>
                                            <td data-column-name="PUB_REPRESENTATIVE"
                                                data-table-name="PUBLISHER" data-parent-column="PUB_REPRESENTATIVE"
                                            >${pub.PUB_REPRESENTATIVE}</td>
                                            <td data-column-name="PUB_PHONE"
                                                data-table-name="PUBLISHER"
                                                data-parent-column="PUB_PHONE">${pub.PUB_PHONE}</td>
                                            <td data-column-name="PUB_ADDR"
                                                data-table-name="PUBLISHER"
                                                data-parent-column="PUB_ADDR">${pub.PUB_ADDR}</td>
                                            <td data-column-name="PUB_BANK"
                                                data-table-name="PUBLISHER"
                                                data-parent-column="PUB_BANK">${pub.PUB_BANK}</td>
                                            <td name="dontedit">
                                                <form id="deleteForm"
                                                      action="${path}/logistics/inventory/list/delete"
                                                      method="post" style="display: none;">
                                                    <input type="hidden" name="pub_id" id="deleteId"
                                                           value="${pub.PUB_ID}">
                                                </form>
                                                <button type="button" onclick="confirmDeletion(this,${pub.PUB_ID})"
                                                        class="waves-effect waves-light btn btn-danger-light btn-flat mb-5">
                                                    삭제
                                                </button>
                                                <script>
                                                    function confirmDeletion(buttonElement, pubId) {
                                                        var trElement = buttonElement.closest('tr');
                                                        var table = $('#example1').DataTable();
                                                        if (confirm('정말로 삭제 하시겠습니까?')) {
                                                            fetch('${path}/logistics/publisher/list/delete', {
                                                                method: 'POST',
                                                                headers: {
                                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                                },
                                                                body: 'pub_id=' + pubId
                                                            })
                                                                .then(response => {
                                                                    if (response.ok) {
                                                                        return response.json();
                                                                    } else {
                                                                        throw new Error('서버에 문제가 발생했습니다.');
                                                                    }
                                                                })
                                                                .then(data => {
                                                                    alert(data.message);
                                                                    table.row(trElement).remove().draw();

                                                                })
                                                                .catch(error => {
                                                                    console.error('오류가 발생했습니다:', error);
                                                                });
                                                        }
                                                    }
                                                </script>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>

                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
</div>
<script src="${path }/resources/js/pages/validation.js"></script>
<script src="${path }/resources/js/pages/form-validation.js"></script>
<%--
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>--%>
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