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
         <form>
         	<table class="board_view">
        <caption>상세보기</caption> 
        <tbody>
            <tr>
                <th>제목</th>
                <td></td>
                <th>조회수</th>
                <td></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td></td>
                <th>작성시간</th>
                <td>$</td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                   
                </td>
            </tr>
       	 </tbody>
       	  </table>
         </form>
      </section>
   </div>
</div>
<!-- Vendor JS -->
<script src="src/resources/js/vendors.min.js"></script>
<script src="src/resources/js/pages/chat-popup.js"></script>
<script src="src/resources/js/assets/icons/feather-icons/feather.min.js"></script>
<script src="src/resources/js/assets/vendor_components/datatable/datatables.min.js"></script>

<!-- CRMi App -->
<script src="src/resources/js/template.js"></script>

<script src="src/resources/js/pages/data-table.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>