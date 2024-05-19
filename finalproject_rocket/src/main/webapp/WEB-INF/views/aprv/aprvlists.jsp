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
				    <td>
				    <c:if test="${l.DOC_TAG eq 1}">
				    	<c:out value="${l.EMP_NAME }"/>님의 휴가신청입니다
				    </c:if>
				    [<c:out value="${l.DOC_TITLE }"/>]
				    </td>
				    <td>
				    <c:if test="${l.DOC_STATCD eq 0}">
				    	결재중
				    </c:if>
				    <c:if test="${l.DOC_STATCD eq 1}">
				    	결재완료
				    </c:if>
				    <c:if test="${l.DOC_STATCD eq -1}">
				    	반려
				    </c:if>
				    <c:if test="${l.DOC_STATCD eq  2}">
				    	임시저장
				    </c:if>
				    </td>
				    <td><fmt:formatDate value="${l.U_DATE }" pattern="yyyy-MM-dd"/></td>
				    
				    <td><c:out value="${l.EMP_NAME }"/></td>
				    
				    <td>
				    <c:if test="${l.DOC_TAG eq 1}">
				    	휴가신청
				    </c:if>
				    <c:if test="${l.DOC_TAG eq 2}">
				    	입출고요청
				    </c:if>
				    </td>
				</tr>
				</c:forEach>

	         </c:if>
         </tbody>	
         </table>
      </section>
   </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>