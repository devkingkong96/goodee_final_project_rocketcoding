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
      <!-- Main content -->
      <section class="content">
         <body class="hold-transition light-skin sidebar-mini theme-primary fixed">
    <div class="col-12">
         <div class="box">
               <div class="box-header with-border">
                 <h3 class="box-title">자유 게시판</h3>
                 <hr color="black" size="7">
               </div>
               <!-- /.box-header -->
               <div class="box-body">
                   <div class="table-responsive">
                     <table id="example1" class="table table-bordered table-striped">
                       <thead>
                           <tr>
                               <th>번호</th>
                               <th>제목</th>
                               <th>작성자</th>
                               <th>조회수</th>
                               <th>작성일</th>
                             
                           </tr>
                       </thead>
                       <tbody>
                           <tr>
                               <td>Tiger Nixon</td>
                               <td>System Architect</td>
                               <td>Edinburgh</td>
                               <td>61</td>
                               <td>2011/04/25</td>
                          
                           </tr>
                       </tbody>
                  
                     </table>
                   </div>
               </div>
             </div>
  	</div>
 </body>
      </section>
   </div>
</div>
	<!-- Page Content overlay -->
	
	
	<!-- Vendor JS -->
	<script src="../src/js/vendors.min.js"></script>
	<script src="../src/js/pages/chat-popup.js"></script>
    <script src="../../../assets/icons/feather-icons/feather.min.js"></script>	
	<script src="../../../assets/vendor_components/datatable/datatables.min.js"></script>
	
	<!-- CRMi App -->
	<script src="../src/js/template.js"></script>
	
	<script src="../src/js/pages/data-table.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>