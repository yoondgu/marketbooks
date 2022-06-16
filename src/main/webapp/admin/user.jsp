<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
    
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
   		<div>
 		<table class="table table-bordered">
 			<thead>
 				<tr scope="row">
 					<th>회원번호</th>
 					<th colspan=3>1</th>
 				</tr>
 				<tr>
 					<th>회원명</th>
 					<th>홍길동</th>
 					<th>전화</th>
 					<th>010-1234-5678</th>
 				</tr>
 				<tr scope="row">
 					<th>이메일</th>
 					<th colspan=3>hong@gmail.com</th>
 				</tr>
 				<tr scope="row">
 					<th>주소</th>
 					<th colspan=3>서울특별시 종로구 율곡로10길 105 디아망 4F(봉익동 10-1 디아망 4F)</th>
 				</tr>
 				<tr scope="row">
 					<th>가입일</th>
 					<th>2022-06-13</th>
 					<th>Updated_date</th>
 					<th>2022-06-13</th>
 				</tr>
 			</thead>
 		</table>
   		</div>
   		<div style="height:80px"></div>
 		<div>
 		<h2>"홍길동"님의 최근 주문 내역</h2>
 		<table class="table table-bordered">
 			<thead>
 				<tr>
 					<th>주문번호</th>
	   				<th>주문도서</th>
	   				<th>주문수량</th>
	   				<th>결제금액</th>
	   				<th>상태</th>
	   				<th>주문날짜</th>
 				</tr>
 				<tr>
 					<th>10001</th>
	   				<th>작별인사</th>
	   				<th>1</th>
	   				<th>12,600원</th>
	   				<!-- 주문 상태 : 주문취소/입금대기/배송완료/입금대기 -->
	   				<th>order_status</th>
	   				<th>2022-06-15</th>
	 				</tr>
 			</thead>
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
					<a class="page-link" href="">이전</a>
					<li class="page-item"><a class="page-link" href="">1</a></li>
					<li class="page-item"><a class="page-link" href="">2</a></li>
					<li class="page-item"><a class="page-link" href="">3</a></li>
					<li class="page-item"><a class="page-link" href="">4</a></li>
					<li class="page-item"><a class="page-link" href="">5</a></li>
					<a class="page-link" href="">다음</a>
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
</body>
</html>