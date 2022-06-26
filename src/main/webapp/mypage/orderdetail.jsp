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
<div class="container" style="min-width: 1200px; max-width: 1200px;">
   <div class="row">
   		<div class="col-3 p-3">
	   		<!-- 마이페이지 메뉴리스트 import -->
			<jsp:include page="../common/mypagemenu.jsp">
				<jsp:param name="menu" value="order"/>
			</jsp:include>
   		</div>
   		<div class="col-9 p-3">
   			<div class="row mb-5">
		   		<!-- 주문정보 조회 -->
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
				<table class="pay-info-table text-muted">
					<colgroup>
						<col width="16%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<td><strong>상품금액</strong></td>
							<td class="align-middle text-end p-3"><span>0원</span></td>
						</tr>
						<tr>
							<td><strong>배송비</strong></td>
							<td class="align-middle text-end p-3"><span>0원</span></td>
						</tr>
						<tr>
							<td><strong>상품할인금액</strong></td>
							<td class="align-middle text-end p-3"><span>0원</span></td>
						</tr>
						<tr>
							<td><strong>결제금액</strong></td>
							<td class="align-middle text-end p-3"><span>0원</span></td>
						</tr>
						<tr>
							<td><strong>결제수단</strong></td>
							<td class="align-middle text-end p-3"><span>신용카드</span></td>
						</tr>
					</tbody>
				</table>
  			</div>
  			<div class="row mb-5">
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>주문정보</strong></h5>
				<table class="order-info-table text-muted">
					<colgroup>
						<col width="16%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<td><strong>주문번호</strong></td>
							<td class="align-middle text-end p-3"><span>111111</span></td>
						</tr>
						<!-- 현재는 주문자명과 보내는 분의 정보가 동일하다. (별도 발송인 정보 기능 없음) -->
						<tr>
							<td><strong>주문자명</strong></td>
							<td class="align-middle text-end p-3"><span>유도영</span></td>
						</tr>
						<tr>
							<td><strong>보내는분</strong></td>
							<td class="align-middle text-end p-3"><span>유도영</span></td>
						</tr>
						<tr>
							<td><strong>결제일시</strong></td>
							<td class="align-middle text-end p-3"><span>2022-06-25-18:34:57</span></td>
						</tr>
					</tbody>
				</table>
  			</div>
  			<div class="row mb-5">
  				<h5 class="py-3 ps-0 mb-3 border-bottom border-2 border-dark"><strong>배송정보</strong></h5>
				<table class="ship-info-table text-muted">
					<colgroup>
						<col width="16%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<td><strong>받는분</strong></td>
							<td class="align-middle text-end p-3"><span>오공일</span></td>
						</tr>
						<tr>
							<td><strong>핸드폰</strong></td>
							<td class="align-middle text-end p-3"><span>010-1234-3456</span></td>
						</tr>
						<tr>
							<td><strong>주소</strong></td>
							<td class="align-middle text-end p-3"><span>ㅇㅇㅇㅇ</span></td>
						</tr>
						<!-- 추후 배송지 상세정보 추가 -->
					</tbody>
				</table>
  			</div>
  			<!-- 추후 배송 추가 옵션 정보 추가 -->
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