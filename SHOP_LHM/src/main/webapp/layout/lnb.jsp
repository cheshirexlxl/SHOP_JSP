<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%
boolean login = false;
if( loginId != null && !loginId.isEmpty() ) {
	login = true;
}
%>
<div class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
	<div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary">
		<ul class="nav nav-pills flex-column mb-auto">
			<!-- 로그인 시 -->
			<% if( login ) { %>
			<li class="nav-item">
				<a href="${ root }/user/my/detail.jsp" class="nav-link ${dp1 eq 'my' and dp2 eq 'detail' ? 'active' : 'link-body-emphasis'}"> 마이 페이지 </a>
			</li>
			<li class="nav-item">
				<a href="${ root }/user/my/update.jsp" class="nav-link ${dp1 eq 'my' and dp2 eq 'update' ? 'active' : 'link-body-emphasis'}" aria-current="page"> 회원정보 수정 </a>
			</li>
			<% } %>
			<li>
				<a href="${ root }/user/my/order.jsp" class="nav-link ${dp1 eq 'my' and dp2 eq 'order' ? 'active' : 'link-body-emphasis'}"> 주문내역 </a>
			</li>
		</ul>
		<hr>
	</div>
</div>