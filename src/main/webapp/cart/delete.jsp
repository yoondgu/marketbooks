<%@page import="vo.CartItem"%>
<%@page import="dao.CartItemDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CartItemDao cartItemDao = CartItemDao.getInstance();

	// TO DO: 로그인된 사용자 정보 조회
	//		 로그인된 사용자가 NULL이거나, cartItem의 userNo와 로그인된 사용자의 userNo가 다를 경우 경고메시지를 띄우고 로그인페이지로 이동한다.
	
	// itemNo가 여러 개일 경우도 고려해서, List로 받고 for문으로 돌린다.
	String[] values = request.getParameterValues("deleteItemNo");
	for (String value : values) {
		int itemNo = StringUtil.stringToInt(value);
		// 획득한 아이템번호로 DB에서 카트아이템을 조회한다.
		CartItem cartItem = cartItemDao.getCartItemByNo(itemNo);
		// 존재하지 않는 아이템일 경우 list.jsp로 재요청, fail=invalid 값을 전달한다.
		if (cartItem == null) {
			response.sendRedirect("list.jsp?fail=invalid");
			return;
		}
		
		// Dao객체에서 해당 번호의 cartItem 객체를 삭제한다.
		cartItemDao.deleteCartItem(itemNo);
	}

	// 응답으로 list.jsp를 재요청한다.
	response.sendRedirect("list.jsp");
	
%>