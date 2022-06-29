<%@page import="vo.Book"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.BookDao"%>
<%@page import="vo.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓북스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"	type="image/x-icon">
<link href="../css/home.css" rel="stylesheet">
</head>
<body>
<!-- 헤더 include -->
<jsp:include page="/common/header.jsp">
	<jsp:param name="menu" value="list" />
</jsp:include>

<div class="container">
<%
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 12);
	String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
	String categoryName = StringUtil.nullToBlank(request.getParameter("category"));

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
	if (!categoryName.isEmpty()) {
		bookList = bookDao.getBooksByCategory(pagination.getBeginIndex(), pagination.getEndIndex(), categoryName);
	} else if (!keyword.isEmpty()) {
		bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
	} else {
		bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex());
	}
%>

	<div class="row m-5">
		<span class="text-center fs-2"><%=categoryName %></span>
	<%
		if (!keyword.isEmpty()) {
	%>
		<span class="text-end">"<%=keyword %>" 총 <%=bookDao.getTotalRows(keyword) %> 개가 검색되었습니다.</span>
	<%
		}
	%>
		<div class="">
			
		</div>
	</div>
	
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

<!-- footer include -->
<jsp:include page="/common/footer.jsp">
	<jsp:param name="menu" value="list" />
</jsp:include>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>	
</body>
</html>