<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shop.dao.UserRepository"%>
<%	

	// TODO: 아이디 저장, 자동 로그인 쿠키 삭제
	// /logout - 로그아웃
	String root = request.getContextPath();
	System.out.println("로그아웃...");
	
	// 쿠키 제거
	// - 자동 로그인, 토큰
	Cookie cookieRememberMe = new Cookie("rememberMe", "");
	Cookie cookieToken = new Cookie("token", "");
	Cookie[] deleteCookies = { cookieRememberMe, cookieToken };	
	for (int i = 0; i < deleteCookies.length; i++) {
		Cookie cookie = deleteCookies[i];
		cookie.setPath("/");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
	}

	// 자동 로그인 토큰 삭제	
	UserRepository userDAO = new  UserRepository();
	String userId = (String) session.getAttribute("loginId");
	int result = userDAO.deleteToken(userId);
	System.out.println("자동 로그인 토큰 삭제 : " + result);	
	
	session.invalidate();				// 세션 속성 모두 제거 : 세션 무효화
	response.sendRedirect(root + "/");	// 로그아웃 후 메인화면으로 이동	
	
%>