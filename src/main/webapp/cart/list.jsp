<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>marketbooks</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .cartlist div { text-align: left; padding: 3px 7px; }
	.coverimage { display: block; margin: 0 auto; width: 70px; object-fit: contain }
	input { width: 80%; }
</style>
</head>
<body>
<!-- common 파일 import (nav, footer) -->
<!-- 사용자 상호작용 관련 작업 
	 1. 체크박스 토글 
	 2. 수량 버튼 클릭 시 장바구니 아이템 수량변경, 주문 정보 변경
	 3. 삭제 버튼 클릭 시 체크된 장바구니 아이템 삭제, 장바구니 정보 변경
	 3. 배송지 입력 - api창 구현
	 4. 카트리스트 정보, 수량 반영해서 결제금액 정보 띄우기
	 4. 주문 버튼 클릭하면 입력값 + order.jsp 요청
 -->
<!-- DB 관련 작업
	 1. 세션에서 사용자정보 획득, 로그인 체크
		User user = (User) session.getAttribute("LOGINED_USER");
	 2. 카트아이템 정보 List<CartItemDto> 획득하기
	 	List<CartItemDto> cartList = cartItemDto.getCartListByUser(int userNo) 
	 3. cartList.isEmpty() 가 true이면 "장바구니에 담긴 상품이 없습니다."
	 4. false이면 for문으로 뿌리기
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
	<!-- submitOrderForm() 함수가 false를 반환하면 form태그 값의 입력값이 order.jsp로 전달되지 않는다. -->
	<form method="post" action="order.jsp" onsubmit="return submitOrderForm()">
		<input type="hidden" >
		<div class="row">
			<div class="col-9 mb-3 pb-3 border-bottom border-dark">
				<div class="row">
					<div class="col-1">
						<input type="checkbox" id="all-toggle-checkbox" onchange="toggleCheckbox();"/>
					</div>
					<div class="col-5">
						<!-- 카트 전체 수량, 선택한 카트 수량 반영 -->
						<span class="border-end me-3 pe-3">전체선택(3/3)</span>
						<a class="link-dark text-decoration-none" href="javascript:removeCheckedItem()">선택삭제</a>
					</div>
					<div class="col-6">
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<!-- 장바구니 리스트 조회, 변경, 삭제 -->
			<div class="col-9">
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
						<!-- tr태그의 id는 "item-row-카트아이템번호" 이다. -->
						<tr id="item-row-1001">
							<td class="align-middle">
								<input type="checkbox" name="book-checkbox" value="1001" onchange="changeCheckbox();"/>
							</td>
							<td  class="align-middle">
								<!-- 커버이미지 파일은 sample-책번호 포맷으로 저장해두고 가져온다. cartItem.getBookNo() -->
								<img alt="cover image" src="../image/sample-24.jpg" class="rounded coverimage"/>
							</td>
							<td class="align-middle">
								<span id="item-title-1001">세상의 마지막 기차역</span>
							</td>
							<td class="align-middle">
								<span id="item-author-1001">무라세 다케시</span>
							</td>
							<td class="align-middle">
								<span id="item-publisher-1001">모모</span>
							</td>
							<td  class="align-middle">
								<input type="number" class="form-control w-100 mb-3" min="1" value="1" id="item-quantity-1001" onchange="changeQuantity(1001);"/>
							</td>
							<td  class="align-middle">
								<!-- hidden 태그에 들어있는 값은 한권에 대한 금액, 할인된 한 권에 대한 금액이다. 
									할인가격 item-total-discount-price:(한 권에 대한 할인된 금액)*수량
									일반가격 item-total-price: (한 권에 대한 금액)*수량
									할인가격과 일반가격이 같을 경우, 할인가격만 표시
									할인가격과 일반가격이 다를 경우, 할인가격 표시, 일반가격 취소선으로 표시 -->
								<input type="hidden" name="item-price-1001" value="14000" />
								<input type="hidden" name="item-discount-price-1001" value="12600" />
								<strong id="item-total-discount-price-1001">12,600</strong> 원<br/>
								<small class="text-decoration-line-through"><span id="item-total-price-1001">14,000</span>원</small>
							</td>
							<td  class="align-middle">
								<button type="button" class="btn btn-outline-danger btn-sm" onclick="removeItem(1001);">삭제</button>
							</td>
						</tr>
						<tr id="item-row-1002">
							<td class="align-middle">
								<input type="checkbox" name="book-checkbox" value="1002" onchange="changeCheckbox();"/>
							</td>
							<td  class="align-middle">
								<!-- 커버이미지 파일은 sample-책번호 포맷으로 저장해두고 가져온다. cartItem.getBookNo() -->
								<img alt="cover image" src="../image/sample-1.jpg" class="rounded coverimage"/>
							</td>
							<td class="align-middle">
								<span id="item-title-1002">높은 자존감의 사랑법</span>
							</td>
							<td class="align-middle">
								<span id="item-author-1002">정아은</span>
							</td>
							<td class="align-middle">
								<span id="item-publisher-1002">마름모</span>
							</td>
							<td  class="align-middle">
								<input type="number" class="form-control w-100 mb-3" min="1" value="1" id="item-quantity-1002" onchange="changeQuantity(1002);"/>
							</td>
							<td  class="align-middle">
								<!-- hidden 태그에 들어있는 값은 한권에 대한 금액, 할인된 한 권에 대한 금액이다. 
									할인가격 item-total-discount-price:(한 권에 대한 할인된 금액)*수량
									일반가격 item-total-price: (한 권에 대한 금액)*수량
									할인가격과 일반가격이 같을 경우, 할인가격만 표시
									할인가격과 일반가격이 다를 경우, 할인가격 표시, 일반가격 취소선으로 표시 -->
								<input type="hidden" name="item-price-1002" value="16000" />
								<input type="hidden" name="item-discount-price-1002" value="14400" />
								<strong id="item-total-discount-price-1002">14,400</strong> 원<br/>
								<small class="text-decoration-line-through"><span id="item-total-price-1002">16,000</span>원</small>
							</td>
							<td  class="align-middle">
								<button type="button" class="btn btn-outline-danger btn-sm" onclick="removeItem(1002);">삭제</button>
							</td>
						</tr>
						<tr id="item-row-1003">
							<td class="align-middle">
								<input type="checkbox" name="book-checkbox" value="1003" onchange="changeCheckbox();"/>
							</td>
							<td  class="align-middle">
								<!-- 커버이미지 파일은 sample-책번호 포맷으로 저장해두고 가져온다. cartItem.getBookNo() -->
								<img alt="cover image" src="../image/sample-2.jpg" class="rounded coverimage"/>
							</td>
							<td class="align-middle">
								<span id="item-title-1003">크게 그린 사람</span>
							</td>
							<td class="align-middle">
								<span id="item-author-1003">은유</span>
							</td>
							<td class="align-middle">
								<span id="item-publisher-1003">한겨레출판</span>
							</td>
							<td  class="align-middle">
								<input type="number" class="form-control w-100 mb-3" min="1" value="1" id="item-quantity-1003" onchange="changeQuantity(1003);"/>
							</td>
							<td  class="align-middle">
								<!-- hidden 태그에 들어있는 값은 한권에 대한 금액, 할인된 한 권에 대한 금액이다. 
									할인가격 item-total-discount-price:(한 권에 대한 할인된 금액)*수량
									일반가격 item-total-price: (한 권에 대한 금액)*수량
									할인가격과 일반가격이 같을 경우, 할인가격만 표시
									할인가격과 일반가격이 다를 경우, 할인가격 표시, 일반가격 취소선으로 표시 -->
								<input type="hidden" name="item-price-1003" value="16000" />
								<input type="hidden" name="item-discount-price-1003" value="14400" />
								<strong id="item-total-discount-price-1003">14,400</strong> 원<br/>
								<small class="text-decoration-line-through"><span id="item-total-price-1003">16,000</span>원</small>
							</td>
							<td  class="align-middle">
								<button type="button" class="btn btn-outline-danger btn-sm" onclick="removeItem(1003);">삭제</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--  배송지 입력, 총 금액 조회, 주문 버튼 -->
			<div class="col-3">
				<div class="card mb-3">
					<div class="card-body">
					<!-- 배송지 변경은 adress를 저장하고, user에 반영시킨다. -->
						<h6 class="card-title">배송지</h6>
						<p>사용자가 선택한 배송지 주소가 이곳에 출력됩니다.</p>
						<div class="d-grid gap-2">
							<a href="#" class="btn btn-outline-secondary btn-sm">배송지 변경</a>
						</div>
					</div>
					<div class="card-footer text-muted">
						<div class="row mt-3 mb-3"><div class="col">주문금액</div><div class="col"><strong id="order-total-price">35,000</strong>원</div></div>
						<div class="row mb-3"><div class="col">주문할인금액</div><div class="col"><strong id="order-discount-amount">0</strong>원</div></div>
						<div class="row mb-3 pb-3 border-bottom"><div class="col">배송비</div><div class="col"><strong id="item-ship-price">0</strong>원</div></div>
						<div class="row mb-3"><div class="col">결제예정금액</div><div class="col"><strong id="order-pay-price">35,000</strong>원</div></div>
					</div>
				</div>
				<div class="d-grid gap-2">
				    <button type="submit" class="btn btn-primary">주문하기</button>
				</div>
			</div>
		</div>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	/*
		all-toggle-checkbox의 체크상태가 변경되는 이벤트 핸들러 함수
        all-toggle-checkbox의 체크상태가 변경되면 input[name="book-checkbox"]의 상태를 같이 변경한다.
	*/
	function toggleCheckbox() {
		let allToggleCheckboxCheckedStatus = document.getElementById("all-toggle-checkbox").checked;
		let bookCheckboxList = document.querySelectorAll("input[name='book-checkbox']");
		
		// bookCheckboxList의 모든 체크박스 상태를 allToggleCheckbox와 같게 만든다.
		for (let checkbox of bookCheckboxList) {
			checkbox.checked = allToggleCheckboxCheckedStatus;
		}
		
		//TO DO : 구매정보 갱신하기
		changeOrderInfo();
	}
	
	/*
		장바구니 아이템의 체크박스의 체크상태가 변경될 때마다 실행되는 이벤트핸들러 함수
	*/
	function changeCheckbox() {
		// 체크된 체크박스의 개수가 전체 체크박스의 개수와 같으면 전체 토글 체크박스의 상태를 변경
		let allToggleCheckboxElement = document.getElementById("all-toggle-checkbox");
		let bookCheckboxsLength = document.querySelectorAll("input[name='book-checkbox']").length;
		let checkedBookCheckboxsLength = document.querySelectorAll("input[name='book-checkbox']:checked").length;

		if (bookCheckboxsLength === checkedBookCheckboxsLength) {
			allToggleCheckboxElement.checked = true;
		} else {
			allToggleCheckboxElement.checked = false;
		}
		
		//TO DO : 구매정보 갱신하기
		console.log("changeCheckbox() 테스트")
		changeOrderInfo();
	}
	
	/*
		폼 입력값의 변화에 따라 화면에 출력된 전체 주문정보를 페이지 이동 없이 변경한다.(실제 order 객체의 값이 아니다) (ajax)
		체크박스 선택, 카트아이템 삭제, 수량 변경 시 각각 해당하는 이벤트핸들러함수 내에서 이 함수를 실행시킨다.
	*/
	function changeOrderInfo() {
		console.log("changeOrderInfo() 테스트");
		// 출력할 DOM객체
		let totalPriceElement = document.getElementById("order-total-price"); 
		let discountAmountElement = document.getElementById("order-discount-amount"); 
		let payPriceElement = document.getElementById("order-pay-price"); 
		
		// 체크박스가 checked 상태인 전체 카트아이템을 획득 후, for문으로 전체 계산
		// 일반 금액 합계
		// 할인된 금액 합계
		// 할인받는 금액 합계 = 일반 금액 합계 - 할인된 금액 합계
		// 결제 예정 금액: 일반 금액 합계 - 할인받는 금액 합계
		
	}
	
	/*
		사용자가 input[type=number] 태그에서 수량을 변경할 때마다 실행되는 이벤트핸들러 함수
	*/
	function changeQuantity(itemNo) {
		// td 태그에 표시된 금액 정보를 변경한다.
		// dao 작업: ajax로 update.jsp에 요청을 보내 DB의 카트아이템 정보를 변경한다.
		// changeOrderInfo 함수 실행 : dao작업과 별개로 화면에 표시된 전체 주문정보를 갱신한다. 화면 표시용으로 가격, 구매수량을 조회해서 계산된 값을 DOM객체에 넣는다. 
		console.log("changeQuantity() 테스트");
		// 변경할 DOM객체 획득
		let totalBookPriceElement = document.getElementById("item-total-price-" + itemNo);
		let totalBookDiscountPriceElement = document.getElementById("item-total-discount-price-" + itemNo);
		
		// 한 권에 대한 금액정보 획득
		let bookPrice = document.querySelector("input[name='item-price-" + itemNo + "']").value;
		let bookDiscountPrice = document.querySelector("input[name='item-discount-price-" + itemNo + "']").value;
		// 수량 획득
		let changedQuantity = document.getElementById("item-quantity-" + itemNo).value;
				
		// 한 권에 대한 금액정보, 수량을 이용하여 금액 계산 후 DOM 객체에 반영
		totalBookPriceElement.textContent = (bookPrice*changedQuantity).toLocaleString();
		totalBookDiscountPriceElement.textContent = (bookDiscountPrice*changedQuantity).toLocaleString();
		
		// TO DO: ajax로 dao작업
		
		changeOrderInfo();
	}
	
	/*
		개별 카트아이템을 버튼 클릭하여 삭제할 때마다 실행되는 이벤트핸들러 함수
	*/
	function removeItem(itemNo) {
		// 화면에 표시된 카트아이템 엘리먼트를 지운다.
		// dao 작업: ajax로 delete.jsp에 요청을 보내 DB의 카트아이템 정보를 변경한다.
		// changeOrderInfo 함수 실행 : dao작업과 별개로 화면에 표시된 전체 주문정보를 갱신한다. 화면 표시용으로 가격, 구매수량을 조회해서 계산된 값을 DOM객체에 넣는다. 
		console.log("removeItem() 테스트");
		// 삭제할 DOM 객체 획득
		let cartItemElement = document.getElementById("item-row-" + itemNo);
		cartItemElement.remove();
		
		// TO DO: ajax로 dao작업
		
		changeOrderInfo();
	}
	
	/*
		선택삭제 버튼을 클릭할 때마다 실행되는, checkbox가 checked 상태인 카트아이템을 모두 삭제시키는 이벤트핸들러 함수
	*/
	function removeCheckedItem() {
		// 화면에 표시된 카트아이템 엘리먼트를 지운다.
		// dao 작업: ajax로 delete.jsp에 요청을 보내 DB의 카트아이템 정보를 변경한다.
		// changeOrderInfo 함수 실행 : dao작업과 별개로 화면에 표시된 전체 주문정보를 갱신한다. 화면 표시용으로 가격, 구매수량을 조회해서 계산된 값을 DOM객체에 넣는다. 
		console.log("removeCheckedItem() 테스트");
		
		// 체크된 input엘리먼트를 획득하여 삭제하려는 아이템번호를 획득해 list로 담는다.
		let inputItemElements = document.querySelectorAll("input[name='book-checkbox']:checked");
		let itemNos = [];
		for (let input of inputItemElements) {
			itemNos.push(input.value);
		}
		
		// for문에서 아이템번호 순으로 tr엘리먼트 획득해서 remove()로 지운다.
		for (let itemNo of itemNos) {
			let cartItemElement = document.getElementById("item-row-" + itemNo);
			cartItemElement.remove();
		}
		
		// TO DO: ajax로 dao작업

		changeOrderInfo();
	}
	
	
	/*
		주문 폼 제출하는 onsubmit 이벤트 발생 시, 일부 조건을 만족하지 못하면 false를, 정상적인 주문 폼이면 true를 반환하는 함수
		주문 폼으로 전달해야 할 입력값: 폼에서 checked 상태인 cartNo 리스트 (cartNo의 userNo, bookNo를 참조해 상세 정보를 확인할 수 있다) 
	*/
	function submitOrderForm() {

	}
</script>
</body>
</html>