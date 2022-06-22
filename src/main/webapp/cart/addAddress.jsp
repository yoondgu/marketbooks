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
	
	// 체크 상태를 유지시킬 아이템번호를 전달받아서 재요청URL에 반영해둔다.
	String[] numbers = request.getParameterValues("checkedItemNo");
	String checkboxQueryString = QueryStringUtil.generateCartItemQueryString(numbers, "checkedItemNo");
	
	// postcode, address, detailAddress 파라미터값 전달 받아서 db에 hta_user_addresses에 저장하기
	int postcode = StringUtil.stringToInt(request.getParameter("postcode"));
	String address = StringUtil.nullToBlank(request.getParameter("address"));
	String detailAddress = StringUtil.nullToBlank(request.getParameter("detailAddress"));
	
	UserAddressDao userAddrDao = UserAddressDao.getInstance();
	// 시퀀스 값을 다른 부분에서도 써야 할 때는 시퀀스를 별도로 생성해서 사용한다.
	int addrNo = userAddrDao.getAddressSequence();
	
	UserAddress userAddr = new UserAddress();
	userAddr.setNo(addrNo);
	userAddr.setUserNo(userNo);
	userAddr.setPostalCode(postcode);
	userAddr.setAddress(address);
	userAddr.setDetailAddress(detailAddress);
	
	userAddrDao.insertAddress(userAddr);
	
	// isChecked 파라미터값이 null이 아니고 yes일 경우 db에 hta_user에 user_address_no 변경하기
	String isChecked = StringUtil.nullToBlank(request.getParameter("isChecked"));
	boolean isCheckedDefAddr = "yes".equals(isChecked);
	if (isCheckedDefAddr) {
		// 저장한 배송지정보를 사용자정보에 기본배송지로 업데이트한다.
		UserDao userDao = UserDao.getInstance();
		user.setAddress(userAddr);
		userDao.updateUser(user);
	}
	
	// 추가폼에서 '기본배송지로 저장'에 체크했을 경우 부모창에 제출할 것이므로 list.jsp, 아닐 경우 address.list.jsp를 요청한다.
	boolean isDefaultAddress = user.getAddress() != null && user.getAddress().getNo() == addrNo;
	response.sendRedirect((isCheckedDefAddr? "list.jsp" : "addressList.jsp") + checkboxQueryString);
%>