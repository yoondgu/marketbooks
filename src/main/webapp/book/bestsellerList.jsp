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
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 10);
	String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));

	BookDao bookDao = BookDao.getInstance();
	// 전체 데이터 갯수 조회
	int totalRows = 0;
	if (keyword.isEmpty()) {
		totalRows = bookDao.getTotalRows();
	} else {
		totalRows = bookDao.getTotalRows(keyword);
	}
	// 페이징처리에 필요한 정보를 제공하는 객체 생성
	Pagination pagination = new Pagination(rows, totalRows, currentPage);

	// 요청한 페이지번호에 맞는 데이터 조회하기
	List<Book> bookList = null;
	if (keyword.isEmpty()) {
		bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex());
	} else {
		bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
	}
%>

	<div class="row">
	<%
		for (Book book : bookList) {
	%>
		<div class="col mb-5">
			<div class="card m-2 border-white" style="width:280px;">
				<img src="images/bookcover/book-<%=book.getNo()%>.jpg"
					class="card-img-top .img-fluid" id="book-cover-img" />
				<div class="card-body">
					<h5 id="book-title" class="card-title lh-sm mb-4"><%=book.getTitle()%></h5>
					<span class="bookAuthor card-text lh-sm float-start" ><%=book.getAuthor()%></span>
					<span class="fw-semibold lh-sm float-end fw-bold"><%=book.getDiscountPrice()%></span>
					<span class="text-decoration-line-through lh-sm float-end me-3"><%=book.getPrice()%></span>			
					<a href="detail.jsp" class="stretched-link"></a>
				</div>
			</div>
		</div>
	<%
		}
	%>
	</div>
</div>
