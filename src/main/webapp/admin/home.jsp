<%@page import="vo.Book"%>
<%@page import="dao.BookDao"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
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
<header class="align-middle text-center">
<nav></nav>
	<div style="height:200px">
		<p><h6 class="align-middle text-end">관리자 홈 | 관리자님 안녕하세요 | 로그아웃 </h6></p>
		<h1><p>market</p><p>books</p></h1>
	</div>
</header>
<div class="container">
   <h1 class="text-center">관리자 페이지</h1>
   <p class="text-center">회원관리, 도서관리, 게시판관리, 주문관리를 할 수 있는 관리자 페이지 입니다.</p>
   <div class="admin_main">
   <!-- 각 메뉴마다 최신글 3개만 메인에서 확인할 수 있게 합니다. -->
   <%   		
   		OrderDao orderDao = OrderDao.getInstance();
   		List<Order> orders = orderDao.getRecentOrders();
   		
   		BookDao bookDao = BookDao.getInstance();
   		List<Book> books = bookDao.getRecentBooks();
   		
   		UserDao userDao = UserDao.getInstance();
   		List<User> users = userDao.getRecentUsers();
   %>
		<div class="row">
			<form class="col-12 g-3 border bg-light mx-1">
				<div class="text-center"><a href="orderlist.jsp">주문관리</a></div>
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
			   				<th>주문도서</th>
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
			   				<th><a href="userorder.jsp?no=<%=order.getUserNo()%>"><%=order.getUser().getName() %></a></th>
			   				<th><%=order.getTitle() %></th>
			   				<th><%=order.getTotalQuantity() %></th>
			   				<th><%=order.getTotalPrice() %>원</th>
			   				<!-- 주문 상태 : 주문취소/입금대기/배송완료/입금대기 -->
			   				<th><%=order.getStatus() %></th>
			   				<th><%=order.getCreatedDate() %></th>
			   			</tr>
			   		<%
						}
					%>
			   			
			   		</tbody>
			    </table>
	   		</form>
			<form class="col-12 g-3 border bg-light mx-1 ">
				<div class="text-center"></a><a href="inquirylist.jsp">게시판관리</a></div>
				<div>
				<div class="text-center">1:1문의</div>
				<table class="table">
			   		<colgroup>
			   			<col width="7%">
			   			<col width="%">
			   			<col width="10%">
			   			<col width="16%">
			   			<col width="14%">
			   			<col width="14%">
			   		</colgroup>
			   		<thead>
			   			<tr>
			   				<th>번호</th>
			   				<th>문의제목</th>
			   				<th>회원명</th>
			   				<th>작성날짜</th>
			   				<th>답변날짜</th>
			   				<th>답변유무</th>
			   			</tr>
			   		</thead>
			   		<tbody class="table-group-divider">
			   			<tr>
			   				<th>1</th>
			   				<!-- 문의제목을 누르면 1:1문의페이지로 넘어갑니다. 1:1 답변은 댓글 작성으로 처리 -->
			   				<th><a href="inquiry.jsp">디자인은 어떻게 하는게 좋을까요?</a></th>
			   				<th>홍길동</th>
			   				<th>2022-06-13</th>
			   				<th>2022-06-13</th>
			   				<!-- 답변대기 상태일 때는 다른색 글씨로(빨간색 혹은 회색) -->
			   				<th>답변완료</th>
			   			</tr>
			   			<tr>
			   				<th>1</th>
			   				<!-- 문의제목을 누르면 1:1문의페이지로 넘어갑니다. 1:1 답변은 댓글 작성으로 처리 -->
			   				<th><a href="inquiry.jsp">디자인은 어떻게 하는게 좋을까요?</a></th>
			   				<th>홍길동</th>
			   				<th>2022-06-13</th>
			   				<th>2022-06-13</th>
			   				<!-- 답변대기 상태일 때는 다른색 글씨로(빨간색 혹은 회색) -->
			   				<th>답변완료</th>
			   			</tr>
			   			<tr>
			   				<th>1</th>
			   				<!-- 문의제목을 누르면 1:1문의페이지로 넘어갑니다. 1:1 답변은 댓글 작성으로 처리 -->
			   				<th><a href="inquiry.jsp">디자인은 어떻게 하는게 좋을까요?</a></th>
			   				<th>홍길동</th>
			   				<th>2022-06-13</th>
			   				<th>2022-06-13</th>
			   				<!-- 답변대기 상태일 때는 다른색 글씨로(빨간색 혹은 회색) -->
			   				<th>답변완료</th>
			   			</tr>
			   		</tbody>
			   </table>
			   </div>
			   <div>
			   <div class="text-center">상품문의</div>
			   <table class="table">
			   		<colgroup>
			   			<col width="7%">
			   			<col width="%">
			   			<col width="10%">
			   			<col width="16%">
			   			<col width="14%">
			   			<col width="14%">
			   		</colgroup>
			   		<thead>
			   			<tr>
			   				<th>번호</th>
			   				<th>문의제목</th>
			   				<th>회원명</th>
			   				<th>작성날짜</th>
			   				<th>답변날짜</th>
			   				<th>답변유무</th>
			   			</tr>
			   		</thead>
			   		<tbody class="table-group-divider">
			   			<tr>
			   				<th>1</th>
			   				<!-- 문의제목을 누르면 상품문의페이지로 넘어갑니다. 상품문의답변은 댓글 작성으로 처리 -->
			   				<th><a href="bookinquiry.jsp">상품문의 답변은 1:1답변과 다른 방식으로 나오게 하는게 좋을까요?</a></th>
			   				<th>홍길동</th>
			   				<th>2022-06-13</th>
			   				<th>2022-06-13</th>
			   				<th>답변대기</th>
			   			</tr>
			   			<tr>
			   				<th>1</th>
			   				<!-- 문의제목을 누르면 상품문의페이지로 넘어갑니다. 상품문의답변은 댓글 작성으로 처리 -->
			   				<th><a href="bookinquiry.jsp">상품문의 답변은 1:1답변과 다른 방식으로 나오게 하는게 좋을까요?</a></th>
			   				<th>홍길동</th>
			   				<th>2022-06-13</th>
			   				<th>2022-06-13</th>
			   				<th>답변대기</th>
			   			</tr>
			   			<tr>
			   				<th>1</th>
			   				<!-- 문의제목을 누르면 상품문의페이지로 넘어갑니다. 상품문의답변은 댓글 작성으로 처리 -->
			   				<th><a href="bookinquiry.jsp">상품문의 답변은 1:1답변과 다른 방식으로 나오게 하는게 좋을까요?</a></th>
			   				<th>홍길동</th>
			   				<th>2022-06-13</th>
			   				<th>2022-06-13</th>
			   				<th>답변대기</th>
			   			</tr>
			   		</tbody>
			   </table>
			   </div>
			</form>
			
			
			
	   		<div class="col-12 d-flex">
	   		<form class="col-6 g-3 border bg-light mx-1 flex-fill">
				<div class="text-center"><a href="booklist.jsp">도서관리</a></div>
				<table class="table">
			   		<colgroup>
			   			<col width="10%">
			   			<col width="%">
			   			<col width="10%">			   			
			   			<col width="13%">
			   		</colgroup>
			   		<thead>
			   			<tr class="text-center">
			   				<!-- 간략한 도서리스트만 보이도록합니다. 상세한 도서정보 페이지는 따로 만들지 않고 상품페이지로 연결합니다. -->
			   				<th>도서번호</th>
			   				<th>도서명</th>
			   				<th>재고</th>
			   				<th>가격</th>
			   			</tr>
			   		</thead>
			   		<tbody class="table-group-divider">
			   		<%
			   			for(Book book : books) {
			   		%>
			   			<tr>
			   				<th><%=book.getNo() %></th>
			   				<!-- 도서명을 클릭하면 해당 도서페이지로 넘어가도록 링크를 설정한다. -->
			   				<th>
			   					<a href=""><%=book.getTitle() %></a>
			   				</th>
			   				
			   				<th><%=book.getStock() %></th>
			   				<th class="align-middle"><strong><%=book.getDiscountPrice() %></strong>원(<%=book.getPrice() %>원)</th>
			   			</tr>
			   		<%
			   			}
			   		%>
			   		</tbody>
			   </table>
			</form>
	   		
	   		<form class="col-6 g-3 border bg-light mx-1 flex-fill">
				<div class="text-center"><a href="userlist.jsp">회원관리</a></div>
				<table class="table">
			   		<colgroup>
			   			<col width="15%">
			   			<col width="15%">
			   			<col width="%">
			   			<col width="20%">
			   		</colgroup>
			   		<thead>
			   			<tr>
			   				<th>회원번호</th>
			   				<th>회원명</th>
			   				<th>이메일</th>
			   				<th>전화</th>
			   			</tr>
			   		</thead>
			   		<tbody class="table-group-divider">
			   		<%
			   			for(User user : users) {
			   		%>
			   			<tr>
			   				<th><%=user.getNo() %></th>
			   				<th><%=user.getName()%></th>
			   				<th><%=user.getEmail() %></th>
			   				<th><%=user.getTel() %></th>
			   			</tr>
		   			<%
			   			}
		   			%>
			   		</tbody>
			   </table>
  			</form>
  			</div>
  		</div>
  		
   		
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>