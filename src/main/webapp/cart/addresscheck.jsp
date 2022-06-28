<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.UserAddress"%>
<%@page import="dao.UserAddressDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}

	//해당 사용자의 기본 배송지 획득
	UserAddress defAddr = user.getAddress();

	// 로컬스토리지에서 꺼낸 선택 배송지 정보 획득
	int selectedAddressNo = StringUtil.stringToInt(request.getParameter("selectedAddressNo"));
	UserAddressDao userAddressDao = UserAddressDao.getInstance();
	UserAddress addr = userAddressDao.getAddressByNo(selectedAddressNo);

	Map<String, Object> result = new HashMap<>();
	if (addr == null && defAddr == null) {
		// 로컬스토리지 배송지정보 없음, 기본배송지 없음
		result.put("exist", "no");

	} else if (addr == null && defAddr != null) {
		// 로컬스토리지 배송지정보 없지만, 기본배송지 있음
		result.put("exist", "no");
		addr = defAddr;
		result.put("address", addr);
		result.put("defaddress", "yes");
		
	} else if (addr != null) {
		
		// 사용자의 배송지정보가 아니면 존재하지 않는 것으로 본다.
		if (addr.getUserNo() != user.getNo()) {
			result.put("exist", "no");
			
			if (defAddr != null) {
				addr = defAddr;
				result.put("address", addr);
				result.put("defaddress", "yes");
			}
			
		} else {
			
			// 로컬스토리지 배송지정보가 있음
			result.put("exist", "yes");
			result.put("address", addr);
			result.put("defaddress", "no");
			
			if (defAddr != null && addr.getNo() == defAddr.getNo()){
				// 로컬스토리지 배송지의 번호가 기본배송지 번호와 같은 경우
				result.put("defaddress", "yes");
			}
		}
			
	}
	
			
	
		
	Gson gson = new Gson();
	String jsonText = gson.toJson(result);
	out.write(jsonText); // 이 페이지에 요청을 보낸 곳으로 응답정보를 보낸다.
%>
		
