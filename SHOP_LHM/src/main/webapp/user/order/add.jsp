<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLDecoder"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<jsp:include page="/layout/header.jsp" />
<% 
	// TODO: 쿠키에 저장된 배송 정보 불러오기
	// 힌트: ship_cartId, ship_name, ship_date, ship_country, ship_zipCode, ship_addressName, ship_phone 변수 선언 (빈 문자열로 초기화)
	String ship_cartId = "";
	String ship_name = "";
	String ship_date = "";
	String ship_country = "";
	String ship_zipCode = "";
	String ship_addressName = "";
	String ship_phone = "";
	
	// TODO: request에서 쿠키 배열을 가져오기
	Cookie[] cookies =  request.getCookies();
	
	// TODO: 쿠키 배열이 null이 아니면 반복문으로 각 쿠키 처리
	if( cookies != null ) {
		for(int i = 0 ; i < cookies.length ; i++) {
			Cookie cookie = cookies[i];
			String cookieName = cookie.getName();
			String cookieValue = URLDecoder.decode( cookie.getValue(), "UTF-8" );
			switch(cookieName) {
			 	case "ship_cartId" 			: ship_cartId = cookieValue;		break;
			 	case "ship_name" 			: ship_name = cookieValue;			break;
			 	case "ship_date" 			: ship_date = cookieValue;			break;
			 	case "ship_country" 		: ship_country = cookieValue;		break;
			 	case "ship_zipCode" 		: ship_zipCode = cookieValue;		break;
			 	case "ship_addressName" 	: ship_addressName = cookieValue;	break;
			 	case "ship_phone" 			: ship_phone = cookieValue;			break;
			}
		}
	}	
	
	// TODO: 세션에서 장바구니 목록(cartList) 가져오기	
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
	if( cartList == null ) cartList = new ArrayList<Product>();
	
	
	// TODO: 로그인 여부 확인
	String order_type = "";
	boolean login = false;
	if (loginId != null && !loginId.isEmpty()) {
		login = true;
		order_type = "회원 주문";
	} else {
		login = false;
		order_type = "비회원 주문";
	}

%>

<div class="px-4 py-5 my-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
</div>

<!-- 주문 확인 영역 -->
<div class="container order mb-5">
	<form action="add_action.jsp" method="post">
	<!-- 배송정보 -->
	<div class="ship-box">
		<table class="table ">
			<tr>
				<td>주문 형태 :</td>
				<td><%= order_type %></td>
			</tr>
			<tr>
				<td>성 명 :</td>
				<td><%= ship_name %></td>
			</tr>
			<tr>
				<td>우편번호 :</td>
				<td><%= ship_zipCode %></td>
			</tr>
			<tr>
				<td>주소 :</td>
				<td><%= ship_addressName %></td>
			</tr>
			<tr>
				<td>배송일 :</td>
				<td><%= ship_date %></td>
			</tr>
			<tr>
				<td>전화번호 :</td>
				<td><%= ship_phone %></td>
			</tr>
			<%
				// TODO: 로그인하지 않은 경우(!login)에만 주문 비밀번호 입력 필드 표시
				if( !login ) {				
			%>		
			<tr>
				<td>주문 비밀번호 :</td>
				<td>
					<input type="password" class="form-control" name="orderPw" >
				</td>
			</tr>
			<% } %>
		</table>
	</div>
	
	<!-- 주문목록 -->
	<div class="cart-box">
		<table class="table table-striped table-hover table-bordered text-center align-middle">
			<thead>
				<tr class="table-primary">
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<%
					// TODO: 총 금액 계산을 위한 변수 선언 및 초기화
					// TODO: cartList의 모든 상품을 반복하며 출력							
					int sum = 0;
					for(int i = 0 ; i < cartList.size() ; i++) {
						Product product = cartList.get(i);
						int total = product.getUnitPrice() * product.getQuantity();
						sum += total;					
						
				%>
				<tr>
					<td><%= product.getName() %></td>			
					<td><%= product.getUnitPrice() %></td>			
					<td><%= product.getQuantity() %></td>
					<td><%= total %></td>
					<td></td>
			    <% } %>	
				<%		
					// TODO: 장바구니가 비어있는지 확인
					if( cartList.isEmpty() ) {
					
				%>
				<tr>
					<td colspan="5">추가된 상품이 없습니다.</td>	
				</tr>
				<% } else { %>
				<tr>
					<td></td>
					<td></td>
					<td>총액</td>
					<td><%= sum %></td>
					<td></td>
				</tr>
				<%
					}
				%>
			</tfoot>
		</table>
	</div>
	
	<!-- 버튼 영역 -->
	<div class="d-flex justify-content-between mt-5 mb-5">
		<div class="item">
			<a href="../shipment/add.jsp" class="btn btn-lg btn-success">이전</a>
			<!-- 취소 프로세스는 이어서... -->				
			<a href="" class="btn btn-lg btn-danger">취소</a>				
		</div>
		<div class="item">
			<input type="hidden" name="login" value="<%= login %>" />
			<input type="hidden" name="totalPrice" value="<%= sum %>" />
			<input type="submit" class="btn btn-lg btn-primary" value="주문완료" />	
		</div>
	</div>
	</form>
</div>

<jsp:include page="/layout/script.jsp" />
<jsp:include page="/layout/footer.jsp" />