<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="" />
</jsp:include>
<style>
    .box-footer{
        text-align: right;
        }
</style>
<div class="content-wrapper">
   <div class="container-full">
      <!-- Main content -->
      <section class="content">
		   <!-- Main content -->
			<div class="row">			  
				<div class="col-lg-12 col-12">
					<form class="form" action="${path }/board/fboardupdate" method="post" enctype="multipart/form-data">
					  <div class="box">
						<div class="box-header with-border">
						  <h4 class="box-title">자유 게시판</h4>
						</div>
						<!-- /.box-header -->
							<div class="box-body">
								<h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i>글 수정하기</h4>
								<hr class="my-15">
								<div class="row">
								  <div class="col-md-6">
									<div class="form-group">
									  <label class="form-label">글 제목</label>
									  <input type="text" name="fboardTitle" class="form-control" placeholder="제목을 적어주세요"
									  value="${board.fboardTitle }">
									  <input type="hidden" name="fboardNo" value="${board.fboardNo }">
									</div>
								  </div>								
								</div>								
                  
								<div class="form-group">
								  <label class="form-label"></label>
								  <label class="file">
								  <c:if test="${not empty board.files and board.files.get(0).fboardFileNo!=0}">
								  		<h4>이전파일</h4>
									  	<c:forEach var="f" items="${board.files }">
									  		<span>${f.fboardFileOri }</span><br>
											<input type="hidden" name="rename" value="${f.fboardFileRe}">
											<input type="hidden" name="oriname" value="${f.fboardFileOri}">
										</c:forEach>
									</c:if>
									<input type="file" id="file" name="upfile">
								  </label>
								</div>
								<div class="form-group">
								  <label class="form-label">내용</label>
								  <textarea style="resize: none;" rows="5" class="form-control" name="fboardContent">${board.fboardContent }</textarea>
								</div>
							</div>
				              <div class="box-footer">
								<button type="submit" class="btn btn-primary">
								  <i class="ti-save-alt"></i> 수정
								</button>
								<button type="button" class="btn btn-warning me-1">
								  <i class="ti-trash"></i> 취소
								</button>
							</div>  
		</div>
		</form>
		</div>
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

<jsp:include page="/WEB-INF/views/common/footer.jsp" />