<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>test</h3>
	<p>세영이가 수정함</p>
	<h3>update</h3>
	<h3>update</h3>
	<h3>update</h3>
	<h3>update</h3>
	<h3>update</h3>
	<c:if test="${not empty notices }">
		<c:forEach var="n" items="${notices }">
				<c:out value="${n.noticeTitle }"/>
				<c:out value="${n.noticeDate}"/>
		</c:forEach>
	</c:if>
	
	
</body>
</html>