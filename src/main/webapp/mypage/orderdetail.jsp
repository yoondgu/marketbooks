<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓북스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon"
	href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"
	type="image/x-icon">
<style type="text/css">
	.list-group a {
		font-size: small;
    }
	
	.list-group a.active {
		color: #5f0080;
		--bs-list-group-active-bg: #fff;
		--bs-list-group-active-border-color: rgba(0, 0, 0, 0.125);
	}

	.list-group a:hover {
		color: #5f0080;
		--bs-list-group-active-bg: #fff;
		--bs-list-group-active-border-color: rgba(0, 0, 0, 0.125);
	}
	
	.coverimage { display: block; margin: 0 auto; width: 70px; object-fit: contain }
	
</style>
</head>
<body>
<div class="contatiner">
   	<div class="row">
		<div class="col">
			<h1 class="fs-4 p-2 mb-3 border text-center">임시헤더</h1>
		</div>
	</div>
</div>
<div class="container" style="min-width: 1200px; max-width: 1200px; min-height: 700px;">
   <div class="row">
   		<!-- 메뉴 바 -->
   		<div class="col-3 p-3">
  			<h4 class="p-3 ps-0 mb-3 fw-bold">마이북스</h4>
			<div class="list-group fw-bold me-3" id="menu">
				<a href="#" class="list-group-item list-group-item-action p-3 d-flex justify-content-between align-items-center active" aria-current="true">
					<span>주문내역</span>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
					</svg>
				</a>
				<a href="#" class="list-group-item list-group-item-action p-3 d-flex justify-content-between align-items-center">
					<span>배송지 관리</span>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
					</svg>
				</a>
				<a href="#" class="list-group-item list-group-item-action p-3 d-flex justify-content-between align-items-center">
					<span>상품 리뷰</span>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
					</svg>
				</a>
				<a href="#" class="list-group-item list-group-item-action p-3 d-flex justify-content-between align-items-center">
					<span>개인정보 수정</span>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
					</svg>
				</a>
			</div>
   		</div>
   		<!-- 주문정보 조회 -->
   		<div class="col-9 p-3">
   			<div class="row mb-5">
	  			<h5 class="py-3 ps-0 mb-3 fw-bold">주문 내역 상세</h5>
	  			<div class="row py-3 border-bottom border-2 border-dark">
	  				<div class="col-6">
			  			<span class="p-3 ps-0 mb-3 fw-bold">주문번호 111111</span>
	  				</div>
	  				<div class="col-6 text-end">
			  			<small>배송 또는 상품에 문제가 있나요?<a href="../board/form.jsp" class="text-end text-decoration-none fw-bold ps-3" style="color:#5f0080;">1:1 문의하기></a></small>
	  				</div>
	  			</div>
				<table class="table my-3" id="order-item-list">
					<colgroup>
						<col width="10%">
						<col width="*%">
						<col width="15%">
						<col width="15%">
					</colgroup>
					<tbody>
						<tr>
							<td class="align-middle">
								<img alt="cover image" src="../images/bookcover/book-1.jpg" class="rounded coverimage"/>
							</td>
							<td class="align-middle">
								<a href="../book/detail.jsp?bookNo=1" class="py-3 text-decoration-none text-dark"><strong>책제목</strong> 저자, 출판사</a><br/>
								<small>12,900원<span class="text-decoration-line-through text-muted px-1 border-end">15,000원</span> 1권</small>
							</td>
							<td class="align-middle">
								<strong style="color:#5f0080;">결제완료</strong>
							</td>
							<td class="align-middle text-center">
								<a href="../board/review.jsp" class="btn btn-sm w-100 mb-1" style="background-color:#5f0080; color:#fff;">후기쓰기</a>
								<a href="../cart/add.jsp?itemNo=1" class="btn btn-sm w-100" style="color:#5f0080; border-color:#5f0080;">장바구니담기</a>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="row p-3 mx-auto">
					<div class="col text-center">
						<a href="" class="btn btn-sm fw-bold p-3" style="border-color:#5f0080; color:#5f0080; border-color:">전체 상품 다시 담기</a>
						<a href="" class="btn btn-sm fw-bold p-3 disabled" style="border-color:#5f0080; color:#5f0080;" >전체 상품 주문 취소</a>
						<p class="p-3"><small class="text-muted fw-bold">주문 취소는 '배송준비중' 이전 상태일 경우에만 가능합니다.</small></p>
					</div>
				</div>
   			</div>
  			<div class="row mb-5">
	   			<!-- 이 태그는 배송중 상태가 아니면 d-none이다. -->
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>배송조회</strong></h5>
  			</div>
  			<div class="row mb-5">
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>결제정보</strong></h5>
  			</div>
  			<div class="row mb-5">
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>주문정보</strong></h5>
  			</div>
  			<div class="row mb-5">
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>배송정보</strong></h5>
  			</div>
   		</div>
   </div>
</div>
<div class="contatiner">
   	<div class="row">
		<div class="col">
			<h1 class="fs-4 p-2 mb-3 border text-center">임시푸터</h1>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>