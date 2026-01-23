<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dao.ProductIORepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dto.Order"%>
<%@page import="shop.dto.Ship"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<% 
	String root = request.getContextPath();

	// TODO: 쿠키에 저장된 배송정보를 저장할 변수 선언 및 초기화	
	String ship_cartId = "";
	String ship_name = "";
	String ship_date = "";
	String ship_country = "";
	String ship_zipCode = "";
	String ship_addressName = "";
	String ship_phone = "";

	
	// TODO: 쿠키 배열이 null이 아니면 반복문으로 각 쿠키 처리
	Cookie[] cookies = request.getCookies();
	
	// Order 객체 생성
	Order order = new Order();	

	// 쿠키에서 배송 정보 꺼내기
	if( cookies != null ) {
		for(int i = 0 ; i < cookies.length ; i++) {
			Cookie cookie = cookies[i];
			String cookieName = cookie.getName();
			String cookieValue = URLDecoder.decode( cookie.getValue(), "UTF-8" );
			switch(cookieName) {
			 	case "ship_cartId" 			: ship_cartId = cookieValue; order.setCartId(cookieValue); break;
			 	case "ship_name" 			: ship_name = cookieValue; order.setShipName(cookieValue); break;
			 	case "ship_date" 			: ship_date = cookieValue; order.setDate(cookieValue); break;
			 	case "ship_country" 		: ship_country = cookieValue; order.setCountry(cookieValue); break;
			 	case "ship_zipCode" 		: ship_zipCode = cookieValue; order.setZipCode(cookieValue); break;
			 	case "ship_addressName" 	: ship_addressName = cookieValue; order.setAddress(cookieValue); break;
			 	case "ship_phone" 			: ship_phone = cookieValue; order.setPhone(cookieValue); break;
			}
		}
	}		

	// TODO: 세션에서 로그인 아이디 가져오기
	String loginId = (String) session.getAttribute("loginId");
	loginId = loginId != null ? loginId : "";	
	order.setUserId(loginId);

	// TODO: 회원/비회원 주문 처리를 위한 파라미터 가져오기
	String loginStr = request.getParameter("login");
	
	// 총 금액
	String totalPrice = request.getParameter("totalPrice");
	int total = 0;

	if(totalPrice != null && !totalPrice.isEmpty()) {
		total = Integer.parseInt(totalPrice);
	}	
	order.setTotalPrice(total);

	// 비회원 주문 비밀번호
	String orderPw = request.getParameter("orderPw");
	order.setOrderPw(orderPw);

	// TODO: 주문 내역 등록
	OrderRepository orderDAO = new OrderRepository();	
	int orderNo = orderDAO.insert(order);		
	

	// TODO: 세션에서 장바구니 목록 가져오기
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");		
	
	// 객체 생성
	ProductIORepository productIODAO = new ProductIORepository();
	ProductRepository productDAO = new ProductRepository();
	
	if (cartList != null) {
	    for (Product product : cartList) {
	        product.setOrderNo(orderNo);
	        product.setUserId(loginId);
	        product.setType("OUT");              // 상품 입출고 타입	       

	        productIODAO.insert(product);     	 // 출고 등록
	        productDAO.update(product);          // 상품 재고수 갱신		        
	    }
	}	

	// 장바구니 세션 삭제
	session.setAttribute("cartList", null);
	
	// 배송 쿠키 삭제
	if (cookies != null) {
	    for (int i = 0; i < cookies.length; i++) {
	        Cookie cookie = cookies[i];
	        String cookieName = cookie.getName();
	        cookie.setValue("");

	        switch (cookieName) {
	            case "ship_cartId" 			: cookie.setMaxAge(0); break;
			 	case "ship_name" 			: cookie.setMaxAge(0); break;
			 	case "ship_date" 			: cookie.setMaxAge(0); break;
			 	case "ship_country" 		: cookie.setMaxAge(0); break;
			 	case "ship_zipCode" 		: cookie.setMaxAge(0); break;
			 	case "ship_addressName" 	: cookie.setMaxAge(0); break;
	        }
	        response.addCookie(cookie);
	    }
	}

	// 주문 완료 페이지 이동
	response.sendRedirect(root + "/user/order/complete.jsp?cartId=" + ship_cartId + "&addressName=" + URLEncoder.encode(ship_addressName, "UTF-8"));
	
%>