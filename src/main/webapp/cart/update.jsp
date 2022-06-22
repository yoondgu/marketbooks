<%@page import="util.QueryStringUtil"%>
<%@page import="vo.User"%>
<%@page import="vo.Book"%>
<%@page import="vo.CartItem"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int userNo = user.getNo();
	
	// 체크 상태를 유지시킬 아이템번호를 전달받아서 재요청URL에 반영해둔다.
	String[] numbers = request.getParameterValues("checkedItemNo");
	String checkboxQueryString = QueryStringUtil.generateCartItemQueryString(numbers, "checkedItemNo");
	
	int itemNo = StringUtil.stringToInt(request.getParameter("itemNo"));
	int quantity = StringUtil.stringToInt(request.getParameter("quantity"));
	
	CartItemDao cartItemDao = CartItemDao.getInstance();
	// 획득한 아이템번호로 DB에서 카트아이템을 조회한다.
	CartItem cartItem = cartItemDao.getCartItemByNo(itemNo);
	// 존재하지 않는 아이템이거나 사용자번호가 일치하지 않을 경우 list.jsp로 재요청, fail=invalid 값을 전달한다.
	if (cartItem == null || cartItem.getUserNo() != userNo) {
		response.sendRedirect("list.jsp" + checkboxQueryString + (checkboxQueryString.isEmpty()? "?" : "&") + "fail=invalid");
	}
	
	// 변경하려는 수량이 1보다 작을 경우 fail=quantityInvalid 값을 전달한다. (체크된 아이템번호도 함께 전달한다.)
	if (quantity < 1) {
		response.sendRedirect("list.jsp" + checkboxQueryString + (checkboxQueryString.isEmpty()? "?" : "&") + "fail=quantityInvalid");
		return;
	}
	
	// 변경하려는 수량이 book.getStock()보다 클 경우 list.jsp로 재요청, fail=stockInvalid 값을 전달한다. (체크된 아이템번호도 함께 전달한다.)
	Book book = cartItem.getBook();
	if (quantity > book.getStock()) {
		response.sendRedirect("list.jsp" + checkboxQueryString + (checkboxQueryString.isEmpty()? "?" : "&") + "fail=stockInvalid");
		return;
	}

	// 획득한 객체에 변경된 값을 저장한다.
	cartItem.setQuantity(quantity);
	// Dao객체에서 cartitem 객체의 update 작업을 한다.
	cartItemDao.updateCartItem(cartItem);
	
	// 응답으로 list.jsp를 재요청한다.
	response.sendRedirect("list.jsp" + checkboxQueryString);
%>