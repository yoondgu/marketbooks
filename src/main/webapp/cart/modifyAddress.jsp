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
	// 선택된 배송지가 현재 기본배송지인지 확인한다.
	int defaultAddressNo = 0;
	if (user.getAddress() !=null) {
		defaultAddressNo = user.getAddress().getNo();
	}
	// 선택된 배송지와 현재 기본배송지 모두 존재하지 않을 경우에도 true를 반환한다.
	boolean wasDefaultSelected = user.getAddress().getNo() == selectedAddressNo;

	// modifyAddressNo, postcode, address, detailAddress 파라미터값 전달 받아서 db에 hta_user_addresses에 업데이트하기
	int addrNo = StringUtil.stringToInt(request.getParameter("addressNo"));
	
	UserAddressDao userAddrDao = UserAddressDao.getInstance();
	UserAddress userAddr = userAddrDao.getAddressByNo(addrNo);
	if (userAddr == null) {
		throw new RuntimeException("배송지 정보가 존재하지 않습니다.");
	}
	
	int postcode = StringUtil.stringToInt(request.getParameter("postcode"));
	String address = StringUtil.nullToBlank(request.getParameter("address"));
	String detailAddress = StringUtil.nullToBlank(request.getParameter("detailAddress"));
	
	userAddr.setAddress(address);
	userAddr.setDetailAddress(detailAddress);
	userAddr.setPostalCode(postcode);
	
	userAddrDao.updateAddress(userAddr);
	
	// isChecked 파라미터값이 null이 아니고 yes일 경우 db에 hta_user에 user_address_no 변경하기
	String isChecked = StringUtil.nullToBlank(request.getParameter("isChecked"));
	boolean isCheckedDefAddr = "yes".equals(isChecked);
	if (isCheckedDefAddr) {
		// 저장한 배송지정보를 사용자정보에 기본배송지로 업데이트한다.
		UserDao userDao = UserDao.getInstance();
		user.setAddress(userAddr);
		userDao.updateUser(user);
	}
	
	// 수정폼에서 '기본배송지로 저장'에 체크했을 경우 부모창에 제출할 것이므로 list.jsp, 아닐 경우 address.list.jsp를 요청한다.
	// 기본배송지를 삭제할 경우에도 부모창에 제출할 것이므로 list.jsp, 아닐 경우 address.list.jsp를 요청한다.
	response.sendRedirect((addrNo == selectedAddressNo || (isCheckedDefAddr && wasDefaultSelected)? "list.jsp" : "addressList.jsp") + queryString);
%>