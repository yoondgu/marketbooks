<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
    
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
	a :hover {
		background-color:red;
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
		<nav class="navbar navbar-expand-lg bg-light">
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
					
						<!-- side bar -->
						<div id="snb" class="snb_cc">
							<h2 class="tit_snb">관리자메뉴</h2>
							<div class="inner_snb">
								<ul class="list_menu">
									<li><a href="userlist.jsp">회원관리</a></li>
									<li><a href="booklist.jsp">도서관리</a></li>
									<li class="on"><a href="inquirylist.jsp">문의관리</a></li>
									<li><a href="orderlist.jsp">주문관리</a></li>
								</ul>
							</div>
						</div>
						
						<!-- main -->
						<div class="page_section">
							<div class="head_aticle">
								<h2 class="tit">1:1문의 관리<span class="tit_sub">모든 도서를 관리할 수 있는 페이지 입니다.</span></h2>
							</div>
   <%
   		// int currentPage =StringUtil.stringToInt
   %>   
<div class="xans-element- xans-myshop xans-myshop-couponserial ">
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
   				<th>작성자</th>
   				<th>작성일</th>
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
   		</tbody>
   </table>
  </div>
   
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