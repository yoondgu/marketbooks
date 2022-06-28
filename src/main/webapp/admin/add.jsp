<%@page import="java.text.DateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="util.StringUtil"%>
<%@page import="util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//	multipart/form-data 요청을 처리하는 MultipartRequest 객체 생성하기
	MultipartRequest mr = new MultipartRequest(request, "C:\\eclipse\\workspace-web\\atteched-file");
	
	// 요청파라미터값을 조회한다.
	int categoryNo = StringUtil.stringToInt(mr.getParameter("categoryNo"));
	String title = mr.getParameter("title");
	String author = mr.getParameter("author");
	String publisher = mr.getParameter("publisher");
	Date createdDate = DateFormat.parse(mr.getParameter("created-date"));
	int price = StringUtil.stringToInt(mr.getParameter("price"));
	int discountPrice = StringUtil.stringToInt(mr.getParameter("discount-price"));
	int stock = StringUtil.stringToInt(mr.getParameter("stock"));
	String discription = mr.getParameter("discription");
			
	
%>