<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.TimeZone" %>
<%@ page import="java.util.Date" %>


<c:set var="path" value="${pageContext.request.contextPath}"/>
<%--<%@ taglib prefix="seo_num" uri="/WEB-INF/views/logistics/formatNumber.tag" %>--%>

<%
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-ddHH:mm");
    String formattedNow = now.format(formatter);
%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="지점별 재고 현황"/>
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
                        <h5 class="page-title">지점별 재고 현황 (도서명 기준) </h5>
                        <div class="d-inline-block align-items-center">
                            <nav>
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${path}/"> <i
                                            class="mdi mdi-home-outline"></i></a></li>
                                    <li class="breadcrumb-item" aria-current="page">재고 관리</li>
                                    <li class="breadcrumb-item active" aria-current="page">지점별 재고 현황 (도서명 기준)
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-12">
                    <input type="hidden" id="branch-names" name="branch-names" value=
                    <c:forEach var="branch" items="${branchNameUniqueList}">
                        <c:set var="uniqueBranchNames" value=""/>
                    <c:forEach var="item" items="${branchNameUniqueList}">
                    <c:if test="${not uniqueBranchNames.contains(item.BRANCH_NAME)}">
                        <c:set var="uniqueBranchNames"
                               value="${uniqueBranchNames}${item.BRANCH_NAME},"/>
                    </c:if>
                    </c:forEach>
                        <c:set var="uniqueBranchNames"
                               value="${fn:substring(uniqueBranchNames, 0, fn:length(uniqueBranchNames) - 1)} "/>
                    </c:forEach>

                    ${uniqueBranchNames} 외>

                    <input type="hidden" id="branch-names3" name="branch-names3" value=
                    ${daybyStockList[0]["SELECTED_STK_DATE"]}>

                    <script>
                        var uniqueBottomMessage = "기준 날짜 : " + document.getElementById('branch-names3').value;

                        var uniqueBranchNames = document.getElementById('branch-names').value;
                        uniqueBranchNames = "회사명 : (주)로켓 ERP / " + uniqueBranchNames + " 외";

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
                                "paging": false,
                                "lengthChange": true,
                                "searching": false,
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
                                "buttons": [{
                                    extend: 'colvis',
                                    text: '일부 컬럼 보기'
                                }, {
                                    extend: 'colvisRestore',
                                    text: '컬럼 복원'
                                }, {
                                    extend: 'copyHtml5',
                                    text: '클립보드에 복사',
                                    messageTop: uniqueBranchNames,
                                    messageBottom: '생성 시각 : ' + getCurrentDateTime(),
                                    exportOptions: {
                                        columns: ':visible',
                                        rows: ':visible',
                                        encoding: 'UTF-8'
                                    }
                                }, {
                                    extend: 'csvHtml5',
                                    title: '재고현황 ' + uniqueBottomMessage,
                                    messageTop: uniqueBranchNames,
                                    exportOptions: {
                                        columns: ':visible',
                                        rows: ':visible',
                                        encoding: 'UTF-8'
                                    }
                                }, {
                                    extend: 'excelHtml5',
                                    title: '재고현황 ' + uniqueBottomMessage,
                                    messageTop: uniqueBranchNames,

                                    messageBottom: '생성 시각 : ' + getCurrentDateTime(),
                                    exportOptions: {
                                        columns: ':visible',
                                        rows: ':visible',
                                        encoding: 'UTF-8',

                                    }
                                }, {
                                    extend: 'print',
                                    title: '재고현황 ' + uniqueBottomMessage,
                                    messageTop: uniqueBranchNames,
                                    messageBottom: '생성 시각 : ' + getCurrentDateTime(),
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


                            var table = $('#example1').DataTable();
                        });

                    </script>
                    <div class="box">
                        <div class="box-header">


                            <h4 class="box-title"><strong>지점별 재고 현황 (도서명 기준)</strong>
                            </h4>
                            <h6 class="subtitle">지점별 재고 (도서명 기준) 현황 내역을 파일로 활용하세요</h6>
                        </div>


                        <div class="box-body">

                            <div class="table-responsive">
                                <div id="branch-names2" name="branch-names2">


                                    회사명 : (주)로켓 ERP /
                                    <c:forEach var="branch" items="${branchNameUniqueList}">
                                        <c:set var="uniqueBranchNames" value=""/>
                                        <c:forEach var="item" items="${branchNameUniqueList}">
                                            <c:if test="${not uniqueBranchNames.contains(item.BRANCH_NAME)}">
                                                <c:set var="uniqueBranchNames"
                                                       value="${uniqueBranchNames} ${item.BRANCH_NAME}, "/>
                                            </c:if>
                                        </c:forEach>
                                        <c:set var="uniqueBranchNames"
                                               value="${fn:substring(uniqueBranchNames, 0, fn:length(uniqueBranchNames) - 2)}"/>
                                    </c:forEach>
                                    ${uniqueBranchNames}
                                    <br>
                                    기준 날짜 :${daybyStockList[0]["SELECTED_STK_DATE"]}
                                </div>

                                <table id="example1"
                                       class="table table-striped">
                                    <thead>
                                    <tr class="bt-5 border-primary">
                                        <th>도서 코드</th>
                                        <th>도서명</th>
                                        <th>지점 코드</th>
                                        <th>지점명</th>
                                        <th>재고 수량</th>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="daybyStock" items="${daybyStockList }">
                                        <tr class="bt-5 border-primary">
                                            <td name="dontedit" data-column-name="PRD_ID" data-parent-column="PRD_ID"
                                                data-table-name="PRODUCT">${daybyStock.PRD_ID}</td>

                                            <td name="dontedit" data-column-name="PRD_TITLE"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PRD_TITLE">${daybyStock.PRD_TITLE}</td>


                                            <td name="dontedit" data-column-name="PRD_TITLE"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PRD_TITLE">${daybyStock.BRANCH_ID}</td>

                                            <td name="dontedit" data-column-name="PRD_TITLE"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PRD_TITLE">${daybyStock.BRANCH_NAME}</td>
                                            <td name="dontedit" data-column-name="PRD_TITLE"
                                                data-table-name="PRODUCT"
                                                data-parent-column="PRD_TITLE">${daybyStock.STK_STOCK}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                    <tfoot style="background-color: #E6E6FA;">
                                    <tr>
                                        <th colspan="4" style="text-align: center;">합계</th>

                                        <td name="dontedit">
                                            <fmt:formatNumber value="${daybyStockList[0].TOTAL_STOCK_BY_ALLPRD}"
                                                              type="number" groupingUsed="true"/>
                                        </td name="dontedit" >
                                    </tr>
                                    </tfoot>
                                </table>
                                <%
                                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                    dateFormat.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
                                    String koreanTime = dateFormat.format(new Date());
                                %>
                                <p>조회 시각 : <%= koreanTime %>
                                </p>
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

<script src="${path}/resources/assets/vendor_components/ckeditor/ckeditor.js"></script>


<script>
    $.widget.bridge('uibutton', $.ui.button);
</script>


</body>
</html>

