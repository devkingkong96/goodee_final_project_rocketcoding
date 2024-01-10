<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">

   <jsp:param name="title" value=""/>
</jsp:include>
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
                            
                        </div>
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col-->
            </div>
            <!-- ./row -->
  
  
   
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>