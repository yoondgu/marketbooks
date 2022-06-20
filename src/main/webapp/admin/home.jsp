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
<div class="container">
   <h1 class="text-center">관리자 페이지</h1>
   <p class="text-center">회원관리, 도서관리, 게시판관리, 주문관리를 할 수 있는 관리자 페이지 입니다.</p>
   <div class="admin_main">
   		<!-- 각 메뉴마다 최신글 3개만 메인에서 확인할 수 있게 합니다. -->
   		
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
			   			<tr>
			   				<th>10001</th>
			   				<!-- 구매자의 이름을 누르면 구매자가 구매한 리스트들을 확인할 수 있다. -->
			   				<th><a href="userorder.jsp">오공일</a></th>
			   				<th>작별인사</th>
			   				<th>1</th>
			   				<th>12,600원</th>
			   				<!-- 주문 상태 : 주문취소/입금대기/배송완료/입금대기 -->
			   				<th>order_status</th>
			   				<th>2022-06-15</th>
			   			</tr>
			   			<tr>
			   				<th>10001</th>
			   				<!-- 구매자의 이름을 누르면 구매자가 구매한 리스트들을 확인할 수 있다. -->
			   				<th><a href="userorder.jsp">오공일</a></th>
			   				<th>작별인사</th>
			   				<th>1</th>
			   				<th>12,600원</th>
			   				<!-- 주문 상태 : 주문취소/입금대기/배송완료/입금대기 -->
			   				<th>order_status</th>
			   				<th>2022-06-15</th>
			   			</tr>
			   			<tr>
			   				<th>10001</th>
			   				<!-- 구매자의 이름을 누르면 구매자가 구매한 리스트들을 확인할 수 있다. -->
			   				<th><a href="userorder.jsp">오공일</a></th>
			   				<th>작별인사</th>
			   				<th>1</th>
			   				<th>12,600원</th>
			   				<!-- 주문 상태 : 주문취소/입금대기/배송완료/입금대기 -->
			   				<th>order_status</th>
			   				<th>2022-06-15</th>
			   			</tr>
			   		</tbody>
			    </table>
	   		</form>
			<form class="col-12 g-3 border bg-light mx-1 ">
				<div class="text-center"></a><a href="inquiry.jsp">게시판관리</a></div>
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
			   			<col width="13%">
			   			<col width="%">
			   			<col width="10%">			   			
			   			<col width="13%">
			   		</colgroup>
			   		<thead>
			   			<tr class="text-center">
			   				<!-- 간략한 도서리스트만 보이도록합니다. 상세한 도서정보 페이지는 따로 만들지 않고 상품페이지로 연결합니다. -->
			   				<th>도서번호</th>
			   				<th>카테고리</th>
			   				<th>도서명</th>
			   				<th>재고</th>
			   				<th>가격</th>
			   			</tr>
			   		</thead>
			   		<tbody class="table-group-divider">
			   			<tr>
			   				<th>1</th>
			   				<th>예술/대중문화</th>
			   				<!-- 도서명을 클릭하면 해당 도서페이지로 넘어가도록 링크를 설정한다. -->
			   				<th>
			   					<a href="">2022 제5회 한국과학문학상 수상작품집 - 루나 + 블랙박스와의 인터뷰 + 옛날 옛적 판교에서 + 책이 된 남자 + 신께서는 아이들 + 후루룩 쩝접 맛있는<a/>
			   				</th>
			   				
			   				<th>1</th>
			   				<th class="align-middle"><strong>27,000</strong>원(30,000원)</th>
			   			</tr>
			   			<tr>
			   				<th>2</th>
			   				<th>소설</th>
			   				<th><a href="">작별인사<a/></th>
			   				<th>9999</th>
			   				<th class="align-middle"><strong>12,600</strong>원 (14,000원)</th>
			   			</tr>
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
			   			<tr>
			   				<th>1</th>
			   				<th>홍길동</th>
			   				<th>hong@gmail.com</th>
			   				<th>010-1234-5678</th>
			   			</tr>
			   			<tr>
			   				<th>1</th>
			   				<th>홍길동</th>
			   				<th>hong@gmail.com</th>
			   				<th>010-1234-5678</th>
			   			</tr>
			   			<tr>
			   				<th>1</th>
			   				<th>홍길동</th>
			   				<th>hong@gmail.com</th>
			   				<th>010-1234-5678</th>
			   			</tr>
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