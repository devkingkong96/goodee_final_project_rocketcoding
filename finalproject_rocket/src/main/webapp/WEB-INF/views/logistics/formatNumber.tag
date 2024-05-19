<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="value" required="true" type="java.lang.Number" %>
<fmt:formatNumber value="${value}" type="number" groupingUsed="true"/>