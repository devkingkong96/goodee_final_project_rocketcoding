<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="title" value=""/>
</jsp:include>
 <style>
        .title-box{
        	 font-size: 24px;
			  margin: 25px;
			  width: 100%;
			  height: 85px;
			  display: flex;
			  justify-content:center;
        	 
        }
        .emp-box{
        	display:flex;
        	padding-right:5%;
        	justify-content:end;
        }
		#info__f {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 20px; /* 댓글 공간 아래 여백 */
		  }
		
		  #info__f input[type="text"] {
		    flex-grow: 1; /* 입력 필드가 가능한 많은 공간을 차지하도록 함 */
		    margin-right: 10px; /* 버튼과의 간격 */
		    padding: 10px; /* 입력 필드 안쪽 여백 */
		    border: 1px solid #ccc; /* 경계선 스타일 */
		    border-radius: 4px; /* 모서리 둥글게 */
		  }
		
		  #info__f button {
		    padding: 10px 20px; /* 버튼 안쪽 여백 */
		    border: none; /* 기본 경계선 제거 */
		    background-color: #7047ee; /* 배경색 */
		    color: white; /* 글자색 */
		    border-radius: 4px; /* 모서리 둥글게 */
		    cursor: pointer; /* 마우스 오버 시 커서 변경 */
		    margin-left: 5px; /* 버튼 사이의 간격 */ 
		  }
		
		  #info__f button:hover {
		    background-color: #7047ee; /* 호버 시 배경색 변경 */
		  }
		 .right-box{
		 	float: left;
		 }
		 .right-box {
		 	float: right;
		 }
		 #info__ff{
	 	    display: flex;
   			justify-content: center;
		 }
		 #info_fx{
		 	display: flex;
   			justify-content: center;
		 }

 </style>
<div class="content-wrapper">
   <div class="container-full">
      <!-- Main content -->
    	<section class="content">
    		<div class="row">		
				<div class="col-lg-12 col-12">
				<div class="box">
					<div class="box-header with-border">
					    <h3 class="box-title">자유 게시판</h3>
    					<hr color="black" size="7">
    					<h4 class="left-box">${fboard.fboardDate }</h4>
    					<h4 class="right-box">작성자: ${fboard.empNo } 추천:${fboard.fboardViews }</h4>
    					<input class="btn btn-outline-primary" type="button" value="목록" onclick="location.href='/board/fboardlist.do'">
						<input class="btn btn-outline-danger delete_btn" type="button" value="삭제" onclick="fboardDelete(${fboard.fboardNo})">
						<input class="btn btn-outline-warning edit_btn" type="button" value="수정" onclick="fboardEdit(${fboard.fboardNo})">

				</div>
				<div class="title-box">
					<h3>${fboard.fboardTitle}</h3>
				</div>
				<div class="emp-box">
					<h4></h4>
				</div>
				<div id="info__ff">
					<c:if test="${not empty fboard.files and fboard.files.get(0).fboardFileNo!=0}">
						<c:forEach var="f" items="${fboard.files }">
							<img alt="경로에 이미지가 없습니다." src="${path }/resources/upload/fboard/${f.fboardFileRe}" width="650"><br>
						</c:forEach>
					</c:if>
				</div>
				<div id="info_fx" style="font-size:200%">
					내용:${fboard.fboardContent }
				</div>
				<form method="post" id="fboardcomment" action="/board/comment/insertComment.do">
					<hr color="black" size="5">
					<h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i>댓글
					</h4>
					<div class="box-footer no-border">
						 <div class="d-md-flex d-block justify-content-between align-items-center bg-white p-5 rounded10 b-1 overflow-hidden">
						 		<input type="hidden" name="fboardNo" value="${fboard.fboardNo}"/>
						 		<input type="hidden" name="regr_id" value="${loginEmp.empNo }"/>
								<input class="form-control b-0 py-10" type="text" name="content" placeholder="댓글을 달아주세요">
								<div class="d-flex justify-content-between align-items-center mt-md-0 mt-30">
									<button type="submit" class="btn btn-primary">
										<i class="mdi mdi-send"></i>
									</button>
								</div>
							</div>
					 </div>
				</form>
					<div id="info__f">
						
					</div>  
					  <!--댓글 내용 부분   -->
						<div class="row">
									<div class="col-lg-12">
										<div class="box">
											<div class="box-body">
												<div class="table-responsive">
													<table class="table">
														<thead class="bg-primary">
														<tbody>
														<c:choose>
															<c:when test="${fboard.comments.get(0).commentNo!=0 }">
																<c:forEach var="comment" items="${fboard.comments }">
																	<tr>
																		<td colspan="4">
																			<sup>${comment.fbdCommentDate }
																			${comment.writer.empName }</sup><br>
																			 <h3 style="display:inline-block;margin-left:20%">${comment.fbdComment }</h3>
																		</td>
																		
																		<td style="text-align:right">
																			<c:if test="${comment.writer.empNo eq loginEmp.empNo}">
																				<button class="btn btn-outline-warning" onclick="updateComment">수정</button>
																				<button class="btn btn-outline-danger">삭제</button>
																			</c:if>
																		</td>
																	</tr>
																</c:forEach>
															</c:when>
			 														
															<c:otherwise>
																<tr>
																	<td colspan="4">작성된 댓글이 없습니다.</td>
																</tr>
															</c:otherwise>
														</c:choose>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
				</div>
       		</div>
       	</div>
   	 </section>
	</div>
</div>
<script>
function fboardDelete(fboardNo) {
    if(confirm('게시글을 삭제하시겠습니까?')) {
        var form = document.createElement('form');
        form.setAttribute('method', 'post');
        form.setAttribute('action', '/board/fboarddelete');
        form.innerHTML = '<input type="hidden" name="fboardNo" value="' + fboardNo + '">';
        document.body.appendChild(form);
        form.submit();
    }
}
function fboardEdit(fboardNo){
	var form = document.createElement('form');
    form.setAttribute('method', 'get');
    form.setAttribute('action', '/board/fboardupdate');
    form.innerHTML = '<input type="hidden" name="fboardNo" value="' + fboardNo + '">';
    document.body.appendChild(form);
    form.submit();
}

function updateComment(commentNo, fboardNo) {
    var fboardNo = $('#fboardNo').val();
    console.log("수정로그-fboardNo 확인: " + $('#fboardNo').val());
    var commentNo = $('#commentNo').val();
    console.log("수정로그-commentNo 확인: " + $('#commentNo').val());
    var updateContent = $('#updateContent' + commentNo).val();

    if(updateContent =='') {
        alert("수정 할 내용을 입력하세요");
        return;
    } 

    $.ajax({
        type:'post',
        url: '/stationery/CommentUpdate',
        data: JSON.stringify(
            {
                "fbdComment": updateContent,
                "commentNo": commentNo,
                "fboardNo": fboardNo
            }
        ),
        contentType:'application/json',
        success:function(data){
            if(data ==='UpdateSuccess') {
                alert('댓글이 수정되었습니다!');
                getCommentList();
            } else {
                alert('댓글 수정에 실패했습니다.');
            }
        },
        error:function() {
            alert('통신실패');
        }
    });   
};

</script>
<!-- Vendor JS -->
<script src="src/resources/js/vendors.min.js"></script>
<script src="src/resources/js/pages/chat-popup.js"></script>
<script src="src/resources/js/assets/icons/feather-icons/feather.min.js"></script>
<script src="src/resources/js/assets/vendor_components/datatable/datatables.min.js"></script>

<!-- CRMi App -->
<script src="src/resources/js/template.js"></script>

<script src="src/resources/js/pages/data-table.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>