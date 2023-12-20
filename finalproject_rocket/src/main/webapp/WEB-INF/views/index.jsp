<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="메인화면" value=""/>
</jsp:include>
<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
	  <div class="container-full">
		<!-- Main content -->
		<section class="content">
			<div class="row">
				<div class="col-lg-3 col-12">
					<div class="box">
						<div class="box-header">
							<ul class="nav nav-tabs customtab nav-justified" role="tablist">
								<li class="nav-item"> <a class="nav-link active" data-bs-toggle="tab" href="#messages" role="tab">Chat </a> </li>
								<li class="nav-item"> <a class="nav-link" data-bs-toggle="tab" href="#contacts" role="tab">New</a> </li>
							</ul>
						</div>
						<div class="box-body">
							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane active" id="messages" role="tabpanel">
									<div class="chat-box-one-side3">
										<div class="media-list media-list-hover">
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/2.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Mical Clark</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>

											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/3.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Colin Nathan</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/4.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Nathan Johen</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/5.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Semi Doe</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/6.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Mical</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/7.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Johen Doe</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/2.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Nathan</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/2.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Mical Clark</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>

											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/3.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Colin Nathan</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/4.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Nathan Johen</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/5.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Semi Doe</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/6.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Mical</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/7.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Johen Doe</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
											
											<div class="media">
											  <a class="align-self-center me-0" href="#"><img class="avatar avatar-lg" src="${path}/resources/images/avatar/2.jpg" alt="..."></a>
											  <div class="media-body">
												<p>
												  <a class="hover-primary" href="#"><strong>Nathan</strong></a>
												  <span class="float-end fs-10">10:00pm</span>
												</p>
												<p>Nullam facilisis velit.</p>
											  </div>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane" id="contacts" role="tabpanel">	
									<div class="chat-box-one-side3">
										<div class="media-list media-list-hover">
											<div class="media py-10 px-0 align-items-center">
											  <a class="avatar avatar-lg status-success" href="#">
												<img src="${path}/resources/images/avatar/1.jpg" alt="...">
											  </a>
											  <div class="media-body">
												<p class="fs-16">
												  <a class="hover-primary" href="#">Sarah Kortney</a>
												</p>
											  </div>
											</div>

											<div class="media py-10 px-0 align-items-center">
											  <a class="avatar avatar-lg status-danger" href="#">
												<img src="${path}/resources/images/avatar/2.jpg" alt="...">
											  </a>
											  <div class="media-body">
												<p class="fs-16">
												  <a class="hover-primary" href="#">Tommy Nash</a>
												</p>
											  </div>
											</div>

											<div class="media py-10 px-0 align-items-center">
											  <a class="avatar avatar-lg status-warning" href="#">
												<img src="${path}/resources/images/avatar/3.jpg" alt="...">
											  </a>
											  <div class="media-body">
												<p class="fs-16">
												  <a class="hover-primary" href="#">Kathryn Mengel</a>
												</p>
											  </div>
											</div>

											<div class="media py-10 px-0 align-items-center">
											  <a class="avatar avatar-lg status-primary" href="#">
												<img src="${path}/resources/images/avatar/4.jpg" alt="...">
											  </a>
											  <div class="media-body">
												<p class="fs-16">
												  <a class="hover-primary" href="#">Mayra Sibley</a>
												</p>
											  </div>
											</div>			

											<div class="media py-10 px-0 align-items-center">
											  <a class="avatar avatar-lg status-success" href="#">
												<img src="${path}/resources/images/avatar/1.jpg" alt="...">
											  </a>
											  <div class="media-body">
												<p class="fs-16">
												  <a class="hover-primary" href="#">Tommy Nash</a>
												</p>
											  </div>
											</div>

											<div class="media py-10 px-0 align-items-center">
											  <a class="avatar avatar-lg status-danger" href="#">
												<img src="${path}/resources/images/avatar/2.jpg" alt="...">
											  </a>
											  <div class="media-body">
												<p class="fs-16">
												  <a class="hover-primary" href="#">Williemae Lagasse</a>
												</p>
											  </div>
											</div>
										  </div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-9 col-12">
					<div class="row">
						<div class="col-xxxl-8 col-lg-12 col-12">
							<div class="box">
							  <div class="box-header">
								<div class="media align-items-top p-0">
								  <a class="avatar avatar-lg status-success mx-0" href="#">
									<img src="${path}/resources/images/avatar/2.jpg" class="rounded-circle" alt="...">
								  </a>
									<div class="d-lg-flex d-block justify-content-between align-items-center w-p100">
										<div class="media-body mb-lg-0 mb-20">
											<p class="fs-16">
											  <a class="hover-primary" href="#"><strong>Theron Trump</strong></a>
											</p>
											  <p class="fs-12">Last Seen 10:30pm ago</p>
										</div>
										<div>
											<ul class="list-inline mb-0 fs-18">
												<li class="list-inline-item"><a href="#" class="hover-primary"><i class="fa fa-phone"></i></a></li>
												<li class="list-inline-item"><a href="#" class="hover-primary"><i class="fa fa-video-camera"></i></a></li>
												<li class="list-inline-item"><a href="#" class="hover-primary"><i class="fa fa-ellipsis-h"></i></a></li>
											</ul>
										</div>
									</div>				  
								</div>             
							  </div>
							  <div class="box-body">
								  <div class="chat-box-one2">
									  <div class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small text-muted">09:25</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<a class="d-flex" href="#">
													<img alt="Profile" src="${path}/resources/images/avatar/1.jpg" class="avatar me-10">
												</a>
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16 text-dark">Sarah Kortney</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">What do you think about our plans for this product launch?</p>
											</div>
										</div>
									  </div>
									  <div class="clearfix"></div>
									  <div class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small text-muted">09:28</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<a class="d-flex" href="#">
													<img alt="Profile" src="${path}/resources/images/avatar/1.jpg" class="avatar me-10">
												</a>
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16 text-dark">Sarah Kortney</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">It looks to me like you have a lot planned before your deadline. I would suggest you push your deadline back so you have time to run a successful advertising campaign.</p>
											</div>
										</div>
									  </div>							  
									  <div class="clearfix"></div>
									  <div class="card d-inline-block mb-3 float-end me-2 bg-primary max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small">09:41</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<a class="d-flex" href="#">
													<img alt="Profile" src="${path}/resources/images/avatar/2.jpg" class="avatar me-10">
												</a>
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16">Mimi Carreira</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">I would suggest you discuss this further with the advertising team.</p>
											</div>
										</div>
									  </div>
									  <div class="clearfix"></div>
									  <div class="card d-inline-block mb-3 float-end me-2 bg-primary max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small">09:41</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<a class="d-flex" href="#">
													<img alt="Profile" src="${path}/resources/images/avatar/2.jpg" class="avatar me-10">
												</a>
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16">Mimi Carreira</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">I am very busy at the moment and on top of everything, I forgot my umbrella today.</p>
											</div>
										</div>
									  </div>
									  <div class="clearfix"></div>
									  <div class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small text-muted">09:25</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<a class="d-flex" href="#">
													<img alt="Profile" src="${path}/resources/images/avatar/1.jpg" class="avatar me-10">
												</a>
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16 text-dark">Sarah Kortney</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">What do you think about our plans for this product launch?</p>
											</div>
										</div>
									  </div>
									  <div class="clearfix"></div>
									  <div class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small text-muted">09:28</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<a class="d-flex" href="#">
													<img alt="Profile" src="${path}/resources/images/avatar/1.jpg" class="avatar me-10">
												</a>
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16 text-dark">Sarah Kortney</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">It looks to me like you have a lot planned before your deadline. I would suggest you push your deadline back so you have time to run a successful advertising campaign.</p>
											</div>
										</div>
									  </div>
									  <div class="clearfix"></div>
									  <div class="card d-inline-block mb-3 float-end me-2 bg-primary max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small">09:41</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<a class="d-flex" href="#">
													<img alt="Profile" src="${path}/resources/images/avatar/2.jpg" class="avatar me-10">
												</a>
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16">Mimi Carreira</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">I would suggest you discuss this further with the advertising team.</p>
											</div>
										</div>
									  </div>
									  <div class="clearfix"></div>
									  <div class="card d-inline-block mb-3 float-end me-2 bg-primary max-w-p80">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small">09:41</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<a class="d-flex" href="#">
													<img alt="Profile" src="${path}/resources/images/avatar/2.jpg" class="avatar me-10">
												</a>
												<div class="d-flex flex-grow-1 min-width-zero">
													<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16">Mimi Carreira</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">I am very busy at the moment and on top of everything, I forgot my umbrella today.</p>
											</div>
										</div>
									  </div>
								  </div>
							  </div>
							  <div class="box-footer no-border">
								 <div class="d-md-flex d-block justify-content-between align-items-center bg-white p-5 rounded10 b-1 overflow-hidden">
										<input class="form-control b-0 py-10" type="text" placeholder="Say something...">
										<div class="d-flex justify-content-between align-items-center mt-md-0 mt-30">
											<button type="button" class="waves-effect waves-circle btn btn-circle me-10 btn-outline-secondary">
												<i class="mdi mdi-link"></i>
											</button>
											<button type="button" class="waves-effect waves-circle btn btn-circle me-10 btn-outline-secondary">
												<i class="mdi mdi-face"></i>
											</button>
											<button type="button" class="waves-effect waves-circle btn btn-circle me-10 btn-outline-secondary">
												<i class="mdi mdi-microphone"></i>
											</button>
											<button type="button" class="waves-effect waves-circle btn btn-circle btn-primary">
												<i class="mdi mdi-send"></i>
											</button>
										</div>
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
  
  <!-- Side panel --> 
  <!-- quick_actions_toggle -->
  <div class="modal modal-right fade" id="quick_actions_toggle" tabindex="-1">
	  <div class="modal-dialog">
		<div class="modal-content slim-scroll">
		  <div class="modal-body bg-white p-30">
			<div class="d-flex align-items-center justify-content-between pb-30">
				<h4 class="m-0">Quick Actions<br>
				<small class="badge fs-12 badge-primary mt-10">23 tasks pending</small></h4>
				<a href="#" class="btn btn-icon btn-danger-light btn-sm no-shadow" data-bs-dismiss="modal">
					<span class="fa fa-close"></span>
				</a>
			</div>
            <div class="row">
                <div class="col-6">
                    <a class="waves-effect waves-light btn btn-app btn btn-primary-light btn-flat mx-0 mb-20 no-shadow py-35 h-auto d-block" href="accounting.html">
                        <i class="icon-Euro fs-36"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fs-16">Accounting</span>
                    </a>
                </div>
                <div class="col-6">
                    <a class="waves-effect waves-light btn btn-app btn btn-primary-light btn-flat mx-0 mb-20 no-shadow py-35 h-auto d-block" href="contact_userlist_grid.html">
                        <i class="icon-Mail-attachment fs-36"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fs-16">Members</span>
                    </a>
                </div>
                <div class="col-6">
                    <a class="waves-effect waves-light btn btn-app btn btn-primary-light btn-flat mx-0 mb-20 no-shadow py-35 h-auto d-block" href="projects.html">
                        <i class="icon-Box2 fs-36"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fs-16">Projects</span>
                    </a>
                </div>
                <div class="col-6">
                    <a class="waves-effect waves-light btn btn-app btn btn-primary-light btn-flat mx-0 mb-20 no-shadow py-35 h-auto d-block" href="contact_userlist.html">
                        <i class="icon-Group fs-36"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fs-16">Customers</span>
                    </a>
                </div>
                <div class="col-6">
                    <a class="waves-effect waves-light btn btn-app btn btn-primary-light btn-flat mx-0 mb-20 no-shadow py-35 h-auto d-block" href="mailbox.html">
                        <i class="icon-Chart-bar fs-36"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
                        <span class="fs-16">Email</span>
                    </a>
                </div>
                <div class="col-6">
                    <a class="waves-effect waves-light btn btn-app btn btn-primary-light btn-flat mx-0 mb-20 no-shadow py-35 h-auto d-block" href="setting.html">
                        <i class="icon-Color-profile fs-36"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fs-16">Settings</span>
                    </a>
                </div>
                <div class="col-6">
                    <a class="waves-effect waves-light btn btn-app btn btn-primary-light btn-flat mx-0 mb-20 no-shadow py-35 h-auto d-block" href="ecommerce_orders.html">
                        <i class="icon-Euro fs-36"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fs-18">Orders</span>
                    </a>
                </div>
			</div>
		  </div>
		</div>
	  </div>
  </div>
  <!-- /quick_actions_toggle -->    
    
  <!-- quick_panel_toggle -->
  <div class="modal modal-right fade" id="quick_panel_toggle" tabindex="-1">
	  <div class="modal-dialog">
		<div class="modal-content slim-scroll2">
		  <div class="modal-body bg-white py-20 px-0">
			<div class="d-flex align-items-center justify-content-between pb-30">
				<ul class="nav nav-tabs customtab3 px-30" role="tablist">
					<li class="nav-item">
						<a class="nav-link active" data-bs-toggle="tab" href="#quick_panel_logs">Audit Logs</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#quick_panel_notifications">Notifications</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="tab" href="#quick_panel_settings">Settings</a>
					</li>
				</ul>
                <div class="offcanvas-close">
                    <a href="#" class="btn btn-icon btn-danger-light btn-sm no-shadow" data-bs-dismiss="modal">
						<span class="fa fa-close"></span>
					</a>
                </div>
			</div>
              <div class="px-30">
                <div class="tab-content">
                    <div class="tab-pane active" id="quick_panel_logs" role="tabpanel">
                        <div class="mb-30">
                            <h5 class="fw-500 mb-15">System Messages</h5>
                            <div class="d-flex align-items-center mb-30">
                                <div class="me-15 bg-lightest h-50 w-50 l-h-50 rounded text-center">
                                      <img src="${path}/resources/images/svg-icon/color-svg/001-glass.svg" class="h-30" alt="">
                                </div>
                                <div class="d-flex flex-column flex-grow-1 me-2 fw-500">
                                    <a href="#" class="text-dark hover-primary mb-1 fs-16">Duis faucibus lorem</a>
                                    <span class="text-fade">Pharetra, Nulla</span>
                                </div>
                                <span class="badge badge-xl badge-light"><span class="fw-600">+125$</span></span>
                            </div>
                            <div class="d-flex align-items-center mb-30">
                                <div class="me-15 bg-lightest h-50 w-50 l-h-50 rounded text-center">
                                      <img src="${path}/resources/images/svg-icon/color-svg/002-google.svg" class="h-30" alt="">
                                </div>
                                <div class="d-flex flex-column flex-grow-1 me-2 fw-500">
                                    <a href="#" class="text-dark hover-danger mb-1 fs-16">Mauris varius augue</a>
                                    <span class="text-fade">Pharetra, Nulla</span>
                                </div>
                                <span class="badge badge-xl badge-light"><span class="fw-600">+125$</span></span>
                            </div>
                            <div class="d-flex align-items-center mb-30">
                                <div class="me-15 bg-lightest h-50 w-50 l-h-50 rounded text-center">
                                      <img src="${path}/resources/images/svg-icon/color-svg/003-settings.svg" class="h-30" alt="">
                                </div>
                                <div class="d-flex flex-column flex-grow-1 me-2 fw-500">
                                    <a href="#" class="text-dark hover-success mb-1 fs-16">Aliquam in magna</a>
                                    <span class="text-fade">Pharetra, Nulla</span>
                                </div>
                                <span class="badge badge-xl badge-light"><span class="fw-600">+125$</span></span>
                            </div>
                            <div class="d-flex align-items-center mb-30">
                                <div class="me-15 bg-lightest h-50 w-50 l-h-50 rounded text-center">
                                      <img src="${path}/resources/images/svg-icon/color-svg/004-dad.svg" class="h-30" alt="">
                                </div>
                                <div class="d-flex flex-column flex-grow-1 me-2 fw-500">
                                    <a href="#" class="text-dark hover-info mb-1 fs-16">Phasellus venenatis nisi</a>
                                    <span class="text-fade">Pharetra, Nulla</span>
                                </div>
                                <span class="badge badge-xl badge-light"><span class="fw-600">+125$</span></span>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="me-15 bg-lightest h-50 w-50 l-h-50 rounded text-center">
                                      <img src="${path}/resources/images/svg-icon/color-svg/005-paint-palette.svg" class="h-30" alt="">
                                </div>
                                <div class="d-flex flex-column flex-grow-1 me-2 fw-500">
                                    <a href="#" class="text-dark hover-warning mb-1 fs-16">Vivamus consectetur</a>
                                    <span class="text-fade">Pharetra, Nulla</span>
                                </div>
                                <span class="badge badge-xl badge-light"><span class="fw-600">+125$</span></span>
                            </div>
                        </div>
                        <div class="mb-30">
                            <h5 class="fw-500 mb-15">Tasks Overview</h5>
                            <div class="d-flex align-items-center mb-30">
                                <div class="me-15 bg-primary-light h-50 w-50 l-h-60 rounded text-center">
                                      <span class="icon-Library fs-24"><span class="path1"></span><span class="path2"></span></span>
                                </div>
                                <div class="d-flex flex-column fw-500">
                                    <a href="#" class="text-dark hover-primary mb-1 fs-16">Project Briefing</a>
                                    <span class="text-fade">Project Manager</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-30">
                                <div class="me-15 bg-danger-light h-50 w-50 l-h-60 rounded text-center">
                                    <span class="icon-Write fs-24"><span class="path1"></span><span class="path2"></span></span>
                                </div>
                                <div class="d-flex flex-column fw-500">
                                    <a href="#" class="text-dark hover-danger mb-1 fs-16">Concept Design</a>
                                    <span class="text-fade">Art Director</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-30">
                                <div class="me-15 bg-success-light h-50 w-50 l-h-60 rounded text-center">
                                    <span class="icon-Group-chat fs-24"><span class="path1"></span><span class="path2"></span></span>
                                </div>
                                <div class="d-flex flex-column fw-500">
                                    <a href="#" class="text-dark hover-success mb-1 fs-16">Functional Logics</a>
                                    <span class="text-fade">Lead Developer</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-30">
                                <div class="me-15 bg-info-light h-50 w-50 l-h-60 rounded text-center">
                                    <span class="icon-Attachment1 fs-24"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></span>
                                </div>
                                <div class="d-flex flex-column fw-500">
                                    <a href="#" class="text-dark hover-info mb-1 fs-16">Development</a>
                                    <span class="text-fade">DevOps</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="me-15 bg-warning-light h-50 w-50 l-h-60 rounded text-center">
                                    <span class="icon-Shield-user fs-24"></span>
                                </div>
                                <div class="d-flex flex-column fw-500">
                                    <a href="#" class="text-dark hover-warning mb-1 fs-16">Testing</a>
                                    <span class="text-fade">QA Managers</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="quick_panel_notifications" role="tabpanel">
                        <div>
                            <div class="media-list">
                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">10:10</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-primary">
                                    <p>Morbi quis ex eu arcu auctor sagittis.</p>
                                    <span class="text-fade">by Johne</span>
                                  </div>
                                </a>

                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">08:40</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-success">
                                    <p>Proin iaculis eros non odio ornare efficitur.</p>
                                    <span class="text-fade">by Amla</span>
                                  </div>
                                </a>

                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">07:10</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-info">
                                    <p>In mattis mi ut posuere consectetur.</p>
                                    <span class="text-fade">by Josef</span>
                                  </div>
                                </a>

                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">01:15</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-danger">
                                    <p>Morbi quis ex eu arcu auctor sagittis.</p>
                                    <span class="text-fade">by Rima</span>
                                  </div>
                                </a>

                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">23:12</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-warning">
                                    <p>Morbi quis ex eu arcu auctor sagittis.</p>
                                    <span class="text-fade">by Alaxa</span>
                                  </div>
                                </a>
                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">10:10</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-primary">
                                    <p>Morbi quis ex eu arcu auctor sagittis.</p>
                                    <span class="text-fade">by Johne</span>
                                  </div>
                                </a>

                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">08:40</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-success">
                                    <p>Proin iaculis eros non odio ornare efficitur.</p>
                                    <span class="text-fade">by Amla</span>
                                  </div>
                                </a>

                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">07:10</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-info">
                                    <p>In mattis mi ut posuere consectetur.</p>
                                    <span class="text-fade">by Josef</span>
                                  </div>
                                </a>

                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">01:15</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-danger">
                                    <p>Morbi quis ex eu arcu auctor sagittis.</p>
                                    <span class="text-fade">by Rima</span>
                                  </div>
                                </a>

                                <a class="media media-single px-0" href="#">
                                  <h4 class="w-50 text-gray fw-500">23:12</h4>
                                  <div class="media-body ps-15 bs-5 rounded border-warning">
                                    <p>Morbi quis ex eu arcu auctor sagittis.</p>
                                    <span class="text-fade">by Alaxa</span>
                                  </div>
                                </a>
                              </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="quick_panel_settings" role="tabpanel">
                        <div>
                            <form class="form">
							<!--begin::Section-->
							<div>
								<h5 class="fw-500 mb-15">Customer Care</h5>
								<div class="form-group mb-0 row align-items-center">
									<label class="col-8 col-form-label">Enable Notifications:</label>
									<div class="col-4 d-flex justify-content-end">
                                        <button type="button" class="btn btn-sm btn-toggle btn-primary active" data-bs-toggle="button" >
                                            <span class="handle"></span>
                                        </button>
									</div>
								</div>
								<div class="form-group mb-0 row align-items-center">
									<label class="col-8 col-form-label">Enable Case Tracking:</label>
									<div class="col-4 d-flex justify-content-end">
                                        <button type="button" class="btn btn-sm btn-toggle btn-primary" data-bs-toggle="button" >
                                            <span class="handle"></span>
                                        </button>
									</div>
								</div>
								<div class="form-group mb-0 row align-items-center">
									<label class="col-8 col-form-label">Support Portal:</label>
									<div class="col-4 d-flex justify-content-end">
                                        <button type="button" class="btn btn-sm btn-toggle btn-primary active" data-bs-toggle="button" >
                                            <span class="handle"></span>
                                        </button>
									</div>
								</div>
							</div>
							<!--end::Section-->
							<div class="dropdown-divider"></div>
							<!--begin::Section-->
							<div class="pt-2">
								<h5 class="fw-500 mb-15">Reports</h5>
								<div class="form-group mb-0 row align-items-center">
									<label class="col-8 col-form-label">Generate Reports:</label>
									<div class="col-4 d-flex justify-content-end">
                                        <button type="button" class="btn btn-sm btn-toggle btn-danger active" data-bs-toggle="button" >
                                            <span class="handle"></span>
                                        </button>
									</div>
								</div>
								<div class="form-group mb-0 row align-items-center">
									<label class="col-8 col-form-label">Enable Report Export:</label>
									<div class="col-4 d-flex justify-content-end">
                                        <button type="button" class="btn btn-sm btn-toggle btn-danger active" data-bs-toggle="button" >
                                            <span class="handle"></span>
                                        </button>
									</div>
								</div>
								<div class="form-group mb-0 row align-items-center">
									<label class="col-8 col-form-label">Allow Data Collection:</label>
									<div class="col-4 d-flex justify-content-end">
                                        <button type="button" class="btn btn-sm btn-toggle btn-danger active" data-bs-toggle="button" >
                                            <span class="handle"></span>
                                        </button>
									</div>
								</div>
							</div>
							<!--end::Section-->
							<div class="dropdown-divider"></div>
							<!--begin::Section-->
							<div class="pt-2">
								<h5 class="fw-500 mb-15">Memebers</h5>
								<div class="form-group mb-0 row align-items-center">
									<label class="col-8 col-form-label">Enable Member singup:</label>
									<div class="col-4 d-flex justify-content-end">
                                        <button type="button" class="btn btn-sm btn-toggle btn-warning active" data-bs-toggle="button" >
                                            <span class="handle"></span>
                                        </button>
									</div>
								</div>
								<div class="form-group mb-0 row align-items-center">
									<label class="col-8 col-form-label">Allow User Feedbacks:</label>
									<div class="col-4 d-flex justify-content-end">
                                        <button type="button" class="btn btn-sm btn-toggle btn-warning active" data-bs-toggle="button" >
                                            <span class="handle"></span>
                                        </button>
									</div>
								</div>
								<div class="form-group mb-0 row align-items-center">
									<label class="col-8 col-form-label">Enable Customer Portal:</label>
									<div class="col-4 d-flex justify-content-end">
                                        <button type="button" class="btn btn-sm btn-toggle btn-warning active" data-bs-toggle="button" >
                                            <span class="handle"></span>
                                        </button>
									</div>
								</div>
							</div>
							<!--end::Section-->
						</form>
                        </div>
                    </div>
                </div>
              </div>
		  </div>
		</div>
	  </div>
  </div>
  <!-- /quick_panel_toggle -->
  
  <!-- quick_user_toggle -->
  <div class="modal modal-right fade" id="quick_user_toggle" tabindex="-1">
	  <div class="modal-dialog">
		<div class="modal-content slim-scroll3">
		  <div class="modal-body p-30 bg-white">
			<div class="d-flex align-items-center justify-content-between pb-30">
				<h4 class="m-0">User Profile
				<small class="text-fade fs-12 ms-5">12 messages</small></h4>
				<a href="#" class="btn btn-icon btn-danger-light btn-sm no-shadow" data-bs-dismiss="modal">
					<span class="fa fa-close"></span>
				</a>
			</div>
            <div>
                <div class="d-flex flex-row">
                    <div class=""><img src="${path}/resources/images/avatar/avatar-2.png" alt="user" class="rounded bg-danger-light w-150" width="100"></div>
                    <div class="ps-20">
                        <h5 class="mb-0">Johen Doe</h5>
                        <p class="my-5 text-fade">Web Designer</p>
                        <a href="mailto:dummy@gmail.com"><span class="icon-Mail-notification me-5 text-success"><span class="path1"></span><span class="path2"></span></span> dummy@gmail.com</a>
                        <button class="btn btn-success-light btn-sm mt-5"><i class="ti-plus"></i> Follow</button>
                    </div>
                </div>
			</div>
              <div class="dropdown-divider my-30"></div>
              <div>
                <div class="d-flex align-items-center mb-30">
                    <div class="me-15 bg-primary-light h-50 w-50 l-h-60 rounded text-center">
                          <span class="icon-Library fs-24"><span class="path1"></span><span class="path2"></span></span>
                    </div>
                    <div class="d-flex flex-column fw-500">
                        <a href="#" class="text-dark hover-primary mb-1 fs-16">My Profile</a>
                        <span class="text-fade">Account settings and more</span>
                    </div>
                </div>
                <div class="d-flex align-items-center mb-30">
                    <div class="me-15 bg-danger-light h-50 w-50 l-h-60 rounded text-center">
                        <span class="icon-Write fs-24"><span class="path1"></span><span class="path2"></span></span>
                    </div>
                    <div class="d-flex flex-column fw-500">
                        <a href="#" class="text-dark hover-danger mb-1 fs-16">My Messages</a>
                        <span class="text-fade">Inbox and tasks</span>
                    </div>
                </div>
                <div class="d-flex align-items-center mb-30">
                    <div class="me-15 bg-success-light h-50 w-50 l-h-60 rounded text-center">
                        <span class="icon-Group-chat fs-24"><span class="path1"></span><span class="path2"></span></span>
                    </div>
                    <div class="d-flex flex-column fw-500">
                        <a href="#" class="text-dark hover-success mb-1 fs-16">My Activities</a>
                        <span class="text-fade">Logs and notifications</span>
                    </div>
                </div>
                <div class="d-flex align-items-center mb-30">
                    <div class="me-15 bg-info-light h-50 w-50 l-h-60 rounded text-center">
                        <span class="icon-Attachment1 fs-24"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></span>
                    </div>
                    <div class="d-flex flex-column fw-500">
                        <a href="#" class="text-dark hover-info mb-1 fs-16">My Tasks</a>
                        <span class="text-fade">latest tasks and projects</span>
                    </div>
                </div>
              </div>
              <div class="dropdown-divider my-30"></div>
              <div>
                <div class="media-list">
                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">10:10</h4>
                      <div class="media-body ps-15 bs-5 rounded border-primary">
                        <p>Morbi quis ex eu arcu auctor sagittis.</p>
                        <span class="text-fade">by Johne</span>
                      </div>
                    </a>

                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">08:40</h4>
                      <div class="media-body ps-15 bs-5 rounded border-success">
                        <p>Proin iaculis eros non odio ornare efficitur.</p>
                        <span class="text-fade">by Amla</span>
                      </div>
                    </a>

                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">07:10</h4>
                      <div class="media-body ps-15 bs-5 rounded border-info">
                        <p>In mattis mi ut posuere consectetur.</p>
                        <span class="text-fade">by Josef</span>
                      </div>
                    </a>

                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">01:15</h4>
                      <div class="media-body ps-15 bs-5 rounded border-danger">
                        <p>Morbi quis ex eu arcu auctor sagittis.</p>
                        <span class="text-fade">by Rima</span>
                      </div>
                    </a>

                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">23:12</h4>
                      <div class="media-body ps-15 bs-5 rounded border-warning">
                        <p>Morbi quis ex eu arcu auctor sagittis.</p>
                        <span class="text-fade">by Alaxa</span>
                      </div>
                    </a>
                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">10:10</h4>
                      <div class="media-body ps-15 bs-5 rounded border-primary">
                        <p>Morbi quis ex eu arcu auctor sagittis.</p>
                        <span class="text-fade">by Johne</span>
                      </div>
                    </a>

                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">08:40</h4>
                      <div class="media-body ps-15 bs-5 rounded border-success">
                        <p>Proin iaculis eros non odio ornare efficitur.</p>
                        <span class="text-fade">by Amla</span>
                      </div>
                    </a>

                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">07:10</h4>
                      <div class="media-body ps-15 bs-5 rounded border-info">
                        <p>In mattis mi ut posuere consectetur.</p>
                        <span class="text-fade">by Josef</span>
                      </div>
                    </a>

                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">01:15</h4>
                      <div class="media-body ps-15 bs-5 rounded border-danger">
                        <p>Morbi quis ex eu arcu auctor sagittis.</p>
                        <span class="text-fade">by Rima</span>
                      </div>
                    </a>

                    <a class="media media-single px-0" href="#">
                      <h4 class="w-50 text-gray fw-500">23:12</h4>
                      <div class="media-body ps-15 bs-5 rounded border-warning">
                        <p>Morbi quis ex eu arcu auctor sagittis.</p>
                        <span class="text-fade">by Alaxa</span>
                      </div>
                    </a>
                  </div>
            </div>
		  </div>
		</div>
	  </div>
  </div>
  <!-- /quick_user_toggle -->
  
  <!-- quick_shop_toggle -->
  <div class="modal modal-right fade" id="quick_shop_toggle" tabindex="-1">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			  <div class="px-15 d-flex w-p100 align-items-center justify-content-between">
				<h4 class="m-0">Shopping Cart</h4>
				<a href="#" class="btn btn-icon btn-danger-light btn-sm no-shadow" data-bs-dismiss="modal">
					<span class="fa fa-close"></span>
				</a>
			  </div>
		  </div>
		  <div class="modal-body px-30 pb-30 bg-white slim-scroll4">
				<div class="d-flex align-items-center justify-content-between pb-15">
					<div class="d-flex flex-column me-2">
						<a href="#" class="fw-600 fs-18 text-hover-primary">Product Name</a>
						<span class="text-muted">When an unknown printer</span>
						<div class="d-flex align-items-center mt-2">
							<span class="fw-600 me-5 fs-18">$ 125</span>
							<span class="text-muted me-5">for</span>
							<span class="fw-600 me-2 fs-18">4</span>
							<a href="#" class="btn btn-sm btn-success-light btn-icon me-2">
								<i class="fa fa-minus"></i>
							</a>
							<a href="#" class="btn btn-sm btn-success-light btn-icon">
								<i class="fa fa-plus"></i>
							</a>
						</div>
					</div>
					<a href="#" class="flex-shrink-0">
						<img src="${path}/resources/images/product/product-1.png" class="avatar h-100 w-100" alt="" />
					</a>
				</div>
			  <div class="dropdown-divider"></div>
				<div class="d-flex align-items-center justify-content-between py-15">
					<div class="d-flex flex-column me-2">
						<a href="#" class="fw-600 fs-18 text-hover-primary">Product Name</a>
						<span class="text-muted">When an unknown printer</span>
						<div class="d-flex align-items-center mt-2">
							<span class="fw-600 me-5 fs-18">$ 125</span>
							<span class="text-muted me-5">for</span>
							<span class="fw-600 me-2 fs-18">4</span>
							<a href="#" class="btn btn-sm btn-success-light btn-icon me-2">
								<i class="fa fa-minus"></i>
							</a>
							<a href="#" class="btn btn-sm btn-success-light btn-icon">
								<i class="fa fa-plus"></i>
							</a>
						</div>
					</div>
					<a href="#" class="flex-shrink-0">
						<img src="${path}/resources/images/product/product-2.png" class="avatar h-100 w-100" alt="" />
					</a>
				</div>
			  <div class="dropdown-divider"></div>
				<div class="d-flex align-items-center justify-content-between py-15">
					<div class="d-flex flex-column me-2">
						<a href="#" class="fw-600 fs-18 text-hover-primary">Product Name</a>
						<span class="text-muted">When an unknown printer</span>
						<div class="d-flex align-items-center mt-2">
							<span class="fw-600 me-5 fs-18">$ 125</span>
							<span class="text-muted me-5">for</span>
							<span class="fw-600 me-2 fs-18">4</span>
							<a href="#" class="btn btn-sm btn-success-light btn-icon me-2">
								<i class="fa fa-minus"></i>
							</a>
							<a href="#" class="btn btn-sm btn-success-light btn-icon">
								<i class="fa fa-plus"></i>
							</a>
						</div>
					</div>
					<a href="#" class="flex-shrink-0">
						<img src="${path}/resources/images/product/product-3.png" class="avatar h-100 w-100" alt="" />
					</a>
				</div>
			  <div class="dropdown-divider"></div>
				<div class="d-flex align-items-center justify-content-between py-15">
					<div class="d-flex flex-column me-2">
						<a href="#" class="fw-600 fs-18 text-hover-primary">Product Name</a>
						<span class="text-muted">When an unknown printer</span>
						<div class="d-flex align-items-center mt-2">
							<span class="fw-600 me-5 fs-18">$ 125</span>
							<span class="text-muted me-5">for</span>
							<span class="fw-600 me-2 fs-18">4</span>
							<a href="#" class="btn btn-sm btn-success-light btn-icon me-2">
								<i class="fa fa-minus"></i>
							</a>
							<a href="#" class="btn btn-sm btn-success-light btn-icon">
								<i class="fa fa-plus"></i>
							</a>
						</div>
					</div>
					<a href="#" class="flex-shrink-0">
						<img src="${path}/resources/images/product/product-4.png" class="avatar h-100 w-100" alt="" />
					</a>
				</div>
			  <div class="dropdown-divider"></div> 
				<div class="d-flex align-items-center justify-content-between py-15">
					<div class="d-flex flex-column me-2">
						<a href="#" class="fw-600 fs-18 text-hover-primary">Product Name</a>
						<span class="text-muted">When an unknown printer</span>
						<div class="d-flex align-items-center mt-2">
							<span class="fw-600 me-5 fs-18">$ 125</span>
							<span class="text-muted me-5">for</span>
							<span class="fw-600 me-2 fs-18">4</span>
							<a href="#" class="btn btn-sm btn-success-light btn-icon me-2">
								<i class="fa fa-minus"></i>
							</a>
							<a href="#" class="btn btn-sm btn-success-light btn-icon">
								<i class="fa fa-plus"></i>
							</a>
						</div>
					</div>
					<a href="#" class="flex-shrink-0">
						<img src="${path}/resources/images/product/product-5.png" class="avatar h-100 w-100" alt="" />
					</a>
				</div>
			  <div class="dropdown-divider"></div> 
				<div class="d-flex align-items-center justify-content-between py-15">
					<div class="d-flex flex-column me-2">
						<a href="#" class="fw-600 fs-18 text-hover-primary">Product Name</a>
						<span class="text-muted">When an unknown printer</span>
						<div class="d-flex align-items-center mt-2">
							<span class="fw-600 me-5 fs-18">$ 125</span>
							<span class="text-muted me-5">for</span>
							<span class="fw-600 me-2 fs-18">4</span>
							<a href="#" class="btn btn-sm btn-success-light btn-icon me-2">
								<i class="fa fa-minus"></i>
							</a>
							<a href="#" class="btn btn-sm btn-success-light btn-icon">
								<i class="fa fa-plus"></i>
							</a>
						</div>
					</div>
					<a href="#" class="flex-shrink-0">
						<img src="${path}/resources/images/product/product-6.png" class="avatar h-100 w-100" alt="" />
					</a>
				</div>  
		  </div>
		  <div class="modal-footer modal-footer-uniform">
			  <div class="d-flex align-items-center justify-content-between mb-10">
				<span class="fw-600 text-muted fs-16 me-2">Total</span>
				<span class="fw-600 text-end">$1248.00</span>
			  </div>
			  <div class="d-flex align-items-center justify-content-between mb-15">
				<span class="fw-600 text-muted fs-16 me-2">Sub total</span>
				<span class="fw-600 text-primary text-end">$4125.00</span>
			  </div>
			  <div class="text-end">
				<button type="button" class="btn btn-primary">Place Order</button>
			  </div>
		  </div>
		</div>
	  </div>
  </div>
  <!-- /quick_shop_toggle -->
</div>
<!-- ./wrapper -->
	

	<!-- Sidebar -->
	
	<div id="chat-box-body">
		<div id="chat-circle" class="waves-effect waves-circle btn btn-circle btn-sm btn-warning l-h-50">
            <div id="chat-overlay"></div>
            <span class="icon-Group-chat fs-18"><span class="path1"></span><span class="path2"></span></span>
		</div>

		<!-- 채팅  -->
		<div class="chat-box">
            <div class="chat-box-header p-15 d-flex justify-content-between align-items-center">
                <div class="text-center flex-grow-1">
                    <div class="text-dark fs-18">Mayra Sibley</div>
                    <div>
                        <span class="badge badge-sm badge-dot badge-primary"></span>
                        <span class="text-muted fs-12">Active</span>
                    </div>
                </div>
                <div class="chat-box-toggle">
                    <button id="chat-box-toggle" class="waves-effect waves-circle btn btn-circle btn-danger-light h-40 w-40 rounded-circle l-h-45" type="button">
                      <span class="icon-Close fs-22"><span class="path1"></span><span class="path2"></span></span>
                    </button>                    
                </div>
            </div>
            <div class="chat-box-body">
                <div class="chat-box-overlay">   
                </div>
                <div class="chat-logs">
                    <div class="chat-msg user">
                        <div class="d-flex align-items-center">
                            <span class="msg-avatar">
                                <img src="${path}/resources/images/avatar/2.jpg" class="avatar avatar-lg" alt="">
                            </span>
                            <div class="mx-10">
                                <a href="#" class="text-dark hover-primary fw-bold">Mayra Sibley</a>
                                <p class="text-muted fs-12 mb-0">2 Hours</p>
                            </div>
                        </div>
                        <div class="cm-msg-text">
                            Hi there, I'm Jesse and you?
                        </div>
                    </div>
                    <div class="chat-msg self">
                        <div class="d-flex align-items-center justify-content-end">
                            <div class="mx-10">
                                <a href="#" class="text-dark hover-primary fw-bold">You</a>
                                <p class="text-muted fs-12 mb-0">3 minutes</p>
                            </div>
                            <span class="msg-avatar">
                                <img src="${path}/resources/images/avatar/3.jpg" class="avatar avatar-lg" alt="">
                            </span>
                        </div>
                        <div class="cm-msg-text">
                           My name is Anne Clarc.         
                        </div>        
                    </div>
                    <div class="chat-msg user">
                        <div class="d-flex align-items-center">
                            <span class="msg-avatar">
                                <img src="${path}/resources/images/avatar/2.jpg" class="avatar avatar-lg" alt="">
                            </span>
                            <div class="mx-10">
                                <a href="#" class="text-dark hover-primary fw-bold">Mayra Sibley</a>
                                <p class="text-muted fs-12 mb-0">40 seconds</p>
                            </div>
                        </div>
                        <div class="cm-msg-text">
                            Nice to meet you Anne.<br>How can i help you?
                        </div>
                    </div>
                </div><!--chat-log -->
            </div>
            <div class="chat-input">      
                <form>
                    <input type="text" id="chat-input" placeholder="Send a message..."/>
                    <button type="submit" class="chat-submit" id="chat-submit">
                        <span class="icon-Send fs-22"></span>
                    </button>
                </form>      
            </div>
		</div>
	</div>
	
	<!-- Page Content overlay -->
	
	
	<!-- Vendor JS -->
	<script src="${path}/resources/js/vendors.min.js"></script>
	<script src="${path}/resources/js/pages/chat-popup.js"></script>
    <script src="${path}/resources/assets/icons/feather-icons/feather.min.js"></script>
	
	<script src="${path}/resources/assets/vendor_components/moment/min/moment.min.js"></script>
	<script src="${path}/resources/assets/vendor_components/fullcalendar/fullcalendar.js"></script>
	
	<!-- CRMi App -->
	<script src="${path}/resources/js/template.js"></script>
	<script src="${path}/resources/js/pages/calendar.js"></script>

	
	
</body>
</html>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>