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

<div class="layout-wrapper">
	<%
		int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
		int rows = StringUtil.stringToInt(request.getParameter("rows"), 4);
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

	<div class="">
		<div class="row m-5">
			<span class="text-center fs-2"><%=categoryName %></span>
		</div>
	
		<div class="row">
		<%
			for (Book book : bookList) {
		%>
			<div class="col-3">
				<div class="card border-white" style="width:267px;">
					<img src="/marketbooks/images/bookcover/book-<%=book.getNo()%>.jpg"
						class="card-img-top .img-fluid" id="book-cover-img" />
					<div class="cartImageDiv">
						<button class="cartImageBtn" >
							<img class="cartImage" src="https://s3.ap-northeast-2.amazonaws.com/res.kurly.com/kurly/ico/2021/cart_white_45_45.svg" alt="상품 카트에 담기 아이콘">
						</button>
					</div>
					<div class="card-body">
					<%
		
					%>
						<h5 id="book-title" class="card-title lh-sm mb-4"><%=book.getTitle()%></h5>
						<span class="bookAuthor card-text lh-sm float-start" ><%=book.getAuthor()%></span>
						<span class="fw-semibold lh-sm float-end fw-bold"><%=book.getDiscountPrice()%></span>
						<span class="text-decoration-line-through lh-sm float-end me-3"><%=book.getPrice()%></span>			
						<a href="/marketbooks/book/detail.jsp?bookNo=<%=book.getNo() %>" class="stretched-link"></a>
					</div>
				</div><
			</div>
		<%
			}
		%>
		</div>
	</div>	

<!-- footer include -->
<jsp:include page="/common/footer.jsp">
	<jsp:param name="menu" value="list" />
</jsp:include>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>	
</body>
</html>