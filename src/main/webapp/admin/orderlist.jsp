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
<title>관리자페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav></nav>
<header class="align-middle text-center">
	<div style="height:200px">
		<p><h6 class="align-middle text-end">관리자님 안녕하세요 | 로그아웃 </h6></p>
		<h1><p>market</p><p>books</p></h1>
	</div>
</header>
<div class="container" style="width: 1172px">
<div class="row gx-5 mx-auto" style="width: 1050px">

<aside class="col-2">
	<h2 style="width: 200px">관리자메뉴</h2>
	<ul class="list-group text-center">
		<!-- 마우스 커서가 올라가면 active + 글자 strong -->
		<li class="list-group-item"><a href="userlist.jsp">회원관리</a></li>
		<li class="list-group-item"><a href="booklist.jsp">도서관리</a></li>
		<li class="list-group-item"><a href="inquirylist.jsp">문의관리</a></li>
		<li class="list-group-item"><a href="orderlist.jsp">주문관리</a></li>
	</ul>
</aside>

<div class="col-10">
<form>
   <h2 style="width: 820px">전체주문관리</h2>
   
   <%	// 페이징처리
   		int currentPage = StringUtil.stringToInt(request.getParameter("page"),1);
   		
   		OrderDao orderDao = OrderDao.getInstance();
   		int totalRows = orderDao.getTotalRows();
   		
   		Pagination pagination = new Pagination(totalRows, currentPage);
   		List<Order> orders = orderDao.getOrders(pagination.getBeginIndex(), pagination.getEndIndex());
   %>
   
   <table class="table">
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
   				<th><%=order.getNo() %></th>
   				<!-- 구매자의 이름을 누르면 구매자가 구매한 리스트들을 확인할 수 있다. -->
   				<th><a href="user.jsp?no=<%=order.getUserNo()%>"><%=order.getUser().getName() %></a></th>
   				<th><%=order.getTitle() %></th>
   				<th><%=order.getTotalQuantity() %></th>
   				<th><%=order.getTotalPayPrice() %>원</th>
   				<!-- 주문 상태 : 주문취소/입금대기/배송완료/입금대기 -->
   				<th><%=order.getStatus() %></th>
   				<th><%=order.getCreatedDate() %></th>
   			</tr>
   		<%
			}
		%>
   		</tbody>
    </table>

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
</form>
</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>