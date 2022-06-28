<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
	#button a{
		font-family: noto sans,malgun gothic,AppleGothic,dotum;
        line-height: 1;
        letter-spacing: -.05em;
        font-size: 12px;
        max-width: 100%;
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
		<nav class="navbar navbar-expand-lg bg-light  ">
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
						<div id="snb" class="snb_cc">
							<h2 class="tit_snb">관리자메뉴</h2>
							<div class="inner_snb">
								<ul class="list_menu">
									<li class="on"><a href="userlist.jsp">회원관리</a></li>
									<li><a href="booklist.jsp">도서관리</a></li>
									<li><a href="inquirylist.jsp">문의관리</a></li>
									<li><a href="orderlist.jsp">주문관리</a></li>
								</ul>
							</div>
						</div>
						
						<div class="page_section">
							<div class="head_aticle">
								<h2 class="tit">전체회원관리<span class="tit_sub">모든 회원을 관리할 수 있는 페이지 입니다.</span>
								</h2>
							</div>
   <%
   
	   int currentPage = StringUtil.stringToInt(request.getParameter("page"),1);
	   
	   UserDao userDao = UserDao.getInstance();
	   
	   int totalRows = userDao.getTotalRows();
	   
	   Pagination pagination = new Pagination(totalRows, currentPage);
	   
	   List<User> users = userDao.getUsers(pagination.getBeginIndex(), pagination.getEndIndex());
  
   %>
   
   <table width="100%" align="center" cellpadding="0" cellspacing="0">
   		<tbody>
			<tr>
				<td>
					<div class="xans-element- xans-myshop xans-myshop-couponserial ">
						<table width="100%" class="xans-board-listheader" cellpadding="0" cellspacing="0">
					   		<colgroup>
					   			<col width="10%">
					   			<col width="10%">
					   			<col width="%">
					   			<col width="16%">
					   			<col width="14%">
					   			<col width="14%">
					   			<col width="17%">
					   		</colgroup>
					   		<thead>
					   			<tr>
					   				<th>회원번호</th>
					   				<th>회원명</th>
					   				<th>이메일</th>
					   				<th>전화</th>
					   				<th>가입일</th>
					   				<th>최근정보수정일</th>
					   				<th>회원정보</th>
					   			</tr>
					   		</thead>
					   		<tbody class="table-group-divider">
					   		<%
					   			for(User user : users) {
					   		%>
					   			<tr>
					   				<td><%=user.getNo() %></td>
					   				<td><%=user.getName() %></td>
					   				<td><%=user.getEmail() %></td>
					   				<td><%=user.getTel() %></td>
					   				<td><%=user.getCreatedDate() %></td>
					   				<td>
					   				<%
					   					if(user.getUpdatedDate() == null) {
					   				%>
					   					<%=user.getCreatedDate() %>
					   				<%
					   					} else {
					   				%>
					   					<%=user.getUpdatedDate() %>
					   				<%
					   					}
					   				%>
					   				</td>
					   				<td>
					   					<div id="button">
					   						<span><a href="user.jsp?no=<%=user.getNo() %>&page=<%=currentPage %>" class="btn btn-outline-secondary btn-sm me-1">상세보기</a></span>
					   						<span><a href="userdelete.jsp?no=<%=user.getNo() %>&page=<%=currentPage %>" class="btn btn-outline-danger btn-sm">삭제</a></span>
					   					</div>
					   				</td>
					   			</tr>
					   		<%
								}
							%>
					   		</tbody>
					   </table>
   					</div>
   				</td>
   			</tr>
   		</tbody>
   	</table>
	<div class="layout-pagination">
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
						<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="javascript:changePageNo(<%=pagination.getCurrentPage() -1%>)">이전</a>
					</li>
					<%
					for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
					%>
					<li class="page-item <%=pagination.getCurrentPage() == num ? "active" : "" %>">
						<a class="page-link" href="javascript:changePageNo(<%=num %>)"><%=num %></a>
					</li>
					<%
					}
					%>
					<li class="page-item">	
						<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="javascript:changePageNo(<%=pagination.getCurrentPage() +1%>)">다음</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>
   <form id = "search-form" method="get" action="userlist.jsp">
	<div class="d-flex mb-3">
		<div class="me-auto p-2"></div>
		<div class="p-2">
			<input class="form-control" style="width: 220px" type="text" name="keyword" value="" placeholder="검색어를 입력하세요." />
		</div>
		<div class="p-2">
			<button type="button" style="width: 60px" class="btn btn-outline-primary" onclick="searchKeyword()">검색</button>
		</div>
	</div>
	
			<input type="hidden" name="page" />
	</form>
	
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	// 페이지 변경
	function changePageNo(pageNo) {
		document.querySelector("input[name=page]").value = pageNo;
		document.getElementById("search-form").submit();
	}
	function searchKeyword() {
		document.querySelector("input[name=page]").value = 1;
		document.getElementById("search-form").submit();
	}
</script>
		
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>