<%@page import="java.util.Arrays"%>
<%@page import="java.util.Date"%>
<%@page import="vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.BookDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="container">
	<div class="row m-5">
		<span class="text-center fs-2">알뜰쇼핑</span>
	</div>
<%
	BookDao bookDao = BookDao.getInstance();
	// 전체 데이터 갯수 조회
	int totalRows = 0;
	totalRows = bookDao.getTotalRows();

	// 요청한 페이지번호에 맞는 데이터 조회하기
	List<Book> bookList = null;
	bookList = bookDao.getBooksOrderByDiscountPrice(0, totalRows);	
%>
	<div class="row">
	<%
		double dc = 0.0;
		for (Book book : bookList) {
			// 할인률 구하기
			dc = Math.floor(100-(book.getDiscountPrice()*100/book.getPrice()));			
			
			// 책 제목, 부제목 나누기
			String title = book.getTitle();
			String maintitle;
			String subtitle;
			if (title.contains("-")) {
				maintitle = title.substring(0, title.lastIndexOf(" - "));
				subtitle = title.substring(title.lastIndexOf(" - ")+1);
			} else {
				maintitle = title;
			}
			
			// 할인하는 책만 출력
			if (dc != 0.0) {		
	%>
		<div class="col mb-2 book-card" >
			<div class="image-box mb-2">
				<img src="/marketbooks/images/bookcover/book-<%=book.getNo()%>.jpg"
				class="image-thumbnail" id="book-cover-img" />
			</div>
			<div class="text-box mb-5">
				<h5 class="row px-4"><%=maintitle%></h5>
				<span class="fs-6 ps-3 float-start text-danger"><%=dc%>%</span>
				<span class="fs-6 fw-semibold fw-bold ms-3"><%=book.getDiscountPrice()%>원</span>
				<span class="text-decoration-line-through ps-1"><%=book.getPrice()%>원</span>
				<a href="/marketbooks/book/detail.jsp?bookNo=<%=book.getNo() %>" class=""></a>
			</div>
		</div>
	<%
			}
		} 
	%>
	</div>
</div>