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
<div class="container">
	<jsp:include page="/common/header.jsp">
		<jsp:param name="menu" value="list" />
	</jsp:include>

	<div id="main" class="">
		<div id="content" class="mr-3">

			<!-- 상품목록 -->
			<div id="page_article" class="row">
				<div id="lnbMenu" class="lnb_menu">
					<div id="bnrCategory" class="bnr_category link"
						style="display: block; margin:auto; justify-content: center;">
						<div class="thumb"  style="width:1050px; height:200px; text-align:center; justify-content: center;">
							<img src="" alt="카테고리배너">
						</div>
					</div>
					<div class="inner_lnb">
						<h3 class="tit">a</h3>
						<ul class="list on" style="list-style-type:none;">
							<li data-start="124" data-end="188"><a class="on">눈에 띄는
									새책</a></li>
							<li data-start="316" data-end="368"><a class="">신간 베스트</a></li>
							<li data-start="435" data-end="548"><a class="">MD 주목 신작</a></li>
							<li data-start="603" data-end="728"><a class="">경쾌한 인문학</a></li>
							<li data-start="748" data-end="908"><a class="">인문학의 깊은
									맛</a></li>
							<li data-start="956" data-end="1088"><a class="">희노애락
									심리학</a></li>
							<li class="bg"></li>
						</ul>
					</div>
				</div>
				<div id="goodsList">
					<div id="list_goods" class="col">
						<%
						int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
						int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
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
						<div id="">
							<!-- <ul class="list" style="list-style-type:none;"> -->
								<%
									for (Book book : bookList) {
								%>
								<div class="col">
									상품1
									<div class="card" style="width:249px; height:320px;">
										<img src="../images/sample.jpeg" class="card-img-top" alt="...">
										<div class="card-body">
											<h5 class="card-title"><%=book.getTitle()%></h5>
											<p class="card-text"><%=book.getDiscountPrice()%></p>
											<p class="card-text"><%=book.getAuthor()%></p>
										</div>
									</div>
								</div>


								<!-- 
								<li>
									<div class="item">
										<div class="thumb">
											<a class=""> <img src="../images/sample.jpeg"
												class="card-img-top" alt="" onerror=""
												style="height: 435px; width: 337px;">
											</a>
											<div class="group_btn">
												<button type="button" class="btn btn_cart">
													<span class=""></span>
												</button>
											</div>
										</div>
										<a class="info"> <span class="name"> <%=book.getTitle()%>
										</span> <span class="cost"> <span class="price"><%=book.getDiscountPrice()%></span>
										</span> <span class="desc"><%=book.getAuthor()%></span> <span
											class="tag"> </span>
										</a>
									</div>
								</li>
								 -->
								<%
									}
								%>
							</ul>
						</div>
					</div>

					<div class="row">
						<div class="col-4">
							<!-- 페이지 번호 출력 -->
							<nav>
								<ul class="pagination justify-content-center">
									<li class="page-item"><a
										class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : ""%>"
										href="javascript:clickPageNo(<%=pagination.getCurrentPage() - 1%>)">이전</a>
									</li>
									<%
									for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
									%>
									<li class="page-item"><a
										class="page-link <%=pagination.getCurrentPage() == num ? "active" : ""%>"
										href="javascript:clickPageNo(<%=num%>)"><%=num%></a></li>
									<%
									}
									%>
									<li class="page-item"><a
										class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : ""%>"
										href="javascript:clickPageNo(<%=pagination.getCurrentPage() + 1%>)">다음</a>
									</li>
								</ul>
							</nav>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/common/footer.jsp">
		<jsp:param name="menu" value="list" />
	</jsp:include>
</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		function changeRows() {
			document.querySelector("input[name=page]").value = 1;
			document.querySelector("input[name=rows]").value = document
					.querySelector("select[name=rows]").value;
			document.getElementById("search-form").submit();
		}

		function clickPageNo(pageNo) {
			document.querySelector("input[name=page]").value = pageNo;
			document.querySelector("input[name=rows]").value = document
					.querySelector("select[name=rows]").value;
			document.getElementById("search-form").submit();
		}

		function searchKeyword() {
			document.querySelector("input[name=page]").value = 1;
			document.querySelector("input[name=rows]").value = document
					.querySelector("select[name=rows]").value;
			document.getElementById("search-form").submit();
		}
	</script>
</body>
</html>