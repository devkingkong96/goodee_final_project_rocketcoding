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
    <jsp:param name="title" value="입/출고 내역"/>
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
</style>


<div class="content-wrapper">
    <div class="container-full">

        <section class="content">

            <div class="content-header" style="margin-bottom:10px;">
                <div class="d-flex align-items-center">
                    <div class="me-auto">
                        <h5 class="page-title">입고/출고 내역</h5>
                        <div class="d-inline-block align-items-center">
                            <nav>
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${path}/"> <i
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

                                "paging": true,
                                "lengthChange": true,
                                "searching": true,
                                "info": true,
                                ordering: true,
                                order: [[3, "desc"]],
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
                                        targets: 3,
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
                                    title: '입/출고 리스트 ' + getCurrentDateTime(),
                                    exportOptions: {
                                        columns: ':visible',
                                        rows: ':visible',
                                        encoding: 'UTF-8'
                                    }
                                }, {
                                    extend: 'excel',
                                    title: '입/출고 리스트 ' + getCurrentDateTime(),
                                    exportOptions: {
                                        columns: ':visible',
                                        rows: ':visible',
                                        encoding: 'UTF-8'
                                    }
                                }, {
                                    extend: 'print',
                                    title: '입/출고 리스트 ' + getCurrentDateTime(),
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


                            <h4 class="box-title"><strong>입/출고 내역</strong>
                            </h4>
                            <h6 class="subtitle">수정할 row를 선택하세요</h6>
                        </div>


                        <div class="box-body">
                            <div class="table-responsive">
                                <table id="example1"
                                       class="table table-striped">
                                    <thead>
                                    <tr class="bt-5 border-primary">
                                        <th>입/출고 코드</th>
                                        <th>타입</th>
                                        <th>총 수량</th>
                                        <th>게시일</th>
                                        <th>결재여부</th>
                                        <th>거래처</th>
                                        <th>담당자</th>
                                        <th>금액 합계</th>
                                        <th>부가세유형</th>
                                        <th>적요</th>
                                        <th>삭제</th>
                                    </thead>

                                    <tbody>
                                    <c:forEach var="iv" items="${inventories }">
                                        <tr class="bt-5 border-primary">
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
                                            <td name="dontedit">
                                                <fmt:formatNumber
                                                        value="${iv.CALCULATED_PRICE2}"
                                                        type="number" groupingUsed="true"/></td>

                                            <td data-column-name="IV_VAT_TYPE"
                                                data-parent-column="IV_VAT_TYPE"
                                                data-table-name="INVENTORY">${iv.IV_VAT_TYPE}</td>
                                            <td data-column-name="IV_MEMO" data-parent-column="IV_MEMO"
                                                data-table-name="INVENTORY">${iv.IV_MEMO}</td>
                                            <td name="dontedit">
                                                <form id="deleteForm"
                                                      action="${path}/logistics/inventory/list/delete"
                                                      method="post" style="display: none;">
                                                    <input type="hidden" name="iv_id" id="deleteId" valie="${iv.IV_ID}">
                                                </form>
                                                <script>
                                                    function confirmDeletion(buttonElement, ivId) {
                                                        var trElement = buttonElement.closest('tr');
                                                        var table = $('#example1').DataTable();
                                                        if (confirm('정말로 삭제 하시겠습니까?')) {
                                                            fetch('${path}/logistics/inventory/list/delete', {
                                                                method: 'POST',
                                                                headers: {
                                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                                },
                                                                body: 'iv_id=' + ivId
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
                                                <button type="button" onclick="confirmDeletion(this,${iv.IV_ID})"
                                                        class="waves-effect waves-light btn btn-danger-light btn-flat mb-5">
                                                    삭제
                                                </button>

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

