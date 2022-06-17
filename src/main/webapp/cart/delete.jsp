<%@page import="vo.CartItem"%>
<%@page import="dao.CartItemDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CartItemDao cartItemDao = CartItemDao.getInstance();

	// TO DO: 로그인된 사용자 정보 조회
	//		 로그인된 사용자가 NULL이거나, cartItem의 userNo와 로그인된 사용자의 userNo가 다를 경우 경고메시지를 띄우고 로그인페이지로 이동한다.
	
	// 개별 삭제, 체크된 아이템 모두 삭제인지 판정한다.
	String job = request.getParameter("job");
	
	if ("one".equals(job)) {
		
		int itemNo = StringUtil.stringToInt(request.getParameter("itemNo"));
		
		// 획득한 아이템번호로 DB에서 카트아이템을 조회한다.
		CartItem cartItem = cartItemDao.getCartItemByNo(itemNo);
		// 존재하지 않는 아이템일 경우 list.jsp로 재요청, fail=invalid 값을 전달한다.
		if (cartItem == null) {
			response.sendRedirect("list.jsp?fail=invalid");
			return;
		}
		
		// Dao객체에서 해당 번호의 cartItem 객체를 삭제한다.
		cartItemDao.deleteCartItem(itemNo);
		
	} else if ("all".equals(job)) {
		
		String[] values = request.getParameterValues("checkedItemNo");
		
		for (String value : values) {
			
			int deleteItemNo = StringUtil.stringToInt(value);
			
			// 획득한 아이템번호로 DB에서 카트아이템을 조회한다.
			CartItem cartItem = cartItemDao.getCartItemByNo(deleteItemNo);
			// 존재하지 않는 아이템일 경우 list.jsp로 재요청, fail=invalid 값을 전달한다.
			if (cartItem == null) {
				response.sendRedirect("list.jsp?fail=invalid");
				return;
			}
			
			// Dao객체에서 해당 번호의 cartItem 객체를 삭제한다.
			cartItemDao.deleteCartItem(deleteItemNo);
		}
	}
 	
	// 체크 상태를 유지시킬 아이템번호를 전달받아서 재요청URL에 반영한다.
	String[] numbers = request.getParameterValues("checkedItemNo");
	String queryString = "";
	if (numbers != null) {
		queryString = "?";
		for (String number : numbers) {
			int checkedItemNo = StringUtil.stringToInt(number);
			// 체크 상태를 유지시킬 아이템번호에 해당하는 카트가 없으면 덧붙일 queryString이 없다.
			if (cartItemDao.getCartItemByNo(checkedItemNo) == null) {
				continue;
			}
			
			queryString += "?".equals(queryString) ? "checkedItemNo=" + checkedItemNo : "&checkedItemNo=" + checkedItemNo;
		}
	}

	// 응답으로 list.jsp를 재요청한다.
	response.sendRedirect("list.jsp" + queryString);
	
%>