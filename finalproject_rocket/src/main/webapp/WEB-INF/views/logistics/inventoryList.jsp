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
    <jsp:param name="title" value="입/출고 내역"/>
</jsp:include>
<script type="text/javascript"
        src="${path }/resources/assets/vendor_components/moment/moment.js"></script>
<%--<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-gothic.css" rel="stylesheet">--%>
<%--<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">--%>
<%-- <script src="${path }/resources/js/pdfmake.min.js"></script>
<script src="${path }/resources/js/vfs_fonts.js"></script> --%>
<%--<link rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>--%>
<!-- <script
src="https://cdn.datatables.net/datetime/1.5.1/js/dataTables.dateTime.min.js"></script> -->

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

    /*    .box-body > div, .box-body form > div {
                margin: 20px; !* 각 요소의 하단에 20px 마진 추가 *!
            }

            .input-group.mb-3 {
                margin: 20px; !* input-group 클래스가 적용된 요소에도 마진 추가 *!
            }

            .custom-file, .form-control {
                margin: 20px; !* custom-file과 form-control 클래스가 적용된 요소에도 마진 추가 *!
            }*/
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
        /*margin-left: 50px;*/
        /*width: 95%;*/
        align-content: center;
    }
</style>


<div class="content-wrapper">
    <div class="container-full">
        <!-- Main content -->
        <section class="content">


            <!-- 모달 -->
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
            </div>

            <!-- Content Header (Page header) -->
            <div class="content-header" style="margin-bottom:10px;">
                <div class="d-flex align-items-center">
                    <div class="me-auto">
                        <h5 class="page-title">입고/출고 내역</h5>
                        <div class="d-inline-block align-items-center">
                            <nav>
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#"> <i
                                            class="mdi mdi-home-outline"></i></a></li>
                                    <li class="breadcrumb-item" aria-current="page">입/출고 관리</li>
                                    <li class="breadcrumb-item active" aria-current="page">입/출고
                                        내역
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">

                <div class="col-lg-12 col-12">
                    <script>


                        /*
                            let fs = require('fs');

                            // nanumgothinc.ttf 파일 경로
                            let filePath = path + '/resources/assets/fonts/malgun.ttf';

                            // 파일 읽기
                            fs.readFile(filePath, (err, data) => {
                                if (err) {
                                    console.error('파일을 읽을 수 없습니다:', err);
                                    return;
                                }

                                // Base64로 인코딩
                                let base64Data = data.toString('base64');
                                console.log(base64Data);

                                pdfMake.vfs = {
                                    'malgun.ttf': 'base64Data',
                                };

                                let fs = require('fs');

                                // nanumgothinc.ttf 파일 경로
                                let filePath = path + '/resources/assets/fonts/malgunbd.ttf';

                                // 파일 읽기
                                fs.readFile(filePath, (err, data) => {
                                    if (err) {
                                        console.error('파일을 읽을 수 없습니다:', err);
                                        return;
                                    }

                                    // Base64로 인코딩
                                    let base64Data = data.toString('base64');
                                    console.log(base64Data);

                                    pdfMake.vfs = {
                                        'malgunbd.ttf': 'base64Data',
                                    }; */



                        /*     var path = "
${path}";
    pdfMake.fonts = {
        NanumGothic: {
            normal: path + '/resources/assets/fonts/NanumGothic.ttf',
            bold: path + '/resources/assets/fonts/NanumGothicBold.ttf',
            italics: path + '/resources/assets/fonts/NanumGothicLight.ttf',
            bolditalics: path + '/resources/assets/fonts/NanumGothicExtraBold.ttf'
        }
    }; */

                        // 각 폰트 파일의 경로를 콘솔에 출력
                        // console.log("NanumGothic 폰트 경로:");
                        // console.log(pdfMake.fonts.NanumGothic.normal);
                        // console.log(pdfMake.fonts.NanumGothic.bold);
                        // console.log(pdfMake.fonts.NanumGothic.italics);
                        // console.log(pdfMake.fonts.NanumGothic.bolditalics);

                        /*    // 폰트 파일 로드 테스트를 위한 임시 텍스트 요소 생성
                            var testElement = document.createElement('div');
                            testElement.style.fontFamily = 'NanumGothic';
                            testElement.textContent = '폰트 로드 테스트';
                            document.body.appendChild(testElement);

                            // 폰트 로드 확인
                            testElement.addEventListener('fontloading', function () {
                                console.log('폰트 로드 중...');
                            });

                            testElement.addEventListener('fontactive', function () {
                                console.log('폰트 로드 성공!');
                            });

                            testElement.addEventListener('fontinactive', function () {
                                console.log('폰트 로드 실패...');
                            });*/
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


                            $('#example1').DataTable({


                                // 기본 DataTables 설정
                                "paging": true,
                                "lengthChange": true,
                                "searching": true,
                                "info": true,
                                ordering: true,
                                order: [[3, "desc"]],
                                // "editable": true,
                                "responsive": true,
                                /*    "dateFormat": 'YYYY-MM-DD HH:mm', */
                                "dom": '<"dt-buttons">Bflirtp',
                                "autoWidth": false,
                                "fixedHeader": true,
                                "drawCallback": function (settings) {
                                    // DataTables가 다시 그려질 때마다 실행됩니다.
                                    $('#example1').editableTableWidget();

                                },
                                /*  "columns": [
                                      { "editable": false },  // 입/출고
                                      { "editable": false },  // 타입
                                      { "editable": false },  // 수량
                                      { "editable": false },  // 게시일
                                      { "editable": false },  // 결재여부
                                      { "editable": false },  // 거래처
                                      { "editable": true },  // 담당자
                                      { "editable": false },  // 금액합계
                                      { "editable": true },  // 부가세유형
                                      { "editable": true },  // 적요
                                      { "editable": false },  // 삭제

                                  ],*/

                                columnDefs: [
                                    {targets: '_all', editable: true, orderable: true},
                                    {
                                        targets: 3,
                                        /* orderData: 3, // 정렬을 위해 원본 데이터의 인덱스 지정 */
                                        render: function (data, type, row) {
                                            if (type === 'display' || type === 'filter') {
                                                var date = moment(data, 'YYYY-MM-DD HH:mm:ss.S'); // SQL 형식에 맞춰서 변환

                                                return date.format('YYYY-MM-DD'); // 원하는 형식으로 표시
                                            }
                                            /*                          if (type === 'sort') {
                                                                       // 정렬을 위해 원본 데이터 형식 사용
                                                                       return data;
                                                                     }   */
                                            return data;
                                        },

                                    }


                                ],


                                /*    "ordering": [[0, 'desc']],*/
                                // 수정 불가능한 행 설정
                                createdRow: function (row, data, dataIndex) {
                                    if (dataIndex === 6 || dataIndex === 8 || dataIndex === 9) { // 수정 불가능한 행의 인덱스
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
                                            doc.defaultStyle.fonts = 'Roboto';
                                            doc.defaultStyle.font = 'Roboto';
                                            modifier: {
                                                page: 'current'
                                            }
                                            /*                        /!*    doc.defaultStyle.font = 'hangul'; // 폰트 패밀리 이름
                                                                    doc.styles.tableHeader.font = 'hangul';
                                                                    doc.styles.tableHeader.fontSize = 'hangul';
                                                                    doc.defaultStyle.fontSize = 'hangul';// 테이블 헤더에 적용할 폰트*!/*/
                                        },
                                        /*                    customize: function (doc) {
                                                                // 폰트 설정 추가
                                                           /!*     doc.defaultStyle.styles.tableBodyEven.font = 'hangul';*!/
                                                               /!* doc.defaultStyle.fonts = 'hangul';*!/

                                                            /!*    doc.defaultStyle.font = 'hangul'; // 폰트 패밀리 이름
                                                                doc.styles.tableHeader.font = 'hangul';
                                                                doc.styles.tableHeader.fontSize = 'hangul';
                                                                doc.defaultStyle.fontSize = 'hangul';// 테이블 헤더에 적용할 폰트*!/
                                                            },*/
                                        /*          format: {
                                                      body: function (data, row, column, node) {
                                                          // 한글 폰트 설정
                                                          var font = 'hangul'; // 사용하고자 하는 폰트명으로 변경해주세요.
                                                          node.style.fontFamily = font;
                                                          return node;
                                                      }
                                                  },*/
                                        /*                    customize: function (doc) {
                                                                doc.defaultStyle.font = 'NanumGothic';
                                                                doc.styles.tableHeader.font = 'NanumGothic';
                                                            },*/
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
                                        // "info": "현재 _START_ - _END_ / _TOTAL_건",
                                        "infoEmpty": "데이터 없음",
                                        "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
                                        // "search": "에서 검색: ",
                                        "zeroRecords": "일치하는 데이터가 없어요.",
                                        "loadingRecords": "로딩중...",
                                        "processing": "잠시만 기다려 주세요..."
                                        // "paginate": {
                                        //     "next": "다음",
                                        //     "previous": "이전"

                                        // },

                                    },

                                }
                            });

                            $('#example1').editableTableWidget().on('change', function (e, newValue) {
                                // 셀의 데이터가 변경되었을 때의 처리
                                var cell = $(e.target);
                                var columnIdx = cell.index();
                                var rowIdx = cell.closest('tr').index();
                                var table = $('#example1').DataTable();
                                var data = table.row(rowIdx).data();

                                data[columnIdx] = newValue; // 데이터 배열 업데이트
                                table.row(rowIdx).data(data).draw(); // 검색 색인 업데이트
                            });
                            var table = $('#example1').DataTable();

                            /*        // 각 열에 대한 검색을 수행할 수 있는 셀렉트 박스 추가
                                    table.columns().every(function() {
                                        var column = this;
                                        var select = $('<select><option value=""></option></select>')
                                            .appendTo($(column.footer()).empty())
                                            .on('change', function() {
                                                var val = $.fn.dataTable.util.escapeRegex($(this).val());
                                                column.search(val ? '^' + val + '$' : '', true, false).draw();
                                            });

                                        column.data().unique().sort().each(function(d, j) {
                                            select.append('<option value="' + d + '">' + d + '</option>');
                                        });
                                    });*/
                            // 편집 가능한 테이블에서 행이 수정될 때 발생하는 이벤트
                            /*$('#example1').on('edit', function (e, datatable, cell) {
                                    // 수정된 셀의 행 인덱스 가져오기
                                    var rowIndex = cell.index().row;
                                console.log("행 인덱스: " + rowIndex);
                                // Datatables로부터 해당 행의 데이터 가져오기
                                var rowData = datatable.row(rowIndex).data();

                                // IV_ID 열의 데이터 가져오기
                                var ivIdValue = rowData.IV_ID;

                                // 수정된 값 가져오기
                                var cellData = cell.data();

                                // 이제 IV_ID와 cellData를 사용하여 원하는 작업 수행
                                // 데이터를 서버로 전송하거나 다른 작업을 수행할 수 있음
                                console.log("IV_ID: " + ivIdValue);
                                console.log("새로운 값: " + cellData);

                                // 추가 작업을 수행할 수 있음
                                // ...

                                // 예를 들어, 서버로 데이터를 전송하는 경우
                                $.ajax({
                                    method: "POST",
                                    url: "your_server_url_here",
                                    data: {
                                        IV_ID: ivIdValue,
                                        newValue: cellData
                                    },
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

                        });
                        /*
                            alert("test")
                            $('#example1').DataTable().order([0, 'asc']).draw();
                        */

                        /*     let minDate, maxDate;

                            // Custom filtering function which will search data in column four between two values
                            DataTable.ext.search.push(function (settings, data, dataIndex) {
                                let min = minDate.val();
                                let max = maxDate.val();
                                let date = new Date(data[3]);

                                if (
                                    (min === null && max === null) ||
                                    (min === null && date <= max) ||
                                    (min <= date && max === null) ||
                                    (min <= date && date <= max)
                                ) {
                                    return true;
                                }
                                return false;
                            });

                            // Create date inputs
                            minDate = new DateTime('#min', {
                                format: 'MMMM Do YYYY'
                            });
                            maxDate = new DateTime('#max', {
                                format: 'MMMM Do YYYY'
                            });

                            // DataTables initialisation
                            let table = new DataTable('#example1');

                            // Refilter the table
                            document.querySelectorAll('#min, #max').forEach((el) => {
                                el.addEventListener('change', () => table.draw());
                            });
                         */
                    </script>
                    <%--<script>
                        $(document).ready(
                            function () {
                                //Only needed for the filename of export files.
                                //Normally set in the title tag of your page.
                                /*document.title = 'Simple DataTable';*/
                                // DataTable initialisation
                                // var data = [
                                // <c:forEach var="iv" items="${inventories}" varStatus="status">
                                // {
                                //     "IV_ID": "${iv.IV_ID}",
                                //    "IV_TYPE": " ${iv.IV_TYPE}",
                                //    "QUANTITY": "${iv.QUANTITY != null ? iv.QUANTITY : '수량'}",
                                //    "IV_DATE": "${iv.IV_DATE}",
                                //    "CONFIRM_YN": "${iv.CONFIRM_YN != null ? iv.CONFIRM_YN : '결재여부'}",
                                //    "SEND_BRANCH_NAME": "${iv.SEND_BRANCH_NAME}",
                                //    "SEND_EMP_NAME": " ${iv.SEND_EMP_NAME}",
                                //    "TOTAL_AMOUNT": "${iv.TOTAL_AMOUNT != null ? iv.TOTAL_AMOUNT : '금액합계'}",
                                //     "IV_VAT_TYPE": "${iv.IV_VAT_TYPE}",
                                //    "IV_MEMO": "<c:out value='${iv.IV_MEMO}'/>",
                                //    "deleteLink": '<a href="${path} / inventory / delete ? iv_id =${iv.IV_ID}">삭제</a>'
                                // }
                                //  <c:if test="${!status.last}">, </c:if>
                                //   </c:forEach>
                                //];

                                $('#example1').DataTable(
                                    {
                                        "processing": true,
                                        "serverSide": true,
                                        "destroy": true,
                                        "dateFormat": 'YYYY-MM-DD HH:mm:ss',
                                        "ajax": {
                                            "url": "${path }/logistics/inventories",
                                            "type": "GET",
                                            "dataSrc": function (json) {
                                                console.log("Received JSON:", json);
                                                var data = json.data;
                                                return data;
                                            }
                                        },
                                        "columns": [
                                            {title: "입/출고 코드", "data": "IV_ID"},
                                            {title: "타입", "data": "IV_TYPE"},
                                            {
                                                /*                    title: "수량", "data": "QUANTITY"*/
                                                title: "수량",
                                                "data": null,
                                                "defaultContent": "수량",
                                                "render": function (data, type, row, meta) {
                                                    return '임의의 값 또는 HTML 요소';
                                                }
                                            },
                                            {title: "게시일", "data": "IV_DATE"},
                                            {
                                                title: "결재여부",/* "data": "CONFIRM_YN"*/
                                                "data": null,
                                                "defaultContent": "결재여부",
                                                "render": function (data, type, row, meta) {
                                                    return '임의의 값 또는 HTML 요소';
                                                }
                                            },
                                            {title: "거래처", "data": "SEND_BRANCH_NAME"},
                                            {title: "담당자", "data": "SEND_EMP_NAME"},
                                            {
                                                /* title: "금액합계", "data": "TOTAL_AMOUNT" */
                                                title: "금액합계",
                                                "data": null,
                                                "defaultContent": "금액합계",
                                                "render": function (data, type, row, meta) {
                                                    return '임의의 값 또는 HTML 요소';
                                                }
                                            },
                                            {"data": "IV_VAT_TYPE"},
                                            {"data": "IV_MEMO"},
                                            {
                                                /*                      title: "금액합계", "data": "TOTAL_AMOUNT"*/
                                                title: "삭제",
                                                "data": null,
                                                "defaultContent": "삭제",
                                                "render": function (data, type, row, meta) {
                                                    return '<a href="${path}/inventory/delete?iv_id=${iv.IV_ID}">삭제</a>';
                                                }
                                            }
                                            /*                                   {
                                                                                   title: "적요",
                                                                                   "data": "deleteLink", "render": function (data) {
                                                                                       return data;
                                                                                   }
                                                                               }*/
                                        ],
                                        "dom": '<"dt-buttons"Bfli>rtp',
                                        "paging": true,
                                        "autoWidth": true,
                                        "fixedHeader": true,
                                        // 기타 DataTables 설정
                                        "drawCallback": function (settings) {
                                            // DataTables가 다시 그려질 때마다 실행됩니다.
                                            $('#example1').editableTableWidget();

                                        },
                                        "buttons": [{
                                            extend: 'colvis',
                                            text: '일부 컬럼 보기'

                                        }, {

                                            extend: 'copyHtml5',
                                            text: '클립보드에 복사',
                                            exportOptions: {
                                                columns: ':visible'

                                            }
                                        }, {
                                            extend: 'csvHtml5',
                                            exportOptions: {
                                                columns: ':visible'
                                            }
                                        }, {
                                            extend: 'excelHtml5',
                                            exportOptions: {
                                                columns: ':visible'
                                            }
                                        }, {
                                            extend: 'pdfHtml5',
                                            exportOptions: {
                                                columns: ':visible'
                                            }
                                        }, {
                                            extend: 'print',
                                            exportOptions: {
                                                columns: ':visible'
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
                                                // "info": "현재 _START_ - _END_ / _TOTAL_건",
                                                "infoEmpty": "데이터 없음",
                                                "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
                                                // "search": "에서 검색: ",
                                                "zeroRecords": "일치하는 데이터가 없어요.",
                                                "loadingRecords": "로딩중...",
                                                "processing": "잠시만 기다려 주세요..."
                                                // "paginate": {
                                                //     "next": "다음",
                                                //     "previous": "이전"

                                                // },

                                            },

                                        }


                                    });

                                // table.on('init', function() {
                                //     $(".dataTables_length").after("<br>"); // .dataTables_length 뒤에 <br> 추가
                                // });
                            });
                    </script>--%>
                    <div class="box">
                        <div class="box-header">


                            <h4 class="box-title"><strong>입/출고내역</strong>
                            </h4>
                            <h6 class="subtitle">수정할 row를 선택하세요</h6>
                        </div>


                        <div class="box-body">
                            <div class="table-responsive">
                                <!--                                 <table border="0" cellspacing="5" cellpadding="5">
                                                                    <tbody>
                                                                    <tr>
                                                                        <td>Minimum date:</td>
                                                                        <td><input type="text" id="min" name="min"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Maximum date:</td>
                                                                        <td><input type="text" id="max" name="max"></td>
                                                                    </tr>
                                                                    </tbody>
                                                                </table> -->

                                <table id="example1"
                                       class="table table-bordered table-separated">
                                    <thead>
                                    <tr>
                                        <th>입/출고 코드</th>
                                        <th>타입</th>
                                        <th>총 수량</th>
                                        <th>게시일</th>
                                        <th>결재여부</th>
                                        <th>거래처</th>
                                        <th>담당자</th>
                                        <th>금액합계</th>
                                        <th>부가세유형</th>
                                        <th>적요</th>
                                        <th>삭제</th>
                                    </thead>

                                    <tbody>
                                    <%--	<c:if test="받는 거래처가 로그인 직원의 해당 지점일 시">--%>
                                    <c:forEach var="iv" items="${inventories }">
                                        <tr>
                                            <td name="dontedit" data-column-name="IV_ID"
                                                data-table-name="INVENTORY">${iv.IV_ID}</td>
                                            <td name="dontedit" data-column-name="IV_VAT_TYPE"
                                                data-table-name="INVENTORY">${iv.IV_TYPE}</td>
                                            <td name="dontedit">${iv.TOTAL_PRD_IV_QUANTITY}</td>
                                            <td name="dontedit" data-column-name="IV_DATE"
                                                data-table-name="INVENTORY">${iv.IV_DATE}</td>
                                            <td name="dontedit">

                                                <c:choose>
                                                    <c:when test="${iv.DOC_STATCD == 0}">
                                                        진행중
                                                    </c:when>
                                                    <c:when test="${iv.DOC_STATCD == 1}">
                                                        완료
                                                    </c:when>
                                                    <c:when test="${iv.DOC_STATCD == -1}">
                                                        반려
                                                    </c:when>
                                                    <c:otherwise>
                                                        상태 미정
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td name="dontedit" data-column-name="SEND_BRC_ID"
                                                data-parent-column="BRANCH_NAME"
                                                data-table-name="BRANCH">${iv.SEND_BRANCH_NAME}</td>
                                            <td data-column-name="SEND_EMP_ID"
                                                data-parent-column="EMP_NAME"
                                                data-table-name="EMPLOYEE">${iv.SEND_EMP_NAME}</td>
                                            <td name="dontedit">${iv.CALCULATED_PRICE2}</td>
                                            <td data-column-name="IV_VAT_TYPE"
                                                data-parent-column="IV_VAT_TYPE"
                                                data-table-name="INVENTORY">${iv.IV_VAT_TYPE}</td>
                                            <td data-column-name="IV_MEMO" data-parent-column="IV_MEMO"
                                                data-table-name="INVENTORY">${iv.IV_MEMO}</td>
                                            <td name="dontedit">
                                                <form id="deleteForm"
                                                      action="${path}/logistics/inventory/list/delete"
                                                      method="post" style="display: none;">
                                                    <input type="hidden" name="iv_id" id="deleteId">
                                                </form>
                                                <script>
                                                    function confirmDeletion(buttonElement, ivId) {
                                                        var trElement = buttonElement.closest('tr');
                                                        var table = $('#example1').DataTable();
                                                        // var thisRowIndex = table.row(trElement).index();
                                                        if (confirm('정말로 삭제 하시겠습니까?')) {
                                                            // Ajax 요청 설정
                                                            fetch('${path}/logistics/inventory/list/delete', {
                                                                method: 'POST',
                                                                headers: {
                                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                                },
                                                                body: 'iv_id=' + ivId // ivId는 삭제할 항목의 ID
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
                                                                    // table.row($(this).parents('tr')).remove().draw();
                                                                    // 성공적으로 처리된 후 작업을 여기에 작성하세요.
                                                                    // 예: 페이지 새로고침, 사용자에게 알림 표시 등
                                                                })
                                                                .catch(error => {
                                                                    console.error('오류가 발생했습니다:', error);
                                                                });
                                                        }
                                                    }
                                                </script>
                                                <button type="button" onclick="confirmDeletion(this,${iv.IV_ID})"
                                                        class="waves-effect waves-light btn btn-danger-light btn-flat mb-5">
                                                    삭제
                                                </button>

                                            </td>

                                        </tr>
                                    </c:forEach>
                                    </tbody>

                                    <%-- 	  </c:if> --%>
                                    <%--                      <tfoot>
                                                          <tr>
                                                              <th>입/출고 코드</th>
                                                              <th>타입</th>
                                                              <th>수량</th>
                                                              <th>게시일</th>
                                                              <th>결재여부</th>
                                                              <th>거래처</th>
                                                              <th>담당자</th>
                                                              <th>금액합계</th>
                                                              <th>부가세유형</th>
                                                              <th>적요</th>
                                                          </tr>
                                                          </tfoot>--%>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>