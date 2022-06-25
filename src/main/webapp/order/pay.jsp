<%@page import="dao.OrderItemDao"%>
<%@page import="vo.Book"%>
<%@page import="dao.UserAddressDao"%>
<%@page import="vo.UserAddress"%>
<%@page import="dao.BookDao"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.CartItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.OrderItem"%>
<%@page import="java.util.List"%>
<%@page import="dao.CartItemDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	// 초기 DB 생성 이후 변경사항 : hta_orders 테이블에 무료배송여부, 총결제금액, 결제수단 추가
	// order.jsp에서는 카트아이템번호를 사용해 orderItem과 '결제완료' 상태의 order 객체를 생성한다.
	// DB의 hta_orderItems, hta_orders에 저장하고, hta_books의 재고를 변경시킨다. 
	// DB의 hta_cartItems에서 주문에 사용한 카트아이템을 삭제한다.
	CartItemDao cartItemDao = CartItemDao.getInstance();
	OrderDao orderDao = OrderDao.getInstance();
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	BookDao bookDao = BookDao.getInstance();
	UserAddressDao userAddressDao = UserAddressDao.getInstance();
	
	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int userNo = user.getNo();
	
	// 요청객체에서 카트아이템 번호, 배송지번호, 주문제목, 결제수단 정보를 받는다.
	// 유효하지 않은 값이 있을 경우 바로 예외를 던진다.
	int addressNo = StringUtil.stringToInt(request.getParameter("selectedAddressNo"));
	UserAddress selectedAddress = userAddressDao.getAddressByNo(addressNo);
	if (selectedAddress == null || selectedAddress.getUserNo() != userNo) {
		response.sendRedirect("../cart/list.jsp?fail=invalid");
		return;
	}
	
	String[] cartItemNos = request.getParameterValues("cartItemNo");
	if (cartItemNos == null) {
		throw new RuntimeException("결제 실패: 요청 정보가 올바르지 않습니다.");
	}
	
	String orderTitle = StringUtil.nullToBlank(request.getParameter("orderTitle"));
	// null은 아니지만 공백을 입력할 경우 방지
	if ("".equals(orderTitle) || " ".equals(orderTitle)) {
		throw new RuntimeException("결제 실패: 요청 정보가 올바르지 않습니다.");
	}
	
	String payMethod = request.getParameter("payMethod");
	if (payMethod == null) {
		throw new RuntimeException("결제 실패: 요청 정보가 올바르지 않습니다.");
	}
	
	boolean validMethod = "kakaopay".equals(payMethod) || "creditcard".equals(payMethod) || "simplepay".equals(payMethod) || "mobilepay".equals(payMethod);
	if (!validMethod) {
		throw new RuntimeException("결제 실패: 요청 정보가 올바르지 않습니다.");
	}
	
	// 값이 유효함을 확인했으면, 주문번호를 시퀀스로 생성한다.
	int orderNo = orderDao.getOrderSequence();
		
	// cartItem을 이용해서 orderItem객체를 생성해 리스트에 담는다. 
	// HTA_ORDER_ITEMS의 행이 ORDER_NO에서 HTA_ORDERS의 행을 참조하므로 ORDERS 행부터 저장한다.
	// 이 때 카트아이템 번호의 유효성을 검사하고, 하나라도 유효하지 않은 값이면 즉시 결제 작업을 중단한다.
	List<OrderItem> orderItems = new ArrayList<>();
	for (String value : cartItemNos) {
		int cartItemNo = StringUtil.stringToInt(value);
		CartItem cartItem = cartItemDao.getCartItemByNo(cartItemNo);
		
		if (cartItem == null || cartItem.getUserNo() != userNo) {
			throw new RuntimeException("결제 실패: 요청 정보가 올바르지 않습니다.");
		}
		
		OrderItem orderItem = new OrderItem();
		orderItem.setOrderNo(orderNo);
		orderItem.setBook(bookDao.getBookByNo(cartItem.getBook().getNo()));
		orderItem.setPrice(cartItem.getBook().getDiscountPrice());
		orderItem.setQuantity(cartItem.getQuantity());
		orderItems.add(orderItem);
	}
	
	// 생성한 주문번호 orderNo를 ORDER_NO 컬럼의 값으로 갖는 주문객체를 생성해 DB에 저장한다.
	// ORDERS 테이블의 컬럼 중 STATUS는 기본값이 '결제 완료'이다.
	
	// 주문 정보에 필요한 금액 정보를 계산한다.
	int totalPrice = 0;
	for (OrderItem orderItem : orderItems) {
		totalPrice += orderItem.getPrice() * orderItem.getQuantity();
	}
	int shipPrice = totalPrice >= 20000 ? 2500 : 0;
	int totalPayPrice = totalPrice + shipPrice;
	
	Order order = new Order();
	order.setNo(orderNo);
	order.setUserNo(userNo);
	order.setTitle(orderTitle);
	order.setTotalPrice(totalPrice);
	order.setTotalQuantity(orderItems.size()); // 책 권수가 아니라 책 종류 개수로 저장함. 
	order.setTotalPayPrice(totalPayPrice);
	order.setAddressNo(addressNo);
	order.setIsFreeShipping(shipPrice == 0 ? "Y" : "N");
	order.setPayMethod(payMethod);
	
	orderDao.insertOrder(order);
	
	// orderItems 리스트에서 주문아이템을 모두 DB로 저장한다.
	// (결제 실패/성공 여부에 관계없이 모두 저장한다.)
	for (OrderItem orderItem : orderItems) {
		orderItemDao.insertOrderItem(orderItem);
	}
	
	// 도서 재고량을 변경한다.
	// 도서 재고량 변경 시 주문수량이 도서재고량보다 크면 주문정보 상태를 "결제 실패"로 변경하고 예외를 던져 실행을 종료한다.
	// (장바구니를 담을 때 재고 체크를 한 번 하지만, 결제 시점에서 다시 한번 체크하기 위함임)
	for (OrderItem orderItem : orderItems) {
		Book book = bookDao.getBookByNo(orderItem.getBook().getNo());
		int updateStock = book.getStock() - orderItem.getQuantity();
		if (updateStock < 0) {
			order.setStatus("결제실패");
			orderDao.updateOrder(order);
			throw new RuntimeException("결제 실패: 요청 정보가 올바르지 않습니다. (재고부족)");
		}
		
		book.setStock(updateStock);
		bookDao.updateBook(book);
	}
	
	// 결제가 정상적으로 완료된 장바구니아이템을 DB에서 삭제한다.
	for (String value : cartItemNos) {
		// 위에서 카트아이템 번호 유효성 검사를 완료했으므로 다시 확인할 필요가 없다.
		int cartItemNo = StringUtil.stringToInt(value);
		cartItemDao.deleteCartItem(cartItemNo);
	}
	
	// 결제완료 페이지를 재요청한다.
	response.sendRedirect("complete.jsp?orderNo=" + orderNo);
%>