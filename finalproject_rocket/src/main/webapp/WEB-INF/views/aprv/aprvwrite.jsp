<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="" />
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;
    }
    th,
    td {
        border: 1px solid black;
        padding: 15px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strDate = simpleDate.format(date);
	
%>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <div class="container-full">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="d-flex align-items-center">
                <div class="me-auto">
                    <h4 class="page-title">Editors</h4>
                    <div class="d-inline-block align-items-center">
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
                                <li class="breadcrumb-item" aria-current="page">Forms</li>
                                <li class="breadcrumb-item active" aria-current="page">Editors</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-12">
                    <div class="box">
                        <div class="box-header">
                            <h3>결재문서 작성</h3>
                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <table>
                                        <tr>
                                            <th>
                                                <p>양식설정</p>
                                            </th>
                                            <td>
                                                <select class="form-control select2" id="tagSelect" onchange="tagSelect()">
                                                    <option selected="selected" value="">양식을 선택하세요</option>
                                                    <option value="option1">휴가양식</option>
                                                    <option value="option2">재고양식</option>
                                                </select>
                                            </td>
                                            <th rowspan="2">
                                                <p>기안자</p>
                                            </th>
                                            <td>${user.empName }</td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="contentContainer" style="display: none">
                                    <form id="form1">
                                    <div>
                                        <div>
                                            <div>
                                                <div>
                                                    <div class="box-body" style="display: flex;">
                                                        <h4>결재선 설정</h4>
                                                        &nbsp;&nbsp;&nbsp;
                                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target=".bs-example-modal-lg">
                                                            결재선 추가
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /.col -->
                                            <div class="table table-bordered mb-0">
                                                <table style="border: 1px solid black;" id="aprvtable">
                                                    <tr style="background-color: #f2f2f2;">
                                                        <td rowspan="4" style="text-align: center;">결재</td>
                                                    </tr>
                                                    <tr style="background-color: #f2f2f2; width: 10px;" id="name">
                                                    </tr>
                                                    <tr style="height: 120px" id="empty">
                                                    </tr>
                                                    <tr id="emplv">
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="box-header" style="display: flex">
                                        <div class="box-header" style="display: flex" id="singleTag">
                                            <h4>
                                                참조자 :
                                            </h4>
                                            &nbsp;
                                            <p id="taget-reader"></p>
                                        </div>
                                    </div>
                                    <input type="hidden" name="EMP_NO" value="${user.empNo }">
                                    <input type="hidden" name="DOC_TAG" value="" id="DOC_TAG">
                                    <input type="hidden" name="START_DATE" value="" id="START_DATE">
                                    <input type="hidden" name="END_DATE" value="" id="END_DATE">


                                    <div class="box-header">
                                        <h4 class="box-title">제목<br>
                                            <input type="text" name="DOC_TITLE" class="form-control" style="width: 500px">
                                        </h4>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <h4 class="box-title">본문</h4>
                                        <div id="tagCont">
                                        <table>
							                <thead>
							                <tr>
							                    <th colspan="2"><h1 style="text-align: center;">입출고 내역 결재서 </h1></th>
							                </tr>
							            </thead>
							            <tbody>
							            	<c:if test="${not empty inventoryInfo}">
									    <tr>
									        <td>기안자</td>
									        <td>${user.empName}</td>
									    </tr>
									    <tr>
									        <td>거래처</td>
									        <td>${inventoryInfo[0].RECIEVE_EMP_ID}</td>
									    </tr>
									    <tr>
									        <td>${inventoryInfo[0].IV_TYPE}</td>
									        <td>${inventoryInfo[0].IV_DATE} / ${inventoryInfo[0].IV_MEMO} / ${inventoryInfo[0].IV_VAT_TYPE}</td>
									    </tr>
									                    
									    <tr>
									        <th>도서명</th>
									        <th>도서별 입출고 수량 / 도서별 입/출고 단가</th>
									    </tr>
									    <c:forEach var="IV" items="${inventoryInfo}">
									        <tr>
									            <td>${IV.PRD_TITLE}</td>
									            <td>${IV.PRD_IV_QUANTITY} / ${IV.PRD_STKPRICE}</td>
									        </tr>
									    </c:forEach>
									    <tr>
									        <td>모든도서 입출고 단가</td>
									        <td>도서별 매장내 판매액의 총금액</td>
									    </tr>
									    	<tr>
									    		<td>${inventoryInfo[0].TOTAL_INV_ALLPRD}</td>
									    		<td>${inventoryInfo[0].TOTAL_STORE_PRICE}</td>
									    	</tr>
									    <tr style="height: 500px">
									        <td colspan="2" style="text-align: center;">상기와 같은 이유로 결재 바랍니다.<br><br><br><br><br><br>
									        <%=strDate %></td>
									    </tr>
									</c:if>
									</tbody>
									</table>
 
                                        </div>
                                        
                                        
                                        <br>
                                    </form>





                                    </div>
                                    <%-- <div class="box">
                                        <div class="box-header">
                                            <h4 class="box-title">파일첨부</h4>
                                        </div>
                                        <div class="box-body">
                                            <form action="${path }/docu/file" class="dropzone" id="form2">
                                                <div class="fallback">
                                                    <input name="file" type="file" multiple />
                                                </div>
                                            </form>
                                        </div>
                                    </div> --%>
                                </div>
                            </div>
                            <button class="btn btn-primary" id="submitAll">제출하기</button>
                            
                        </div>
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col-->
            </div>
            <!-- ./row -->
            <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none; width: 100%">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content" style="background-color: white;">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myLargeModalLabel">결재선 설정</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="myBtn"></button>
                        </div>
                        <div class="modal-body">
                            <div id="flex-cotainer" style="display: flex">
                                <div class="multinav-scroll" style="height: 97%;">
                                    <!-- sidebar menu-->
                                    <ul class="sidebar-menu" data-widget="tree">
                                        <li class="treeview">
                                            <a href="#">
                                                <i class="icon-Library"><span class="path1"></span><span class="path2"></span></i>
                                                <span>로켓서점 &nbsp;&nbsp;&nbsp;&nbsp;</span>
                                                <span class="pull-right-container">
                                                    <i class="fa fa-angle-right pull-right"></i>
                                                </span>
                                            </a>
                                            <ul class="treeview-menu">
                                                <li class="treeview">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input name="group4" type="radio" id="1" class="radio-col-danger" />
                                                    <label for="1">일부</label>
                                                </li>
                                                <li class="treeview">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input name="group4" type="radio" id="2" class="radio-col-danger" />
                                                    <label for="2">인사부</label>
                                                </li>
                                                <li class="treeview">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input name="group4" type="radio" id="3" class="radio-col-danger" />
                                                    <label for="3">재고부</label>
                                                </li>
                                                <li class="treeview">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input name="group4" type="radio" id="4" class="radio-col-danger" />
                                                    <label for="4">부부</label>
                                                </li>
                                                <li class="treeview">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input name="group4" type="radio" id="5" class="radio-col-danger" />
                                                    <label for="5">아이부</label>
                                                </li>
                                            </ul>
                                        </li>
                                </div>
                                <div id="btn-container" class="">
                                    <div class="col-12">
                                        <div class="">
                                            <div class="box-header with-border">
                                                <h1 class="box-title text-primary" id="peo-heder">People</h1>
                                            </div>
                                            <div class="column" id="dep-container">
                                                <!--인원들출력란  -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <h1 style="position: static; margin-right: 40px">결재자</h1>
                                    <div class="column" style="width: 100%; height: 70%" id="aprv">
                                    </div>
                                </div>
                                <div>
                                    <h1 style="position: static;">참조자</h1>
                                    <div class="column" style="width: 100%; height: 70%;border: 2px"  id="reader">
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger text-start" data-bs-dismiss="modal" onclick="saveMembers();">저장</button>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger text-start" data-bs-dismiss="modal">닫기</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
            </div>
    </div>
</div>
</section>
<!-- /.content -->
</div>
</div>
<!-- /.content-wrapper -->
<script>
    //태그선택하게하기
    function tagSelect() {
        var x = document.getElementById("tagSelect").value;
        if (x === "option1") {
            document.getElementById("contentContainer").style.display = "block";
            document.getElementById("tagCont").innerHTML = "";
            document.getElementById("tagCont").innerHTML = `
        
        <table>
            <thead>
                <th colspan="2"><h1 style="text-align: center;">휴가신청서</h1></th>
            </thead>
            <tbody>
                <tr>
                    <td>성명</td>
                    <td>${user.empName}</td>
                </tr>
                <tr>
                    <td>부서</td>
                    <td>${dept}</td>
                </tr>
                <tr>
                    <td>기간</td>
                    <td >
                    <p id="startDate"></p>
                    
                    
                    <p id="endDate"></p>
                    </td>
                </tr>
                <tr>
                    <td>휴가종류</td>
                    <td>[사용할 휴가의 종류]</td>
                </tr>
                <tr>
                    <td>휴가사유</td>
                    <td><textarea name="DOC_CONT" > </textarea></td>
                </tr>
                <tr style="height: 500px">
                    <td colspan="2" style="text-align: center;">상기와 같은 이유로 휴가를 신청합니다.<br><br><br><br><br><br>
                    <%=strDate %></td>
                </tr>
            </tbody>
        </table>`;
        document.getElementById("DOC_TAG").value=1;
        var startDate = "${startDate}" ;
    	document.getElementById("startDate").innerHTML = startDate;
    	var endDate="${endDate}";
    	document.getElementById("endDate").innerHTML = endDate;
    	
    	document.getElementById("START_DATE").value=startDate;
    	document.getElementById("END_DATE").value=endDate;
        } else if (x === "option2") {
            document.getElementById("contentContainer").style.display = "block";
            //document.getElementById("tagCont").innerHTML = "";
            <%-- document.getElementById("tagCont").innerHTML = `
            <table>
                <thead>
                <tr>
                    <th colspan="2"><h1 style="text-align: center;">입출고 내역 결재서 </h1></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>기안자</td>
                    <td>${user.empName}</td>
                </tr>
                <tr>
                    <td>거래처</td>
                    <td>거래측 담당자이름</td>
                </tr>
                <tr>
                    <td>lV_TYPE</td>
                    <td>IV_DATE / IV_MEMO / IV_VAT_TYPE</td>
                </tr>
                
                <tr>
                    <th>도서명</th>
                    <th>도서별 입출고 수량 / 도서별 입/출고 단가</th>
                </tr>
                <tr>
                    <td>모든도서 입출고 단가</td>
                    <td>도서별 매장내 판매액의 총금액</td>
                </tr>
                <tr style="height: 500px">
                    <td colspan="2" style="text-align: center;">상기와 같은 이유로 결재 바랍니다.<br><br><br><br><br><br>
                    <%=strDate %></td>
                </tr>
            </tbody>
        </table>`; --%>
            document.getElementById("DOC_TAG").value=2;
        } else {
            document.getElementById("contentContainer").style.display = "none";
            document.getElementById("tagCont").innerHTML = "";
        }
    }
    
</script>
<script>
	

</script>
<script>
    //ajax통신
    //modal창 
    $('input[type=radio][name=group4]').change(function() {
        $.ajax({
            url: '${path}/docu/checkDept',
            type: 'GET',
            data: {
                DEP_CODE: this.id
            },
            success: function(data) {
                var html = '';
                for (var i = 0; i < data.length; i++) {
                    html += '<div class="column">'
                    html += '<button class="draggable" draggable="true">'
                    html += '<div class="d-flex align-items-center mb-30">'
                    html += '<div class="me-15">'
                    /* html += '<img src="../../../images/avatar/1.jpg" class="avatar avatar-lg rounded10" alt="" />' */
                    html += '</div>'
                    html += '<div class="d-flex flex-column fw-500" style="width: 100px;height:50px">'
                    html += '<p  class="text-dark hover-primary mb-1 fs-16">' + data[i].EMP_NAME + '</p>'
                    html += '<span class="text-mute">' + data[i].EMP_LV + '</span>'
                    html += ''
                    html += '<input type="hidden" value="' + data[i].EMP_NO + '" class="empNo" name="ARPV_EMP[i]">'
                    html += '</div>'
                    html += '</div>'
                    html += '</button>'
                    html += '</div>'
                    /*  html += '<p>' + data[i].EMP_LV + ' ' + data[i].EMP_NAME + '</p>'; */
                }
                document.getElementById("dep-container").innerHTML = html;
            }
        });
    });
</script>
<script type="text/javascript">
    //라디오 라벨이랑 헤더랑 이름같게
    $(document).ready(function() {
        $('input[type=radio][name=group4]').change(function() {
            var selectedLabel = $("label[for='" + $(this).attr('id') + "']").text();
            $('#peo-heder').text(selectedLabel);
        });
    });
</script>
<script>
    //드래그앤드롭
    //sorttable
    var myNo ="${user.empNo}";
    const columns = document.querySelectorAll(".column");
    columns.forEach((column) => {
        new Sortable(column, {
            group: "shared",
            animation: 150,
            ghostClass: "blue-background-class",
            onStart: function(evt) {
                // 드래그를 시작할 때 항목의 원래 리스트와 위치를 저장합니다.
                evt.item.oldParent = evt.from;
                evt.item.oldIndex = evt.oldIndex;
            },
            onAdd: function(evt) {
                const item = evt.item; // 드롭한 항목
                const empNo = item.querySelector('input[type="hidden"]').value; // 드롭한 항목의 empNo 값

                // myNo인 아이템이 원하지 않는 위치에 드롭된 경우
                if (empNo === myNo) {
                    alert("기안자는 이동할 수 없습니다.");
                    // 드롭한 아이템을 원래 위치로 되돌림
                    evt.item.oldParent.insertBefore(item, evt.item.oldParent.children[evt.item.oldIndex]);
                    return;
                }

                const aprvItems = document.getElementById('aprv').children; // 결재자 div의 모든 항목
                const readerItems = document.getElementById('reader').children; // 참조자 div의 모든 항목
                let allItems = Array.from(aprvItems).concat(Array.from(readerItems));
                for (let i = 0; i < allItems.length; i++) {
                    if (allItems[i] !== item && allItems[i].querySelector('input[type="hidden"]').value === empNo) {
                        alert("중복된 요소가 있습니다.");
                        // 중복이 발견되었을 때 항목을 원래 위치로 돌려놓습니다.
                        evt.item.oldParent.insertBefore(item, evt.item.oldParent.children[evt.item.oldIndex]);
                        return;
                    }
                }
            },
        });
    });     
</script>




<script>
    const saveMembers = () => {
        
    	document.getElementById('name').innerHTML = '';
        document.getElementById('empty').innerHTML = '';
        document.getElementById('emplv').innerHTML = '';
        
        
        if (name) name.innerHTML = '';
        if (empty) empty.innerHTML = '';
        if (emplv) emplv.innerHTML = '';
        
    	
    	const aprvItems = document.getElementById('aprv').children;
        const readItems = document.getElementById('reader').children;
        let aprvempInfo = [];
        let readerempInfo = [];
         aprvempInfo.push({
            empName: "${user.empName}",
            empLv: "${user.empLv}",
            empNo: "${user.empNo}"
        }) 

        for (let i = 0; i < aprvItems.length; i++) {
            let pTag = aprvItems[i].querySelector("p.text-dark.hover-primary.mb-1.fs-16");
            let spanTag = aprvItems[i].querySelector("span.text-mute");
            let inputTag = aprvItems[i].querySelector("input.empNo");
            if (pTag && spanTag && inputTag) {
                aprvempInfo.push({
                    empName: pTag.innerHTML,
                    empLv: spanTag.innerHTML,
                    empNo: inputTag.value
                });
            }
        }
        for (let i = 0; i < readItems.length; i++) {
            let pTag = readItems[i].querySelector("p.text-dark.hover-primary.mb-1.fs-16");
            let spanTag = readItems[i].querySelector("span.text-mute");
            let inputTag = readItems[i].querySelector("input.empNo");
            if (pTag && spanTag && inputTag) {
                readerempInfo.push({
                    empName: pTag.innerHTML,
                    empLv: spanTag.innerHTML,
                    empNo: inputTag.value
                });
            }
        }
        console.log(aprvempInfo);
        console.log(readerempInfo);
        
        
        // 테이블에 새로운 내용 추가
        for (let i = 0; i < aprvempInfo.length; i++) {
		    var row = document.getElementById('name');
		    var cell = document.createElement('td');
		    cell.innerText = aprvempInfo[i].empName;
		    
		    var infoEmp = document.createElement('input');
		    infoEmp.setAttribute('type', 'hidden');
		    infoEmp.setAttribute('name', 'APRV_EMP');
		    infoEmp.value = aprvempInfo[i].empNo;
		    
		    cell.appendChild(infoEmp);
		    row.appendChild(cell);
		
            var rowEmpty = document.getElementById('empty');
            var cellEmpty = document.createElement('td');
            rowEmpty.appendChild(cellEmpty);
            var rowEmpLv = document.getElementById('emplv');
            var cellEmpLv = document.createElement('td');
            cellEmpLv.innerText = aprvempInfo[i].empLv;
            rowEmpLv.appendChild(cellEmpLv);
        }
        var text = " ";
        for (let i = 0; i < readerempInfo.length; i++) {
            text += readerempInfo[i].empLv
            text += " ";
            text += readerempInfo[i].empName
            text += " ";
            
            
            
        } 
        document.getElementById('taget-reader').innerHTML = text;
        
        var singleTag = document.getElementById('singleTag'); 
        for(let i=0; i<readerempInfo.length; i++){
            var infoEmp = document.createElement('input');
            infoEmp.setAttribute('type', 'hidden');
            infoEmp.setAttribute('name', 'APRV_SQ');
            infoEmp.value = readerempInfo[i].empNo;
            
            singleTag.appendChild(infoEmp);
        }
    };
</script>
<script>
$('#submitAll').click(function(e) {
    e.preventDefault();
    $.ajax({
        type: 'POST',
        url: '${path}/docu/submit',
        data: $('#form1').serialize(),
        dataType:"text",
        success: function(response) {
            // AJAX 요청이 성공적으로 완료되면 실행될 콜백 함수
            console.log(response); // 서버로부터 받은 응답을 콘솔에 출력
            window.location.href = '${path}/'+response;
        },
        error:function(error){
            // AJAX 요청이 실패하면 실행될 콜백 함수
            console.error(error); // 발생한 에러를 콘솔에 출력
            alert('망했다')
            
        }
    });
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>

var myDropzone = new Dropzone("#form2", {
    url: `${path}/docu/upload`,
    method: "post",
    autoProcessQueue: false, //자동으로 보내기 방지
    paramName: 'files',
    parallelUploads: 99,
    maxFilesize: 10, // MB
    uploadMultiple: true
    
});
Dropzone.options.myDropzone = {
        autoProcessQueue: false,
        init: function() {
            var submitButton = document.querySelector("#submitAll");
            myDropzone = this;

            submitButton.addEventListener("click", function() {
            	$('#submitAll').click(function(e) {
            	    e.preventDefault();
            	    $.ajax({
            	        type: 'POST',
            	        url: '${path}/docu/submit',
            	        data: $('#form1').serialize(),
            	        dataType:"json",
            	        success: function(response) {
            	            // AJAX 요청이 성공적으로 완료되면 실행될 콜백 함수
            	            if(response=='12')
            	            console.log(response); // 서버로부터 받은 응답을 콘솔에 출력
            	            window.location.href = '${path}/docu/lists/a';
            	        },
            	        error:function(error){
            	            // AJAX 요청이 실패하면 실행될 콜백 함수
            	            console.error(error); // 발생한 에러를 콘솔에 출력
            	            alert('망했다')
            	            
            	        }
            	    });
            	});
                // If there are files in Dropzone, process them
                if (myDropzone.getQueuedFiles().length > 0) {
                    myDropzone.processQueue();
                }
            });
        }
    };
</script>