<%@page import="dao.UserAddressDao"%>
<%@page import="vo.UserAddress"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.OrderItem"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp" %>
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
	
</style>
</head>
<body>
<!-- DB 관련 작업 
	1. 전체 상품 다시 담기 : 주문아이템 리스트의 모든 아이템번호를 전달 (모달-ajax-모달)
	2. 전체 상품 주문 취소 : 주문번호르 전달(모달-ajax-모달)
	3. 특정 상품 다시 담기 : 도서번호, 수량을 전달(모달-ajax-모달)
-->
<%
	OrderDao orderDao = OrderDao.getInstance();
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	
	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int userNo = user.getNo();
	
	// 요청객체에서 조회할 주문번호를 획득 : 주문정보가 NULL이거나 사용자번호가 불일치할 경우 예외를 던진다.
	int orderNo = StringUtil.stringToInt(request.getParameter("orderNo"));
	Order order = orderDao.getOrderByNo(orderNo);
	if (order == null || order.getUserNo() != userNo) {
		throw new RuntimeException("주문정보가 올바르지 않습니다.");
	}
	
	// 해당 주문번호의 주문아이템 리스트를 획득한다.
	List<OrderItem> orderItems = orderItemDao.getOrderItemsByOrderNo(orderNo);
	if (orderItems.isEmpty()) {
		throw new RuntimeException("주문정보가 올바르지 않습니다.");
	}
%>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container mb-5" style="min-width: 1200px; max-width: 1200px;">
   <div class="row">
   		<div class="col-3 p-3">
	   		<!-- 마이페이지 메뉴리스트 import -->
			<jsp:include page="../common/mypagemenu.jsp">
				<jsp:param name="menu" value="order"/>
			</jsp:include>
   		</div>
   		<div class="col-9 p-3">
   			<div class="row mb-5">
		   		<!-- 주문정보 조회 -->
	  			<h5 class="py-3 ps-0 mb-3 fw-bold">주문 내역 상세</h5>
	  			<div class="row py-3 border-bottom border-2 border-dark">
	  				<div class="col-6 align-middle">
			  			<span class="p-3 ps-0 mb-3 fs-6 fw-bold">주문번호 <%=orderNo %></span>
			  			<span id="orderStatus" class="p-3 ps-0 mb-3 fs-6 fw-light" style="color:#5f0080;">(<%=order.getStatus() %>)</span>
			  			<!-- 주문 취소를 위해 저장하는 주문번호 -->
			  			<input type="hidden" name="orderNo" value="<%=orderNo %>"/>
	  				</div>
	  				<div class="col-6 text-end">
			  			<span>배송 또는 상품에 문제가 있나요?<a href="../board/form.jsp" class="text-end text-decoration-none fw-bold ps-3" style="color:#5f0080;">1:1 문의하기></a></span>
	  				</div>
	  			</div>
				<table class="table my-3" id="order-item-list">
					<colgroup>
						<col width="10%">
						<col width="*%">
						<col width="15%">
					</colgroup>
					<tbody>
					<%
						for (OrderItem item : orderItems) {
					%>
						<tr>
							<td class="align-middle">
								<!-- 상품 다시 담기를 위해 저장하는 도서번호 -->
								<input type="hidden" name="bookNo" value="<%=item.getBook().getNo() %>"/>
								<img alt="cover image" src="../images/bookcover/book-<%=item.getBook().getNo() %>.jpg" class="rounded coverimage"/>
							</td>
							<td class="align-middle">
								<p>
									<a href="../book/detail.jsp?bookNo=<%=item.getBook().getNo() %>" class="py-3 text-decoration-none text-dark"><br/>
										<strong><%=item.getBook().getTitle() %></strong><br/>
										 <%=item.getBook().getAuthor() %><br/>
										 <%=item.getBook().getPublisher() %>
									</a>
								<p/>
								<span class="px-1 border-end">
									<%=StringUtil.numberToCurrency(item.getPrice()) %>원
									<span class="text-decoration-line-through text-muted <%=item.getPrice() >= item.getBook().getPrice() ? "d-none" : "" %>">
										<%=StringUtil.numberToCurrency(item.getBook().getPrice()) %>원
									</span>
								</span>
								<span class="px-1"><%=item.getQuantity() %>권</span>
							</td>
							<td class="align-middle text-center">
								<a href="#" class="btn btn-sm w-100 mb-1" style="background-color:#5f0080; color:#fff;" data-bs-toggle="modal">후기쓰기</a>
								<a href="#addCart" class="btn btn-sm w-100" style="color:#5f0080; border-color:#5f0080;" 
								onclick="saveBookInfo(<%=item.getBook().getNo() %>, '<%=item.getBook().getTitle() %>', '<%=item.getBook().getAuthor() %>');">
									장바구니담기
								</a>
							</td>
						</tr>
					<%
						}
					%>
					</tbody>
				</table>
				<div class="row p-3 mx-auto">
					<div class="col text-center">
						<a href="#addAllCarts" class="btn btn-sm fw-bold p-3" style="border-color:#5f0080; color:#5f0080;" data-bs-toggle="modal">전체 상품 다시 담기</a>
						<a href="#cancelOrder" class="btn btn-sm fw-bold p-3 <%="배송준비중".equals(order.getStatus()) || "배송중".equals(order.getStatus()) || "배송완료".equals(order.getStatus()) || "주문취소".equals(order.getStatus()) ? "disabled" : "" %>" 
							style="background-color:#5f0080; color:#fff;" data-bs-toggle="modal">
							전체 상품 주문 취소
						</a>
						<p class="p-3"><span class="text-muted fw-bold">주문 취소는 '배송준비중' 이전 상태일 경우에만 가능합니다.</span></p>
					</div>
				</div>
   			</div>
  			<div class="row mb-5 <%="배송중".equals(order.getStatus()) || "배송완료".equals(order.getStatus()) ? "" : "d-none" %>">
	   			<!-- 이 태그는 배송중 상태가 아니면 d-none이다. -->
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>배송조회</strong></h5>
  			</div>
  			<div class="row mb-5">
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>결제정보</strong></h5>
				<table class="pay-info-table text-muted">
					<colgroup>
						<col width="16%">
						<col width="*">
					</colgroup>
					<tbody>
					<%
						int shipPrice = "N".equals(order.getIsFreeShipping()) ? 2500 : 0;
						int totalOriginalPrice = 0;
						for (OrderItem item : orderItems) {
							totalOriginalPrice += item.getBook().getPrice();
						}
						int totalDiscountedAmount = order.getTotalPrice() - totalOriginalPrice;
					%>
						<tr>
							<td><strong>상품금액</strong></td>
							<td class="align-middle text-end p-3"><span><%=StringUtil.numberToCurrency(totalOriginalPrice) %></span>원</td>
						</tr>
						<tr>
							<td><strong>배송비</strong></td>
							<td class="align-middle text-end p-3"><span><%=StringUtil.numberToCurrency(shipPrice) %></span>원</td>
						</tr>
						<tr>
							<td><strong>상품할인금액</strong></td>
							<td class="align-middle text-end p-3"><span><%=StringUtil.numberToCurrency(totalDiscountedAmount) %></span>원</td>
						</tr>
						<tr>
							<td><strong>결제금액</strong></td>
							<td class="align-middle text-end p-3"><span><%=StringUtil.numberToCurrency(order.getTotalPayPrice()) %></span>원</td>
						</tr>
						<tr>
							<td><strong>결제수단</strong></td>
							<td class="align-middle text-end p-3"><span><%=order.getPayMethod() %></span></td>
						</tr>
					</tbody>
				</table>
  			</div>
  			<div class="row mb-5">
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>주문정보</strong></h5>
				<table class="order-info-table text-muted">
					<colgroup>
						<col width="16%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<td><strong>주문번호</strong></td>
							<td class="align-middle text-end p-3"><span><%=order.getNo() %></span></td>
						</tr>
						<!-- 현재는 주문자명과 받는 분의 정보가 동일하다. (별도 송수신인 정보 기능 없음) -->
						<tr>
							<td><strong>주문자명</strong></td>
							<td class="align-middle text-end p-3"><span><%=user.getName() %></span></td>
						</tr>
						<tr>
							<td><strong>결제일시</strong></td>
							<%
								SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							%>
							<td class="align-middle text-end p-3"><span><%=simpleDateFormat.format(order.getCreatedDate()) %></span></td>
						</tr>
					</tbody>
				</table>
  			</div>
  			<div class="row mb-5">
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>배송정보</strong></h5>
				<table class="ship-info-table text-muted">
					<colgroup>
						<col width="16%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<td><strong>받는분</strong></td>
							<td class="align-middle text-end p-3"><span><%=user.getName() %></span></td>
						</tr>
						<tr>
							<td><strong>핸드폰</strong></td>
							<td class="align-middle text-end p-3"><span><%=user.getTel() %></span></td>
						</tr>
						<tr>
							<td><strong>주소</strong></td>
							<%
								UserAddressDao userAddressDao = UserAddressDao.getInstance();
								UserAddress address = userAddressDao.getAddressByNo(order.getAddressNo());
							%>
							<td class="align-middle text-end p-3"><span><%=address.getAddress() %> <%=StringUtil.nullToBlank(address.getDetailAddress()) %></span></td>
						</tr>
						<!-- 추후 배송지 상세정보 추가 -->
					</tbody>
				</table>
  			</div>
  			<!-- 추후 배송 추가 옵션 정보 추가 -->
   		</div>
   </div>
   
	<!-- 장바구니 관련 모달은 최하단 include 파일 확인할 것 -->
	<!-- 주문 취소 확인 모달 -->
	<div class="modal fade" id="cancelOrder" tabindex="-1" aria-labelledby="cancelOrderModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title fw-bold" id="cancelOrderModalLabel">
		        	전체 주문 취소
		        </h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body border-bottom">
				<p class="text-center m-3 fs-6">
			        전체 상품 주문을 취소하시겠습니까? <br/>
			        취소 후에는 철회가 불가능합니다.
				</p>
		      </div>
		      <div class="modal-footer border-0 m-auto">
		        <button type="button" class="btn" data-bs-dismiss="modal" onclick="cancelOrder();">확인</button>
		      </div>
		    </div>
		  </div>
	</div>
	
	<!-- 주문 취소 결과 모달 -->
	<div class="modal fade" id="cancelOrderResult" tabindex="-1" aria-labelledby="cancelOrderResultModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title fw-bold" id="cancelOrderResultModalLabel">
		        </h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body border-bottom">
		      	<p class="text-center m-3 fs-6" id="cancelResult-message">
			        주문이 취소되었습니다.
		      	</p>
		      </div>
		    </div>
		  </div>
	</div>
	
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	let cancelResultModal = new bootstrap.Modal(document.getElementById("cancelOrderResult"));
	
	/*
		'장바구니 담기' 버튼을 누르면 해당 도서정보를 전달받고, addCartModal 모달 창 태그에 정보를 출력한 뒤, 모달을 연다.
		해당 모달은 수량을 입력받기 위한 창이다.
	*/
	function saveBookInfo(bookNo, bookTitle, bookAuthor) {
		
		let bookNoElement = document.querySelector("input[name=addBookNo]");
		bookNoElement.value = bookNo;
		
		
		let bookTitleElement = document.getElementById("addBookTitle");
		bookTitleElement.textContent = bookTitle;
		let bookAuthorElement = document.getElementById("addBookAuthor");
		bookAuthorElement.textContent = bookAuthor;
		
		addCartModal.show();
	}
	
	/*
		주문번호를 전달해 주문상태를 "주문취소"로 변경하고, 성공여부에 따라 모달창을 띄운다.
		화면을 리로드해야 하므로 ajax보다는 동기식으로 처리하는게 나은 것 같은데, 재요청하고 alert아닌 모달 띄우는 걸 못하겠음 ㅠ
	*/
	function cancelOrder() {
	
		let orderNo = document.querySelector("input[name=orderNo]").value;
		
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				let jsonText = xhr.responseText;
				let result = JSON.parse(jsonText);
				// 성공이면 resultModal 보여주기
				if (!result.success) {
					return;
				} 
				// 재요청 대신 html 변경하고 모달 띄움..
				let statusElement = document.getElementById("orderStatus");
				statusElement.textContent = "(주문취소)"; 
				let buttonElement = document.querySelector("a[href='#cancelOrder']");
				buttonElement.classList.add("disabled");
				cancelResultModal.show();
			}
		}
		
		xhr.open("GET", "../order/cancel.jsp?orderNo=" + orderNo);
		xhr.send();
	}
	
	/*
		(미구현)
		특정 주문아이템의 도서번호를 전달해 상품리뷰 작성페이지로 이동한다.
		배송완료 상태가 아닌 주문아이템일 경우, alert창을 띄우고 실행을 중단한다.
	function writeReview(itemNo) {
		
	}
	*/
</script>
<!-- 장바구니 모달 파일 : 모달 html, script 포함되어있으므로 가장 아래에 include할 것 -->
<jsp:include page="../common/cartModal.jsp"/>
</body>
</html>