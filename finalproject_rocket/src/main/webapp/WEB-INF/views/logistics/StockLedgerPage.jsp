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

<%
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-ddHH:mm");
    String formattedNow = now.format(formatter);
%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="재고 수불부"/>
</jsp:include>
<script type="text/javascript"
        src="${path }/resources/assets/vendor_components/moment/moment.js"></script>

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

    th, td {
        border-right: 1px solid #E5E5E5;
    }
</style>


<div class="content-wrapper">
    <div class="container-full">
        <section class="content">

            <div class="content-header" style="margin-bottom:10px;">
                <div class="d-flex align-items-center">
                    <div class="me-auto">
                        <h5 class="page-title">재고 수불부</h5>
                        <div class="d-inline-block align-items-center">
                            <nav>
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${path}/"> <i
                                            class="mdi mdi-home-outline"></i></a></li>
                                    <li class="breadcrumb-item" aria-current="page">재고 관리</li>
                                    <li class="breadcrumb-item active" aria-current="page">재고 수불부
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



                    </script>
                    <div id="externalTableContainer">
                        <div class="box">
                            <div class="box-header">


                                <h4 class="box-title"><strong>재고 수불부</strong>
                                </h4>
                                <h6 class="subtitle">재고 수불부 내역을 파일로 활용하세요</h6>
                            </div>


                            <div class="box-body">
                                <div class="table-responsive" style="margin-left:20px;">

                                    <c:forEach items="${groupedBySendBrcIdAndPrdId}" var="sendBrcEntry" varStatus="status2">
                                        <c:forEach items="${sendBrcEntry.value}" var="prdEntry" varStatus="status4">
                                            <div style="overflow: hidden; width: 60%; margin-right: auto;"
                                                 class="top">
                                                <p style="float: left; margin-top: 40px; margin-left:5px;">회사명
                                                    : (주)로켓 ERP
                                                    : ${prdEntry.value[0].BRANCH_NAME}, ${prdEntry.value[0].PRD_TITLE}</p>
                                                <p style="float: right; margin-top: 40px; margin-right:20px;">기간
                                                    : ${startDateHiddenValue}
                                                    - ${endDateHiddenValue}</p>
                                            </div>
                                            <table id="datatable-${sendBrcEntry.key}-${status2.index}"
                                                   class="display table table-hover table-sm mb-0"
                                                   style="width: 60%; margin-right: auto;border: 1px solid #F1F1F1; padding: 10px;"
                                                   name="gggg">
                                                <thead class="table-light table-primary">
                                                <tr class=" bt-1 border-primary
                                            ">
                                                    <th>일자</th>
                                                    <th>거래처명</th>
                                                    <th>입고 수량</th>
                                                    <th>출고 수량</th>
                                                    <th>재고 수량</th>
                                                </tr>
                                                </thead>
                                                <tbody>


                                                <c:set var="previousMonth" value=""/>
                                                <c:forEach items="${prdEntry.value}" var="record" varStatus="status3">
                                                    <c:if test="${status3.first}">
                                                        <tr class="bt-1 border-primary">
                                                            <td colspan="2" style="text-align: center; color:red;">
                                                                <strong>전일
                                                                    재고 </strong></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td>${record.PREVIOUS_STOCK}</td>
                                                        </tr>
                                                    </c:if>

                                                    <tr class="bt-1 border-primary">

                                                        <td><fmt:formatDate value="${record.STK_DATE}"
                                                                            pattern="yyyy-MM-dd"/></td>

                                                        <td>${record.RECIEVE_BRANCH_NAME}</td>

                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${record.IN_STOCK == 0}">

                                                                </c:when>
                                                                <c:otherwise>

                                                                    ${record.IN_STOCK}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td><c:choose>
                                                            <c:when test="${record.OUT_STOCK == 0}">

                                                            </c:when>
                                                            <c:otherwise>

                                                                ${record.OUT_STOCK}
                                                            </c:otherwise>
                                                        </c:choose>

                                                        </td>
                                                        <td>${record.STK_STOCK}</td>
                                                    </tr>
                                                    <c:set var="previousMonth"
                                                           value="${record.TOTAL_MONTH_NAME}"/>
                                                    <c:if test="${status3.last or record.TOTAL_MONTH_NAME ne prdEntry.value[status3.index + 1].TOTAL_MONTH_NAME}">
                                                        <tr class="bt-1 border-primary table-light">
                                                            <td colspan="2" style="text-align: center;">
                                                                <b>${record.TOTAL_MONTH_NAME} 계</b>
                                                            </td>
                                                            <td>
                                                                    ${record.TOTAL_MONTH_IN}</td>
                                                            <td>${record.TOTAL_MONTH_OUT}</td>
                                                            <td>${record.TOTAL_MONTH_STOCK}</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:if test="${status3.last}">
                                                        <tr class="bt-1 border-primary table-light">
                                                            <td colspan="2" style="text-align: center;">
                                                                <strong>합계</strong>
                                                            </td>
                                                            <td>${record.FINAL_MONTH_IN}</td>
                                                            <td>${record.FINAL_MONTH_OUT}</td>
                                                            <td>${record.FINAL_QUANTITY}</td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                                </tbody>

                                            </table>

                                            <div style="overflow: hidden; width: 60%; margin-right: auto;"
                                                 class="bottom">
                                                <p style="float: left; margin-left:20px; margin-top:10px;">
                                                    [ ${status4.index + 1} 페이지
                                                    ]</p>

                                                <%
                                                    SimpleDateFormat dateFormat = new SimpleDateFormat(
                                                            "yyyy-MM-dd HH:mm:ss");
                                                    dateFormat.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
                                                    String koreanTime = dateFormat.format(new Date());
                                                %>
                                                <p style="float: right; margin-right:20px; margin-top:10px;">조회 시각
                                                    : <%= koreanTime %>
                                                </p>
                                            </div>
                                        </c:forEach>

                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>


<script>


    $(function () {
        $("#min").datepicker();
        $("#max").datepicker();
    });


    $(document).ready(function () {

        var path = "${path}";
        var select2Data = {};
        var serverData = $("#branch-names2").html();


        var tables;
        $.extend($.fn.dataTable.defaults, {
            dom: 'Blfrtip',
            searching: true,
            ordering: false
        });
/*        alert(tables.length);*/


        var buttons = [
            {
                extend: 'excelHtml5',
                text: 'Excel로 내보내기',
                customize: function (xlsx) {

                    tables.forEach(function (table, index) {
                        addSheet(xlsx, table, 'Sheet ' + (index + 1));
                    });
                },
                title: '재고현황 ' + uniqueBottomMessage,

                messageTop: uniqueBranchNames,

                messageBottom: '생성 시각 : ' + getCurrentDateTime(),
                exportOptions: {
                    columns: ':visible',
                    rows: ':visible',
                    encoding: 'UTF-8',
                }
            }
        ];

        tables.forEach(function (table) {

            new $.fn.dataTable.buttons(table, {

                buttons: buttons
            })
            ;
            table.buttons().container().appendTo($('.table-responsive'));
        });

        function addSheet(xlsx, tableId, sheetName) {


            var sheet = xlsx.xl.worksheets['sheet1.xml'];
            var sheetData = $('row', sheet);

            table.rows().every(function () {
                var data = this.data();
                var row = sheet.createElement('row');

                data.forEach(function (cellData) {
                    var cell = sheet.createElement('c');
                    cell.setAttribute('t', 'inlineStr');
                    var cellValue = sheet.createElement('is');
                    var textNode = sheet.createElement('t');
                    textNode.textContent = cellData;
                    cellValue.appendChild(textNode);
                    cell.appendChild(cellValue);
                    row.appendChild(cell);
                });

                sheetData.append(row);
            });

            var sheetNameTag = $('sheet', xlsx.xl['workbook.xml']).filter(function () {
                return $(this).attr('sheetId') === '1';
            });
            sheetNameTag.attr('name', sheetName);
        }

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
<%--<script src="${path}/resources/assets/vendor_components/datatable/datatables.min.js"></script>--%>
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
<script src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.7.1/jszip.min.js"></script>


<!-- CRMi App -->
<script src="${path}/resources/js/template.js"></script>
<script src="${path}/resources/js/pages/calendar.js"></script>
<script src="${path}/resources/js/pages/editor.js"></script>
<script src="${path}/resources/js/pages/data-table.js"></script>
<%--<script src="${path}/resources/js/pages/data-table2.js"></script>--%>
<script src="${path }/resources/js/pages/editable-tables.js"></script>


<script src="${path}/resources/js/jquery.smartmenus.js"></script>
<script src="${path}/resources/js/menus.js"></script>
<script src="${path}/resources/js/pages/extra_taskboard.js"></script>
<script src="${path}/resources/js/pages/advanced-form-element.js"></script>


<%--<script src="${path}/resources/assets/vendor_components/jquery-knob/js/jquery.knob.js"></script>--%>
<%--<script src="${path}/resources/js/pages/widget-inline-charts.js"></script>--%>
<%--<script src="${path}/resources/assets/vendor_components/raphael/raphael.min.js"></script>--%>
<%--<script src="${path}/resources/assets/vendor_components/morris.js/morris.min.js"></script>--%>
<%--<script src="${path}/resources/js/pages/widget-morris-charts.js"></script>--%>


<%-- <script src="${path}/resources/assets/vendor_components/ckeditor/ckeditor.js"></script> --%>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
<script src="https://cdn.datatables.net/select/1.3.3/js/dataTables.select.min.js"></script>

<script>
    $.widget.bridge('uibutton', $.ui.button);
</script>


</body>
</html>