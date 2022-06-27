<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.Year"%>
<%@page import="vo.OrderItem"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.OrderDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
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
<style type="text/css">

	.page-link {
		--bs-pagination-color:color: #5f0080;
		--bs-pagination-active-bg: #5f0080;
		--bs-pagination-active-border-color: #5f0080;
	}
	
</style>
</head>
<body>
<!-- 화면 구성 및 사용자 상호작용 구현
	1. 주문내역 조회하기
		- 한 페이지 조회 행 수는 3개로 고정, 페이지 번호 개수는 Pagination 객체 설정값에 따라 5개로 고정
		- 페이징 기능 구현 (페이지가 바뀌어도 설정한 기간을 유지하기)
		- 기간별 조회 구현 (1년 단위, 3년까지 조회 가능, 기본값은 현재 연도)
	2. 주문 타이틀을 클릭하면 상세 페이지로 이동 (주문번호 전달)
 -->
 <%
 	OrderDao orderDao = OrderDao.getInstance();
 	OrderItemDao orderItemDao = OrderItemDao.getInstance();
 	
	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int userNo = user.getNo();
	
 	// 요청객체에서 요청한 페이지번호, 기간 값 획득(전달받지 않으면 각각 1, -1을 반환)
 	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1); // 기본값으로 첫번째 페이지를 조회한다.
 	int years = StringUtil.stringToInt(request.getParameter("years"), -1); // 기본값으로 전체 기간을 조회한다.
 	// 조회 기간은 3년까지로 한정하기 때문에 그 이전의 기간을 조회하려고 하면 전체기간을 보여준다.
 	
 	int currentYear = Year.now().getValue(); // 현재 연도
 	int periodYear = -1; // 조회할 연도, 전달받은 years가 -1이면 데이터 조회하는 함수에 -1을 전달해 전체 기간을 조회한다.
 	if (years >= 0) {
		periodYear = currentYear - years; // 조회 연도는 (현재 연도 - 전달받은 기간 값) 이다.
 	}
 	
 	int rows = 3; // 조회 행 수는 3개로 고정한다.

 	// 전체 데이터 개수 조회
 	int totalRows = orderDao.getTotalRowsByPeriod(periodYear, userNo);
 	
 	// 페이징 처리에 필요한 정보를 제공하는 객체 생성
 	Pagination pagination = new Pagination(3, totalRows, currentPage);
 	
 	// 요청한 페이지번호에 맞는, 해당 기간의 주문 데이터 조회
 	List<Order> orderList = orderDao.getOrdersByPeriod(periodYear, userNo, pagination.getBeginIndex(), pagination.getEndIndex());
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
			  			<span class="fs-5 py-3 align-middle ps-0 mb-3 fw-bold">주문 내역</span>
			  			<span class="px-3 align-middle text-muted fw-bold">지난 3년 간의 주문 내역 조회가 가능합니다</span>
	  				</div>
	  				<div class="col-6">
			  			<select class="form-select form-select-sm float-end w-25" name="years" onchange="changeYears();" >
			  				<option value="-1" <%=years == -1 ? "selected" : "" %>>전체기간</option>
			  				<option value="0" <%=years == 0 ? "selected" : "" %>><%=currentYear %>년</option>
			  				<option value="1" <%=years == 1 ? "selected" : "" %>><%=currentYear - 1 %>년</option>
			  				<option value="2" <%=years == 2 ? "selected" : "" %>><%=currentYear - 2 %>년</option>
			  			</select>
	  				</div>
	  			</div>
  				<div class ="list-wrapper">
  				<!-- for문으로 card 형식의 주문정보 출력 -->
  				<%
  					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  					for (Order order : orderList) {
  						OrderItem firstItem = orderItemDao.getOrderItemsByOrderNo(order.getNo()).get(0);
  				%>
  					<div class="ps-0 py-1 fs-6 text-muted fw-bold"><%=simpleDateFormat.format(order.getCreatedDate()) %></div>  				
		  			<div class="card mb-3">
					  	<a href="orderdetail.jsp?orderNo=<%=order.getNo() %>" class="card-title text-decoration-none text-dark p-3 d-flex justify-content-between align-items-center border-bottom">
						  	<span class="fw-bold"><%=order.getTitle() %></span>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
							</svg>
						</a>
						<div class="card-body">
							<table class="table table-sm table-borderless">
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<td rowspan="5" class="align-middle">
											<img alt="cover image" src="../images/bookcover/book-<%=firstItem.getBook().getNo() %>.jpg" class="coverimage rounded p-0"/>
										</td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td class="align-middle fw-bold text-end text-muted"><span>주문번호</span></td>
										<td class="align-middle fw-bold text-muted ps-3"><span><%=order.getNo() %></span></td>
									</tr>
									<tr>
										<td class="align-middle fw-bold text-end text-muted"><span>결제금액</span></td>
										<td class="align-middle fw-bold text-muted ps-3"><span><%=StringUtil.numberToCurrency(order.getTotalPayPrice()) %> 원</span></td>
									</tr>
									<tr>
										<td class="align-middle fw-bold text-end text-muted"><span>주문상태</span></td>
										<td class="align-middle fw-bold text-muted ps-3"><span><%=order.getStatus() %></span></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
							</tbody>
						</table>					
					</div>
				</div>
			<%
  					}
			%>
 			</div>
			<!--  
				요청한 페이지번호에 맞는 페이지번호를 출력한다.
				요청한 페이지번호와 일치하는 페이지번호는 하이라이트 시킨다.
				요청한 페이지가 1페이지인 경우 이전 버튼을 비활성화 시킨다.
				요청한 페이지가 맨 마지막 페이지인 경우 다음 버튼을 비활성화 시킨다. 
			-->
			<nav class="p-3">
				<ul class="pagination pagination-sm justify-content-center">
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() <= 1 ? "disabled" : "" %>" href="orderlist.jsp?page=<%=pagination.getCurrentPage() - 1 %>&years=<%=years %>">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
							</svg>
						</a>
					</li>
			<!-- for문으로 행 개수만큼 페이지 버튼 출력 -->
			<%
				for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
			%>
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() == num ? "active" : "" %>" href="orderlist.jsp?page=<%=num %>&years=<%=years %>"><%=num %></a>
					</li>
			<%
				}
			%>
					<li class="page-item">
						<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="orderlist.jsp?page=<%=pagination.getCurrentPage() + 1 %>&years=<%=years %>">
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

	// 기간을 바꾸면 orderlist.jsp?pageNo=1&years=값으로 요청한다. (location.href로 이동)
	function changeYears() {
		let years = document.querySelector("select[name=years]").value;
		location.href="orderlist.jsp?page=1&years=" + years;
	}
	
</script>
</body>
</html>