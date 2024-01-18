<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${path}/resources/images/favicon.svg">

    <title>Rocket Coding Header</title>

    <!-- Vendors Style-->
    <link rel="stylesheet" href="${path}/resources/css/vendors_css.css">

    <!-- Style-->
    <link rel="stylesheet" href="${path}/resources/css/horizontal-menu.css">
    <link rel="stylesheet" href="${path}/resources/css/style.css">
    <link rel="stylesheet" href="${path}/resources/css/skin_color.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body class="hold-transition light-skin sidebar-mini theme-primary fixed">

<div class="wrapper">
    <div id="loader"></div>

    <header class="main-header">
        <!-- 로고 만들면 추가 -->
        <div class="d-flex align-items-center logo-box justify-content-start d-md-none d-block">
            <!-- Logo -->
            <a href="${path }/" class="logo">
                <!-- logo-->
                <div class="logo-mini w-30">
                    <span class="light-logo"><img src="${path}/resources/images/logo-letter.png" alt="logo"></span>
                    <span class="dark-logo"><img src="${path}/resources/images/logo-letter-white.png" alt="logo"></span>
                </div>
                <div class="logo-lg">
                    <span class="light-logo"><img src="${path}/resources/images/logo-dark-text.png" alt="logo"></span>
                    <span class="dark-logo"><img src="${path}/resources/images/logo-light-text.png" alt="logo"></span>
                </div>
            </a>
        </div>
        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top">
            <!-- Sidebar toggle button-->
            <div class="app-menu">
                <ul class="header-megamenu nav">
                    <li class="btn-group nav-item">
                        <a href="#" class="waves-effect waves-light nav-link push-btn btn-primary-light"
                           data-toggle="push-menu" role="button">
                            <i class="icon-Menu"><span class="path1"></span><span class="path2"></span></i>
                        </a>
                    </li>
                    <li class="btn-group d-lg-inline-flex d-none">
                        <div class="app-menu">
                            <div class="search-bx mx-5">
                                <form>
                                    <div class="input-group">
                                        <input type="search" class="form-control" placeholder="Search">
                                        <div class="input-group-append">
                                            <button class="btn" type="submit" id="button-addon3"><i class="icon-Search"><span
                                                    class="path1"></span><span class="path2"></span></i></button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="navbar-custom-menu r-side">
                <ul class="nav navbar-nav">
                    <li class="dropdown notifications-menu btn-group nav-item">
                        <a href="#" class="waves-effect waves-light nav-link btn-primary-light svg-bt-icon"
                           data-bs-toggle="dropdown" title="Notifications">
                            <i class="icon-Notifications"><span class="path1"></span><span class="path2"></span></i>
                            <div class="pulse-wave"></div>
                        </a>
                        <ul class="dropdown-menu animated bounceIn">
                            <li class="header">
                                <div class="p-20">
                                    <div class="flexbox">
                                        <div>
                                            <h4 class="mb-0 mt-0">Notifications</h4>
                                        </div>
                                        <div>
                                            <a href="#" class="text-danger">Clear All</a>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <!-- inner menu: contains the actual data -->
                                <ul class="menu sm-scrol">
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-users text-info"></i> Curabitur id eros quis nunc suscipit
                                            blandit.
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-warning text-warning"></i> Duis malesuada justo eu sapien
                                            elementum, in semper diam posuere.
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-users text-danger"></i> Donec at nisi sit amet tortor
                                            commodo porttitor pretium a erat.
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-shopping-cart text-success"></i> In gravida mauris et nisi
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-user text-danger"></i> Praesent eu lacus in libero dictum
                                            fermentum.
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-user text-primary"></i> Nunc fringilla lorem
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-user text-success"></i> Nullam euismod dolor ut quam
                                            interdum, at scelerisque ipsum imperdiet.
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="footer">
                                <a href="#">View all</a>
                            </li>
                        </ul>
                    </li>
                    <!-- 			<li class="btn-group nav-item">
                                    <a href="#" class="waves-effect waves-light nav-link btn-primary-light svg-bt-icon" title="" data-bs-toggle="modal" data-bs-target="#quick_actions_toggle">
                                        <i class="icon-Layout-arrange"><span class="path1"></span><span class="path2"></span></i>
                                    </a>
                                </li>
                                <li class="btn-group nav-item d-xl-inline-flex d-none">
                                    <a href="#" class="waves-effect waves-light nav-link btn-primary-light svg-bt-icon" title="" data-bs-toggle="modal" data-bs-target="#quick_panel_toggle">
                                        <i class="icon-Notification"><span class="path1"></span><span class="path2"></span></i>
                                    </a>
                                </li> -->
                    <li class="btn-group nav-item d-xl-inline-flex d-none">
                        <a href="${path }/chat/list"
                           class="waves-effect waves-light nav-link btn-primary-light svg-bt-icon" title=""
                           id="live-chat">
                            <i class="icon-Chat"><span class="path1"></span><span class="path2"></span></i>
                        </a>
                    </li>


                    <li class="btn-group nav-item d-xl-inline-flex d-none">
                        <a href="#" data-provide="fullscreen"
                           class="waves-effect waves-light nav-link btn-primary-light svg-bt-icon" title="Full Screen">
                            <i class="icon-Expand-arrows"><span class="path1"></span><span class="path2"></span></i>
                        </a>
                    </li>

                    <!-- User Account-->
                    <%-- <li class="dropdown user user-menu">
                        <a href="#" class="waves-effect waves-light dropdown-toggle w-auto l-h-12 bg-transparent p-0 no-shadow" title="User" data-bs-toggle="modal" data-bs-target="#quick_user_toggle">
                            <div class="d-flex pt-1">
                                <div class="text-end me-10">
                                    <p class="pt-5 fs-14 mb-0 fw-700 text-primary">홍길동</p>
                                    <small class="fs-10 mb-0 text-uppercase text-mute">사원</small>
                                </div>
                                <img src="${path}/resources/images/avatar/avatar-1.png" class="avatar rounded-10 bg-primary-light h-40 w-40" alt="" />
                            </div>
                        </a>
                    </li> --%>

                </ul>
            </div>
        </nav>
    </header>

    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
        <!-- sidebar-->
        <section class="sidebar position-relative">
            <div class="d-flex align-items-center logo-box justify-content-start d-md-block d-none">
                <!-- Logo -->
                <a href="${path }/" class="logo">
                    <!-- logo-->
                    <div class="logo-mini">
                        <span class="light-logo"><img src="${path}/resources/images/logo-letter.png" alt="logo"></span>
                    </div>
                    <div class="logo-lg">
                        <span class="light-logo fs-36 fw-700">로고</span>
                    </div>
                </a>
            </div>
            <div class="user-profile my-15 px-20 py-10 b-1 rounded10 mx-15">
                <div class="d-flex align-items-center justify-content-between">
                    <div class="image d-flex align-items-center">
                        <img src="${path }/resources/upload/profile/${loginEmp.empFile}" class="rounded-0 me-10"
                             alt="user">
                        <div>
                            <h4 class="mb-0 fw-600"><c:out value="${loginEmp.empName }"/></h4>
                            <p class="mb-0"><c:out value="${loginEmp.empLv }"/></p>
                        </div>
                    </div>
                    <div class="info">
                        <a class="dropdown-toggle p-15 d-grid" data-bs-toggle="dropdown" href="#"></a>
                        <div class="dropdown-menu dropdown-menu-end">
                            <a class="dropdown-item" href="${path }/mypage"><i class="ti-user"></i>마이페이지</a>
                            <!-- <a class="dropdown-item" href="mailbox.html"><i class="ti-email"></i> Inbox</a>
                            <a class="dropdown-item" href="contact_app_chat.html"><i class="ti-link"></i> Conversation</a> -->
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="${path }/logout"><i class="ti-lock"></i> 로그아웃</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="multinav">
                <div class="multinav-scroll" style="height: 97%;">
                    <!-- sidebar menu-->
                    <ul class="sidebar-menu" data-widget="tree">
                        <li class="header">메뉴 리스트</li>

                        <%--         <%=request.getRequestURI()%>--%>
                        <li class="treeview">
                       <!-- 인사관리 메뉴  -->
   			<script>
			    $(document).ready(function() {
			        var depName = '${loginEmp.dep.depName}';
			        if (depName !== '인사팀') {
			            $('#employeeHolidayList, #employeeCommuteList, #departmentList, #dwRulesList').click(function(e) {
			                e.preventDefault();
			                alert('권한이 없습니다.');
			            });
			        }
			    });
			</script>
			<a href="#">
			    <i class="icon-Add-user"><span class="path1"></span><span class="path2"></span></i>
			    <span>인사 관리</span>
			    <span class="pull-right-container">
			        <i class="fa fa-angle-right pull-right"></i>
			    </span>
			</a>
			<ul class="treeview-menu">
			    <li class="treeview">
			        <a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>
			            <span>사원 관리</span>
			            <i class="fa fa-angle-right pull-right"></i> 
			        </a>
			        <ul class="treeview-menu">
			            <li class='<%= request.getRequestURI().contains("/employeelist") ? "active" : "" %>'>
			                <a href="${path}/employeelist" id="employeeInfoManage"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>사원 정보관리</a>
			            </li>
			            <li class='<%= request.getRequestURI().contains("/employeeholidaylist") ? "active" : "" %>'>
			                <a href="${path}/employeeholidaylist" id="employeeHolidayList"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>사원별 휴가사용 조회</a>
			            </li>
			            <li class='<%= request.getRequestURI().contains("/employeecommute") ? "active" : "" %>'>
			                <a href="${path}/employeecommute" id="employeeCommute"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>사원별 근태관리</a>
			            </li>
			        </ul>
			    </li>
			    <li class='<%= request.getRequestURI().contains("/departmentlist") ? "active" : "" %>'>
			        <a href="${path}/departmentlist" id="departmentList"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>부서 관리</a>
			    </li>
			    <li class='<%= request.getRequestURI().contains("/dwruleslist") ? "active" : "" %>'>
			        <a href="${path}/dwruleslist" id="dwRulesList"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>근무시간 관리</a>
			    </li>
			</ul>
					<!-- 인사관리 메뉴  끝 -->

                        <!-- 물류 메뉴-->
                        <li class="treeview">
                            <a href="#">
                                <i class="icon-Box3"><span class="path1"></span><span class="path2"></span></i>
                                <span>물류 관리</span>
                                <span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>


                                <%--              <a href="${path}/logistics/inventory/write"><i class="icon-Commit"><span
                                                        class="path1"></span><span class="path2"></span></i>입/출고 등록</a>--%>


                            </a>
                            <ul class="treeview-menu">

                                <li class='<%= request.getRequestURI().contains("/logistics/product") ? "active" : "" %>'>
                                    <a href="${path}/logistics/product/list"><i class="icon-Commit"><span
                                            class="path1"></span><span
                                            class="path2"></span></i>상품 관리</a></li>
                                <li class='<%= request.getRequestURI().contains("/logistics/publisher") ? "active" : "" %>'>
                                    <a href="${path}/logistics/publisher/list"><i class="icon-Commit"><span
                                            class="path1"></span><span
                                            class="path2"></span></i>출판사 관리</a></li>


                                <li class="treeview <%= request.getRequestURI().contains("/logistics/inventory") ? "active" : "" %>">
                                    <a href="#">
                                        <i class="icon-Commit"><span class="path1"></span><span
                                                class="path2"></span></i>입/출고 관리
                                        <span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
                                    </a>
                                    <ul class="treeview-menu">

                                        <li class='<%= request.getRequestURI().contains("inventoryWrite") ? "active" : "" %>'>
                                            <a href="${path}/logistics/inventory/write"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>입/출고 등록</a></li>
                                        <li class='<%= request.getRequestURI().contains("inventoryList") ? "active" : "" %>'>
                                            <a href="${path}/logistics/inventory/list"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>입/출고 내역</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="treeview">
                                    <a href="#">
                                        <i class="icon-Commit"><span class="path1"></span><span
                                                class="path2"></span></i>재고 관리
                                        <span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
                                    </a>
                                    <ul class="treeview-menu">
                                        <li class='<%= request.getRequestURI().contains("searchStockbyDay") || request.getRequestURI().contains("daybyStockPage") ? "active" : "" %>'>
                                            <a href="${path}/logistics/stock/searchbyday"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>재고 현황 검색</a>
                                        </li>
                                        <li class='<%= request.getRequestURI().contains("searchStockByBranch")|| request.getRequestURI().contains("widthBranchByStockPage") || request.getRequestURI().contains("heihtBranchByStockPage") ? "active" : "" %>'>
                                            <a href="${path}/logistics/stock/searchbybranch"><i
                                                    class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>지점별 재고 현황 검색</a>
                                        </li>
                                        <li><a href="contact_app.html"><i class="icon-Commit"><span
                                                class="path1"></span><span class="path2"></span></i>재고 수불부 검색</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>

                        </li>
                        <!-- 물류 메뉴 끝-->

                        <li>
                            <a href="${pageContext.request.contextPath}/board/fboardlist.do">
                                <i class="glyphicon glyphicon-list-alt"><span class="path1"></span><span
                                        class="path2"></span></i>
                                <span>게시판</span>
                            </a>
                        </li>
                        <li>
                            <a href="${path }/chat/list">
                                <i class="fa fa-comments"></i>
                                <span>채팅</span>
                            </a>
                        </li>
						<li class="treeview">
                            <a href="#">
                                <img style="width: 28px; height: 28px; filter : grayscale(100%)"  src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy9Jc1pfkjTgTIyPDX2byAiDFXg9X-vbgiQA&usqp=CAU"><span class="path1"></span><span class="path2"></span></i>
                                <span>전자결재</span>
                                <span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
                            </a>
                            <ul class="treeview-menu">

                                
                                <li class="treeview">
                                    <a href="#">
                                        <i class="icon-Commit"><span class="path1"></span><span
                                                class="path2"></span></i>진행중인 문서
                                        <span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
                                    </a>
                                    <ul class="treeview-menu">

                                        <li>
                                            <a href="${path}/docu/lists/a"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>전체</a></li>
                                        <li>
                                            <a href="${path}/docu/lists/w"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>대기</a>
                                        </li>
                                        <li>
                                            <a href="${path}/docu/lists/v"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>확인</a>
                                        </li>
                                        <li>
                                            <a href="${path}/docu/lists/e"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>예정</a>
                                        </li>
                                        <li>
                                            <a href="${path}/docu/lists/p"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>진행</a>
                                        </li>
                                        
                                    </ul>
                                </li>
                                <li class="treeview">
                                    <a href="#">
                                        <i class="icon-Commit"><span class="path1"></span><span
                                                class="path2"></span></i>문서함
                                        <span class="pull-right-container">
								<i class="fa fa-angle-right pull-right"></i>
							</span>
                                    </a>
                                    <ul class="treeview-menu">
                                        <li>
                                            <a href="${path}/docu/box/all"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>전체</a>
                                        </li>
                                        <li>
                                            <a href="${path}/docu/box/write"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>기안</a>
                                        </li>
                                        <li>
                                            <a href="${path}/docu/box/aprv"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>결재</a>
                                        </li>
                                        <li>
                                            <a href="${path}/docu/box/refer"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>수신</a>
                                        </li>
                                        <li>
                                            <a href="${path}/docu/box/return"><i class="icon-Commit"><span
                                                    class="path1"></span><span class="path2"></span></i>반려</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <div class="sidebar-widgets">
                        <div class="copyright text-center m-25">
                            <p><strong class="d-block">RocketCoding</strong> ©
                                <script>document.write(new Date().getFullYear())</script>
                                All Rights Reserved
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </aside>

