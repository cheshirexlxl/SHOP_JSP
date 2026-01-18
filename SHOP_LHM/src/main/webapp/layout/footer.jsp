<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<footer class="container p-5">
	<p class="text-center">copyright Shop</p>
</footer>

<c:if test="${dp0 ne 'lnb'}">
	<jsp:include page="/layout/bottom.jsp" />
</c:if>
