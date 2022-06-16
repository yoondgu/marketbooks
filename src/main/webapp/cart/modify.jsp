<%@page import="vo.CartItem"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CartItemDao cartItemDao = CartItemDao.getInstance();
	
	// TO DO: 로그인된 사용자 정보 조회
	//		 로그인된 사용자가 NULL이거나, cartItem의 userNo와 로그인된 사용자의 userNo가 다를 경우 경고메시지를 띄우고 로그인페이지로 이동한다.
	
	int itemNo = StringUtil.stringToInt(request.getParameter("updateItemNo"));
	int quantity = StringUtil.stringToInt(request.getParameter("quantity"));
	
	// 획득한 아이템번호로 DB에서 카트아이템을 조회한다.
	CartItem cartItem = cartItemDao.getCartItemByNo(itemNo);

	// 존재하지 않는 아이템일 경우 list.jsp로 재요청, fail=invalid 값을 전달한다.
	if (cartItem == null) {
		response.sendRedirect("list.jsp?fail=invalid");
		return;
	}
	
	// 변경하려는 수량이 1보다 작을 경우 list.jsp로 재요청, fail=deny 값을 전달한다. 
	if (quantity < 1) {
		response.sendRedirect("list.jsp?fail=deny");
		return;
	}
	
	// TO DO: 변경하려는 수량이 book.getStock()보다 클 경우 list.jsp로 재요청, fail=deny 값을 전달한다.

	// 획득한 객체에 변경된 값을 저장한다.
	cartItem.setQuantity(quantity);
	// Dao객체에서 cartitem 객체의 update 작업을 한다.
	cartItemDao.updateCartItem(cartItem);
	
	// 응답으로 list.jsp를 재요청한다.
	response.sendRedirect("list.jsp");
%>