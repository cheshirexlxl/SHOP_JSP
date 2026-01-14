<!-- 로그인 처리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>

<%
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");	
	
	// 체크박스 값
    String rememberId = request.getParameter("rememberId");   // 아이디 저장
    String rememberMe = request.getParameter("rememberMe");     // 자동 로그인
	
	UserRepository userDAO = new  UserRepository();
	User loginUser = userDAO.login(id, pw);
	
	// TODO: 로그인 실패
	// - 로그인 페이지로 이동(에러코드 전달)
	if (loginUser == null) {
        response.sendRedirect("login.jsp?error=0");
        return;
    }
	
	
	// TODO: 로그인 성공
	// - 세션에 아이디(loginId) 등록	
    session.setAttribute("loginId", loginUser.getId());
    session.setAttribute("loginUser", loginUser);
    
	// - 주문목록(orderList) 초기화
	//  (로그인 후 주문목록은 새로 조회해야 하므로 null로 설정)
	session.setAttribute("orderList", null);
	
	// - 아이디 저장, 자동 로그인 쿠키 처리
	// 아이디 저장 쿠키
	Cookie idCookie = null;

    if (rememberId != null) {   // 체크됨
        idCookie = new Cookie("rememberId", loginUser.getId());
    } else {                    // 체크 해제
        idCookie = new Cookie("rememberId", "");
        idCookie.setMaxAge(0);  // 삭제
    }

    idCookie.setPath("/");
    response.addCookie(idCookie);
    
    // 자동 로그인 쿠키
    Cookie rememberMeCookie = null;

    if (rememberMe != null) {
        // 토큰 생성
        String token = UUID.randomUUID().toString();

        rememberMeCookie = new Cookie("rememberMeToken", token);
        rememberMeCookie.setMaxAge(60 * 60 * 24 * 7); // 7일
        rememberMeCookie.setPath("/");

        response.addCookie(rememberMeCookie);

        // 🔥 실무라면 여기서 token을 DB에 저장해야 함
        // userDAO.updateAutoLoginToken(loginUser.getId(), token);
    } else {
    	rememberMeCookie = new Cookie("rememberMeToken", "");
    	rememberMeCookie.setMaxAge(0); // 삭제
    	rememberMeCookie.setPath("/");
        response.addCookie(rememberMeCookie);
    }
    
	// - 로그인 성공 페이지로 이동
	
	// TODO: 아이디 저장
	// - 아이디 저장 체크 시 : 쿠키 생성
	// - 아이디 저장 체크 해제 시 : 쿠키 삭제
	
	// TODO: 자동 로그인
	// - 자동 로그인 체크 시 : 쿠키 생성(토큰 발급)
	// - 자동 로그인 체크 해제 시 : 쿠키 삭제
	
	
	
	// TODO: 쿠키 전달
	// - 모든 경로에서 접근 가능하도록 설정
	// - 자동 로그인, 토큰 쿠키는 7일간 유지
	// - 아이디 저장, 로그인 아이디 쿠키는 세션 종료 시 삭제(기본값)
	
	// TODO: 로그인 성공 페이지로 이동
	// - 메시지 코드 전달(0: 로그인 성공)
	response.sendRedirect("complete.jsp?msg=0");		

%>