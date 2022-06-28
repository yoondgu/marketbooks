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
<link rel="shortcut icon" href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png" type="image/x-icon">
<link rel="stylesheet" href="../css/board.css">
<style>
	img { display: block; margin: 0px auto; }
	hr { color: #5f0080 }
	#button {
		font-family: noto sans,malgun gothic,AppleGothic,dotum;
        line-height: 1;
        letter-spacing: -.05em;
        font-size: 12px;
        max-width: 100%;
	}
</style>
</head>
<body>	
<div class="container">
	<!-- header -->
	<div class="row">
		<div id="headerLogo" class="layout-wrapper">
				<a href="http://localhost/marketbooks/home.jsp" class="link_main">
					<span id="gnbLogoContainer"></span> 
					<img src="/marketbooks/images/marketbooks-logo.png" class="img-thumbnail" style="border:0; width:120px;">
				</a>
				<h2 class="text-center"><strong>관리자 페이지</strong></h2>
   				<div class="text-center my-3">회원관리, 도서관리, 문의관리, 주문관리를 할 수 있는 관리자 페이지 입니다.</div>
		</div>
	</div>
	
	<!-- main -->
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
			<form class="col-12 g-3 bg-light mx-1">
				<div class="head_aticle">
					<h2 class="tit"><a href="orderlist.jsp">주문관리</a></h2>
				</div>
				<!--  <div class="text-center"><h4><a href="orderlist.jsp">주문관리</a></h4></div> -->
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
			   				<td><%=order.getNo() %></td>
			   				<!-- 구매자의 이름을 누르면 구매자가 구매한 리스트들을 확인할 수 있다. -->
			   				<td><a href="userorder.jsp?no=<%=order.getUserNo()%>"><%=order.getUser().getName() %></a></td>
			   				<td><%=order.getTitle() %></td>
			   				<td><%=order.getTotalQuantity() %></td>
			   				<td><%=order.getTotalPrice() %>원</td>
			   				<!-- 주문 상태 : 주문취소/입금대기/배송완료/입금대기 -->
			   				<td><%=order.getStatus() %></td>
			   				<td><%=order.getCreatedDate() %></td>
			   			</tr>
			   		<%
						}
					%>
			   			
			   		</tbody>
			    </table>
	   		</form>
			<form class="col-12 g-3 bg-light mx-1">
				<div class="head_aticle">
					<h2 class="tit"><a href="inquirylist.jsp">게시판관리</a></h2>
				</div>
				<div class="board">
					<div class="head_aticle text-center"><h6 class="tit">1:1문의</h6></div>
					<table width="100%" class="xans-board-listheader" cellpadding="0" cellspacing="0">
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
				   				<td>1</td>
				   				<!-- 문의제목을 누르면 1:1문의페이지로 넘어갑니다. 1:1 답변은 댓글 작성으로 처리 -->
				   				<td><a href="inquiry.jsp">디자인은 어떻게 하는게 좋을까요?</a></td>
				   				<td>홍길동</td>
				   				<td>2022-06-13</td>
				   				<td>2022-06-13</td>
				   				<!-- 답변대기 상태일 때는 다른색 글씨로(빨간색 혹은 회색) -->
				   				<td>답변완료</td>
				   			</tr>
				   			<tr>
				   				<td>1</td>
				   				<!-- 문의제목을 누르면 1:1문의페이지로 넘어갑니다. 1:1 답변은 댓글 작성으로 처리 -->
				   				<td><a href="inquiry.jsp">디자인은 어떻게 하는게 좋을까요?</a></td>
				   				<td>홍길동</td>
				   				<td>2022-06-13</td>
				   				<td>2022-06-13</td>
				   				<!-- 답변대기 상태일 때는 다른색 글씨로(빨간색 혹은 회색) -->
				   				<td>답변완료</td>
				   			</tr><tr>
				   				<td>1</td>
				   				<!-- 문의제목을 누르면 1:1문의페이지로 넘어갑니다. 1:1 답변은 댓글 작성으로 처리 -->
				   				<td><a href="inquiry.jsp">디자인은 어떻게 하는게 좋을까요?</a></td>
				   				<td>홍길동</td>
				   				<td>2022-06-13</td>
				   				<td>2022-06-13</td>
				   				<!-- 답변대기 상태일 때는 다른색 글씨로(빨간색 혹은 회색) -->
				   				<td>답변완료</td>
				   			</tr>
				   		</tbody>
				   </table>
			   </div>
			   <hr>
			   <div style="height:50px"></div>
			   <div>
			   <div class="head_aticle text-center"><h6>상품문의</h6></div>
			   <table width="100%" class="xans-board-listheader" cellpadding="0" cellspacing="0">
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
			   				<td>1</td>
			   				<!-- 문의제목을 누르면 상품문의페이지로 넘어갑니다. 상품문의답변은 댓글 작성으로 처리 -->
			   				<td><a href="bookinquiry.jsp">상품문의 답변은 1:1답변과 다른 방식으로 나오게 하는게 좋을까요?</a></td>
			   				<td>홍길동</td>
			   				<td>2022-06-13</td>
			   				<td>2022-06-13</td>
			   				<td>답변대기</td>
			   			</tr>
			   			<tr>
			   				<td>1</td>
			   				<!-- 문의제목을 누르면 상품문의페이지로 넘어갑니다. 상품문의답변은 댓글 작성으로 처리 -->
			   				<td><a href="bookinquiry.jsp">상품문의 답변은 1:1답변과 다른 방식으로 나오게 하는게 좋을까요?</a></td>
			   				<td>홍길동</td>
			   				<td>2022-06-13</td>
			   				<td>2022-06-13</td>
			   				<td>답변대기</td>
			   			</tr><tr>
			   				<td>1</td>
			   				<!-- 문의제목을 누르면 상품문의페이지로 넘어갑니다. 상품문의답변은 댓글 작성으로 처리 -->
			   				<td><a href="bookinquiry.jsp">상품문의 답변은 1:1답변과 다른 방식으로 나오게 하는게 좋을까요?</a></td>
			   				<td>홍길동</td>
			   				<td>2022-06-13</td>
			   				<td>2022-06-13</td>
			   				<td>답변대기</td>
			   			</tr>
			   		</tbody>
			   </table>
			   <hr>
			   </div>
			</form>
			
			<div style="height:10px"></div>
			
	   		<div class="col-12 d-flex px-0">
	   		<form class="col-6 g-3 bg-light mx-1 flex-fill px-2">
				<div class="head_aticle">
					<h2 class="tit"><a href="orderlist.jsp">도서관리</a></h2>
				</div>
				<table width="100%" class="xans-board-listheader" cellpadding="0" cellspacing="0">
			   		<colgroup>
			   			<col width="12%">
			   			<col width="%">
			   			<col width="10%">			   			
			   			<col width="15%">
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
			   				<td><%=book.getNo() %></td>
			   				<!-- 도서명을 클릭하면 해당 도서페이지로 넘어가도록 링크를 설정한다. -->
			   				<td>
			   					<a href="../book/detail.jsp?bookNo=<%=book.getNo() %>"><%=book.getTitle() %></a>
			   				</td>
			   				
			   				<td><%=book.getStock() %></td>
			   				<td class="align-middle"><strong><%=book.getDiscountPrice() %></strong><div style="text-decoration: line-through"><small><%=book.getPrice() %></small></div></td>
			   			</tr>
			   		<%
			   			}
			   		%>
			   		</tbody>
			   </table>
			</form>
	   		
	   		<form class="col-6 g-3 bg-light mx-1 flex-fill px-2">
				<div class="head_aticle">
					<h2 class="tit"><a href="orderlist.jsp">회원관리</a></h2>
				</div>
				<table width="100%" class="xans-board-listheader" cellpadding="0" cellspacing="0">
			   		<colgroup>
			   			<col width="15%">
			   			<col width="15%">
			   			<col width="%">
			   			<col width="30%">
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
			   				<td><%=user.getNo() %></td>
			   				<td><%=user.getName()%></td>
			   				<td><%=user.getEmail() %></td>
			   				<td><%=user.getTel() %></td>
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