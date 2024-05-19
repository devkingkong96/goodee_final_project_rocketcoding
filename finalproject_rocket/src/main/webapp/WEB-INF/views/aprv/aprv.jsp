<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
	

<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="title" value=""/>
</jsp:include>
<style>
    table {
        width: 100%;
        table-layout: fixed;
        border-collapse: collapse;
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
<div class="content-wrapper">
    <div class="container-full">
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-12">
                    <div class="box">
                        <div class="box-header">
                            <h3>결재문서</h3>
                            <div class="row">
                                <div class="col-md-12 col-12">
											<div class="table table-bordered mb-0">
                                                <table style="border: 1px solid black; " id="aprvtable">
                                                    <tr style="background-color: #f2f2f2; ">
                                                        <td rowspan="4" style="text-align: center;">결재</td>
                                                    </tr>
                                                    <tr style="background-color: #f2f2f2;" id="name">
													    <c:forEach var="doc" items="${docu}">
													        <c:if test="${doc.APRV_LV ne 99}">
													            <td><c:out value="${doc.EMP_NAME}"/></td>
													        </c:if>
													    </c:forEach>
													</tr>
													<tr style="height: 120px;" id="empty">
													    <c:forEach var="doc" items="${docu}">
														    <c:if test="${doc.APRV_LV ne 99}">
														        <c:if test="${doc.APRV_SQ == 1}">
														        <td style="text-align: center; vertical-align: middle;">
																	    <img src="https://approval.office.hiworks.com/gabia.biz/approval/sign/approval/A/2/87786" 
																	        style="width: 70%; height: auto; max-width: none;" 
																	        alt="아이콘">
																	    <p style="color: gray; margin: 0;"><fmt:formatDate value="${doc.APRV_DATE }" pattern="yyyy-MM-dd"/></p>
																	</td>
																															        
														        
														     
														        </c:if>
														        <c:if test="${doc.APRV_SQ == 0}">
														            <td id="APRV_EMP">
														                <c:if test="${doc.APRV_EMP eq user.empNo}">
														                    <button type="button" class="btn btn-primary" id="targetbtn">
					                                                            결재
					                                                        </button>
														                </c:if>
														            </td>
														        </c:if>
														        <c:if test="${doc.APRV_SQ == -1}">
														            <td>
														                <img src="https://approval.office.hiworks.com/gabia.biz/approval/sign/approval/A/4/87789" 
														                    style="width: 100%; height: 100%"
														                    alt="아이콘">
														                <p style="color: gray; margin: 0;"><fmt:formatDate value="${doc.APRV_DATE }" pattern="yyyy-MM-dd"/></p>
														            </td>
														        </c:if>
														    </c:if>
														</c:forEach>

													</tr>
													<tr id="emplv">
													    <c:forEach var="doc" items="${docu}">
													        <c:if test="${doc.APRV_LV ne 99}">
													            <td><c:out value="${doc.EMP_LV}"/></td>
													        </c:if>
													    </c:forEach>
													</tr>


                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="col-md-12 col-12" style="display: flex">
                                        <div class="box-header" style="display: flex" id="singleTag">
                                            <h4>
                                                참조자 
                                            </h4>
                                            &nbsp;
                                            <c:forEach var="doc" items="${docu}">
										<c:if test="${doc.APRV_LV eq 99}">
										    <c:if test="${doc.APRV_EMP eq user.empNo}">
										        	<p>
										            <c:out value="${doc.EMP_LV }"/>
										            <c:out value="${doc.EMP_NAME }"/>
										        	
										            <c:if test="${doc.APRV_SQ eq 0}"> 
										            	<button type="button" class="btn btn-primary" onclick="read();">확인</button>
										            	<input type="hidden" value="${doc.APRV_LV }" name="APRV_LV">
										            	&nbsp;
										            </c:if>
										    		
										    		<c:if test="${doc.APRV_SQ eq 1}">
										       	 		<img style="width: 7px;height: 7px;" alt="check" src="https://approval.office.hiworks.com/gabia.biz/approval/sign/approval/F/2">
										    		</c:if>
										    		<p>
										    </c:if>
										    <c:if test="${doc.APRV_EMP ne user.empNo}">
										        <p id="taget-reader">
										            &nbsp;
										            <c:out value="${doc.EMP_LV }"/>
										            <c:out value="${doc.EMP_NAME }"/>  
										 
										            <c:if test="${doc.APRV_SQ eq 1}">
										       	 		<img alt="check" src="https://approval.office.hiworks.com/gabia.biz/approval/sign/approval/F/2	">
										    		</c:if>
										    		&nbsp;   
										        </p>
										    </c:if>
										</c:if>

										</c:forEach>                                     
                                        </div>
                                    </div>
  									</div>                        
                                    <div class="box">
                                        <div class="box-header">
                                            
                                   <c:if test="${docu[0]['DOC_TAG'] eq 1}" >
                                   	
									   </div>
                                         <div class="box-body">
				                                            <table>
				            <thead>
				                <th colspan="2"><h1 style="text-align: center;">휴가신청서</h1></th>
				            </thead>
				            <tbody>
				                <tr>
				                    <td>성명</td>
				                    <td>${docu[0]['EMP_NAME']}</td>
				                </tr>
				                
                <tr>
                    <td>기간</td>
                    <td >
                    <p id="startDate"></p>
                    	<fmt:formatDate value="${docu[0]['START_DATE']}" pattern="yyyy-MM-dd"/>
                    
                    <p id="endDate"></p>
                    	<fmt:formatDate value="${docu[0]['END_DATE']}" pattern="yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
                    <td>휴가종류</td>
                    <td>${docu[0]['DOC_TITLE']}</td>
                </tr>
                <tr>
                    <td>휴가사유</td>
                    
                    <td><c:out value="${textData}"/></td>
                </tr>
                <tr style="height: 500px">
                    <td colspan="2" style="text-align: center;">상기와 같은 이유로 휴가를 신청합니다.<br><br><br><br><br><br>
                   	<fmt:formatDate value="${docu[0]['U_DATE']}" pattern="yyyy-MM-dd"/>
                   	</td> 
                </tr>
            </tbody>
        </table>
                                        </div> 
                                    </div>
									</c:if>
		<table>							
		<c:if test="${docu[0]['DOC_TAG'] eq 2}" >							
			<c:out value="${textData}" escapeXml="false"/>
  		</c:if>
  		</table> 
    
                                    
                                    
                                    
                                    
                                    
                                  
                                    
                                    
                                    
                                    
                                    
                                </div>
                            </div>
                            
                            <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none; width: 100%">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content" style="background-color: white;">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myLargeModalLabel">결재하기</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="myBtn"></button>
                        </div>
                        <div class="modal-body">
                                <h3>결재하면 수정하실수없습니다. 정말 결재하시겠습니까?</h3>
                            <div id="flex-cotainer" style="display: flex">
                                
                                <button type="button" class="btn btn-info text-start"  onclick="aprv();"> 결재 </button>
                                
                                <button type="button" class="btn btn-warning text-start"  onclick="reject();"> 반려 </button>
                                
                                <button type="button" class="btn btn-danger text-start" data-bs-dismiss="modal"> 닫기 </button>
                                
                                
                            </div>
                            
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
                        </div>
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col-->
            </div>
            <!-- ./row -->
  

   
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script>
const docNo = "${docNo}";
const empNo = "${user.empNo}";


 function aprv() {
    $.ajax({
        type: "POST",
        url: `${path}/docu/updateaprv`,
        data: {
            DOC_NO: docNo,
            EMP_NO: empNo
        },
        dataType: "text",
        success: function(response){
        	console.log(response);
        	if(response === "결재 성공") {
                alert(response);
                location.reload();
            } else {
                alert("결재 실패. 전산팀에게 문의하세요.");
                location.reload();
            }
        }


    });
}


</script>

<script>
function reject() {
	$.ajax({
        type: "POST",
        url: `${path}/docu/rejectaprv`,
        data: {
            DOC_NO: docNo,
            EMP_NO: empNo
        }, 
        dataType: "text",
        success: function(response){
        	console.log(response);
        	if(response === "반려 성공") {
                alert(response);
                location.reload();
            } else {
                alert("반려 실패. 전산팀에게 문의하세요.");
                location.reload();
            }
        }


    });
}

</script>
<script>
function read(){
	
	if(confirm("참조 확인하시겠습니까?")){
		aprv();
	}else{
		close();
	}
	
}

</script>
<script>

document.getElementById("targetbtn").addEventListener("click", function(e) {
	$.ajax({
	    type: "POST",
	    url: `${path}/docu/checkaprvlv`,
	    data: {
	        DOC_NO: docNo,
	        EMP_NO: empNo
	    },
	    dataType: "text",
	    success: function(response){
	    	console.log(response);
	    	if(response === "true") {
	    		$('.bs-example-modal-lg').modal('show');
	            
	        } else {
	        	alert('전 결재자 결재를 안했어요');
	        	e.preventDefault();
	            
	        }
	    }


	});
	 
    
});

</script>
