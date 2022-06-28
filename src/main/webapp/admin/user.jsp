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
</head>
<body>
<header class="align-middle text-center">
<nav></nav>
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
   <h2 style="width: 820px">주문자별 주문리스트</h2>
   <form>
   
   <%
   // 요청 URL : http://localhost/marketbooks/admin/user.jsp?no=101&page=1
   		// 요청파라미터에서 게시글 번호를 조회한다.
   		int userNo = StringUtil.stringToInt(request.getParameter("no"));
   		int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
   		
   		UserDao userDao = UserDao.getInstance();
   		User user = userDao.getUserByNo(userNo);
   		
   		if (user == null) {
   			throw new RuntimeException("회원정보가 존재하지 않습니다.");
   		}
   %>
   
   		<div>
 		<table class="table table-bordered">
 			<thead>
 				<tr scope="row">
 					<th>회원번호</th>
 					<th colspan=3><%=user.getNo() %></th>
 				</tr>
 				<tr>
 					<th>회원명</th>
 					<th><%=user.getName() %></th>
 					<th>전화</th>
 					<th><%=user.getTel() %></th>
 				</tr>
 				<tr scope="row">
 					<th>이메일</th>
 					<th colspan=3><%=user.getEmail() %></th>
 				</tr>
 				<tr scope="row">
 					<th>주소</th>
 					<th colspan=3>[<%=user.getAddress().getPostalCode() %>]<%=user.getAddress().getAddress() %>
 					<%
 						if(user.getAddress().getDetailAddress() != null) {
 					%>
 							<%=user.getAddress().getDetailAddress() %>
 					<%
 						} else {
 					%>
 						
 					<%
 						}
 					%>
 					</th>
 				</tr>
 				<tr scope="row">
 					<th>가입일</th>
 					<th><%=user.getCreatedDate() %></th>
 					<th>최근정보수정일</th>
 					<th><%=user.getUpdatedDate() %></th>
 				</tr>
 			</thead>
 		</table>
   		</div>
   		<div style="height:80px"></div>
 		<div>
		<%
			OrderItemDao itemDao = OrderItemDao.getInstance();
	   		// OrderItem item = itemDao.getItemByUserNo(userNo);
		%>
 		<h2><strong><%=user.getName() %></strong>님의 최근 주문 내역</h2>
 		<table class="table table-bordered">
 		
 			<thead>
 				<tr>
 					<th>주문번호</th>
	   				<th>주문도서</th>
	   				<th>수량</th>
	   				<th>결제금액</th>
	   				<th>order_status</th>
	   				<th>주문날짜</th>
 				</tr>
 			</thead>
 			</tbody>
 			<%
 			List<OrderItem> itemList = null;
 				for (OrderItem item : itemList) {
 			%>
 				<tr>
 					<th><a href=""><%=item.getOrderNo() %></a>></th>
	   				<th><%=item.getBook().getTitle() %></th>
	   				<th><%=item.getQuantity() %></th>
	   				<th><%=item.getPrice() %>*<%=item.getQuantity() %>원</th>
	   				<!-- 주문 상태 : 주문취소/입금대기/배송완료/입금대기 -->
	   				<th><%=item.getOrder().getStatus()%></th> 
	   				<th><%=item.getCreatedDate() %></th>
	 			</tr>
	 		<%
 				}
	 		%>
 			</tbody>
 		</table>
<%  
   	    int totalRows = itemDao.getTotalRows();
		   
	    Pagination pagination = new Pagination(totalRows, currentPage);
	  
%>	
 
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
						<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="user.jsp?no=<%=user.getNo() %>&page=<%=pagination.getCurrentPage() -1%>">이전</a>
					</li>
					<%
					for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
					%>
					<li class="page-item <%=pagination.getCurrentPage() == num ? "active" : "" %>">
						<a class="page-link" href="user.jsp?no=<%=user.getNo() %>&page=<%=num %>"><%=num %></a>
					</li>
					<%
					}
					%>
					<li>	
						<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="user.jsp?no=<%=user.getNo() %>&page=<%=pagination.getCurrentPage() +1%>">다음</a>
					</li>
				</ul>
	      </nav>
	   </div>
 		</div>
   </form>
</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function changePageNo(pageNo) {
		
	}
</script>
</body>
</html>