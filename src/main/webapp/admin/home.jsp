<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
   <h1>관리자 페이지</h1>
   <p>회원관리, 상품관리, 게시판관리, 주문관리를 할 수 있는 페이지 입니다.</p>
   <div class="admin_main">
   		<ul class="admin_menu">
   			<li class="menu1"><a href="userlist.jsp">회원관리</a></li>
   			<li class="menu2"><a href="booklist.jsp">도서관리</a></li>
   			<li class="menu3"><a href="inquiry.jsp">게시판관리</a></li>
   			<li class="menu4"><a href="orderlist.jsp">주문관리</a></li>
   		</ul>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>