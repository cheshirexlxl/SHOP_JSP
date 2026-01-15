<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	

	// TODO: 아이디 저장, 자동 로그인 쿠키 삭제
	// /logout - 로그아웃
	String root = request.getContextPath();
	System.out.println("로그아웃...");
	session = request.getSession();	
	
	// TODO: 세션 무효화
	
	// TODO: 쿠키 전달
	
	
	session.invalidate();				// 세션 속성 모두 제거 : 세션 무효화
	response.sendRedirect(root + "/");	// 로그아웃 후 메인화면으로 이동	
	
%>