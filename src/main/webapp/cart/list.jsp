<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.CartItemDao"%>
<%@page import="vo.CartItem"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>marketbooks</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.coverimage { display: block; margin: 0 auto; width: 70px; object-fit: contain }
	input { width: 80%; }
	.text-middle-center {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
</style>
</head>
<body>
<!-- common 파일 import (nav, footer) -->
<!-- 사용자 상호작용 관련 작업 
	 1. 체크박스 토글 (재요청시에도 상태 유지)
	 2. 수량 버튼 클릭 시 modify.jsp 요청 -> list.jsp 재요청받음
	 3. 삭제 버튼 클릭 시 delete.jsp 요청 -> list.jsp 재요청받음
	 3. 배송지 입력 클릭시 address/list.jsp를 요청 -> 팝업으로 해당 사용자의 배송지 리스트를 조회하는 새 페이지가 뜬다.
	 4. 카트리스트 정보, 수량 반영해서 결제금액 정보 띄우기
	 4. 주문 버튼 클릭하면 입력값 + order.jsp 요청
 -->
<!-- DB 관련 작업
	 1. 세션에서 사용자정보 획득, 로그인 체크
		User user = (User) session.getAttribute("LOGINED_USER");
	 2. 카트아이템 정보 List<CartItemDto> 획득하기
	 3. cartList.isEmpty() 가 true이면 "장바구니에 담긴 상품이 없습니다."
	 4. false이면 for문으로 뿌리기
	 5. 장바구니 아이템 수량변경
	 6. 장바구니 아이템 한 개 삭제, 여러 개 삭제
	 -->
<div class="contatiner">
   	<div class="row">
		<div class="col">
			<h1 class="fs-4 p-2 mb-3 border text-center">임시헤더</h1>
		</div>
	</div>
</div>
<div class="container" style="min-width: 1200px; max-width: 1200px">
   	<div class="row">
		<div class="col">
			<h1 class="fs-4 p-2 mb-3 text-center">장바구니</h1>
		</div>  
	</div>
	<%
		// TO DO: 로그인된 사용자 정보 조회
		//		 로그인된 사용자가 NULL이거나, cartItem의 userNo와 로그인된 사용자의 userNo가 다를 경우 경고메시지를 띄우고 로그인페이지로 이동한다.
		int userNo = 110;
		
		// 해당 사용자의 장바구니아이템 Dto 리스트, 리스트 내 객체 개수 획득
		CartItemDao cartItemDao = CartItemDao.getInstance();
		List<CartItem> cartItemList = cartItemDao.getCartItemsByUser(userNo);
		int cartItemListSize = cartItemList.size();
		
		// 재요청에 대한 응답일 경우 요청객체에서 체크 상태를 유지할 아이템번호 획득
		String[] checkedValues = request.getParameterValues("checkedItemNo");
		// null일 경우 빈 list 객체를 대입한다.
		List<String> checkedItemNos = checkedValues == null ? new ArrayList<>() : Arrays.asList(checkedValues);
	%>
	<!-- 잘못된 수량으로 update.jsp를 요청했을 경우 fail값 획득하여 경고메시지 표시-->
	<%	
		String fail = request.getParameter("fail");
		if ("quantityInvalid".equals(fail)) {
	%>
	<div class="alert alert-danger">
		<strong>수량이 올바르지 않습니다.</strong>
	</div>
	<%
		}
		if ("stockInvalid".equals(fail)) {
	%>
	<div class="alert alert-danger">
		<strong>입력하신 수량보다 재고가 부족합니다.</strong>
	</div>	
	<%		
		}
	%>
	
	<!-- action의 값에는 각 폼입력값이 변경상태에 따른 요청url(order.jsp, delete.jsp, modify.jsp) 가 대입된다. 
		onsubmit="return submitOrderForm();" : 폼 제출시 submitOrderForm()의 반환값이 false이면 제출되지 않는다. -->
	<form id="cart-form" method="get" action="" >
		<div class="row">
			<div class="col-9 mb-3 pb-3 border-bottom border-dark">
				<div class="row">
					<div class="col-1">
						<!-- TO DO : 카트아이템 dao 작업으로 인한 재요청 시 checked 상태 유지 구현하기 -->
						<input type="checkbox" id="all-toggle-checkbox" onchange="toggleCheckbox(); changeCheckBoxNumber(<%=cartItemListSize %>);"/>
					</div>
					<div class="col-5">
						<span class="border-end me-3 pe-3" id="checked-number">전체선택(<%=checkedItemNos.size() %>/<%=cartItemListSize %>)</span>
						<a class="link-dark text-decoration-none" href="javascript:deleteCheckedItems();">선택삭제</a>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<!-- 장바구니 리스트 조회, 변경, 삭제 -->
			<div class="col-9 <%=cartItemList.isEmpty()? "text-middle-center" : "" %>">
			<%
				if (cartItemList.isEmpty()) {
			%>
				<span class="align-middle">장바구니에 담긴 상품이 없습니다.</span>
			<%
				} else {
			%>
				<!-- form 전달값 -->
				<input type="hidden" name="job" id="hidden-job" />
				<input type="hidden" name="itemNo" id="hidden-itemNo" />
				<input type="hidden" name="quantity" id="hidden-quantity" />
				<table class="table">
					<colgroup>
						<col width="5%">
						<col width="5%">
						<col width="*">
						<col width="15%">
						<col width="12%">
						<col width="8%">
						<col width="12%">
						<col width="8%">
					</colgroup>
					<tbody>
					<%
						for (CartItem item : cartItemList) {
					%>			
						<!-- tr태그의 id는 "item-row-카트아이템번호" 이다. -->
						<tr id="item-row-<%=item.getNo() %>">
							<td class="align-middle">
								<input type="checkbox" class="book-checkbox" 
									 <%=checkedItemNos.contains(String.valueOf(item.getNo())) ? "checked" : "" %>
									name="checkedItemNo" value="<%=item.getNo() %>" onchange="changeCheckbox(); changeCheckBoxNumber(<%=cartItemListSize %>);"/>
							</td>
							<td  class="align-middle">
								<img alt="cover image" src="../image/book-<%=item.getBook().getNo() %>.jpg" class="rounded coverimage"/>
							</td>
							<td class="align-middle">
								<span id="item-title-<%=item.getNo() %>"><%=item.getBook().getTitle() %></span>
							</td>
							<td class="align-middle">
								<span id="item-author-<%=item.getNo() %>"><%=item.getBook().getAuthor() %></span>
							</td>
							<td class="align-middle">
								<span id="item-publisher-<%=item.getNo() %>"><%=item.getBook().getPublisher() %></span>
							</td>
							<td class="align-middle">
								<input type="number" class="form-control w-100 mb-3" min="1" value="<%=item.getQuantity() %>" id="item-quantity-<%=item.getNo() %>" onchange="updateQuantity(<%=item.getNo() %>);"/>
							</td>
							<td class="align-middle">
							<%
								int totalDiscountPrice = item.getBook().getDiscountPrice() * item.getQuantity();
								int totalPrice = item.getBook().getPrice() * item.getQuantity();
							%>
								<strong id="item-total-discount-price-<%=item.getNo() %>"><%=StringUtil.numberToCurrency(totalDiscountPrice) %></strong>원<br/>
								<small class="text-decoration-line-through" style="<%=totalPrice == totalDiscountPrice ? "display:none" : "" %>">
									<span id="item-total-price-<%=item.getNo() %>"><%=StringUtil.numberToCurrency(totalPrice) %></span>원
								</small>
							</td>
							<td  class="align-middle">
								<button type="button" class="btn btn-outline-danger btn-sm" onclick="deleteItem(<%=item.getNo() %>);">삭제</button>
							</td>
						</tr>
					<%
						}
					%>
					</tbody>
				</table>
			<%
				}
			%>
			</div>
			<!--  배송지 입력, 총 금액 조회, 주문 버튼 -->
			<div class="col-3">
				<div class="card mb-3">
					<div class="card-body">
						<!-- addressList.jsp에서 재요청하면서 보낸 addressNo를 받아서 DB에서 해당 배송지정보를 조회하고 출력한다.-->
						<h6 class="card-title">배송지</h6>
						<p>사용자가 선택한 배송지 주소가 이곳에 출력됩니다.</p>
						<div class="d-grid gap-2">
							<button class="btn btn-outline-secondary btn-sm"
							onclick="submitFormNewWindow('addressList.jsp', 'addressList');">배송지 변경</button>
						</div>
					</div>
					<div class="card-footer text-muted">
						<div class="row mt-3 mb-3"><div class="col">주문금액</div><div class="col"><strong id="order-total-price">0</strong>원</div></div>
						<div class="row mb-3"><div class="col">주문할인금액</div><div class="col"><strong id="order-discount-amount">0</strong>원</div></div>
						<div class="row mb-3 pb-3 border-bottom"><div class="col">배송비</div><div class="col"><strong id="item-ship-price">0</strong>원</div></div>
						<div class="row mb-3"><div class="col">결제예정금액</div><div class="col"><strong id="order-pay-price">0</strong>원</div></div>
					</div>
				</div>
				<div class="d-grid gap-2">
					<!-- 아래 버튼을 누르면 체크된 카트아이템 번호가 orderform.jsp로 전달된다. -->
				    <button type="button" class="btn btn-primary" onclick="submitForm('orderform.jsp');" >주문하기</button>
				</div>
			</div>
		</div>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	// 주문정보 DOM객체 리프레쉬 (Dao 작업으로 인한 재요청 시 필요)
	changeOrderInfo();
	
	/*
		all-toggle-checkbox의 체크상태가 변경되는 이벤트 핸들러 함수
        all-toggle-checkbox의 체크상태가 변경되면 input[name="book-checkbox"]의 상태를 같이 변경한다.
	*/
	function toggleCheckbox() {
		let allToggleCheckboxCheckedStatus = document.getElementById("all-toggle-checkbox").checked;
		
		// bookCheckboxList의 모든 체크박스 상태를 allToggleCheckbox와 같게 만든다.
		let bookCheckboxList = document.querySelectorAll(".book-checkbox");
		for (let checkbox of bookCheckboxList) {
			checkbox.checked = allToggleCheckboxCheckedStatus;
		}
		
		changeOrderInfo();
	}
	
	/*
		장바구니 아이템의 체크박스의 체크상태가 변경될 때마다 실행되는 이벤트핸들러 함수
	*/
	function changeCheckbox() {
		// 체크된 체크박스의 개수가 전체 체크박스의 개수와 같으면 전체 토글 체크박스의 상태를 변경
		let allToggleCheckboxElement = document.getElementById("all-toggle-checkbox");
		let bookCheckboxsLength = document.querySelectorAll(".book-checkbox").length;
		let checkedBookCheckboxsLength = document.querySelectorAll(".book-checkbox:checked").length;

		if (bookCheckboxsLength === checkedBookCheckboxsLength) {
			allToggleCheckboxElement.checked = true;
		} else {
			allToggleCheckboxElement.checked = false;
		}
		
		changeOrderInfo();
	}
	
	/*
		폼 입력값의 변화에 따라 화면에 출력된 전체 주문정보를 페이지 이동 없이 변경한다.(실제 order 객체의 값이 아니다) (ajax)
		체크박스 선택, 카트아이템 삭제, 수량 변경 시 각각 해당하는 이벤트핸들러함수 내에서 이 함수를 실행시킨다.
	*/
	function changeOrderInfo() {
		// 내용을 출력할 DOM객체
		let totalPriceElement = document.getElementById("order-total-price"); 
		let discountAmountElement = document.getElementById("order-discount-amount"); 
		let payPriceElement = document.getElementById("order-pay-price"); 
		
		// 체크박스가 checked 상태인 카트아이템의 번호를 모두 획득 후, for문으로 전체 계산
		let checkedBookCheckboxList = document.querySelectorAll(".book-checkbox:checked");
		let totalPrice = 0;
		let payPrice = 0;
		for (let bookCheckbox of checkedBookCheckboxList) {
			let itemNo = bookCheckbox.value;
		// 일반 금액 합계
			totalPrice += parseInt(document.getElementById("item-total-price-" + itemNo).textContent.replaceAll(",",""));
		// 할인된 금액 합계 (결제예정금액)
			payPrice += parseInt(document.getElementById("item-total-discount-price-" + itemNo).textContent.replaceAll(",",""));
		}
		
		// 할인받는 금액 합계 = 일반 금액 합계 - 할인된 금액 합계
		totalPriceElement.textContent = totalPrice.toLocaleString();
		discountAmountElement.textContent = (totalPrice - payPrice).toLocaleString();
		payPriceElement.textContent = payPrice.toLocaleString(); // 현재는 배송비, 쿠폰, 적립금 등 적용이 없어 주문할인금액 = 결제 예정 금액이다.
	}
	
	/*
		체크박스 선택 상태가 달라질 때마다 선택된 개수를 변경한다.
	*/
	function changeCheckBoxNumber(cartItemListSize) {
		// 내용을 출력할 DOM객체
		let checkBoxNumberElement = document.getElementById("checked-number");
		// 체크된 체크박스의 개수
		let checkedCheckBoxNumber = document.querySelectorAll(".book-checkbox:checked").length;
		// DOM객체 컨텐츠 변경
		checkBoxNumberElement.textContent = "전체선택(" + checkedCheckBoxNumber + "/" + cartItemListSize + ")";
	}
	
	/*
		사용자가 input[type=number] 태그에서 수량을 변경할 때마다 실행되는 이벤트핸들러 함수
	*/
	function updateQuantity(updateItemNo) {
		// td 태그에 표시된 금액 정보를 변경한다.
		// dao 작업: modify.jsp에 요청을 보내 DB의 카트아이템 정보를 변경한다.
		let quantityElement = document.getElementById("item-quantity-" + updateItemNo);
		let quantity = quantityElement.value;
		
		// hidden태그 값 설정하기
		document.getElementById("hidden-itemNo").value = updateItemNo;
		document.getElementById("hidden-quantity").value = quantity;
		
		//form 제출하기
		submitForm("update.jsp");
	}
	
	// 개별삭제
	function deleteItem(deleteItemNo) {
		document.getElementById("hidden-job").value = "one";
		document.getElementById("hidden-itemNo").value = deleteItemNo;
		
		submitForm("delete.jsp");
	}
	
	// 선택삭제
	function deleteCheckedItems() {
		document.getElementById("hidden-job").value = "all";
		
		submitForm("delete.jsp");
	}
	
	/*
		form 입력값에 대하여 지정된 URL로 form 요청을 보내는 이벤트핸들러 함수
		선택삭제버튼 클릭: delete.jsp, 주문하기 버튼: orderform.jsp로 요청을 보낸다.
	*/
	function submitForm(requestURL) {
		let form = document.getElementById("cart-form");
		form.setAttribute("action", requestURL);
		
		// form태그의 submit으로 서버에 제출하면, name=value 쌍으로 존재하는 입력값을 요청파라미터로 전달된다.
		// 체크 박스의 경우 checked 상태인 값만 전달된다.
		// 요청 URL: delete.jsp?no=1001&no=1003 (checked 상태인 값들만)
		//			order.jsp?no=1001&no=1003 (checked 상태인 값들만)
		form.submit();
		// 요청페이지에서 dao 작업 후, 재요청으로 다시 list.jsp를 불러온다.	
	}
	
	function submitFormNewWindow(requestURL, windowname) {
		window.open(requestURL, windowname, 'width=500,height=750'); 
		
		let form = document.getElementById("cart-form");

		// 자식창에 cart-form의 입력값을 전달한다. (체크된 아이템번호를 전달하기 위함)
		form.setAttribute("target", windowname);
		form.setAttribute("action", requestURL);
		
		form.submit();
	}
	
</script>
</body>
</html>