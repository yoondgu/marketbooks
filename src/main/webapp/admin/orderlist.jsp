<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.OrderDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
    <!-- 관리자만 접속할 수 있게 합니다. -->
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
		<nav class="navbar navbar-expand-lg bg-light  ">
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
	<div class="container">
		<div id="main">
			<div class="container">
				<div class="page_aticle">
					<!-- side bar -->
					<div id="snb" class="snb_cc">
						<h2 class="tit_snb">관리자메뉴</h2>
						<div class="inner_snb">
							<ul class="list_menu">
								<li><a href="userlist.jsp">회원관리</a></li>
								<li><a href="booklist.jsp">도서관리</a></li>
								<li><a href="inquirylist.jsp">문의관리</a></li>
								<li class="on"><a href="orderlist.jsp">주문관리</a></li>
							</ul>
						</div>
					</div>
						<!-- main -->
						<div class="page_section">
							<div class="head_aticle">
								<h2 class="tit">전체주문관리<span class="tit_sub">모든 주문을 관리할 수 있는 페이지 입니다.</span>
								</h2>
							</div>
   
   <%	// 페이징처리
   		int currentPage = StringUtil.stringToInt(request.getParameter("page"),1);
   		
   		OrderDao orderDao = OrderDao.getInstance();
   		int totalRows = orderDao.getTotalRows();
   		
   		Pagination pagination = new Pagination(totalRows, currentPage);
   		List<Order> orders = orderDao.getOrders(pagination.getBeginIndex(), pagination.getEndIndex());
   %>
   
   <table width="100%" align="center" cellpadding="0" cellspacing="0">
   		<tbody>
			<tr>
				<td>
					<div class="xans-element- xans-myshop xans-myshop-couponserial ">
						<table width="100%" class="xans-board-listheader" cellpadding="0" cellspacing="0">
					   		<colgroup>
					   			<col width="8%">
					   			<col width="10%">
					   			<col width="%">
					   			<col width="10%">
					   			<col width="14%">
					   			<col width="14%">
					   			<col width="14%">
					   		</colgroup>
					   		<thead>
					   			<tr>
					   				<th>주문번호</th>
					   				<th>구매자</th>
					   				<th>order_title</th>
					   				<th>주문수량</th>
					   				<th>결제금액</th>
					   				<th>상태</th>
					   				<th>주문날짜</th>
					   			</tr>
					   		</thead>
					   		<tbody class="table-group-divider">
					   		<%
					   			for(Order order : orders) {
					   		%>
					   			<tr>
					   				<td><%=order.getNo() %></td>
					   				<!-- 구매자의 이름을 누르면 구매자가 구매한 리스트들을 확인할 수 있다. -->
					   				<td><a href="user.jsp?no=<%=order.getUserNo()%>"><%=order.getUser().getName() %></a></td>
					   				<td><%=order.getTitle() %></td>
					   				<td><%=order.getTotalQuantity() %></td>
					   				<td><%=order.getTotalPayPrice() %>원</td>
					   				<!-- 주문 상태 : 주문취소/입금대기/배송완료/입금대기 -->
					   				<td><%=order.getStatus() %></td>
					   				<td><%=order.getCreatedDate() %></td>
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
						<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="orderlist.jsp?page=<%=pagination.getCurrentPage() -1%>">이전</a>
					</li>
				<%
					for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
				%>
					<li class="page-item <%=pagination.getCurrentPage() == num ? "active" : "" %>">
						<a class="page-link" href="orderlist.jsp?page=<%=num %>"><%=num %></a>
					</li>
				<%
					}
				%>
					<li class="page-item">	
						<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="orderlist.jsp?page=<%=pagination.getCurrentPage() +1%>">다음</a>
					</li>
				</ul>
	      </nav>
   		</div>
   	</div>
</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>