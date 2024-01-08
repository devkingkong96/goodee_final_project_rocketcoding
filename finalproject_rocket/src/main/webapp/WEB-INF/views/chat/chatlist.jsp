<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<title>채팅방 목록</title>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="채팅방 목록" value=""/>
</jsp:include>
<!-- Content Wrapper. Contains page content -->
<%-- <form action="${path }/chat/room" method="post"> --%>
<form id="createRoom">
  <div class="content-wrapper">
	  <div class="container-full">
		<!-- Main content -->
		<section class="content">
			<div class="row">
				<div class="col-lg-4 col-4">
					<div class="box">
						<div class="box-header">
							<span class="fs-20">채팅방 목록</span>
						</div>
						<div class="box-body">
							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane active" id="messages" role="tabpanel">
									<div class="chat-box-one-side3">
										<div class="media-list media-list-hover">
											<c:if test="${not empty chatlist }">
											<c:forEach var="c" items="${chatlist }">
											<div class="media">
											  <p class="align-self-center me-0"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/2.jpg" alt="..."></p>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="${path }/chat/room/${c.CHATROOM_NO}"><strong><c:out value="${c.CHATROOM_NAME }"/></strong></a>
												  <span class="float-end fs-10"><fmt:formatDate value="${c.CREATED_AT }" pattern="yyyy.MM.dd" /></span>
												</p>
												<p>참여 인원 수 : <c:out value="${c.EMP_COUNT }"/></p>
											  </div>
											  <button type="button" class="btn btn-danger btn-sm" id="chatRoomDelete">채팅방 삭제</button>
											</div>
											</c:forEach>
											</c:if>
											
											</div>
											
										</div>
									</div>
								</div>
								
								
								
							</div>
						</div>
						
					</div>
				
                    <div class="col-lg-4 col-4">
                        <div class="box">
                            <div class="box-header">
                            	<div class="row">
								<div class="col-lg-6 col-6">
									<span class="fs-20">직원 목록</span>
								</div>
								<div class="col-lg-6 col-6 ">
									<button type="button" class="btn btn-primary float-end" id="chatRoomCreate"  data-bs-toggle="modal" data-bs-target="#modal-default">채팅방 생성</button>
								</div>
								</div>
                            </div>
                            <div class="box-body">
                            
                                    <div class="tab-pane" id="contacts" role="tabpanel">	
                                        <div class="chat-box-one-side3">
                                            <div class="media-list media-list-hover">
                                            	<c:if test="${not empty emplist }">
												<c:forEach var="e" items="${emplist }">
                                                <div class="media py-10 px-0 align-items-center">
                                                  <p class="avatar avatar-lg status-success">
                                                    <img src="${path}/resources/images/avatar/1.jpg" alt="...">
                                                  </p>
                                                  <div class="media-body">
                                                    <p class="fs-20" id="chatEmpName">
                                                      <c:out value="${e.EMP_NAME }"/>
                                                    </p>
                                                    <p id="chatEmpLv"><c:out value="${e.EMP_LV }"/></p>
                                                  </div>
                                                  
                                                  	<input type="checkbox" id="${e.EMP_NO }" class="filled-in chk-col-primary" name="empCheck" value="${e.EMP_NO}"/>
													<label for="${e.EMP_NO }"> </label>
                                                  
                                                </div>
                                                </c:forEach>
                                                </c:if>
                                              </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
				
			</div>
		</section>
		<!-- /.content -->
	  </div>
  </div>
  <!-- /.content-wrapper -->
<!-- modal Area -->              
  <div class="modal fade" id="modal-default">
	  <div class="modal-dialog" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<h4 class="modal-title" ><strong>채팅방 생성하기</strong></h4>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div class="modal-body">
		  	<table class="table table-striped-columns">
				<tr>
					<td>채팅방 이름</td>
					<td><input type="text" id="roomName" name="roomName"/></td>
				</tr>
				<!-- <tr>
					<td>채팅방 인원수</td>
					<td><input type="text" id="count" name="count"/></td>
				</tr>  -->
			</table>
		  </div>
		  <div class="modal-footer">
			<button type="button" id="createBtn" class="btn btn-info float-end">생성</button>
			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		  </div>
		</div>
		<!-- /.modal-content -->
	  </div>
	  <!-- /.modal-dialog -->
  </div>
</form>
  <!-- /.modal -->

<script>
	document.getElementById('createBtn').addEventListener('click',function(){
		$.ajax({
			type:"POST",
			url:"${path}/chat/room",
			data:$("#createRoom").serialize(),
			dataType:"json",
			success:function(){
				alert("채팅방 생성 성공");
				location.reload();
			},
			error:function(){
				alert("채팅방 생성 실패");
				location.reload();
			}
		});
	})
	
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>