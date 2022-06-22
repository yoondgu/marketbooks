<%@page import="util.QueryStringUtil"%>
<%@page import="vo.User"%>
<%@page import="vo.CartItem"%>
<%@page import="dao.CartItemDao"%>
<%@page import="util.StringUtil"%>
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
	
	String job = request.getParameter("job");
	CartItemDao cartItemDao = CartItemDao.getInstance();
	
	if ("one".equals(job)) {
		
		int itemNo = StringUtil.stringToInt(request.getParameter("itemNo"));
		
		// 획득한 아이템번호로 DB에서 카트아이템을 조회한다.
		CartItem cartItem = cartItemDao.getCartItemByNo(itemNo);
		// 존재하지 않는 아이템이거나 사용자번호가 일치하지 않을 경우 list.jsp로 재요청, fail=invalid 값을 전달한다.
		if (cartItem == null || cartItem.getUserNo() != userNo) {
			response.sendRedirect("list.jsp" + checkboxQueryString + (checkboxQueryString.isEmpty()? "?fail=invalid" : "&fail=invalid"));
		}
				
		
		// Dao객체에서 해당 번호의 cartItem 객체를 삭제한다.
		cartItemDao.deleteCartItem(itemNo);
		
	} else if ("all".equals(job)) {
		
		String[] values = request.getParameterValues("checkedItemNo");
		
		for (String value : values) {
			
			int deleteItemNo = StringUtil.stringToInt(value);
			
			// 획득한 아이템번호로 DB에서 카트아이템을 조회한다.
			CartItem cartItem = cartItemDao.getCartItemByNo(deleteItemNo);
			// 존재하지 않는 아이템이거나 사용자번호가 일치하지 않을 경우 list.jsp로 재요청, fail=invalid 값을 전달한다.
			if (cartItem == null || cartItem.getUserNo() != userNo) {
				response.sendRedirect("list.jsp" + checkboxQueryString + (checkboxQueryString.isEmpty()? "?fail=invalid" : "&fail=invalid"));
			}
			
			// Dao객체에서 해당 번호의 cartItem 객체를 삭제한다.
			cartItemDao.deleteCartItem(deleteItemNo);
		}
	}

	// 응답으로 list.jsp를 재요청한다.
	response.sendRedirect("list.jsp" + checkboxQueryString);
	
%>