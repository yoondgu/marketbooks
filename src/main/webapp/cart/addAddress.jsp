<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	
	// postcode, address, detailAddress 파라미터값 전달 받아서 db에 hta_user_addresses에 저장하기
	int postcode = StringUtil.stringToInt(request.getParameter("postcode"));
	String address = StringUtil.nullToBlank(request.getParameter("address"));
	String detailAddress = StringUtil.nullToBlank(request.getParameter("detailAddress"));
	
	// isChecked 파라미터값이 null이 아니고 yes일 경우 db에 hta_user에 user_address_no 변경하기
%>