<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%
request.setAttribute("dp0", "lnb");
request.setAttribute("dp1", "my");
request.setAttribute("dp2", "detail");

if( loginId == null || loginId.equals("") ) {
	response.sendRedirect(root + "/");
}

%>
<jsp:include page="/layout/header.jsp" />
<div class="row m-0 mypage">		
	<jsp:include page="/layout/lnb.jsp" />
	
	<div class="col-md-9 ms-sm-auto col-lg-10 p-0 m-0">
		<div class="px-4 py-3 my-3 text-center">
			<h1 class="display-5 fw-bold text-body-emphasis">마이 페이지</h1>
		</div>
		
		<!-- 마이 페이지 -->
		<div class="container shop m-auto mb-5">
			<div class="btn-box d-grid gap-2">
				<a href="${ root }/user/my/update.jsp" class="btn btn-outline-primary btn-lg px-4 gap-3">회원정보 수정</a>
				<a href="${ root }/user/my/order.jsp" class="btn btn-outline-primary btn-lg px-4 gap-3">주문내역</a>
			</div>
		</div>		
		<jsp:include page="/layout/footer.jsp" />
	</div>
</div>
<jsp:include page="/layout/script.jsp" />
<jsp:include page="/layout/bottom.jsp" />