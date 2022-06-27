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
<link href="../css/home.css" rel="stylesheet">
</head>
<body>
<!-- 화면 구성 및 사용자 상호작용 구현
	1. 주문내역 조회하기
		- 한 페이지 조회 행 수는 5개로 고정
		- 페이징 기능 구현 (페이지가 바뀌어도 설정한 기간을 유지하기)
		- 기간별 조회 구현 (1년 단위, 3년까지 조회 가능, 기본값은 현재 연도)
	2. 주문 타이틀을 클릭하면 상세 페이지로 이동 (주문번호 전달)
 -->
 <%
 	// 요청객체에서 페이지번호, 기간 값 획득
 	// Pagenation 객체 생성하여 페이징처리에 필요한 값 계산
 	// 페이징 처리에 맞는, 해당 기간의 주문 데이터 조회
 %>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container mb-5" style="min-width: 1200px; max-width: 1200px;">
   <div class="row">
   		<div class="col-3 p-3">
   			<!-- 마이페이지 메뉴리스트 import -->
			<jsp:include page="../common/mypagemenu.jsp">
				<jsp:param name="menu" value="order"/>
			</jsp:include>
   		</div>
   		<div class="col-9 p-3">
	  			<div class="row py-3 border-bottom border-2 border-dark mb-3">
	  				<div class="col-6">
			  			<span class="fs-5 py-3 ps-0 mb-3 fw-bold">주문 내역</span>
	  				</div>
	  				<div class="col-6">
			  			<select class="form-select form-select-sm float-end w-25" name="years" onchange="changeYears();" >
			  				<option value="0" selected>전체기간</option>
			  				<option value="1">2022년</option>
			  				<option value="2">2021년</option>
			  				<option value="3">2020년</option>
			  			</select>
	  				</div>
	  			</div>
	  			<div class="card">
				  	<a href="orderdetail.jsp?orderNo=1" class="card-title text-decoration-none text-dark p-3 d-flex justify-content-between align-items-center border-bottom">
					  	<span class="fw-bold">주문타이틀</span>
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
							<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
						</svg>
					</a>
	  				<!-- for문으로 card 형식의 주문정보 출력 -->
					<div class="card-body">
						<table class="table table-sm table-borderless">
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<td rowspan="5"><img alt="cover image" src="../images/bookcover/book-1.jpg" class="coverimage rounded p-0"/></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td class="align-middle fw-bold text-end text-muted"><span>주문번호</span></td>
									<td class="align-middle fw-bold text-muted ps-3"><span>111111</span></td>
								</tr>
								<tr>
									<td class="align-middle fw-bold text-end text-muted"><span>결제금액</span></td>
									<td class="align-middle fw-bold text-muted ps-3"><span>111111</span></td>
								</tr>
								<tr>
									<td class="align-middle fw-bold text-end text-muted"><span>주문상태</span></td>
									<td class="align-middle fw-bold text-muted ps-3"><span>111111</span></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
								</tr>
						</tbody>
					</table>					
				</div>
			</div>
			<!--  
				요청한 페이지번호에 맞는 페이지번호를 출력한다.
				요청한 페이지번호와 일치하는 페이지번호는 하이라이트 시킨다.
				요청한 페이지가 1페이지인 경우 이전 버튼을 비활성화 시킨다.
				요청한 페이지가 맨 마지막 페이지인 경우 다음 버튼을 비활성화 시킨다. 
			-->
			<nav class="p-3" style="color:#5f0080;">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<a class="page-link" href="orderlist.jsp?pageNo=1&years=0">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
							</svg>
						</a>
					</li>
					<!-- for문으로 행 개수만큼 페이지 버튼 출력 -->
					<li class="page-item">
						<a class="page-link" href="orderlist.jsp?pageNo=1&years=0">1</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="orderlist.jsp?pageNo=1&years=0">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
							</svg>
						</a>
					</li>
				</ul>
			</nav>
  		</div>
   	</div>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	// 기간을 바꾸면 orderlist.jsp?pageNo=1&changeYears=값으로 요청한다. (location.href로 이동)
	function changeYears() {
		
	}
</script>
</body>
</html>