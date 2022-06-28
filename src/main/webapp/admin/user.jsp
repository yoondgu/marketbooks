<%@page import="vo.OrderItem"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- 관리자만 접속할 수 있게 합니다. -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png" type="image/x-icon">
<link rel="stylesheet" href="../css/board.css">
<style>
	#button {
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
	
<div id="wrap">
		<div class="container">
			<div id="main">
				<div id="content">
				
					<div class="page_aticle">
						<div id="snb" class="snb_cc">
							<h2 class="tit_snb">관리자메뉴</h2>
							<div class="inner_snb">
								<ul class="list_menu">
									<li class="on"><a href="userlist.jsp">회원관리</a></li>
									<li><a href="booklist.jsp">도서관리</a></li>
									<li><a href="inquirylist.jsp">문의관리</a></li>
									<li><a href="orderlist.jsp">주문관리</a></li>
								</ul>
							</div>
						</div>
					<div class="page_section">
						<div class="head_aticle">
   							<h2 class="tit">주문자별 주문리스트<span class="tit_sub">상세정보를 확인해보세요.</span></h2>
   						</div>
  
   <%
   		// 요청 URL : http://localhost/marketbooks/admin/user.jsp?no=109
   		// 요청파라미터에서 게시글 번호를 조회한다.
   		int userNo = StringUtil.stringToInt(request.getParameter("no"));
   		
   		UserDao userDao = UserDao.getInstance();
   		
   		int totalRows = userDao.getTotalRows();
   		
   // -- userNo로 User정보 조회
   		User user = userDao.getUserByNo(userNo);
   		
   		if (user == null) {
   			throw new RuntimeException("회원정보가 존재하지 않습니다.");
   		}
   %>
   		<div style="height:20px"></div>
   		<div>
   		<h2>[ <%=user.getName() %> ] 님의 상세정보</h2>
   		</div>
   		<table width="100%" align="center" cellpadding="0" cellspacing="0">
   		<tbody>
 			<tr>
				<td>
					<div class="xans-element- xans-myshop xans-myshop-couponserial ">
						<table width="100%" class="xans-board-listheader" cellpadding="0" cellspacing="0">
				 			<thead>
				 				<tr scope="row">
				 					<th style="font-size:14px">회원번호</th>
				 					<td colspan=3 class="text-start"><%=user.getNo() %></td>
				 				</tr>
				 				<tr>
				 					<th style="font-size:14px">회원명</th>
				 					<td class="text-start"><%=user.getName() %></td>
				 					<th style="font-size:14px">전화</th>
				 					<td class="text-start"><%=user.getTel() %></td>
				 				</tr>
				 				<tr scope="row">
				 					<th style="font-size:14px">이메일</th>
				 					<td colspan=3 class="text-start"><%=user.getEmail() %></td>
				 				</tr>
				 				<tr scope="row">
				 					<th style="font-size:14px">주소</th>
				 					<td colspan=3 class="text-start">[ <%=user.getAddress().getPostalCode() %> ] <%=user.getAddress().getAddress() %>
				 				<%
				 						if(user.getAddress().getDetailAddress() != null) {
				 				%>
				 							<%=user.getAddress().getDetailAddress() %>
				 				<%
				 						} else {	}
				 				%>
				 					</td>
				 				</tr>
				 				<tr scope="row">
				 					<th style="font-size:14px">가입일</th>
				 					<td class="text-start"><%=user.getCreatedDate() %></td>
				 					<th style="font-size:14px">최근정보수정일</th>
				 					<td class="text-start"><%=user.getUpdatedDate() %></td>
				 				</tr>
				 			</thead>
				 		</table>
			   		</div>
			   		<div style="height:80px"></div>
			 		<div>
						<%
							OrderDao orderDao = OrderDao.getInstance();
						%>
						
				 		<h2>[ <%=user.getName() %> ] 님의 최근 주문 내역</h2>
				 		<div class="xans-element- xans-myshop xans-myshop-couponserial ">
							<table width="100%" class="xans-board-listheader" cellpadding="0" cellspacing="0">
					 		
					 			<thead>
					 				<tr>
					 					<th>주문번호</th>
						   				<th>주문내역</th>
						   				<th>수량</th>
						   				<th>결제금액</th>
						   				<th>주문상태</th>
						   				<th>주문날짜</th>
					 				</tr>
					 			</thead>
					 			<tbody class="table-group-divider">
						 			<%
						 				List<Order> orderList = orderDao.getOrdersByUserNo(userNo);
						 				for (Order order : orderList) {
						 			%>
						 				<tr>
						 					<td><a href=""><%=order.getNo() %></a></td>
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
 					</div>
				</td>
			</tr>
		</tbody>
	</table>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

</script>
</body>
</html>