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
	UserDao userDao = UserDao.getInstance();
	User user = userDao.getUserByNo(userNo);

	// modifyAddressNo, postcode, address, detailAddress 파라미터값 전달 받아서 db에 hta_user_addresses에 업데이트하기
	int addrNo = StringUtil.stringToInt(request.getParameter("addressNo"));
	
	UserAddressDao userAddrDao = UserAddressDao.getInstance();
	UserAddress userAddr = userAddrDao.getAddressByNo(addrNo);
	if (userAddr == null) {
		throw new RuntimeException("배송지 정보가 존재하지 않습니다.");
	}
	
	userAddr.setDeleted("Y");
	userAddrDao.updateAddress(userAddr);
	
	// 이 배송지가 기존 사용자의 기본 배송지였을 경우, DB에 저장된 기본 배송지 번호 값을 null로 바꾼다.	
	boolean isDefaultAddress = user.getAddress() != null && user.getAddress().getNo() == addrNo;
	if (isDefaultAddress) {
		user.setAddress(null);
		userDao.updateUser(user);
	}
	
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
	
	// 기본배송지를 삭제할 경우 부모창에 제출할 것이므로 list.jsp, 아닐 경우 address.list.jsp를 요청한다.
	response.sendRedirect((isDefaultAddress ? "list.jsp" : "addressList.jsp") + checkboxQueryString);%>