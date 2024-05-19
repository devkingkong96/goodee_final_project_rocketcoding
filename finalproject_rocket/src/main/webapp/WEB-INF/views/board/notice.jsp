<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="title" value=""/>
</jsp:include>
 <style>
        body {
            background-color: #ffffff;
        }
        .expand-icon {
            cursor: pointer;
        }
        .collapsible.active .expand-icon {
            content: '-';
        }
        .write-button {
            background-color: #343a40;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .write-button:hover {
            background-color: #282c34;
        }
</style>
<div class="content-wrapper">
   <div class="container-full">
      <!-- Main content -->
      <section class="content">
       		<div style="width: 80%; margin: 0 auto; padding: 20px;">
	            <h1 style="font-size: 2.5em; color: #343a40; text-align: center; margin-bottom: 30px;">공지사항</h1>
	            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
	                <div></div>
	                <a href="${path}/notice/write.do" class="write-button">글쓰기</a>
	            </div>
	            <div style="box-shadow: 0px 0px 10px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden;">
	                <table style="width: 100%; border-collapse: collapse;">
	                    <thead>
	                        <tr style="background-color: #343a40; color: #ffffff;">	
	                            <th style="padding: 10px; border-bottom: 2px solid #dee2e6; width: 10%; text-align: center;">번호</th>
	                            <th style="padding: 15px; border-bottom: 2px solid #dee2e6; width: 60%; text-align: left;">제목</th>
	                            <th style="padding: 15px; border-bottom: 2px solid #dee2e6; width: 20%; text-align: center;">등록일</th>
	                            <th style="padding: 15px; border-bottom: 2px solid #dee2e6; width: 10%; text-align: center;"></th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach var="notice" items="${noticeList}">
						    <tr class="collapsible" onclick="toggleContent(this)">    
						        <td style="padding: 10px; border-bottom: 1px solid #dee2e6; text-align: center;">${notice.noticeNo }</td>
						        <td style="padding: 15px; border-bottom: 1px solid #dee2e6;"><a href="${path}/notice/detail.do?noticeNo=${notice.noticeNo}" style="color: #343a40; text-decoration: none;">${notice.noticeTitle }</a></td>
						        <td style="padding: 15px; border-bottom: 1px solid #dee2e6; text-align: center;"><fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd"/></td>
						        <td style="padding: 15px; border-bottom: 1px solid #dee2e6; text-align: center;" class="expand-icon">+</td>
						    </tr>
						    <tr class="content" style="display: none;">
						        <td colspan="4" style="padding: 15px; border-bottom: 1px solid #dee2e6;">${notice.noticeContent }</td>
						    </tr>
						</c:forEach>

	                    </tbody>
	                </table>
	           	</div>
	        </div>
      </section>
   </div>
</div>
<script>
	function toggleContent(element) {
	    var contentRow = element.nextElementSibling;
	    var expandIcon = element.querySelector('.expand-icon');
	    if (contentRow.style.display === "none") {
	        contentRow.style.display = "table-row";
	        element.classList.add("active");
	        expandIcon.textContent = '-';
	    } else {
	        contentRow.style.display = "none";
	        element.classList.remove("active");
	        expandIcon.textContent = '+';
	    }
	}
</script>
<!-- Vendor JS -->
<script src="${path }/resources/js/vendors.min.js"></script>
<script src="${path }/resources/js/pages/chat-popup.js"></script>
<script src="${path }/resources/js/assets/icons/feather-icons/feather.min.js"></script>
<script src="${path }/resources/js/assets/vendor_components/datatable/datatables.min.js"></script>

<!-- CRMi App -->
<script src="${path }/resources/js/template.js"></script>
<script src="${path }/resources/js/pages/data-table.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>