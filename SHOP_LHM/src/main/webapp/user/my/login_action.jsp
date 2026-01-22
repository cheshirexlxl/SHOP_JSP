<!-- 로그인 처리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.PersistentLogin"%>

<%
	String root = request.getContextPath();

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");		
	
    String rememberId = request.getParameter("remember-id");   // 아이디 저장
    String rememberMe = request.getParameter("remember-me");   // 자동 로그인
	
	UserRepository userDAO = new  UserRepository();
	User loginUser = userDAO.login(id, pw);	

	// 로그인 실패 - 로그인 페이지로 이동(에러코드 전달)
	if (loginUser == null) {
        response.sendRedirect("login.jsp?error=0");
        return;
    }
	
	// TODO: 로그인 성공 -----------------------------------------------------	
	// - 세션에 아이디(loginId) 등록	
    session.setAttribute("loginId", loginUser.getId());	
    
	// - 주문목록(orderList) 초기화
	//  (로그인 후 주문목록은 새로 조회해야 하므로 null로 설정)
	session.setAttribute("orderList", null);
	
	// TODO: 아이디 저장 -----------------------------------------------------	
	
	Cookie cookieRememberId = new Cookie("rememberId", "");
	Cookie cookieUserId = new Cookie("loginId", "");
	cookieRememberId.setPath("/");
	cookieUserId.setPath("/");	

	// 아이디 저장 체크 시 - 값 : on
    if ( rememberId != null && rememberId.equals("on") ) {   
    	// 체크됨
    	// 쿠키 생성
		cookieRememberId.setValue( URLEncoder.encode(rememberId, "UTF-8") );
		cookieUserId.setValue( URLEncoder.encode(id, "UTF-8") );		
		// 쿠키 만료시간 설정 - 7일 (/초)    	
    	cookieRememberId.setMaxAge(60 * 60 * 24 * 7);     
    	cookieUserId.setMaxAge(60 * 60 * 24 * 7);     	
    } else {                    
    	// 체크 해제     	
    	// 쿠키 삭제 - 쿠키 유효시간을 0으로 하고 응답
		cookieRememberId.setMaxAge(0);
		cookieUserId.setMaxAge(0);		
    }
 	// 응답에 쿠키 등록
	response.addCookie(cookieRememberId);
	response.addCookie(cookieUserId);
    
	
	// TODO: 자동 로그인 -----------------------------------------------------

	Cookie cookieRememberMe = new Cookie("rememberMe", "");
	Cookie cookieToken = new Cookie("token", "");
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	
	// 쿠키 만료시간 설정 - 7일 (/초)
	cookieRememberMe.setMaxAge(60 * 60 * 24 * 7); 
	cookieToken.setMaxAge(60 * 60 * 24 * 7);

    if (rememberMe != null && rememberMe.equals("on")) {
    	// 자동 로그인 체크 시 - 토큰 발행    	
    	String token = userDAO.refreshToken(id);
    	PersistentLogin persistenceLogin = null;
    	if( token != null ) {
    		persistenceLogin = new PersistentLogin();
    	    persistenceLogin.setUserId(id);
    	    persistenceLogin.setToken(token);
    	    persistenceLogin.setDate(new java.sql.Timestamp(System.currentTimeMillis()));
		}
		// 쿠키 생성
		cookieRememberMe.setValue( URLEncoder.encode(rememberMe, "UTF-8") );
		cookieToken.setValue( URLEncoder.encode(token, "UTF-8") );
    } else {
    	// 자동 로그인 미체크 시 - 쿠키 삭제
    	cookieRememberMe.setMaxAge(0);
		cookieToken.setMaxAge(0);
    }
    
    response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	
	// TODO: 로그인 성공 페이지로 이동 - 메시지 코드 전달(0: 로그인 성공)
	response.sendRedirect("complete.jsp?msg=0");		

%>