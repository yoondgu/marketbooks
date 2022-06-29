<%@page import="util.QueryStringUtil"%>
<%@page import="dao.CartItemDao"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.UserAddress"%>
<%@page import="dao.UserAddressDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 에러페이지를 띄운다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("로그인 후 이용가능한 서비스입니다.");
	}
	int userNo = user.getNo();
	
	String queryString = "";
	// 체크 상태를 유지시킬 아이템번호를 전달받아서 재요청URL에 반영해둔다.
	String[] numbers = request.getParameterValues("checkedItemNo");
	queryString += QueryStringUtil.generateCartItemQueryString(numbers, "checkedItemNo");
	
	// 선택된 배송지번호를 전달받아서 재요청URL에 반영해둔다.
	int selectedAddressNo = StringUtil.stringToInt(request.getParameter("selectedAddressNo"));
	queryString += (queryString.isEmpty()? "?" : "&") + "selectedAddressNo=" + selectedAddressNo;

	// 파라미터값 전달 받아서 db에 hta_user_addresses에 업데이트하기
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
		UserDao userDao = UserDao.getInstance();
		user.setAddress(null);
		userDao.updateUser(user);
	}
	
	// 선택된 배송지를 삭제할 경우 부모창에 제출할 것이므로 list.jsp, 아닐 경우 address.list.jsp를 요청한다.
	// 요청파라미터 location=mypage 값을 받았을 경우 무조건 mypage/addressList.jsp로 이동한다.
	String location = StringUtil.nullToBlank(request.getParameter("location"));
	if ("mypage".equals(location)) {
		response.sendRedirect("/marketbooks/mypage/addressList.jsp" + queryString);
	} else {
		response.sendRedirect((addrNo == selectedAddressNo? "/marketbooks/cart/list.jsp" : "/marketbooks/cart/addressList.jsp") + queryString);
	}
	
%>