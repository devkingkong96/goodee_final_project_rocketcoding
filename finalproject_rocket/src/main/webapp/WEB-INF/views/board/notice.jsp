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
       		<div class="box-body">
								<h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i>공지사항</h4>
								<hr class="my-15">
								<div class="row">
								  <div class="col-md-6">
									<div class="form-group">
									  <label class="form-label">제목</label>
									  <input type="text" class="form-control" placeholder="제목 ">
									</div>
								  </div>								
								</div>								
                  <div class="form-group">
                    <label class="form-label">비밀번호</label>
                    <div class="input-group mb-3">
                      <span class="input-group-text"><i class="ti-lock"></i></span>
                      <input type="password" class="form-control" placeholder="비밀번호">
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label">비밀번호 확인</label>
                    <div class="input-group mb-3">
                      <span class="input-group-text"><i class="ti-lock"></i></span>
                      <input type="password" class="form-control" placeholder="비밀번호 확인">
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label">웹 주소</label>
                    <input class="form-control" type="url" placeholder="http://">
                  </div>
								<div class="form-group">
								  <label class="form-label"></label>
								  <label class="file">
									<input type="file" id="file">
								  </label>
								</div>
								<div class="form-group">
								  <label class="form-label">내용</label>
								  <textarea rows="5" class="form-control" placeholder="작성해볼까요?"></textarea>
								</div>
							</div>
              <div class="box-footer">
								<button type="button" class="btn btn-warning me-1">
								  <i class="ti-trash"></i> 취소
								</button>
								<button type="submit" class="btn btn-primary">
								  <i class="ti-save-alt"></i> 등록
								</button>
							</div>  
      </section>
   </div>
</div>
	<!-- Vendor JS -->
	<script src="src/resources/js/vendors.min.js"></script>
	<script src="src/resources/js/pages/chat-popup.js"></script>
	<script
		src="src/resources/js/assets/icons/feather-icons/feather.min.js"></script>
	<script
		src="src/resources/js/assets/vendor_components/datatable/datatables.min.js"></script>

	<!-- CRMi App -->
	<script src="src/resources/js/template.js"></script>

	<script src="src/resources/js/pages/data-table.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>