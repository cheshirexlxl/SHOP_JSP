<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<jsp:include page="/layout/header.jsp" />

<div class="px-4 py-5 mt-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">로그인</h1>
</div>

<!-- 로그인 영역 -->
<main class="form-signin login-box w-100 m-auto">
  <form action="login_pro.jsp" method="post">
    <div class="form-floating">
      <input type="text" class="form-control" id="floatingInput" name="id" 
      		 value="" placeholder="아이디" autofocus>
      <label for="floatingInput">아이디</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control" id="floatingPassword" name="pw" placeholder="비밀번호">
      <label for="floatingPassword">비밀번호</label>
    </div>

    <div class="form-check text-start my-3 d-flex justify-content-around">
    	<div class="item">    	    
	      <input class="form-check-input" type="checkbox" name="remember-id" id="flexCheckDefault1">		  	
	      <label class="form-check-label" for="flexCheckDefault1">아이디 저장</label>
    	</div>
    	<div class="item">
	      <input class="form-check-input" type="checkbox" name="remember-me" id="flexCheckDefault2">
	      <label class="form-check-label" for="flexCheckDefault2">자동 로그인</label>
    	</div>
      
    </div>
    <p class="text-center text-danger">
    	
    </p>
    
    <div class="d-grid gap-2">
	    <button class="btn btn-primary w-100 py-2" type="submit">로그인</button>
	    <a href="${ root }/user/join.jsp" class="btn btn-success w-100 py-2">회원가입</a>
    </div>
  </form>
</main>

<jsp:include page="/layout/script.jsp" />
<jsp:include page="/layout/footer.jsp" />