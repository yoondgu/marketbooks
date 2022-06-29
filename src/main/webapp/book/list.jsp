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
	int rows = 12;
	
	// 파라미터 사용하기
	String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
	String categoryName = StringUtil.nullToBlank(request.getParameter("category"));
	String tab = StringUtil.nullToBlank(request.getParameter("tab"));
	// bookdao 사용하기
	BookDao bookDao = BookDao.getInstance();
	// 데이터 개수 조회
	int totalRows = 0;
	if (!categoryName.isBlank()) {
		totalRows = bookDao.getTotalRowsByCategoryName(categoryName);
	} else if (!keyword.isBlank()) {
		totalRows = bookDao.getTotalRowsByKeyword(keyword);
	} else {
		totalRows = bookDao.getTotalRows();
	}
	// 페이징처리에 필요한 정보를 제공하는 객체 생성
	Pagination pagination = new Pagination(rows, totalRows, currentPage);
	// 요청한 페이지탭 및 페이지번호에 맞는 데이터 조회하기
	List<Book> bookList = null;
	
	if (!categoryName.isEmpty()) {
		bookList = bookDao.getBooksByCategory(pagination.getBeginIndex(), pagination.getEndIndex(), categoryName);
	} else if (!keyword.isEmpty()) {
		bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
	} else if (!tab.isEmpty()) {
			bookList = bookDao.getNewBooks(pagination.getBeginIndex(), pagination.getEndIndex());
		if (tab.equals("신작")) {
		} else if (tab.equals("베스트셀러")) {
			bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex());
		} else if (tab.equals("알뜰쇼핑")) {
			bookList = bookDao.getBooksOrderByDiscountPrice(pagination.getBeginIndex(), pagination.getEndIndex());
		}
	} else {
		bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex());
	}
%>
	<div class="row m-5">
	<%
		if (!categoryName.isBlank()){
	%>
			<span class="text-center fs-2"><%=categoryName %></span>
	<%		
		} else if (!keyword.isBlank()) {
	%>
			<span class="text-center fs-2">"<%=keyword %>" 검색결과</span>
	<%
		} else if (!tab.isBlank()) {
    %>
            <span class="text-center fs-2">"<%=tab %>" 검색결과</span>
    <%
		}   
	%>
	</div>
		
	<div class="row m-2" style="text-decoration: none;">
		<div>
			<div class="float-start"> 총 <%=totalRows%>개 </div>	
			<div class="float-end me-2 pe-4">				
				<ul class="float-end .alignlist">
					<li class=" float-start"><a class="me-2 pe-auto" href="">신상품순</a></li>
					<li class=" float-start"><a class="me-2 pe-auto" href="">판매량순</a></li>
					<li class=" float-start"><a class="me-2 pe-auto" href="">낮은 가격순</a></li>
					<li class=" float-start"><a class="me-2 pe-auto" href="">높은 가격순</a></li>
				</ul>
			</div>
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

	<!-- 페이징 영역 -->
	<div class="row">
			<!--  
				요청한 페이지번호에 맞는 페이지번호를 출력한다.
				요청한 페이지번호와 일치하는 페이지번호는 하이라이트 시킨다.
				요청한 페이지가 1페이지인 경우 이전 버튼을 비활성화 시킨다.
				요청한 페이지가 맨 마지막 페이지인 경우 다음 버튼을 비활성화 시킨다. 
			-->
			<nav>
				<ul class="pagination justify-content-center">
			<%
				if (!keyword.isBlank()) {
			%>
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() == 1 || pagination.getCurrentPage() == 0 ? "disabled" : "" %>" href="list.jsp?keyword=<%=keyword %>&page=<%=currentPage - 1 %>">이전</a>
					</li>
			<%					
				} else {
			%>
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() == 1 || pagination.getCurrentPage() == 0 ? "disabled" : "" %>" href="list.jsp?category=<%=categoryName %>&page=<%=currentPage - 1 %>">이전</a>
					</li>
			<%				
				}
			%>

			<%
				for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
					if (!keyword.isBlank()) {
			%>
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() == num ? "active" : "" %>" href="list.jsp?keyword=<%=keyword %>&page=<%=num %>"><%=num %></a>
					</li>
			<%
					} else {
			%>				
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() == num ? "active" : "" %>" href="list.jsp?category=<%=categoryName %>&page=<%=num %>"><%=num %></a>
					</li>

			<%
					}
				}
			%>
			
			
			<%
				if (!keyword.isBlank()) {
			%>
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="list.jsp?keyword=<%=keyword %>&page=<%=currentPage + 1 %>">다음</a>
					</li>
			<%					
				} else {
			%>
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="list.jsp?category=<%=categoryName %>&page=<%=currentPage + 1 %>">다음</a>
					</li>
			<%				
				}
			%>

				</ul>
			</nav>		
	</div>

<!-- footer include -->
<jsp:include page="/common/footer.jsp">
	<jsp:param name="menu" value="list" />
</jsp:include>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

</script>	
</body>
</html>