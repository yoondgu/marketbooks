<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@page import="dao.BookDao"%>
<%@page import="vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>북 스토어</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<link href="../css/common.css" rel="stylesheet">
<link href="../css/normalize.css" rel="stylesheet">
<link href="../css/section1.css" rel="stylesheet">
</head>
<body>
<div class="container">
	<div class="row">
		<div class="row m-5">
			<span id="bestseller-title" class="align-middle text-center">베스트셀러</span>
		</div>
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
	<div>
		<div class="row">
			<%
			for (Book book : bookList) {
			%>
			<div class="card m-2" style="width: 280px; height: 550px;">
				<img src="images/bookcover/book-<%=book.getNo()%>.jpg" class="card-img-top" id="book-cover-img" />
				<div class="card-body">
					<h5 id="book-title" class="card-title lh-sm"><%=book.getTitle()%></h5>
					<p id="author-name" class="card-text lh-sm"><%=book.getAuthor()%></p>
					<p class="fw-semibold lh-sm"><%=book.getDiscountPrice()%></p>
					<p class="text-decoration-line-through lh-sm"><%=book.getPrice()%></p>
				    <a href="detail.jsp" class="stretched-link"></a>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>