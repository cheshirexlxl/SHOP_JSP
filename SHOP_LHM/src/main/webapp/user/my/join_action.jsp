<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ include file="/layout/common.jsp" %>
<%
	User user = new User();
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String pw_confirm = request.getParameter("pw_confirm");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birth = year + "/" + month + "/" + day;
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email = email1 + "@" + email2;
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");		
	
	// 비밀번호 확인
    if (!pw.equals(pw_confirm)) {
        response.sendRedirect("join.jsp");
        return;
    }

 	// TODO: User 객체에 회원 가입 정보를 설정한다.
    user.setId(id);
    user.setPassword(pw);
    user.setName(name);
    user.setGender(gender);
    user.setBirth(birth);
    user.setMail(email);
    user.setPhone(phone);
    user.setAddress(address);
    
	// TODO: 회원 정보 등록 요청
 	// UserRepository 객체를 생성하고 insert() 메서드를 호출하여 회원 정보를 데이터베이스에 저장한다.
    UserRepository userRepository = new UserRepository();
    int result = userRepository.insert(user);

 	// 회원 가입이 성공하면 complete.jsp 페이지로 리다이렉트한다.
 	// 실패하면 join.jsp 페이지로 리다이렉트한다.
    if (result > 0) {
        response.sendRedirect("complete.jsp?msg=1");
    } else {
        response.sendRedirect("join.jsp");
    }
	
%>