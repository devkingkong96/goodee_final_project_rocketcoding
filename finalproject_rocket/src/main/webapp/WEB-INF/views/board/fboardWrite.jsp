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
      <form id="boardfrm">
		  <div class="board">
		        <div class="board-wite">
		            <h1>글 작성</h1>
		        </div>
		        <div class="myinfo">
		            비밀번호<input type="password" placeholder="비밀번호 를 입력하세요">
		        </div>
		        <div class="title-b">
		            제목<input type="text" placeholder="제목을 입력하세요!">
		        </div>
		        <div class="msg">
		            내용<textarea placeholder="내용을 입력하세요"></textarea>
		            <input type="file" name="" id="">
		        </div>
		        <div class="btn-w">
		            <a href="">등록</a>
		            <a href="">취소</a>
		        </div>
		    </div>
		    </form>
      </section>
   </div>
</div>
<style>
    .board-wite{
        font-size: 30px;
        font-weight: 600;
    }
    .myinfo{
        padding: 20px;
    }
    .myinfo input,textarea{
        margin-left: 10px;
        padding: 10px;
        border: 1px solid #999;
        border-radius: 10px;
        box-shadow: 3px 3px 10px #e6e6e6;
    }
    .board.myinfo input[type="text"]{
        width: 25%;
        margin-right: 50px;
    }
    .board.myinfo input[type="password"]{
        width: 31%;
    }
    .board-wite.title-b input[type="text"]{
        margin-top: 20px;
        margin-bottom: 20px;
        width: 85.5%;
       
    }
    .board-wite .msg textarea{
        min-width: 85.5%;
        min-width: 85.5%;
        min-height: 200px;
        max-height: 200px;
        box-shadow: inset 3px 3px 10px #e6e6e6;
        vertical-align: top;
    }
    .board-wite input[type="file"]{
        border: none;
        box-shadow: none;
        padding: 10px;
        margin-left: 40px;
    }
</style>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>