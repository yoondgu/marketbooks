<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String menu = request.getParameter("menu");

%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	.list-group a {
		font-size: small;
    }
	
	.list-group a.active {
		color: #5f0080;
		--bs-list-group-active-bg: #fff;
		--bs-list-group-active-border-color: rgba(0, 0, 0, 0.125);
	}

	.list-group a:hover {
		color: #5f0080;
		--bs-list-group-active-bg: #fff;
		--bs-list-group-active-border-color: rgba(0, 0, 0, 0.125);
	}
</style>

<div>
	<h5 class="p-3 ps-0 mb-3 fw-bold">마이북스</h5>
	<div class="list-group fw-bold me-3" id="menu">
		<a href="/marketbooks/mypage/orderlist.jsp" class="<%="order".equals(menu)? "active" : "" %> list-group-item list-group-item-action p-3 d-flex justify-content-between align-items-center" aria-current="true">
			<span>주문내역</span>
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
				<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</a>
		<a href="/marketbooks/mypage/addressList.jsp" class="<%="address".equals(menu)? "active" : "" %> list-group-item list-group-item-action p-3 d-flex justify-content-between align-items-center">
			<span>배송지 관리</span>
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
				<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</a>
		<a href="#" class="<%="review".equals(menu)? "active" : "" %> list-group-item list-group-item-action p-3 d-flex justify-content-between align-items-center">
			<span>상품 리뷰</span>
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
				<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</a>
		<a href="#" class="<%="user".equals(menu)? "active" : "" %> list-group-item list-group-item-action p-3 d-flex justify-content-between align-items-center">
			<span>개인정보 수정</span>
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
				<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</a>
	</div>
</div>