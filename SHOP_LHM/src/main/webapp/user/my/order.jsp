<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%
request.setAttribute("dp0", "lnb");
request.setAttribute("dp1", "my");
request.setAttribute("dp2", "order");

%>
<jsp:include page="/layout/header.jsp" />
<div class="row m-0 mypage">		
	<jsp:include page="/layout/lnb.jsp" />

	<div class="col-md-9 ms-sm-auto col-lg-10 p-0 m-0">
		<div class="px-4 py-3 my-3 text-center">
			<h1 class="display-5 fw-bold text-body-emphasis">주문 내역</h1>
			<div class="col-lg-6 mx-auto">
				<% if( loginId == null ) { %>	
					<p class="lead mb-4">비회원 주문하신 경우, 전화번호와 주문 비밀번호를 입력해주세요.</p>
				<% } %>
			</div>
		</div>
		
		<jsp:include page="/layout/footer.jsp" />
	</div>

</div>
<jsp:include page="/layout/script.jsp" />
<jsp:include page="/layout/bottom.jsp" />