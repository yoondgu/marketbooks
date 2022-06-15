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
   <h2 style="width: 820px">1:1문의내역 전체리스트</h2>
      
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
</form>
<div style="height:100px"></div>
<form>
	<h2 style="width: 820px">상품문의내역 전체리스트</h2>
	      
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
</form>
</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>