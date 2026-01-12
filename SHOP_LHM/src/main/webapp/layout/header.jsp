<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<jsp:include page="/layout/top.jsp" />

<nav class="navbar bg-dark navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="/">Home</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/shop/products.jsp">Product</a></li>
			</ul>
			<ul class="navbar-nav d-flex align-items-center px-3">

				<!-- 비로그인 시 -->
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="/user/login.jsp">로그인</a></li>
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="/user/join.jsp">회원가입</a></li>
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="/user/order.jsp">주문내역</a></li>

				<li class="nav-item"><a class="nav-link position-relative"
					aria-current="page" href="/shop/cart.jsp"> <i
						class="material-symbols-outlined">shopping_bag</i> <span
						class="cart-count">0</span>
				</a></li>
			</ul>
			<form class="d-flex" role="search" action="/shop/products.jsp"
				method="get">
				<input class="form-control me-2" type="search" name="keyword"
					placeholder="Search" aria-label="Search" value="">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
		</div>
	</div>
</nav>
