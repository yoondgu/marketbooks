<%@page import="util.MultipartRequest"%>
<%@page import="vo.Book"%>
<%@page import="dao.BookDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
    
<%
	//	multipart/form-data 요청을 처리하는 MultipartRequest 객체 생성하기
	MultipartRequest mr = new MultipartRequest(request, "C:\\eclipse\\workspace-web\\atteched-file");

	//요청파라미터값을 조회한다.
	int bookNo = StringUtil.stringToInt(request.getParameter("bookNo"));
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	
	// 도서 정보를 조회한다.
	BookDao bookDao = BookDao.getInstance();
	Book book = bookDao.getBookByNo(bookNo);
	if(book == null) {
		throw new RuntimeException("도서 정보가 존재하지 않습니다.");
	}
	
	// 요청파라미터에서 수정된 정보를 조회한다.
	int categoryNo = StringUtil.stringToInt(mr.getParameter("categoryNo"));
	String title = mr.getParameter("title");
	String author = mr.getParameter("author");
	String publisher = mr.getParameter("publisher");
	int price = StringUtil.stringToInt(mr.getParameter("price"));
	int discountPrice = StringUtil.stringToInt(mr.getParameter("discount-price"));
	int stock = StringUtil.stringToInt(mr.getParameter("stock"));
	String discription = mr.getParameter("discription");
	
	// book객체를 생성해서 도서 정보를 저장한다.
	Book modifyBook = new Book();
	modifyBook.setCategoryNo(categoryNo);
	modifyBook.setTitle(title);
	modifyBook.setAuthor(author);
	modifyBook.setPublisher(publisher);
	modifyBook.setPrice(price);
	modifyBook.setDiscountPrice(discountPrice);
	modifyBook.setStock(stock);
	modifyBook.setDiscountPrice(discountPrice);
	
	// 도서 정보를 데이터베이스에 갱신시킨다.
	bookDao.updateBook(modifyBook);
	
	// 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("booklist.jsp");
	
%>