<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓북스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon"
	href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"
	type="image/x-icon">
<style type="text/css">
	.text-middle-center {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
</style>
</head>
<body>
<!-- 주문 완료 후 로딩되는 주문완료 페이지 -->
<!-- 화면 및 사용자 상호작용 구현 내용
	1. 고객님의 주문이 완료되었습니다.
	2. 전달받은 주문번호, 결제금액, 배송관련 안내사항 출력 (orderNo의 사용자정보가 로그인한 사용자정보와 일치하지 않을 경우 에러페이지로 이동)
	3. '주문 상세보기' 링크 -> 마이페이지 주문내역조회 페이지 내 해당 주문내역 상세페이지로 이동 
	4. '쇼핑 계속하기' 링크 -> 홈화면으로 이동
<!-- DB 관련 구현 내용 : 없음 -->
<%
	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int userNo = user.getNo();
	
	// 요청객체에서 주문번호를 획득 : 주문번호가 NULL이거나 로그인 사용자의 주문정보가 아닐 경우 예외를 던진다.
	int orderNo = StringUtil.stringToInt(request.getParameter("orderNo"));
	OrderDao orderDao = OrderDao.getInstance();
	Order order = orderDao.getOrderByNo(orderNo);
	if (order == null || order.getUserNo() != userNo) {
		throw new RuntimeException("잘못된 요청입니다.");
	}
	
%>
<div class="contatiner">
   	<div class="row">
		<div class="col">
			<h1 class="fs-4 p-2 mb-3 border text-center">임시헤더</h1>
		</div>
	</div>
</div>
<div class="container my-auto" style="min-width: 600px; max-width: 600px; height: 700px;">
	<div class="row align-items-center" style="min-height: 700px;">
		<div class="col-12">
		   	<div class="row p-3">
				<div class="col-12 text-center" id="complete-title">
					<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#5f0080" class="bi bi-check-circle" viewBox="0 0 16 16">
					  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
					  <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z"/>
					</svg>
					<h1 class="fs-5 p-3 fw-bold"><%=user.getName() %>님의 주문이 완료되었습니다.</h1>
				</div>  
			</div>
			<div class="row text-middle-center fw-bold text-muted mb-5" id="payPrice-info">
				<div class="col-3">
					<small>결제금액</small>
				</div>
				<div class="col-3 text-end">
					<small><%=StringUtil.numberToCurrency(order.getTotalPayPrice()) %>원</small>
				</div>
			</div>
			<div class="row text-middle-center" id="customer-info-list">
				<div class="col-8 text-muted">
					<ul style="list-style-type: circle;">
						<li><small>[배송준비중] 이전일 때 주문내역 상세페이지에서 주문 취소가 가능합니다.</small></li>
						<li><small>엘리베이터 이용이 어려운 경우 6층 이상부터는 공동현관 앞 또는 경비실로 대응 배송될 수 있습니다.</small></li>
						<li><small>주문 / 배송 및 기타 문의가 있을 경우, 1:1 문의에 남겨주시면 신속히 해결해드리겠습니다.</small></li>
					</ul>
				</div>
			</div>
			<div class="row p-5">
				<div class="col-12 text-center">
					<div class="d-grid gap-2 col-6 mx-auto">
						<a href="detail.jsp?orderNo=<%=orderNo %>" class="btn fw-bold" style="border-color:#5f0080; color:#5f0080;">주문 상세보기</a>
						<a href="../home.jsp" class="btn btn-primary fw-bold" style="background-color:#5f0080; color:white;">쇼핑 계속하기</a>
					</div>		
				</div>
			</div>
		</div>
	</div>
</div>
<div class="contatiner">
   	<div class="row">
		<div class="col">
			<h1 class="fs-4 p-2 mb-3 border text-center">임시푸터</h1>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>