<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="header">

	<!-- 화면 최상단 가입이벤트문구(링크) -->
	<div class="bnr_header">
		지금 가입하고 인기상품 <b>100원</b>에 받아가세요!
	</div>

	<!-- 유저 메뉴 -->
	<div class="">
		<div class="btn-group">
			<a href="loginform.jsp" class="">로그인 </a> 
			<a href="registerform.jsp" class="">회원가입 </a>
			<a href="" class="">고객센터</a>
		</div>
	</div>

	<!-- 헤더 로고 -->
	<div class="">
		<h1 class="">
			<img src="images/logo_marketbooks.png" alt="">
		</h1>
	</div>

	<!-- 헤더 nav -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">	전체 카테고리 </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#"> 인문학 </a></li>
							<li><a class="dropdown-item" href="#"> 사회/과학 </a></li>
							<li><a class="dropdown-item" href="#"> 소설 </a></li>
							<li><a class="dropdown-item" href="#"> 역사 </a></li>
							<li><a class="dropdown-item" href="#"> 예술/대중문화 </a></li>
						</ul>
					</li>
					<li class="nav-item"><a class="nav-link" href="#">신상품</a></li>
					<li class="nav-item"><a class="nav-link" href="#">베스트</a></li>
					<li class="nav-item"><a class="nav-link" href="#">알뜰쇼핑</a></li>
					<li class="nav-item"><a class="nav-link" href="#">특가/혜택</a></li>
				</ul>
				<form class="d-flex">
					<input class="form-control me-5" type="search" placeholder="검색어를 입력해주세요." aria-label="Search">
					<input type="image" src="https://res.kurly.com/pc/service/common/1908/ico_search_x2.png" class="btn_search">
				</form>

			</div>
		</div>
	</nav>
</div>