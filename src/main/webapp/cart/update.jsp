<%@page import="vo.Book"%>
<%@page import="vo.CartItem"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	CartItemDao cartItemDao = CartItemDao.getInstance();
	
	// TO DO: 로그인된 사용자 정보 조회
	//		 로그인된 사용자가 NULL이거나, cartItem의 userNo와 로그인된 사용자의 userNo가 다를 경우 로그인페이지로 이동하고 아래 코드는 실행하지 않는다.
	
	int itemNo = StringUtil.stringToInt(request.getParameter("itemNo"));
	int quantity = StringUtil.stringToInt(request.getParameter("quantity"));
	
	
	// 획득한 아이템번호로 DB에서 카트아이템을 조회한다.
	CartItem cartItem = cartItemDao.getCartItemByNo(itemNo);

	// 존재하지 않는 아이템일 경우 list.jsp로 재요청, fail=invalid 값을 전달한다.
	if (cartItem == null) {
		throw new RuntimeException("장바구니 정보가 존재하지 않습니다.");
	}

	// 체크 상태를 유지시킬 아이템번호를 재요청에 전달할 쿼리스트링을 만든다.
	String[] numbers = request.getParameterValues("checkedItemNo");
	String checkboxQueryString = "?";
	if (numbers != null) {
		for (String number : numbers) {
			int checkedItemNo = StringUtil.stringToInt(number);
			// 체크 상태를 유지시킬 아이템번호에 해당하는 카트가 없으면 덧붙일 queryString이 없다.
			if (cartItemDao.getCartItemByNo(itemNo) == null) {
				continue;
			}
			
			checkboxQueryString += "?".equals(checkboxQueryString) ? "checkedItemNo=" + checkedItemNo : "&checkedItemNo=" + checkedItemNo;
		}
	}
	
	// 변경하려는 수량이 1보다 작을 경우 fail=quantityInvalid 값을 전달한다. (체크된 아이템번호도 함께 전달한다.)
	if (quantity < 1) {
		response.sendRedirect("list.jsp" + checkboxQueryString + "&fail=quantityInvalid");
		return;
	}
	
	// 변경하려는 수량이 book.getStock()보다 클 경우 list.jsp로 재요청, fail=stockInvalid 값을 전달한다. (체크된 아이템번호도 함께 전달한다.)
	Book book = cartItem.getBook();
	if (quantity > book.getStock()) {
		response.sendRedirect("list.jsp" + checkboxQueryString + "&fail=stockInvalid");
		return;
	}

	// 획득한 객체에 변경된 값을 저장한다.
	cartItem.setQuantity(quantity);
	// Dao객체에서 cartitem 객체의 update 작업을 한다.
	cartItemDao.updateCartItem(cartItem);
	
	// 응답으로 list.jsp를 재요청한다.
	response.sendRedirect("list.jsp" + checkboxQueryString);
%>