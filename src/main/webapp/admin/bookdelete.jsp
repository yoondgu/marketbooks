<%@page import="vo.Book"%>
<%@page import="dao.BookDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 요청파라미터에서 도서번호를 조회한다.
	int bookNo = StringUtil.stringToInt(request.getParameter("no"));
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	
	// 도서번호에 해당하는 도서 정보를 조회한다.
	BookDao bookDao = BookDao.getInstance();
	Book book = bookDao.getBookByNo(bookNo);
	
	// 도서정보가 없으면 재요청 URL을 응답으로 보낸다.
	if (book == null) {
		throw new RuntimeException("도서 정보가 존재하지 않습니다.");
	}
	
	// 도서 정보의 삭제여부를 Y로 변경한다.
	book.setDeleted("Y");
	// 변경된 도서 정보를 데이터베이스에 반영시킨다.
	bookDao.updateBook(book);
	
	// 도서목록을 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("booklist.jsp");
%>