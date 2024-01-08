<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp">

    <jsp:param name="title" value="" />
</jsp:include>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>



<style>
    
   
 	table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	th,
	td {
	    border: 1px solid black;
	    padding: 15px;
	    text-align: left;
	}
	
	th {
	    background-color: #f2f2f2;
	} 
	
	
	</style>


<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strDate = simpleDate.format(date);
	

%>


<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <div class="container-full">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="d-flex align-items-center">
                <div class="me-auto">
                    <h4 class="page-title">Editors</h4>
                    <div class="d-inline-block align-items-center">
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
                                <li class="breadcrumb-item" aria-current="page">Forms</li>
                                <li class="breadcrumb-item active" aria-current="page">Editors</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-12">
                    <div class="box">
                        <div class="box-header">
                            <h3>결재문서 작성</h3>
                            <div class="row">
                                <div class="col-md-12 col-12">
                                	<table>
	                                   	 <tr>
	                                    	<th>
	                                    		<p>양식설정</p>
	                                    	</th>
	                                    	<td>
	                                    		<select class="form-control select2" id="tagSelect" onchange="tagSelect()">
		                                            <option selected="selected" value="">양식을 선택하세요</option>
		                                            <option value="option1">휴가양식</option>
		                                            <option value="option2">재고양식</option>              
	                                        	</select>
	                                    	</td>
	                                    	<th rowspan="2">
	                                    		<p>기안자</p>
	                                    	</th>
	                                    	<td>${user.empName }</td>
	                                    </tr>
                                	</table>
                                </div>
                                <div id="contentContainer" style="display: none">
                                    <div>
                                        <div>
                                            <div>
                                                <div>
                                                    <div class="box-body" style="display: flex;">
                                                        <h4>결재선 설정</h4>
                                                        &nbsp;&nbsp;&nbsp;
                                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target=".bs-example-modal-lg">
                                                            결재선 추가
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /.col -->
                                           <div class="table table-bordered mb-0">
											    <table style="border: 1px solid black;" id="aprvtable">								
											            <tr style="background-color: #f2f2f2;">
											               <td rowspan="4" style="text-align: center;">결재</td>
											            </tr>
											            <tr style="background-color: #f2f2f2;" id="name">
											                <td>이름</td>
											                <td>이름</td>
											                <td>이름</td>
											                <td>이름</td>
											            </tr>
											            <tr style="height: 120px" id="empty">
											                <td>도장</td>
											                <td>도장</td>
											                <td>도장</td>
															<td>도장</td>
														</tr>
											            <tr id="emplv">
											                <td>직책</td>
											                <td>직책</td>
											                <td>직책</td>
											                <td>직책</td>
											            </tr>
											        </tbody>
											    </table>
											</div>
										</div>
										<div class="box-header" style="display: flex">
										<h4>
											참조자 : 
										</h4>
										&nbsp;	
										<p>dasdasdsadad</p>
										</div>
										</div>
                                        <form action="${path }/aprv/insertaprv" method="post">
                                            <div class="box-header">
                                                <h4 class="box-title">제목<br>
                                                    <input type="text" name="" class="form-control" style="width: 500px">
                                                </h4>
                                            </div>
                                            <!-- /.box-header -->
                                            <div class="box-body">
                                                <h4 class="box-title">본문</h4>
                                                <div id="tagCont">                                                   
                                                    
												

                                                </div>
                                                <br>
                                                <button class="btn btn-primary" type="submit">제출하기</button>
                                        </form>
                                    </div>
                                </div>
                                <!-- /.box -->
                            </div>
                            <!-- /.col-->
                        </div>
                        <!-- ./row -->
                        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none; width: 100%" >
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content" style="background-color: white;">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myLargeModalLabel">결재선 설정</h4>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="myBtn"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div id="flex-cotainer" style="display: flex" >
                                              
                                         
								  <div class="multinav-scroll" style="height: 97%;">	
									  <!-- sidebar menu-->
									  <ul class="sidebar-menu" data-widget="tree">					  
										<li class="treeview">
										  <a href="#">
											<i class="icon-Library"><span class="path1"></span><span class="path2"></span></i>
											<span>로켓서점 &nbsp;&nbsp;&nbsp;&nbsp;</span>
											<span class="pull-right-container">
											  <i class="fa fa-angle-right pull-right"></i>
											</span>
										  </a>
										  <ul class="treeview-menu">											
											<li class="treeview">
												
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;												
												<input name="group4" type="radio" id="1" class="radio-col-danger" />
												<label for="1">일부</label>
												
											</li>												
											<li class="treeview">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input name="group4" type="radio" id="2" class="radio-col-danger" />
												<label for="2">인사부</label>
											</li>										
											<li class="treeview">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input name="group4" type="radio" id="3" class="radio-col-danger" />
												<label for="3">재고부</label>
											</li>									
											<li class="treeview">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input name="group4" type="radio" id="4" class="radio-col-danger" />
												<label for="4">부부</label>
											</li>
											<li class="treeview">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input name="group4" type="radio" id="5" class="radio-col-danger" />
												<label for="5">아이부</label>
												
											</li>  
										  </ul>
										</li>                        
                                        </div>
                                            <div id="btn-container" class="">
                                                <div class="col-12">
											<div class="">
												<div class="box-header with-border">
													<h1 class="box-title text-primary" id="peo-heder">People</h1>
												</div>
												<div class="column" id="dep-container">
												<!--인원들출력란  -->		
											</div>
										</div>
									  </div>
                                            </div>
                                  <div>
                                  <h1 style="position: static; margin-right: 40px">결재자</h1>
                                  <div class="column" style="width: 100%;" id="aprv">
                                  </div>  	


                                    
                                  </div>
                                <div>
                                  <h1 style="position: static;">참조자</h1>
                                  <div class="column" style="width: 100%" id="reader">
								</div>

                                    
                                  </div>
                                            
                                            
                                            
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger text-start" data-bs-dismiss="modal" onclick="saveMembers();">저장</button>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger text-start" data-bs-dismiss="modal">닫기</button>
                                    </div>
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                        </div>
                        <!-- /.modal -->
                    </div>
                </div>
            </div>
        </section>
        <!-- /.content -->
    </div>
</div>
<!-- /.content-wrapper -->

<script>


	//태그선택하게하기
	function tagSelect() {
        var x = document.getElementById("tagSelect").value;

        if (x === "option1") {
        	document.getElementById("contentContainer").style.display ="block";
            document.getElementById("tagCont").innerHTML = "";
            document.getElementById("tagCont").innerHTML = `
        <style>
            table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        </style>
        <table>
            <thead>
                <th colspan="2"><h1 style="text-align: center;">휴가신청서</h1></th>
            </thead>
            <tbody>
                <tr>
                    <td>성명</td>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <td>부서</td>
                    <td>[당신의 부서]</td>
                </tr>
                <tr>
                    <td>기간</td>
                    <td>[휴가를 사용할 날짜]</td>
                </tr>
                <tr>
                    <td>휴가종류</td>
                    <td>[사용할 휴가의 종류]</td>
                </tr>
                <tr>
                    <td>휴가사유</td>
                    <td><textarea>texttext</textarea></td>
                </tr>
                <tr style="height: 500px">
                    <td colspan="2" style="text-align: center;">상기와 같은 이유로 휴가를 신청합니다.<br><br><br><br><br><br>
                    <%=strDate %></td>
                </tr>
            </tbody>
        </table>`;
        } else if (x === "option2") {
        	document.getElementById("contentContainer").style.display ="block";
            document.getElementById("tagCont").innerHTML = "";
            document.getElementById("tagCont").innerHTML = "";
        }else {
        	document.getElementById("contentContainer").style.display ="none";
        	document.getElementById("tagCont").innerHTML = "";
        }
    }
</script>

<script>



	//ajax통신
	$('input[type=radio][name=group4]').change(function() {
	    $.ajax({
	        url: '${path}/docu/checkDept', 
	        type: 'GET',
	        data: {
	            DEP_CODE: this.id
	        },
	        success: function(data) {

	        	 var html = '';
	             for (var i = 0; i < data.length; i++) {
	            	 html += '<div class="column">' 
	                 html += '<button class="draggable" draggable="true">'
	            	 html += '<div class="d-flex align-items-center mb-30">'
	                 html += '<div class="me-15">'
	                 /* html += '<img src="../../../images/avatar/1.jpg" class="avatar avatar-lg rounded10" alt="" />' */  
	                 html += '</div>'
	                 html += '<div class="d-flex flex-column fw-500" style="width: 100px;height:50px">'
	                 html += '<p  class="text-dark hover-primary mb-1 fs-16">'+ data[i].EMP_NAME +'</p>'
	                 html += '<span class="text-mute">'+data[i].EMP_LV+'</span>'
	                 html += ''
	                 html += '<input type="hidden" value="'+data[i].EMP_NO+'" class="empNo">'
	                 html += '</div>'
	                 html += '</div>'
	                 html += '</button>'
	               	 html += '</div>' 
	            	/*  html += '<p>' + data[i].EMP_LV + ' ' + data[i].EMP_NAME + '</p>'; */
	             }
	             document.getElementById("dep-container").innerHTML = html;
	              
	        }
	    });
	});

	


</script>
<script type="text/javascript">
//라디오 라벨이랑 헤더랑 이름같게
$(document).ready(function() {
    $('input[type=radio][name=group4]').change(function() {
        var selectedLabel = $("label[for='"+ $(this).attr('id') +"']").text();
        $('#peo-heder').text(selectedLabel);
    });
});
</script>


<script>
//드래그앤드롭
//sorttable
const columns = document.querySelectorAll(".column");
columns.forEach((column) => {
  new Sortable(column, {
    group: "shared",
    animation: 150,
    ghostClass: "blue-background-class",
    onStart: function (evt) {
      // 드래그를 시작할 때 항목의 원래 리스트와 위치를 저장합니다.
      evt.item.oldParent = evt.from;
      evt.item.oldIndex = evt.oldIndex;
    },
    onAdd: function (evt) {
      const item = evt.item; // 드롭한 항목
      const empNo = item.querySelector('input[type="hidden"]').value; // 드롭한 항목의 empNo 값
      const aprvItems = document.getElementById('aprv').children; // 결재자 div의 모든 항목
      const readerItems = document.getElementById('reader').children; // 참조자 div의 모든 항목

      for (const items of [aprvItems, readerItems]) {
        for (let i = 0; i < items.length; i++) {
          if (items[i] !== item && items[i].querySelector('input[type="hidden"]').value === empNo) {
            alert("중복된 요소가 있습니다.");
            
            // 중복이 발견되었을 때 항목을 원래 위치로 돌려놓습니다.
            evt.from.insertBefore(item, evt.from.children[item.oldIndex]);
            return;
          }
        }
      }
    },
  });
});

	
﻿

</script>

<script>
	const saveMembers = () => {
		const aprvItems = document.getElementById('aprv').children;
		const readItems = document.getElementById('reader').children;
		let aprvempInfo = [];
		let readerempInfo = [];

		for(let i = 0; i < aprvItems.length; i++) {
		  let pTag = aprvItems[i].querySelector("p.text-dark.hover-primary.mb-1.fs-16");
		  let spanTag = aprvItems[i].querySelector("span.text-mute");
		  let inputTag = aprvItems[i].querySelector("input.empNo");

		  if(pTag && spanTag && inputTag) {
		    aprvempInfo.push ({
		      empName: pTag.innerHTML,
		      empLv: spanTag.innerHTML,
		      empNo: inputTag.value
		    });
		  }
		}
		for(let i = 0; i < readItems.length; i++) {
			  let pTag = readItems[i].querySelector("p.text-dark.hover-primary.mb-1.fs-16");
			  let spanTag = readItems[i].querySelector("span.text-mute");
			  let inputTag = readItems[i].querySelector("input.empNo");

			  if(pTag && spanTag && inputTag) {
				 readerempInfo.push ({
			      empName: pTag.innerHTML,
			      empLv: spanTag.innerHTML,
			      empNo: inputTag.value
			    });
			  }
			}
		
		console.log(aprvempInfo);
		console.log(readerempInfo); // 콘솔에 empInfo 객체 출력
 	

	   
	  
	};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />


