<%@page import="vo.UserAddress"%>
<%@page import="dao.UserAddressDao"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
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
<title>마켓북스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon"
	href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"
	type="image/x-icon">
<link href="../css/home.css" rel="stylesheet">
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
<!-- 사용자 상호작용 관련 작업 
	 1. 체크박스 토글 (재요청시에도 상태 유지)
	 2. 수량 버튼 클릭 시 modify.jsp 요청 -> list.jsp 재요청받음
	 3. 삭제 버튼 클릭 시 delete.jsp 요청 -> list.jsp 재요청받음
	 3. 배송지 입력 클릭시 address/list.jsp를 요청 -> 팝업으로 해당 사용자의 배송지 리스트를 조회하는 새 페이지가 뜬다.
	 4. 카트리스트 정보, 수량 반영해서 결제금액 정보 띄우기
	 5. 주문 버튼 클릭하면 입력값 + order.jsp 요청
	 * 선택배송지는 로컬스토리지에 담고 꺼내는 것으로 변경함.
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
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container mb-5" style="min-width: 1200px; max-width: 1200px">
   	<div class="row">
		<div class="col">
			<h1 class="fs-3 p-5 mb-3 text-center"><strong>장바구니</strong></h1>
		</div>  
	</div>
	<%
		// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
		User user = (User) session.getAttribute("LOGINED_USER");
		if (user == null) {
			response.sendRedirect("../loginform.jsp?fail=deny");
			return;
		}
		int userNo = user.getNo();
		
		// 해당 사용자의 장바구니아이템 리스트, 리스트 내 객체 개수 획득
		CartItemDao cartItemDao = CartItemDao.getInstance();
		List<CartItem> cartItemList = cartItemDao.getCartItemsByUser(userNo);
		int cartItemListSize = cartItemList.size();
		
		// 재요청에 대한 응답일 경우 요청객체에서 체크 상태를 유지할 아이템번호 획득
		String[] checkedValues = request.getParameterValues("checkedItemNo");
		// null일 경우 빈 list 객체를 대입한다.
		List<String> checkedItemNos = checkedValues == null ? new ArrayList<>() : Arrays.asList(checkedValues);
		
		// 사용자의 기본 배송지 번호 획득
		int defAddressNo = 0;
		if (user.getAddress() != null) {
			defAddressNo = user.getAddress().getNo();
		}
	%>
	<!-- 잘못된 수량, 번호로 update.jsp, delete.jsp 를 요청했을 경우 fail값 획득하여 경고메시지 표시-->
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
		if ("invalid".equals(fail)) {
	%>
	<div class="alert alert-danger">
		<strong>잘못된 접근입니다.</strong>
	</div>	
	<%
		}
	%>
	
	<!-- action의 값에는 각 폼입력값이 변경상태에 따른 요청url(orderform.jsp, delete.jsp, modify.jsp) 가 대입된다.  -->
	<form id="cart-form" method="get" action="" >
		<div class="row">
			<div class="col-9 mb-3 pb-3 border-bottom border-dark">
				<div class="row">
					<div class="col-1">
						<!-- orderform으로 폼 제출 시에 전달을 위해 로컬스토리지에서 selectedAddressNo 값을 꺼내서 저장할 것 -->
						<input type="hidden" name="selectedAddressNo" />
						<input type="hidden" name="defaultAddressNo" value="<%=defAddressNo %>"/>
						<!-- 체크된 아이템 url로 전달 -->
						<input type="checkbox" id="all-toggle-checkbox" onchange="toggleCheckbox(); changeCheckBoxNumber(<%=cartItemListSize %>);"/>
					</div>
					<div class="col-5" >
						<span class="border-end me-3 pe-3 text-muted" id="checked-number">전체선택(<%=checkedItemNos.size() %>/<%=cartItemListSize %>)</span>
						<a class="link-dark text-decoration-none text-muted" href="javascript:deleteCheckedItems();">선택삭제</a>
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
				<table class="table lh-base">
					<colgroup>
						<col width="5%">
						<col width="10%">
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
								<img alt="cover image" src="../images/bookcover/book-<%=item.getBook().getNo() %>.jpg" class="rounded coverimage"/>
							</td>
							<td class="align-middle">
								<span id="item-title-<%=item.getNo() %>"><a href="../book/detail.jsp?bookNo=<%=item.getBook().getNo() %>"><%=item.getBook().getTitle() %></a></span>
							</td>
							<td class="align-middle">
								<span id="item-author-<%=item.getNo() %>"><%=item.getBook().getAuthor() %></span>
							</td>
							<td class="align-middle">
								<span id="item-publisher-<%=item.getNo() %>"><%=item.getBook().getPublisher() %></span>
							</td>
							<td class="align-middle">
								<!-- 추후 레퍼런스와 유사한 + - 버튼 방식으로 수정 예정 -->
								<input type="number" class="form-control w-100 mb-3" min="1" value="<%=item.getQuantity() %>" id="item-quantity-<%=item.getNo() %>" onchange="updateQuantity(<%=item.getNo() %>);"/>
							</td>
							<td class="align-middle">
							<%
								int totalDiscountPrice = item.getBook().getDiscountPrice() * item.getQuantity();
								int totalPrice = item.getBook().getPrice() * item.getQuantity();
							%>
								<strong id="item-total-discount-price-<%=item.getNo() %>"><%=StringUtil.numberToCurrency(totalDiscountPrice) %></strong>원<br/>
								<span class="text-decoration-line-through text-muted <%=totalPrice == totalDiscountPrice ? "d-none" : "" %>">
									<span id="item-total-price-<%=item.getNo() %>"><%=StringUtil.numberToCurrency(totalPrice) %></span>원
								</span>
							</td>
							<td  class="align-middle text-center">
								<a href="javascript:deleteItem(<%=item.getNo() %>);" >
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="gray" class="bi bi-x-lg" viewBox="0 0 16 16">
										<path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
									</svg>
								</a>
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
						<!-- 사용자의 배송지 정보를 출력한다. 
							선택된 배송지 번호를 요청 파라미터로 받았을 경우 그 배송지의 정보를, 받지 않았을 경우 기본배송지를 선택 배송지로 하고 정보를 출력한다.
							기본 배송지가 없을 경우, 안내메시지가 출력된다.
							이 배송지번호는 히든 태그에 저장되어 주문 폼 제출 시 전달된다.-->
						<h6 class="card-title mb-3"><strong>배송지</strong></h6>
					<!-- 스크립트에서 로컬스토리지에 저장된 선택배송지번호에 대한 검사를 ajax로 실행해서 주문번호 객체를 획득후 태그에 정보를 출력한다. -->
						<p class="d-none" id="none-selected-message">배송지를 선택하세요.</p>
						<div class="d-none mb-1 ms-0" id="defAddress-tag"><span class="text-muted text-bg-light rounded p-1">기본 배송지</span></div>
						<p class="d-none lh-base" id="address-info"></p>
						<div class="d-grid gap-2">
							<button class="btn btn-sm" style="border-color:#5f0080; color:#5f0080;"
							onclick="submitFormNewWindow('addressList.jsp', 'addressList');">배송지 변경</button>
						</div>
					</div>
					<div class="card-footer text-muted">
						<div class="row mt-3 mb-3"><div class="col">주문금액</div><div class="col"><strong id="order-total-price">0</strong>원</div></div>
						<div class="row mb-3"><div class="col">주문할인금액</div><div class="col"><strong id="order-discount-amount">0</strong>원</div></div>
						<div class="row mb-3 pb-3 border-bottom"><div class="col">배송비</div><div class="col"><strong id="order-ship-price">0</strong>원</div></div>
						<div class="row mb-3"><div class="col">결제예정금액</div><div class="col"><strong id="order-pay-price">0</strong>원</div></div>
					</div>
				</div>
				<div class="d-grid gap-2">
					<!-- 아래 버튼을 누르면 체크된 카트아이템 번호, 선택된 배송지 번호가 orderform.jsp로 전달된다. -->
				    <button type="button" class="btn" style="background-color:#5f0080; color:white;" onclick="submitOrderForm();">주문하기</button>
				</div>
			</div>
		</div>
	</form>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	// 주문정보, 전체 토글박스 DOM객체 리프레쉬 (Dao 작업으로 인한 재요청 시 필요)
	changeCartInfo();
	changeCheckbox();
	
	
	// 로컬스토리지에 저장된 선택배송지번호를 전달해 ajax로 검사 후 선택지배송지 정보를 전달받는다.
	let selectedAddressNo = localStorage.getItem('selectedAddressNo');
	if (selectedAddressNo == null) {
		selectedAddressNo = document.querySelector("input[name=defaultAddressNo]").value;
	}
	
	// 서버에서는 사용자가 해당 배송지번호를 가지고 있는지 검사해서, 존재여부와 배송지정보를 응답한다.
	// 유효하면 그 배송지정보를, 유효하지 않으면 기본배송지정보를, 기본배송지정보도 없을 경우 존재여부만 전달한다.
	let noneSelected = document.getElementById("none-selected-message");
	let defAddrTag = document.getElementById("defAddress-tag");
	let addressInfo = document.getElementById("address-info");
	
	let xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			let jsonText = xhr.responseText;
			let result = JSON.parse(jsonText);
			
			// 존재, 배송지정보 받은 경우: 배송지정보 내용입력, 태그 활성화
			//		이 때 배송지번호가 input에 저장된 기본배송지번호랑 같으면 기본배송지태그 활성화
			// 존재x, 배송지정보 받은 경우: 로컬스토리지에 저장, 기본배송지태그, 배송지정보 내용입력, 활성화
			let addr = result.address;
			if (addr != null) {
				
				if (result.exist === "no") {
					// 로컬스토리지에 주소 저장 (exist === "yes"이면 다시 저장할 필요가 없다.)
					localStorage.setItem('selectedAddressNo', addr.no);
				}
				
				if (result.defaddress === "yes" ) {
					// 기본배송지 태그 활성화
					defAddrTag.classList.remove("d-none");
				}
				
				// 배송지 내용 입력
				addressInfo.classList.remove("d-none");
				if (addr.detailAddress == 'undefined' || addr.detailAddress == null) {
					addr.detailAddress = "";
				}
				addressInfo.textContent = addr.address + " " + addr.detailAddress;
				
				// 검사가 완료된 배송지번호를 input태그에 저장한다.
				document.querySelector("input[name=selectedAddressNo]").value = selectedAddressNo;
				
			} else {
					// 존재x, 배송지정보 안받은 경우: 존재하지않습니다. 메시지 태그만 활성화
					noneSelected.classList.remove("d-none");
			}
		}
	}
	
	xhr.open("GET", "../cart/addresscheck.jsp?selectedAddressNo=" + selectedAddressNo);
	xhr.send();
	
	
	
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
		
		changeCartInfo();
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
		
		changeCartInfo();
	}
	
	/*
		폼 입력값의 변화에 따라 화면에 출력된 전체 주문정보를 페이지 이동 없이 변경한다.(실제 order 객체의 값이 아니다) (ajax)
		체크박스 선택, 카트아이템 삭제, 수량 변경 시 각각 해당하는 이벤트핸들러함수 내에서 이 함수를 실행시킨다.
		계산한 값은 JSON형식으로 로컬스토리지에 저장하여 주문서 페이지에서 사용할 수 있게끔 한다.
	*/
	function changeCartInfo() {
		// 내용을 출력할 DOM객체
		let totalPriceElement = document.getElementById("order-total-price"); 
		let discountAmountElement = document.getElementById("order-discount-amount");
		let shipPriceElement = document.getElementById("order-ship-price");
		let payPriceElement = document.getElementById("order-pay-price"); 
		
		// 체크박스가 checked 상태인 카트아이템의 번호를 모두 획득 후, for문으로 전체 계산
		// 
		let checkedBookCheckboxList = document.querySelectorAll(".book-checkbox:checked");
		let totalPrice = 0;
		let discountedPrice = 0;
		for (let bookCheckbox of checkedBookCheckboxList) {
			let itemNo = bookCheckbox.value;
		// 일반 금액 합계
			totalPrice += parseInt(document.getElementById("item-total-price-" + itemNo).textContent.replaceAll(",",""));
		// 할인된 금액 합계 
			discountedPrice += parseInt(document.getElementById("item-total-discount-price-" + itemNo).textContent.replaceAll(",",""));
		}
		
		// 배송비는 2만원 이상 구매 시 무료이다.
		let shipPrice = (discountedPrice >= 20000) || totalPrice == 0 ? 0 : 2500;
		
		// 전체 주문금액을 화면에 출력
		totalPriceElement.textContent = totalPrice.toLocaleString();
		// 할인받는 금액을 주문에 출력 (할인받는 금액 합계 = 일반 금액 합계 - 할인된 금액 합계)
		discountAmountElement.textContent = (totalPrice - discountedPrice).toLocaleString();
		// 배송비를 화면에 출력
		shipPriceElement.textContent = "+ " + shipPrice.toLocaleString();
		// 결제예정금액을 화면에 출력
		let payPrice = discountedPrice + shipPrice; // 현재는 쿠폰, 적립금 등 적용이 없어 (할인된 금액 + 배송비)가 결제 예정 금액이다.
		payPriceElement.textContent = payPrice.toLocaleString();
		
		// 계산한 값들을 객체로 만들고 JSON형식으로 변환해서 로컬스토리지에 저장한다.
		let cartInfo = {};
		cartInfo.totalPrice = totalPrice;
		cartInfo.discountedPrice = discountedPrice;
		cartInfo.shipPrice = shipPrice;
		cartInfo.payPrice = payPrice;
		
		// 이 값은 다른 페이지에서도 꺼내쓸 수 있다.
		localStorage.setItem('cartInfo', JSON.stringify(cartInfo));
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
		form.setAttribute("target", ""); // submitFormNewWindow()를 실행한 뒤 이 함수를 실행할 때 target의 값을 초기화해야 한다.
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
	
	/*
		주문하기 버튼을 클릭하면 실행되는 함수
		선택한 장바구니아이템 또는 선택한 배송지가 존재하지 않을 경우 alert창을 띄우고 폼을 제출하지 않는다. 
	*/
	function checkParameters() {
		let checkedItemsElement = document.querySelectorAll(".book-checkbox:checked");
		let selectedAddressNoElement = document.querySelector("input[name=selectedAddressNo]");

		if (checkedItemsElement.length === 0) {
			alert("주문할 상품을 선택해주세요.");
			return false;
		}
		
		if (selectedAddressNoElement == null) {
			alert("배송지를 선택해주세요.");
			return false;
		}
		
		return true;
	}
	
	/*
		주문폼 제출 시 전달값 체크를 위해, 다른 폼 제출과 이벤트핸들러 함수를 분리한다.
	
	*/
	function submitOrderForm() {
		if (!checkParameters()) {
			return;
		}
		
		submitForm('../order/orderform.jsp');
	}

</script>
<script type="text/javascript"></script>
</body>
</html>