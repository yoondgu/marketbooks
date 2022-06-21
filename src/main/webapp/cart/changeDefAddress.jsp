<%@page import="dao.CartItemDao"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.UserAddress"%>
<%@page import="dao.UserAddressDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	// TO DO: 로그인 체크
	int userNo = 110;
	UserAddressDao userAddrDao = UserAddressDao.getInstance();

	//  파라미터값 전달 받아서 db에 hta_user에 기본 배송지 업데이트 하기
	int addrNo = StringUtil.stringToInt(request.getParameter("changeDefAddressNo"));
	
	UserAddress userAddr = userAddrDao.getAddressByNo(addrNo);
	if (userAddr == null) {
		throw new RuntimeException("배송지 정보가 존재하지 않습니다.");
	}
	
	// 이 배송지 번호를 사용자의 기본 배송지 번호로 바꾼다.
	// TO DO: 아래는 로그인 구현하고 나면 지우기
	UserDao userDao = UserDao.getInstance();
	User user = userDao.getUserByNo(userNo);
	
	user.setAddress(userAddr);
	userDao.updateUser(user);
	
	// 체크 상태를 유지시킬 아이템번호를 재요청에 전달할 쿼리스트링을 만들어둔다.
	String[] numbers = request.getParameterValues("checkedItemNo");
	String checkboxQueryString = "";
	CartItemDao cartItemDao = CartItemDao.getInstance();
	if (numbers != null) {
		checkboxQueryString = "?";
		for (String number : numbers) {
			int checkedItemNo = StringUtil.stringToInt(number);
			// 체크 상태를 유지시킬 아이템번호에 해당하는 카트가 없으면 덧붙일 queryString이 없다.
			if (cartItemDao.getCartItemByNo(checkedItemNo) == null) {
				continue;
			}
			
			checkboxQueryString += "?".equals(checkboxQueryString) ? "checkedItemNo=" + checkedItemNo : "&checkedItemNo=" + checkedItemNo;
		}
		
		if ("?".equals(checkboxQueryString)) {
			checkboxQueryString = "";
		}
	}
	
	response.sendRedirect("list.jsp" + checkboxQueryString);
%>