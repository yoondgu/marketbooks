<%@page import="dao.BookDao"%>
<%@page import="vo.Category"%>
<%@page import="vo.Book"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="util.StringUtil"%>
<%@page import="util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
<%
	//	multipart/form-data 요청을 처리하는 MultipartRequest 객체 생성하기
	MultipartRequest mr = new MultipartRequest(request, "C:\\eclipse\\workspace-web\\atteched-file");
	
	// 요청파라미터값을 조회한다.
	int categoryNo = StringUtil.stringToInt(mr.getParameter("categoryNo"));
	String title = mr.getParameter("title");
	String author = mr.getParameter("author");
	String publisher = mr.getParameter("publisher");
	int price = StringUtil.stringToInt(mr.getParameter("price"));
	int discountPrice = StringUtil.stringToInt(mr.getParameter("discount-price"));
	int stock = StringUtil.stringToInt(mr.getParameter("stock"));
	String discription = mr.getParameter("discription");
	
	// book객체를 생성해서 도서 정보를 저장한다.
	Book book = new Book();
	book.setCategoryNo(categoryNo);
	book.setTitle(title);
	book.setAuthor(author);
	book.setPublisher(publisher);
	book.setPrice(price);
	book.setDiscountPrice(discountPrice);
	book.setStock(stock);
	book.setDiscountPrice(discountPrice);
	
	// 도서 정보를 데이터베이스에 저장시킨다.
	BookDao bookDao = BookDao.getInstance();
	bookDao.insertbook(book);
	
	// 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("../home.jsp");
	
%>