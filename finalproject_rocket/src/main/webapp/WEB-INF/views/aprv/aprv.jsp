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
                            <h3>결재문서</h3>
                            <div class="row">
                                <div class="col-md-12 col-12">
											<div class="table table-bordered mb-0">
                                                <table style="border: 1px solid black; " id="aprvtable" >
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
														            <td>
														                <img src="https://approval.office.hiworks.com/gabia.biz/approval/sign/approval/A/2/87786" 
														                    style="width: 100%; height: 100%"
														                    alt="아이콘">
														            </td>
														        </c:if>
														        <c:if test="${doc.APRV_SQ == 0}">
														            <td id="APRV_EMP">
														                <c:if test="${doc.APRV_EMP eq user.empNo}">
														                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target=".bs-example-modal-lg">
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
                                        <div class="box-header" style="display: flex">
                                        <div class="box-header" style="display: flex" id="singleTag">
                                            <h4>
                                                참조자 :
                                            </h4>
                                            &nbsp;
                                            <p id="taget-reader"></p>
                                        </div>
                                    </div>
  									</div>
                                    <div class="box">
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
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-primary" id="submitAll">제출하기</button>
                            <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none; width: 100%">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content" style="background-color: white;">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myLargeModalLabel">결재선 설정</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="myBtn"></button>
                        </div>
                        <div class="modal-body">
                            <div id="flex-cotainer" style="display: flex">
                                
                                <button type="button" class="btn btn-danger text-start"  onclick="aprv();"> 결재 </button>
                                
                                <button type="button" class="btn btn-danger text-start" data-bs-dismiss="modal"> 반려 </button>
                                
                                
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
  type : "POST",
  url  : `${path}/docu/updateaprv`,
  data : {
   	DOC_NO: docNo,
	EMP_NO: empNo
	
  },
  dataType: "json",
  success : function(){
    alert("성공했네?!");
  }
});
} 
</script>


