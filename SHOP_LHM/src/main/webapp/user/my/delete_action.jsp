<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shop.dto.User"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%
    /**
    * TODO: 세션에서 로그인한 사용자의 id를 얻어와서
    * userDAO 객체의 delete() 메서드를 호출하여
    * 해당 사용자의 데이터를 데이터베이스에서 삭제한다.
    * 삭제가 성공하면 complete.jsp 페이지로 리다이렉트하고,
    * 실패하면 "회원삭제가 안됐습니다..."라는 메시지를 출력한 후
    * update.jsp 페이지로 리다이렉트한다.
    */
    String loginId = (String) session.getAttribute("loginId");

    if (loginId == null) {
        response.sendRedirect("login.jsp");
        return;
    }   
    
    int result = userDAO.delete(loginId);
    if (result > 0 ){
    	// 세션 속성 모두 제거 : 세션 무효화
    	session.invalidate();
        response.sendRedirect("complete.jsp?msg=3");
    } else {
    	out.println("<script>alert('회원삭제가 안됐습니다...'); location.href='update.jsp';</script>");
    }
    
%>