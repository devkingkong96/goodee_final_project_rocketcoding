<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    #content{
    	text-align: center;
    	align-items: center;
    }
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
	<%-- <img src="${path }/resources/images/500.avif" alt="에러화면" width="450" height="450"> --%>
	<div id="content">
		<h1>권한이 없거나 존재하지 않는</h1>
		<h1>페이지입니다.</h1><br>
		<p>관리자에게 문의하세요.</p><br>
		<button type="button" class="btn btn-warning" onclick="location.replace('${path}/');">메인페이지로 돌아가기</button>
	</div>
	<script>
		/* setTimeout(()=>{
			location.replace('${path}/');
		},3000) */
	</script>
</body>
</html>