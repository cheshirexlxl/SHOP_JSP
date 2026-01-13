<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<jsp:include page="/layout/header.jsp" />

<div class="px-4 py-5 my-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">메인화면</h1>
	<div class="col-lg-6 mx-auto">
		<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
		<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">				
			<a href="${ root }/user/product/list.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품목록</a>
			<%
				// TODO: 로그인 여부에 따라 로그인/로그아웃 버튼 표시
				// - 비로그인
				if( loginId == null || loginId.equals("") ) {
			%>
				<a href="${ root }/user/my/login.jsp" class="btn btn-outline-secondary btn-lg px-4">로그인</a>
			<%
				// - 로그인
				} else {
			%>
				<a href="${ root }/user/my/logout.jsp" class="btn btn-outline-danger btn-lg px-4">로그아웃</a>
			<%
				}
			%>
		</div>
	</div>
</div>

<jsp:include page="/layout/script.jsp" />
<jsp:include page="/layout/footer.jsp" />