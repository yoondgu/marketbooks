<%@page import="vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.BookDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="container">
	<div class="row m-5">
		<span class="text-center fs-2">베스트셀러</span>
	</div>
<%
	BookDao bookDao = BookDao.getInstance();
	// 전체 데이터 갯수 조회
	int totalRows = 0;
	totalRows = bookDao.getTotalRows();

	// 요청한 페이지번호에 맞는 데이터 조회하기
	List<Book> bookList = null;
	bookList = bookDao.getBooks(0, totalRows);

%>
	<div class="row">
	<%
		for (Book book : bookList) {
	%>
		<div class="col mb-5">
			<div class="card m-2 border-white" style="width:280px;">
				<img src="/marketbooks/images/bookcover/book-<%=book.getNo()%>.jpg"
					class="card-img-top .img-fluid" id="book-cover-img" />
				<div class="card-body">
					<h5 id="book-title" class="card-title lh-sm mb-4"><%=book.getTitle()%></h5>
					<span class="bookAuthor card-text lh-sm float-start" ><%=book.getAuthor()%></span>
					<span class="fw-semibold lh-sm float-end fw-bold"><%=book.getDiscountPrice()%></span>
					<span class="text-decoration-line-through lh-sm float-end me-3"><%=book.getPrice()%></span>			
					<a href="/marketbooks/book/detail.jsp" class="stretched-link"></a>
				</div>
			</div>
		</div>
	<%
		}
	%>
	</div>
</div>
