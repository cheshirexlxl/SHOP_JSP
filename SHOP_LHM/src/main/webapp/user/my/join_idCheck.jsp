<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shop.dao.UserRepository"%>
<%@ include file="/layout/common.jsp" %>
<%
	// 아이디 중복 확인	
    String userId = request.getParameter("id");	

    UserRepository userRepository = new UserRepository();
    boolean exists = userRepository.userIdCheck(userId);

    if (exists) {
        out.println("DUPLICATE");
    } else {
    	out.println("OK");
    }
%>