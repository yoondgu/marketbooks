<%@page import="com.google.gson.Gson"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@page import="util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	OrderDao orderDao = OrderDao.getInstance();

	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int userNo = user.getNo();
	
	int orderNo = StringUtil.stringToInt(request.getParameter("orderNo"));
	Order order = orderDao.getOrderByNo(orderNo);
	if (order != null && order.getUserNo() == userNo) {
		order.setStatus("주문취소");
		orderDao.updateOrder(order);
	} else {
		throw new RuntimeException("요청 정보가 올바르지 않습니다.");
	}
	
	Map<String, Object> result = new HashMap<>();
	result.put("success", true);
	
	Gson gson = new Gson();
	String jsonText = gson.toJson(result);
	out.write(jsonText); // 이 페이지에 요청을 보낸 곳으로 응답정보를 보낸다.
%>