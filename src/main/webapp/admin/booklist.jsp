<%@page import="vo.User"%>
<%@page import="vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.BookDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
    
   <!-- 관리자만 접속할 수 있게 합니다. -->
<%     
	// 세션에 저장된 사용자정보를 조회한다.
	User logineduser = null;
	if((logineduser = (User) session.getAttribute("LOGINED_USER")) != null) {
		if(!"admin@gmail.com".equals(logineduser.getEmail())) {
			throw new RuntimeException("관리자 홈페이지에 접속하실 수 없습니다.");
		} else {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓북스 - 관리자페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png" type="image/x-icon">
<link rel="stylesheet" href="../css/board.css">
<style>
	#button a{
		font-family: noto sans,malgun gothic,AppleGothic,dotum;
        line-height: 1;
        letter-spacing: -.05em;
        font-size: 12px;
        max-width: 100%;
	}
	a :hover {
		background-color:red;
	}
	.pagediv {
		font-family: noto sans,malgun gothic,AppleGothic,dotum;
        line-height: 1;
        letter-spacing: -.05em;
        font-size: 12px;
        max-width: 100%;
	}
</style>
</head>

<body class="board-list">
	<!-- header -->
	<div id="header">
	<%
		String menu = request.getParameter("menu");
	%>
		<nav class="navbar navbar-expand-lg bg-light">
			<div class="container">
				<a class="navbar-brand" href="../home.jsp"><img alt="마켓북스 로고" src="../images/marketbooks-logo.png" style="width:40%; justify-content:center;"></a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
		        <span class="navbar-text" style="font-size:15px"><strong>관리자님 환영합니다.</strong></span>
				<div class="">
				    <div class="collapse navbar-collapse " id="navbarNav">
				        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
					        <li class="nav-item">
								<a class="nav-link <%="admin".equals(menu) ? "active" : "" %>" aria-current="page" href="/marketbooks/admin/home.jsp">관리자홈</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" aria-current="page" href="../logout.jsp">로그아웃</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</nav>
	</div>

	<div id="wrap">
		<div class="container">
			<div id="main">
				<div id="content">
					<div class="page_aticle">
					
						<!-- side bar -->
						<div id="snb" class="snb_cc">
							<h2 class="tit_snb">관리자메뉴</h2>
							<div class="inner_snb">
								<ul class="list_menu">
									<li><a href="userlist.jsp">회원관리</a></li>
									<li class="on"><a href="booklist.jsp">도서관리</a></li>
									<li><a href="inquirylist.jsp">문의관리</a></li>
									<li><a href="orderlist.jsp">주문관리</a></li>
								</ul>
							</div>
						</div>
						
						<!-- main -->
						<div class="page_section">
							<div class="head_aticle">
								<h2 class="tit">전체도서관리<span class="tit_sub">모든 도서를 관리할 수 있는 페이지 입니다.</span>
									<a href="form.jsp" class="btn btn-outline-warning btn-sm float-end mt-1">도서 등록</a>
								</h2>
							</div>
							
	   <%
	   		int currentPage = StringUtil.stringToInt(request.getParameter("page"));
	   		BookDao bookDao = BookDao.getInstance();
	   		
	   		int totalRows = bookDao.getTotalRows();
	   		
	   		Pagination pagination = new Pagination(totalRows, currentPage);
	   		
	   		List<Book> bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex());
	   %> 
						  
						   
	<table width="100%" align="center" cellpadding="0" cellspacing="0">
   		<tbody>
			<tr>
				<td>
					<div class="xans-element- xans-myshop xans-myshop-couponserial ">
						<table width="100%" class="xans-board-listheader" cellpadding="0" cellspacing="0">
					   		<colgroup>
					   			<col width="8%">
					   			<col width="13%">
					   			<col width="%">
					   			<col width="10%">
					   			<col width="12%">
					   			<col width="5%">
					   			<col width="15%">
					   		</colgroup>
					   		<thead>
					   			<tr>
					   				<!-- 간략한 도서리스트만 보이도록합니다. 상세한 도서정보 페이지는 따로 만들지 않고 도서상세페이지로 연결합니다. -->
					   				<th>도서번호</th>
					   				<th>카테고리</th>
					   				<th>도서명</th>
					   				<th>저자</th>
					   				<th>출판사</th>
					   				<th>재고</th>
					   				<th>가격</th>
					   				<th></th>
					   			</tr>
					   		</thead>
					   		<tbody class="table-group-divider">
					   		<%
					   			for(Book book : bookList) {
					   		%>
					   			<tr>
					   				<td><%=book.getNo() %></td>
					   				<td><%=book.getCategory().getName() %></td>
					   				<!-- 도서명을 클릭하면 해당 도서페이지로 넘어가도록 링크를 설정한다. -->
					   				<td>
					   					<a href="../book/detail.jsp?bookNo=<%=book.getNo() %>"><%=book.getTitle() %></a>
					 				</td>
					   				<td><%=book.getAuthor() %></td>
					   				<td><%=book.getPublisher() %></td>
					   				<td><%=book.getStock() %></td>
					   				<td><strong><%=book.getDiscountPrice() %>원</strong><div><small><%=book.getPrice() %>원</small></div></td>
					   				<td>
						   				<div id="button" class="">
						   				
						   				<!--  도서 수정은 추가구현으로 남겨두겠습니다.
						   					<div><a href="modifyform.jsp" class="btn btn-outline-secondary btn-sm mb-1" style="width:41px">수정</a></div>
						   				-->
						 					<div><a href="bookdelete.jsp?no=<%=book.getNo() %>" class="btn btn-outline-danger btn-sm" style="width:41px">삭제</a></div>
						   				</div>
					   				</td>
					   			</tr>
				   			<%
				   				}
				   			%>
					   		</tbody>
					   </table>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="layout-pagination">
		<div class="pagediv">
	   		<!--  
				요청한 페이지번호에 맞는 페이지번호를 출력한다.
				요청한 페이지번호와 일치하는 페이지번호는 하이라이트 시킨다.
				요청한 페이지가 1페이지인 경우 이전 버튼을 비활성화 시킨다.
				요청한 페이지가 맨 마지막 페이지인 경우 다음 버튼을 비활성화 시킨다. 
			-->
			<nav>
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="javascript:changePageNo(<%=pagination.getCurrentPage() -1%>)">이전</a>
					</li>
				<%
					for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
				%>
					<li class="page-item <%=pagination.getCurrentPage() == num ? "active" : "" %>">
						<a class="page-link" href="javascript:changePageNo(<%=num %>)"><%=num %></a>
					</li>
				<%
					}
				%>
					<li class="page-item">	
						<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="javascript:changePageNo(<%=pagination.getCurrentPage() +1%>)">다음</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>
		<form id = "search-form" method="get" action="booklist.jsp">
			<input type="hidden" name="page" />
	  		<div class="d-flex mb-3">
				<div class="me-auto p-2"></div>
				<div class="p-2">
					<input class="form-control" style="width: 220px" type="text" name="keyword" value="" placeholder="검색어를 입력하세요." />
				</div>
				<div class="p-2">
					<button type="button" style="width: 60px" class="btn btn-outline-primary" onclick="searchKeyword()">검색</button>
				</div>
			</div>
		</form>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function changePageNo(pageNo) {
		document.querySelector("input[name=page]").value = pageNo;
		document.getElementById("search-form").submit();
	}
	function searchKeyword() {
		document.querySelector("input[name=page]").value = 1;
		document.getElementById("search-form").submit();
	}
</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%			
		}
	} else {
		throw new RuntimeException("관리자 홈페이지에 접속하실 수 없습니다.");
	}
%> 