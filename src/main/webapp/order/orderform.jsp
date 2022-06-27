<%@page import="vo.UserAddress"%>
<%@page import="dao.UserAddressDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.CartItem"%>
<%@page import="dao.CartItemDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link href="../css/home.css" rel="stylesheet">
<style type="text/css">
	.coverimage { display: block; margin: 0 auto; width: 70px; object-fit: contain }

	.td-definition {
		padding: 8px;
	}
	
	.accordion-button:focus {
		box-shadow: none;
		border: none;
		color: black;
		background-color: white;
	}
	
	.btn-group input:checked + label, .btn-group input:hover + label {
		background-color: #5f0080!important;
	}
	
	.kakaopay-btn input:checked + label, .kakaopay-btn input:hover + label {
		border: gray;
		color: black!important;
		background-color: #f6e500!important;
	}

</style>
</head>
<body>
<!-- DB 관련 작업
	1. cart/list.jsp에서 받아온 checkedItemNo를 이용해 cartItem 정보를 모두 조회하고, hidden타입의 input태그를 생성, 주문상품 아코디언 창에도 출력한다. => 둘다 for문 돌려야 하니까 같은 위치에 넣기
	2. session객체에 저장된 user객체를 확인하고, 주문자 정보 란에 사용자 정보를 출력한다.
	3. cart/list.jsp에서 받아온 selectedAddressNo를 이용해 userAddress객체를 확인하고, 배송 정보 란에 출력한다.
	4. 카트아이템 번호, 배송지번호, 주문제목(편의상 추가), 결제수단을 요청파라미터로 order.jsp에 폼을 제출한다. (추가작업: 주문 상세정보)
	* 금액 계산 정보는 URL을 통해 악의적인 조작이 가능하므로 pay.jsp에서 자체적으로 다시 계산한다.
	5. order.jsp에서는 카트아이템번호를 사용해 orderItem과 '결제완료' 상태의 order 객체를 생성한다.
	6. DB의 hta_orderItems, hta_orders에 저장하고, hta_books의 재고를 변경시킨다. 
	7. DB의 hta_cartItems에서 주문에 사용한 카트아이템을 삭제한다.
 -->
<!-- 화면 표현, 사용자 상호작용 작업 
	1. DB 관련 작업에서 획득한 cartItem 정보를 이용해 주문정보, 결제금액 내용을 계산해 출력한다.
	2. 카카오페이, 간편결제, 휴대폰 클릭 시 첫 화면에 출력된 신용카드 관련 입력 element를 숨긴다.
	3. 신용카드 클릭 시 신용카드 관련 입력 element를 출력한다. 
	4. 결제 진행 필수 동의 관련 보기 링크를 클릭하면 모달창이 뜬다.
	5. 결제 진행 필수 동의를 체크하지 않고 결제하기 버튼을 누르면, 폼이 제출되지 않고 경고창을 띄운다.
	6. 결제수단 중 카카오페이를 선택하고 결제하기 버튼을 누르면, 카카오페이 결제 팝업이 뜬다. 그 외 결제수단은 order.jsp로 바로 이동한다.
	7. (추가 작업) 상세정보 수정하기를 누르면 입력폼이 표현된 모달창이 뜬다. 
-->
<%
	CartItemDao cartItemDao = CartItemDao.getInstance();
	UserAddressDao userAddressDao = UserAddressDao.getInstance();

	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int userNo = user.getNo();
	
	// 요청객체에서 선택한 배송지 번호를 획득 : 배송지 정보가 NULL일 경우 장바구니 페이지로 이동하고, fail=invalid값을 전달한다.
	int selectedAddressNo = StringUtil.stringToInt(request.getParameter("selectedAddressNo"));
	UserAddress selectedAddress = userAddressDao.getAddressByNo(selectedAddressNo);
	if (selectedAddress == null || selectedAddress.getUserNo() != userNo) {
		response.sendRedirect("../cart/list.jsp?fail=invalid");
		return;
	}
	
	// 요청객체에서 전달한 장바구니아이템 번호를 획득 : 전달한 장바구니아이템번호가 없을 경우 장바구니 페이지로 이동하고, fail=invalid값을 전달한다.
	String[] checkedValues = request.getParameterValues("checkedItemNo");
	if (checkedValues == null) {
		response.sendRedirect("../cart/list.jsp?fail=invalid");
		return;
	}
	
	// 사용자 장바구니아이템 리스트와 비교하여, 유효하지 않은 번호(존재하지 않거나, 다른 사용자의 장바구니아이템인 경우)를 제외하고 주문할 카트아이템 리스트를 새로 생성한다.
	List<CartItem> cartItemList = new ArrayList<>(); 
	for (String value : checkedValues) {
		int cartItemNo = StringUtil.stringToInt(value);
		CartItem cartItem = cartItemDao.getCartItemByNo(cartItemNo);
		if (cartItem != null && cartItem.getUserNo() == userNo) {
			cartItemList.add(cartItem);
		}
	}
	
	// 화면에 출력하고, 편의상 폼 제출에도 전달할 주문제목 문자열을 생성한다.
	String orderTitle = "";
	if (cartItemList.size() == 1) {
		orderTitle = "[" + cartItemList.get(0).getBook().getTitle() + "]";
	} else {
		orderTitle = "[" + cartItemList.get(0).getBook().getTitle() + "] 외 " + (cartItemList.size() - 1) + "개";
	}
	
%>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container mb-5" style="min-width: 1200px; max-width: 1200px">
   	<div class="row">
		<div class="col">
			<h1 class="fs-3 p-5 mb-3 text-center"><strong>주문서</strong></h1>
		</div>  
	</div>
	<form id="order-form" method="post" action="pay.jsp" onsubmit="return checkRequiredAllow();">
		<!-- 주문할 카트아이템 번호, 배송지 번호, 결제금액 계산결과를 hidden 타입의 input태그에 저장해 전달한다. -->
		<input type="hidden" name="selectedAddressNo" value="<%=selectedAddressNo %>" />
	<%
		for (CartItem cartItem : cartItemList) {
	%>
		<input type="hidden" name="cartItemNo" value="<%=cartItem.getNo() %>" />
	<%
		}
	%>
		<input type="hidden" name="orderTitle" value="<%=orderTitle %>" />
		<div class="row mb-5" id="order-items-row">
			<!-- 1. 주문상품 %%%외 %개 상품을 주문합니다. : 화살표를 클릭하면 주문상품리스트가 펼쳐진다. -->
			<div class="accordion accordion-flush m-0 p-0" id="accordionFlush">
				<div class="accordion-item">
				    <div class="accordion-header" id="flush-headingOne">
				    	<button class="accordion-button collapsed ps-0 border-bottom border-dark rounded-0" type="button" 
				    	data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne" 
				    	onclick="displaySummary(event);">
				    		<h5><strong>주문상품</strong></h5>
				    	</button>
				    </div>
				    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlush">
					    <div class="accordion-body">
					     	<!-- 선택한 장바구니 아이템 리스트 출력 -->
					     	<table class="table" id="order-items-table">
					     		<colgroup>
					     			<col width="10%">
					     			<col width="*">
					     			<col width="15%">
					     			<col width="10%">
					     			<col width="10%">
					     			<col width="10%">
					     		</colgroup>
					     		<tbody>
								<!-- 체크한 장바구니 아이템을 for문으로 출력한다.-->
								<%
									for (CartItem cartItem : cartItemList) {
								%>
					     			<tr  id="item-row-<%=cartItem.getNo() %>" class="align-middle">
					     				<td><img alt="cover image" src="../images/bookcover/book-<%=cartItem.getBook().getNo() %>.jpg" class="rounded coverimage"></td>
					     				<td><%=cartItem.getBook().getTitle() %></td>
					     				<td><%=cartItem.getBook().getAuthor() %></td>
					     				<td><%=cartItem.getBook().getPublisher() %></td>
					     				<td class="text-end"><%=cartItem.getQuantity() %> 권</td>
					     				<td class="text-end"><strong><%=StringUtil.numberToCurrency(cartItem.getBook().getDiscountPrice()*cartItem.getQuantity()) %> 원</strong></td>
					     			</tr>
								<%
									}
								%>
					     		</tbody>
					     	</table>
					    </div>
				    </div>
				</div>
			</div>
			<!-- 주문상품 버튼을 누르면 아래 태그가 숨겨진다. -->
			<div class="text-center p-5 border-bottom border-gray fw-bold" id="order-title"><%=orderTitle %> 상품을 주문합니다.</div>
		</div>
		<!-- 2. 주문자 정보: 보내는 분, 휴대폰, 이메일 -->
		<div class="row mb-5" id="user-info-row">
			<h5 class="p-3 ps-0 mb-3 border-bottom border-dark">
				<strong>주문자 정보</strong>
			</h5>
			<table class="user-info-table">
				<colgroup>
					<col width="16%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<td><strong>보내는 분</strong></td>
						<td class="td-definition">
							<div><%=user.getName() %></div>
						</td>
					</tr>
					<tr>
						<td><strong>휴대폰</strong></td>
						<td class="td-definition">
							<div><%=user.getTel() %></div>
						</td>
					</tr>
					<tr>
						<td><strong>이메일</strong></td>
						<td class="td-definition">
							<div class="mt-3 mb-3"><%=user.getEmail() %></div>
							<span class="text-muted lh-base"><strong>이메일을 통해 주문처리과정을 보내드립니다.</strong></span><br/>
							<span class="text-muted lh-base"><strong>정보 변경은 마이페이지 > 개인정보 수정 메뉴에서 가능합니다.</strong></span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 3. 배송 정보 : 배송지 , 상세정보(order 컬럼 추가해야 하는지? 일단 공간만 만들어놓기)-->
		<div class="row mb-5" id="address-info-row">
			<h5 class="p-3 ps-0 mb-3 border-bottom border-dark"><strong>배송 정보</strong></h5>
			<table class="user-info-table">
				<colgroup>
					<col width="16%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<td><strong>배송지</strong></td>
						<td class="td-definition">
							<div><%=selectedAddress.getAddress() %> <%=selectedAddress.getDetailAddress() %></div>
						</td>
					</tr>
					<tr>
						<td><strong>상세정보</strong></td>
						<td class="td-definition">
							<div class="mt-3 mb-3"><%=user.getName() %>, <%=user.getTel() %></div>
							<span class="text-muted lh-base"><strong class="pe-2 border-end border-gray">문 앞</strong><strong class="ps-2">공동현관 비밀번호</strong></span><br/>
							<span class="text-muted lh-base"><strong class="pe-2 border-end border-gray">배송 완료 메시지</strong><strong class="ps-2">배송직후</strong></span><br/>
							<!-- 추후 구현 시 모달 기능 추가-->
							<button type="button" class="btn btn-sm btn-outline-secondary px-3 my-3" data-bs-toggle="modal">수정</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 4. 적립금, 결제수단 선택/ 결제금액 표시 카드 -->
		<div class="row mb-5" id="pay-info-row">
			<div class="col-9">
			
				<!-- TO DO: 적립금 사용은 추후 DB 수정, Dao 수정과 함께 반영해야 함 
				<div class="mb-5">
					<h5 class="p-3 ps-0 mb-3 border-bottom border-dark"><strong>적립금</strong></h5>
				</div>
				-->
				<div class="row mb-5">
					<h5 class="p-3 ps-0 mb-3 border-bottom border-dark"><strong>결제 수단</strong></h5>
					<!-- TO DO: 결제 수단 선택 버튼, 결제 수단에 따른 옵션 선택 -->
					<!-- 결제수단: 카카오페이, 신용카드, 간편결제, 휴대폰
						카카오페이를 선택했을 때는 openAPI로 연결하고, 나머지는 바로 결제완료 창으로 보내기 -->
					<div class="col-8 m-auto p-3">
						<div class="btn-group w-100 mb-3 kakaopay-btn" role="group" aria-label="Basic radio toggle button group">
							<input type="radio" class="btn-check" name="payMethod" value="kakaopay" id="btnradio1" autocomplete="off" onchange="displayInfo('kakaopay')">
							<label class="btn btn-sm btn-outline-dark p-3 px-5 round-0" for="btnradio1">카카오페이</label>
						</div>
						<div class="btn-group w-100 mb-5" role="group" aria-label="Basic radio toggle button group">
							<input type="radio" class="btn-check" name="payMethod" value="creditcard" id="btnradio2" autocomplete="off" value="신용카드" checked onchange="displayInfo('creditcard')">
							<label class="btn btn-sm btn-outline-dark p-3 px-5 round-0" for="btnradio2">신용카드</label>
							
							<input type="radio" class="btn-check" name="payMethod" value="simplepay" id="btnradio3" autocomplete="off" onchange="displayInfo('simplepay')">
							<label class="btn btn-sm btn-outline-dark p-3 px-5 round-0" for="btnradio3">간편결제</label>
							
							<input type="radio" class="btn-check" name="payMethod" value="mobilepay" id="btnradio4" autocomplete="off" onchange="displayInfo('mobilepay')">
							<label class="btn btn-sm btn-outline-dark p-3 px-5 round-0" for="btnradio4">휴대폰</label>
						</div>
						<!-- 위 라디오버튼 선택에 따라 다른 html 내용이 출력된다. -->
						<div id="payment-method-info">
							<div class="d-none" id="kakaopay">
									<span class="fw-bold p-3 text-muted">※ 카카오페이, 차이, 토스, 네이버페이, 페이코 결제 시, 결제하신 수단으로만</span><br/>
									<span class="fw-bold p-3 text-muted">환불되는 점 양해부탁드립니다.</span>
							</div>
							<div id="creditcard">
								<select class="form-select mb-3">
									<option>현대(무이자)</option>
									<option>신한</option>
									<option>비씨(페이북)</option>
									<option>KB국민</option>
									<option>삼성</option>
									<option>롯데</option>
									<option>하나</option>
								</select>
								<select class="form-select mb-3">
									<option>일시불</option>
									<option>2개월(무이자)</option>
									<option>3개월(무이자)</option>
									<option>4개월(무이자)</option>
									<option>5개월(무이자)</option>
									<option>6개월(무이자)</option>
									<option>7개월(무이자)</option>
									<option>8개월</option>
									<option>9개월</option>
									<option>10개월</option>
									<option>11개월</option>
									<option>12개월</option>
								</select>
								<span class="fw-bold p-3 text-muted">무이자 할부 유의사항: 은행계열/체크/기프트/선불/법인/개인사업자 기업카드는 제외</span>
							</div>
							<div class="d-none" id="simplepay">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" id="simplepay-1">
										<label class="form-check-label" for="inlineRadio1">차이</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" id="simplepay-2">
										<label class="form-check-label" for="inlineRadio2">토스</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" id="simplepay-3">
										<label class="form-check-label" for="inlineRadio3">네이버페이</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" id="simplepay-4">
										<label class="form-check-label" for="inlineRadio4">페이코</label>
									</div><br/>
									<span class="fw-bold p-3 text-muted">※ 카카오페이, 차이, 토스, 네이버페이, 페이코 결제 시, 결제하신 수단으로만</span><br/>
									<span class="fw-bold p-3 text-muted">환불되는 점 양해부탁드립니다.</span>
							</div>
							<div class="d-none" id="mobilepay">
									<span class="fw-bold p-3 text-muted">※ 카카오페이, 차이, 토스, 네이버페이, 페이코 결제 시, 결제하신 수단으로만</span><br/>
									<span class="fw-bold p-3 text-muted">환불되는 점 양해부탁드립니다.</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-3">
					<h5 class="p-3 ps-0"><strong>결제금액</strong></h5>
					<div class="card">
						<div class="card-body text-bg-light">
							<div class="row mt-3 mb-3">
								<div class="col">주문금액</div>
								<div class="col text-end"><strong id="info-discounted-price">0</strong> 원</div>
							</div>
							<div class="row mt-1 mb-1 text-muted">
								<div class="col">
									<span>ㄴ 상품금액</span>
								</div>
								<div class="col text-end"><span><strong id="info-total-price">0</strong> 원</span></div>
							</div>
							<div class="row mt-1 mb-1 text-muted">
								<div class="col">
									<span>ㄴ 상품할인금액</span>
								</div>
								<div class="col text-end"><span><strong id="info-discount-amount">0</strong> 원</span></div>
							</div>
							<div class="row mt-3 mb-3">
								<div class="col">배송비</div>
								<div class="col text-end"><strong id="info-ship-price">+ 0</strong> 원</div>
							</div>
							<!-- TO DO : 적립금 사용은 추후 DB 수정, Dao 수정과 함께 반영해야 함 -->
							<!-- 
							<div class="row mt-3 mb-3 pb-3 border-bottom">
								<div class="col">적립금사용</div>
								<div class="col text-end"><strong id="point-discount">0</strong> 원</div>
							</div>
							-->
							<div class="row mt-3 mb-3">
								<div class="col">최종결제금액</div>
								<div class="col text-end"><strong id="info-pay-price"> 0</strong> 원</div>
							</div>
						</div>
					</div>
			</div>
		</div>
		<!-- 5. 개인정보 수집/제공: 체크하지 않으면 결제버튼 넘어가지 않고 alert창이 뜬다. 보기 버튼을 누르면 모달 창이 뜬다.-->
		<div class="row mb-5 border-bottom border-gray" id="agree-checkbox-row">
			<h5 class="p-3 ps-0 mb-3 border-bottom border-dark"><strong>개인정보 수집 / 제공</strong></h5>
			<table class="agree-checkbox-table table table-borderless table-sm">
				<colgroup>
					<col width="5%">
					<col width="30%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<td class="text-center">
							<input type="checkbox" id="agree-checkbox"/>
						</td>
						<td>
							<div class="fs-5 fw-bold mb-1">결제 진행 필수 동의</div>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							개인정보 수집 · 이용 및 처리 동의<span class="text-muted"> (필수)</span>
						</td>
						<td>
							<!-- 모달 창으로 약관 정보 출력 -->
							<a href="#terms-1" class="text-decoration-none fw-bold" style="color:#5f0080;" data-bs-toggle="modal">보기></a>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<!-- 모달 창으로 약관 정보 출력 -->
							전자지급 결제대행 서비스 이용약관 동의<span class="text-muted"> (필수)</span>
						</td>
						<td>
							<a href="#terms-2" class="text-decoration-none fw-bold" style="color:#5f0080;" data-bs-toggle="modal">보기></a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 6. %%원 결제하기 버튼, 안내 텍스트 -->
		<div class="row mb-5" id="order-button-row">
			<div class="col-5 mx-auto text-center">
				<button class="btn fs-6 fw-bold" style="background-color:#5f0080; color:white; --bs-btn-padding-y: 1em; --bs-btn-padding-x: 4em;"><span id="button-pay-price">0</span> 원 결제하기</button>	
				<p class="text-muted my-3 fw-bold lh-base">
					<span>[배송준비중] 이전까지 주문취소 가능합니다.</span><br>
					<span>미성년자가 결제 시 법정대리인이 그 거래를 취소할 수 있습니다.</span><br>
					<span>상품 미배송 시, 결제수단으로 환불됩니다.</span>
				</p>
			</div>
		</div>
	</form>
	
	<!-- TO DO: 배송 상세정보 기능 구현 시 배송 정보 상세 수정 모달 추가-->	
	
	<!-- 개인정보 수집 / 제공 동의 관련 모달 -->
	<div class="modal fade" id="terms-1" tabindex="-1" aria-labelledby="terms1leModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title fw-bold" id="terms1ModalLabel">
		        	개인정보 수집 · 이용 및 처리 동의<span class="text-muted"> (필수)</span>
		        </h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body border-bottom">
		        개인정보 수집 · 이용 및 처리 동의 관련 내용이 이곳에 출력됩니다.
		      </div>
		      <div class="modal-footer border-0 m-auto">
		        <button type="button" class="btn" data-bs-dismiss="modal">확인</button>
		      </div>
		    </div>
		  </div>
	</div>
	<div class="modal fade" id="terms-2" tabindex="-1" aria-labelledby="terms2ModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title fw-bold" id="terms2ModalLabel">
		        	전자지급 결제대행 서비스 이용약관 동의<span class="text-muted"> (필수)</span>
		        </h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body border-bottom">
		        전자지급 결제대행 서비스 이용약관 동의 약관이 이곳에 출력됩니다.
		      </div>
		      <div class="modal-footer border-0 m-auto">
		        <button type="button" class="btn" data-bs-dismiss="modal">확인</button>
		      </div>
		    </div>
		  </div>
	</div>
</div>	
<jsp:include page="../common/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	// cart/list.jsp에서 로컬스토리지에 저장한 계산정보를 가져와 화면에 출력한다.
	let cartInfo = JSON.parse(localStorage.getItem('cartInfo'));
	
	document.getElementById("info-discounted-price").textContent = (cartInfo.discountedPrice).toLocaleString();
	document.getElementById("info-total-price").textContent = (cartInfo.totalPrice).toLocaleString();
	document.getElementById("info-discount-amount").textContent = (cartInfo.totalPrice - cartInfo.discountedPrice).toLocaleString();
	document.getElementById("info-ship-price").textContent = (cartInfo.shipPrice).toLocaleString();
	document.getElementById("info-pay-price").textContent = (cartInfo.payPrice).toLocaleString();
	document.getElementById("button-pay-price").textContent = (cartInfo.payPrice).toLocaleString();
	
	/*
		결제하기 버튼을 누르면 실행되는 이벤트핸들러함수
		개인정보 수집/제공 동의란에 체크하지 않으면 폼 제출을 하지 않고, alert창을 띄운다.
	*/
	function checkRequiredAllow() {
		
		let allowCheckbox = document.getElementById("agree-checkbox");
		if (!allowCheckbox.checked) {
			alert("결제 진행 필수 동의란에 체크해주세요.");
			return false;
		}
		
		return true;
	}

	/*
		주문상품 아코디언을 클릭하면 실행되는 이벤트핸들러함수
		아코디언이 닫혀있을 때는 주문정보 요약 텍스트가 보이고, 열려있을 때는 보이지 않도록 한다.
	*/
	function displaySummary(e) {
		let summary = document.getElementById('order-title');
		if (e.target.getAttribute('aria-expanded') === 'true') {
			summary.classList.add('d-none'); 
		} else {
			summary.classList.remove('d-none'); 
		}
	}
	
	/*
		결제수단 라디오버튼을 선택하면 실행되는 이벤트핸들러함수
		#payment-method-info 내의 div 태그 중 특정 id를 가진 태그만 보여주도록 한다.
	*/
	function displayInfo(id) {
		let infos = document.querySelectorAll("#payment-method-info > div");
		for (let i = 0; i < infos.length; i++) {
			infos[i].classList.add('d-none');
		}
		
		document.getElementById(id).classList.remove('d-none');
	}
</script>
</body>
</html>