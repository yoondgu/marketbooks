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

	//  파라미터값 전달 받아서 db에 hta_user에 기본 배송지 업데이트 하기
	int addrNo = StringUtil.stringToInt(request.getParameter("changeDefAddressNo"));
	
	UserAddressDao userAddrDao = UserAddressDao.getInstance();
	UserAddress userAddr = userAddrDao.getAddressByNo(addrNo);
	if (userAddr == null) {
		throw new RuntimeException("배송지 정보가 존재하지 않습니다.");
	}
	
	// 이 배송지 번호를 사용자의 기본 배송지 번호로 바꾼다.
	UserDao userDao = UserDao.getInstance();
	user.setAddress(userAddr);
	userDao.updateUser(user);
	
	response.sendRedirect("list.jsp" + checkboxQueryString);
%>