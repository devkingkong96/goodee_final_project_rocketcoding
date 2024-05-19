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
    <jsp:param name="title" value="책 리스트"/>
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
        border-color: red !important;
    }
</style>


<div class="content-wrapper">
    <div class="container-full">
        <section class="content">
            <div class="content-header" style="margin-bottom:10px;">
                <div class="d-flex align-items-center">
                    <div class="me-auto">
                        <h5 class="page-title">도서 목록</h5>
                        <div class="d-inline-block align-items-center">
                            <nav>
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${path}/"> <i
                                            class="mdi mdi-home-outline"></i></a></li>
                                    <li class="breadcrumb-item" aria-current="page">도서 목록</li>
                                    <li class="breadcrumb-item active" aria-current="page">도서
                                        목록 관리
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
                        <form name="insertproduct" id="insertproduct"
                        <%-- method="post"--%> enctype="multipart/form-data">
                            <div class="box box-slided-up">
                                <div class="box-header with-border">
                                    <h4 class="box-title"><i class="ti-agenda"></i> 책 등록</h4>

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
                                                    <i class="si-note si" for="prdTitle"></i>
                                                    도서명</label>
                                            </div>
                                            <input name="prdTitle" id="prdTitle" class="form-control" type="text"
                                                   placeholder="도서명" required>
                                        </div>

                                        <div class="col-2" style="margin-bottom: 20px;">
                                            <div class="col-12" style="margin-bottom: 5px;">
                                                <label class="form-label" style="margin:5px;" for="prdAuthor">
                                                    <i class="si-location-pin si"></i>
                                                    저자명</label>
                                            </div>
                                            <input name="prdAuthor" id="prdAuthor" class="form-control" type="text"
                                                   placeholder="저자명" required>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-2 col-5" style="margin:0px; margin-top:0px;"><label
                                                class=" form-label" for="prdGenre">
                                            <i class="si-organization si" style="margin-right:10px;"></i>장르</label>
                                            <select
                                                    class="form-control select2 genre" name="prdGenre" id="prdGenre"
                                                    data-placeholder="장르" style="width: 100%;">
                                                <option></option>
                                                <option>소설</option>
                                                <option>시,에세이</option>
                                                <option>인문</option>
                                                <option>가정,육아</option>
                                                <option>요리</option>
                                                <option>건강</option>
                                                <option>취미,실용,스포츠</option>
                                                <option>경제, 경영</option>
                                                <option>자기계발</option>
                                                <option>정치,사회</option>
                                                <option>역사,문화</option>
                                                <option>종교</option>
                                                <option>예술, 대중문화</option>
                                                <option>중,고등 참고서</option>
                                                <option>기술, 공학</option>
                                                <option>외국어</option>
                                                <option>과학</option>
                                                <option>취업, 수험서</option>
                                                <option>여행</option>
                                                <option>컴퓨터,IT</option>
                                                <option>잡지</option>
                                                <option>청소년</option>
                                                <option>초등참고서</option>
                                                <option>유아</option>
                                                <option>어린이</option>
                                                <option>만화</option>
                                                <option>대학교재</option>
                                            </select>
                                        </div>


                                        <div class="col-lg-2 col-5" style="margin:0px; margin-top:0px" ;><label
                                                class=" form-label">
                                            <i class="si-organization si" style="margin-right:10px;" for="pubId"></i>출판사</label>

                                            <select
                                                    class=" form-control select2" name="pubId" id="pubId"
                                                    data-placeholder="출판사" style="width: 100%;">
                                                <option></option>
                                                <c:forEach var="entry" items="${publisherList }">
                                                    <option value="${entry.PUB_ID}">${entry.PUB_NAME}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top:10px;">

                                        <div class="col-lg-2 col-5">
                                            <label class="form-label" style="margin:5px;"
                                                   for="publishDate"><i
                                                    class="si-calendar si"
                                                    style="margin-right:10px;"></i>
                                                출판일</label>
                                            <input class="form-control" id="publishDate" name="publishDate"
                                                   type="date" required>

                                        </div>

                                        <div class="col-lg-2 col-5 form-group">
                                            <label class="form-label" style="margin:5px;" for="prdPrice">
                                                <i class="si-calendar si"
                                                   style="margin-right:10px;"></i>
                                                판매가</label>
                                            <div class="input-group"><span class="input-group-addon">&#8361;</span>
                                                <input type="number" id="prdPrice" name="prdPrice" class="form-control"
                                                       placeholder="판매가"
                                                       required
                                                       data-validation-containsnumber-regex="(\d)+"
                                                       data-validation-containsnumber-message="숫자만 입력 가능합니다.">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="col-lg-2 col-5 form-group">
                                            <label class="form-label" style="margin:5px;" for="priceInStk">
                                                <i class="si-calendar si" style="margin-right:10px;"></i>
                                                입고 단가</label>
                                            <div class="input-group"><span class="input-group-addon">&#8361;</span>
                                                <input type="number" id="priceInStk" name="priceInStk"
                                                       class="form-control"
                                                       placeholder="입고 단가"
                                                       required
                                                       data-validation-containsnumber-regex="(\d)+"
                                                       data-validation-containsnumber-message="숫자만 입력 가능합니다.">
                                            </div>
                                        </div>
                                        <div class="form-group col-lg-2 col-5">
                                            <label class="form-label" style="margin:5px;" for="priceOutStk">
                                                <i class="si-calendar si" style="margin-right:10px;"></i>
                                                출고 단가</label>
                                            <div class="input-group"><span class="input-group-addon">&#8361;</span>
                                                <input type="number" id="priceOutStk" name="priceOutStk"
                                                       class="form-control" placeholder="출고 단가"
                                                       required
                                                       data-validation-containsnumber-regex="(\d)+"
                                                       data-validation-containsnumber-message="숫자만 입력 가능합니다.">
                                            </div>
                                        </div>
                                    </div>

                                    <div id="file-container" style="margin-top:25px;">

                                        <div class="row">
                                            <div id="basicFileForm" class="input-group col-2"
                                                 style="padding: 0; margin-top:-20px;">
                                                <div>
                                                    <div>
                                                    <span class="input-group-text1"><i
                                                            class="fa fa-fw fa-file-o"
                                                            style="margin-right:10px;"></i> 표지 이미지</span>
                                                    </div>
                                                    <input type="file" class="custom-file-input" name="upFile"
                                                           id="upFile1" style="display: none;" accept="image/*"
                                                           onchange="changeFileFunc(event);">
                                                    <label
                                                            class="custom-file-label waves-effect waves-light btn btn-primary-light btn-flat mb-3"
                                                            for="upFile1" style="margin:10px; margin-top:25px;">파일을
                                                        선택하세요</label>
                                                    <div class="col-5 ImageThumbnail-container">
                                                        <img id="thumbnail" src="" alt="Thumbnail"
                                                             style="max-width: 300px; max-height: 300px; display: none;">
                                                    </div>
                                                </div>

                                            </div>


                                        </div>

                                    </div>
                                    <div name="fileButton"></div>
                                    <br/>
                                    <div>
                                        <div class="col-12"
                                             style="margin-top:30px; margin-left:430px; align-items: flex-end; margin-bottom:50px;">
                                            <input type="hidden" id="prdIsdel" name="prdIsdel" value="N">

                                            <button type="submit" name="formSubmitButton"
                                                    class="btn btn-primary submitproduct">
                                                <i class="ti-save-alt" style="margin-right:10px;"></i> 저장
                                            </button>
                                        </div>

                                    </div>
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
                                            $("div[name=fileBut" +
                                                "ton]").before(fileForm);
                                            count++;
                                        } else {
                                            alert("첨부파일은 5개까지 가능합니다.");
                                        }
                                    };
                                    const delFile = () => {
                                        if (count != 2) {
                                            $("div[name=fileButton]").prev().remove();
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

                                    const thumbnailImg = document.getElementById("thumbnail");

                                    if (e.target.files.length > 0) {
                                        const file = e.target.files[0];
                                        const reader = new FileReader();

                                        reader.onload = function (event) {
                                            const imageUrl = event.target.result;
                                            thumbnailImg.src = imageUrl;
                                            thumbnailImg.style.display = "block";
                                        };

                                        reader.readAsDataURL(file);
                                    } else {
                                        thumbnailImg.src = "";
                                        thumbnailImg.style.display = "none";
                                    }
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
                                    {
                                        targets: 5,
                                        render: function (data, type, row) {
                                            if (type === 'display' || type === 'filter') {
                                                var date = moment(data, 'YYYY-MM-DD HH:mm:ss.S');
                                                return date.format('YYYY-MM-DD');
                                            }
                                            return data;
                                        },
                                    }
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
                                }, {
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

                        const saveButton = document.querySelector('.submitproduct');

                        saveButton.addEventListener('click', function (event) {
                            event.preventDefault();
                            insertProduct();
                        });


                        function insertProduct() {
                            var table = $('#example1').DataTable();

                            const inputElements = document.querySelectorAll('input[type="number"]');

                            const prdFileUploadDateInput = document.getElementById("prdFileUploadDate");
                            prdFileUploadDateInput.value = getCurrentDateTime();

                            let form = document.getElementById('insertproduct');
                            let inputs = form.querySelectorAll('input, .select2');
                            let ones = false;
                            let countForEmptyValue = 0;
                            let parentElementForSelect = document.querySelectorAll('.select2-hidden-accessible');


                            let selectedElement = document.querySelectorAll('.select2-selection__rendered');
                            let select2CssForQuery = document.querySelectorAll('.select2-selection--single');

                            let prdTitleQuery = document.getElementById('prdTitle');
                            let prdAuthorQuery = document.getElementById('prdAuthor');

                            let prdGenreQueryOri = document.getElementById('prdGenre');
                            let prdPublisherQueryOri = document.getElementById('pubId');

                            let prdPublishDateQuery = document.getElementById('publishDate');
                            let prdPriceQuery = document.getElementById('prdPrice');
                            let priceInStkQuery = document.getElementById('priceInStk');
                            let priceOutStkQuery = document.getElementById('priceOutStk');
                            let upFileQuery = document.getElementById('upFile');

                            var fileInputs = document.querySelectorAll('input[name=upFile]');
                            //////////중요 ////////////////
                            $('#prdGenre').on('select2:select', function (e) {
                                console.log(e.params.data);
                                if (selectedElement[0].textContent === parentElementForSelect[0].getAttribute('data-placeholder')) {
                                    select2CssForQuery[0].classList.add('error-border');
                                } else {
                                    select2CssForQuery[0].classList.remove('error-border');
                                }

                            });
                            $('#pubId').on('select2:select', function (e) {
                                console.log(e.params.data);

                                if (selectedElement[1].textContent === parentElementForSelect[0].getAttribute('data-placeholder')) {
                                    select2CssForQuery[1].classList.add('error-border');
                                } else {
                                    select2CssForQuery[1].classList.remove('error-border');
                                }

                            });

                            //////////////중요 ///////////////////
                            let emptyFields = form.querySelectorAll('input:required:invalid');
                            for (let field of emptyFields) {
                                field.classList.add('error-border');
                            }

                            form.addEventListener('input', (event) => {
                                if (event.target.validity.valid) {
                                    event.target.classList.remove('error-border');
                                }
                            });
                            if (prdTitleQuery.value === '') {
                                prdTitleQuery.classList.add("error-border");
                                prdTitleQuery.addEventListener('blur', () => {
                                    if (prdTitleQuery.value === '') {
                                        prdTitleQuery.classList.add('error-border');
                                    } else {
                                        prdTitleQuery.classList.remove('error-border');
                                    }
                                });
                                if (ones === false) {
                                    alert('도서명을(를) 입력해주세요.');
                                    ones = true;
                                }
                            } else if (prdAuthorQuery.value === '') {
                                prdAuthorQuery.classList.add("error-border");
                                prdAuthorQuery.addEventListener('blur', () => {
                                    if (prdAuthorQuery.value === '') {
                                        prdAuthorQuery.classList.add('error-border');
                                    } else {
                                        prdAuthorQuery.classList.remove('error-border');
                                    }
                                });

                                if (ones === false) {
                                    alert('저자명을(를) 입력해주세요.');
                                    ones = true;
                                }
                            } else if (parentElementForSelect[0].getAttribute('data-placeholder') === document.querySelectorAll('.select2-selection__rendered')[0].textContent) {

                                parentElementForSelect[0].classList.add("error-border");
                                prdGenreQueryOri.addEventListener('blur', () => {

                                    if (selectedElement[0].textContent !== parentElementForSelect[0].getAttribute('data-placeholder')) {
                                        parentElementForSelect[0].classList.add('error-border');
                                    } else {
                                        parentElementForSelect[0].classList.remove('error-border');
                                    }
                                });

                                if (ones === false) {
                                    alert('장르을을(를) 선택해주세요.');
                                    ones = true;
                                }
                            } else if (parentElementForSelect[1].getAttribute('data-placeholder') === document.querySelectorAll('.select2-selection__rendered')[1].textContent) {

                                parentElementForSelect[1].classList.add("error-border");
                                prdPublisherQueryOri.addEventListener('blur', () => {

                                    if (selectedElement[1].textContent !== parentElementForSelect[1].getAttribute('data-placeholder')) {
                                        parentElementForSelect[1].classList.add('error-border');
                                    } else {
                                        parentElementForSelect[1].classList.remove('error-border');
                                    }
                                });
                                if (ones === false) {
                                    alert('출판사을(를) 선택해주세요.');
                                    ones = true;
                                }
                            } else if (prdPublishDateQuery.value === '') {

                                prdPublishDateQuery.classList.add("error-border");
                                prdPublishDateQuery.addEventListener('blur', () => {
                                    if (prdPublishDateQuery.value === '') {
                                        prdPublishDateQuery.classList.add('error-border');
                                    } else {
                                        prdPublishDateQuery.classList.remove('error-border');
                                    }
                                });
                                if (ones === false) {
                                    alert('출판일을(를) 입력해주세요.');
                                    ones = true;
                                }
                            } else if (prdPriceQuery.value === '') {

                                prdPriceQuery.classList.add("error-border");
                                prdPriceQuery.addEventListener('blur', () => {
                                    if (prdPriceQuery.value === '') {
                                        prdPriceQuery.classList.add('error-border');
                                    } else {
                                        prdPriceQuery.classList.remove('error-border');
                                    }
                                });
                                if (ones === false) {
                                    alert('판매가을(를) 숫자로 입력해주세요.');
                                    ones = true;
                                }
                            } else if (priceInStkQuery.value === '') {
                                priceInStkQuery.classList.add("error-border");
                                priceInStkQuery.addEventListener('blur', () => {
                                    if (priceInStkQuery.value === '') {
                                        priceInStkQuery.classList.add('error-border');
                                    } else {
                                        priceInStkQuery.classList.remove('error-border');
                                    }
                                });
                                if (ones === false) {
                                    alert('입고 단가을(를) 숫자로 입력해주세요.');
                                    ones = true;
                                }
                            } else if (priceOutStkQuery.value === '') {
                                priceOutStkQuery.classList.add("error-border");
                                priceOutStkQuery.addEventListener('blur', () => {
                                    if (priceOutStkQuery.value === '') {
                                        priceOutStkQuery.classList.add('error-border');
                                    } else {
                                        priceOutStkQuery.classList.remove('error-border');
                                    }
                                });
                                if (ones === false) {
                                    alert('출고 단가을(를) 숫자로 입력해주세요.');
                                    ones = true;
                                }

                            } else if (fileInputs[0].files.length === 0) {
                                if (ones === false) {
                                    alert('표지 이미지 파일을(를) 선택해주세요.');
                                    ones = true;
                                }
                            }


                            for (let input of inputs) {

                                let parentElementForSelect = document.querySelectorAll('.select2-hidden-accessible');

                                let dataPlaceholderValue = parentElementForSelect[countForEmptyValue].getAttribute('data-placeholder');

                                let selectedElement = document.querySelectorAll('.select2-selection__rendered');
                                let selectText = selectedElement[countForEmptyValue].textContent;

                                if (input.tagName === 'SELECT' && selectText === dataPlaceholderValue) {

                                    let parentElement = document.querySelectorAll('.select2-selection--single');
                                    parentElement[countForEmptyValue].classList.add("error-border");

                                    input.addEventListener('blur', () => {

                                        if (selectText === dataPlaceholderValue) {

                                            parentElement[countForEmptyValue].classList.add("error-border");

                                        } else {

                                            parentElement[countForEmptyValue].classList.remove('error-border');
                                        }
                                    });

                                    if (ones === false) {
                                        alert(dataPlaceholderValue + '을(를) 입력해주세요. 3 : ' + input.getAttribute('name'));
                                        ones = true;
                                    }
                                    countForEmptyValue++;
                                }
                            }
                            if (ones === true) {
                                return;
                            }

                            for (let inputElement of inputElements) {
                                const regex = /(\d)+/;
                                if (!regex.test(inputElement.value) || inputElement.value.trim() === '') {
                                    inputElement.classList.add('error-border');
                                    inputElement.addEventListener('blur', () => {
                                        if (inputElement.value.trim() === '' || !regex.test(inputElement.value)) {
                                            inputElement.classList.add('error-border');
                                        } else {
                                            inputElement.classList.remove('error-border');
                                        }
                                    });

                                    alert(inputElement.placeholder + '은(는) 숫자만 입력 가능합니다.');
                                    return;
                                }
                            }
                            var formdata1 = $("#insertproduct").serialize();
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
                            var prdFileNameRe;

                            var insertproductform = document.querySelector("#insertproduct");
                            var formData = new FormData(insertproductform);

                            fileInputs = document.querySelectorAll('input[name=upFile]');
                            fileInputs.forEach(function (input) {
                                var files = input.files;
                                if (files.length > 0) {
                                    for (var i = 0; i < files.length; i++) {
                                        table.draw();
                                        formData.append('files', files[i]);

                                    }
                                }
                            });


                            console.log("formdata files: " + formData.get('files'));

                            console.log(table.row().data());
                            fetch("${path}/logistics/product/list/insert", {
                                method: 'POST',
                                body: formData
                            }).then(response => response.json())
                                .then(data => {
                                    alert(data.message);
                                    console.log(data.status);
                                    parsedData = Object.fromEntries(new URLSearchParams(formdata1));

                                    selectKey = data.selectKey;
                                    prdFileNameRe = data.prdFileNameRe;


                                    var currentData = table.rows().data().toArray();

                                    var pubName;
                                    <c:forEach var="entry" items="${publisherList }">
                                    if (parsedData.pubId === "${entry.PUB_ID}") {
                                        pubName = "${entry.PUB_NAME}";
                                    }
                                    </c:forEach>

                                    currentData.splice(0, 0, [selectKey, '<div class="col-5 ImageThumbnail-container"><img id="' + selectKey + '" src="${path }/resources/upload/logistics/' + prdFileNameRe + '" alt="Thumbnail" width="80px" id="prdFileNameRe"></div>', parsedData.prdTitle, parsedData.prdAuthor, parsedData.prdGenre, parsedData.publishDate, pubName, parsedData.prdPrice, parsedData.priceInStk, parsedData.priceOutStk, '<form id="deleteForm" action="${path}/logistics/inventory/list/delete" method="post" style="display: none;"> <input type="hidden" name="pub_id" id="deleteId"> </form> <button type="button" onclick="confirmDeletion(this,' + selectKey + ')" class="waves-effect waves-light btn btn-danger-light btn-flat mb-5">삭제 </button>']);

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
                                            'data-column-name': 'PRD_ID',
                                            'data-table-name': 'PRODUCT',
                                            'data-parent-column': 'PRD_ID'
                                        });
                                        $(this).find('td').eq(1).attr({
                                            'name': 'dontedit',
                                            'data-column-name': 'PRD_FILE_NAME_RE',
                                            'data-table-name': 'PRD_ATTACH',
                                            'data-parent-column': 'PRD_FILE_NAME_RE'
                                        });
                                        $(this).find('td').eq(2).attr({
                                            'data-column-name': 'PRD_TITLE',
                                            'data-table-name': 'PRODUCT',
                                            'data-parent-column': 'PRD_TITLE'
                                        });
                                        $(this).find('td').eq(3).attr({
                                            'data-column-name': 'PRD_AUTHOR',
                                            'data-table-name': 'PRD_AUTHOR',
                                            'data-parent-column': 'PRD_AUTHOR'
                                        });
                                        $(this).find('td').eq(4).attr({
                                            'name': 'dontedit',
                                            'data-column-name': 'PRD_GENRE',
                                            'data-table-name': 'PRODUCT',
                                            'data-parent-column': 'PRD_GENRE'
                                        });
                                        $(this).find('td').eq(5).attr({
                                            'data-column-name': 'PUBLISH_DATE',
                                            'data-table-name': 'PRODUCT',
                                            'data-parent-column': 'PUBLISH_DATE'
                                        });
                                        $(this).find('td').eq(6).attr({
                                            'data-column-name': 'PUB_NAME',
                                            'data-table-name': 'PUBLISHER',
                                            'data-parent-column': 'PUB_NAME'
                                        });
                                        $(this).find('td').eq(7).attr({
                                            'data-column-name': 'PRD_PRICE',
                                            'data-table-name': 'PRODUCT',
                                            'data-parent-column': 'PRD_PRICE'
                                        });
                                        $(this).find('td').eq(8).attr({
                                            'data-column-name': 'PRICE_IN_STK',
                                            'data-table-name': 'PRODUCT',
                                            'data-parent-column': 'PRICE_IN_STK'
                                        });
                                        $(this).find('td').eq(9).attr({
                                            'data-column-name': 'PRICE_OUT_STK',
                                            'data-table-name': 'PRODUCT',
                                            'data-parent-column': 'PRICE_OUT_STK'
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


                            <h4 class="box-title"><strong>도서 목록</strong>
                            </h4>
                            <h6 class="subtitle">수정할 row를 선택하세요</h6>
                        </div>


                        <div class="box-body">
                            <div class="table-responsive">

                                <table id="example1"
                                       class="table table-striped">
                                    <thead>
                                    <tr class="bt-5 border-primary">
                                        <th>책 코드</th>
                                        <th>책 표지</th>
                                        <th>도서명</th>
                                        <th>저자명</th>
                                        <th>장르</th>
                                        <th>출판일</th>
                                        <th>출판사</th>
                                        <th>판매가</th>
                                        <th>입고 단가</th>
                                        <th>출고 단가</th>
                                        <th>삭제</th>
                                    </thead>

                                    <tbody>
                                    <%--	<c:if test="받는 거래처가 로그인 직원의 해당 지점일 시">--%>
                                    <c:forEach var="prd" items="${uniqueProductList }">
                                        <tr class="bt-5 border-primary">
                                            <td name="dontedit" data-column-name="PRD_ID" data-parent-column="PRD_ID"
                                                data-table-name="PRODUCT">${prd.PRD_ID}</td>

                                            <td name="dontedit" data-column-name="PRD_FILE_NAME_RE"
                                                data-parent-column="PRD_FILE_NAME_RE"
                                                data-table-name="PRD_ATTACH">


                                                <img src="${path }/resources/upload/logistics/${prd.PRD_FILE_NAME_RE}"
                                                     alt="prdImage" width="80px" id="${prd.PRD_ID}"
                                                     onclick="document.getElementById('fileUpload').click();"/>

                                            </td>

                                            <td data-column-name="PRD_TITLE"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PRD_TITLE">${prd.PRD_TITLE}</td>

                                            <td data-column-name="PRD_AUTHOR"
                                                data-parent-column="PRD_AUTHOR"
                                                data-table-name="PRODUCT">${prd.PRD_AUTHOR}</td>

                                            <td data-column-name="PRD_GENRE"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PRD_GENRE">${prd.PRD_GENRE}</td>

                                            <td data-column-name="PUBLISH_DATE"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PUBLISH_DATE">${prd.PUBLISH_DATE}</td>

                                            <td data-column-name="PUB_NAME"
                                                data-table-name="PUBLISHER"
                                                data-parent-column="PUB_NAME">${prd.PUB_NAME}</td>

                                            <td data-column-name="PRD_PRICE"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PRD_PRICE">
                                                <fmt:formatNumber
                                                        value="${prd.PRD_PRICE}"
                                                        type="number" groupingUsed="true"/></td>
                                            <td data-column-name="PRICE_IN_STK"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PRICE_IN_STK">
                                                <fmt:formatNumber
                                                        value="${prd.PRICE_IN_STK}"
                                                        type="number" groupingUsed="true"/></td>
                                            <td data-column-name="PRICE_OUT_STK"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PRICE_OUT_STK"><fmt:formatNumber
                                                    value="${prd.PRICE_OUT_STK}"
                                                    type="number" groupingUsed="true"/></td>
                                            <td name="dontedit">
                                                <form id="deleteForm"
                                                      action="${path}/logistics/product/list/delete"
                                                      method="post" style="display: none;">
                                                    <input type="hidden" name="prd_id" id="deleteId"
                                                           value="${prd.PRD_ID}">
                                                    <!-- 어차피 자바에서 받고있음.. prdFileUploadDate-->
                                                    <input type="hidden" name="prdFileUploadDate" id="prdFileUploadDate"
                                                           value="">
                                                </form>
                                                <button type="button" onclick="confirmDeletion(this,${prd.PRD_ID})"
                                                        class="waves-effect waves-light btn btn-danger-light btn-flat mb-5">
                                                    삭제
                                                </button>
                                                <script>
                                                    function confirmDeletion(buttonElement, prdId) {
                                                        var trElement = buttonElement.closest('tr');
                                                        var table = $('#example1').DataTable();

                                                        if (confirm('정말로 삭제 하시겠습니까?')) {

                                                            fetch('${path}/logistics/product/list/delete', {
                                                                method: 'POST',
                                                                headers: {
                                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                                },
                                                                body: 'prd_id=' + prdId
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