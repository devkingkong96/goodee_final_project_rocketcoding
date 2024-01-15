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
         <table class="table table-hover">
         	<tbody>
	         <tr>
	         	<th>문서번호</th>
	         	<th>문서제목</th>
	         	<th>문서상태</th>
	         	<th>기안일</th>
	         	<th>기안자</th>
	         	<th>구분</th>
	         </tr>
	         <c:if test="${not empty lists }">
	         <c:forEach var="l" items="${lists }">
				<tr style="cursor: pointer;" onclick="window.location.href='${path}/docu/aprv/' + ${l.DOC_NO}">
				    <td><c:out value="${l.DOC_NO }"/></td>
				    <td><c:out value="${l.DOC_TITLE }"/></td>
				    <td><c:out value="${l.DOC_STATCD }"/></td>
				    <td><c:out value="${l.U_DATE }"/></td>
				    <td><c:out value="${l.EMP_NO }"/></td>
				    <td><c:out value="${l.DOC_TAG }"/></td>
				</tr>
				</c:forEach>

	         </c:if>
         </tbody>	
         </table>
      </section>
   </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>