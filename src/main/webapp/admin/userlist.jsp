<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="vo.User"%>
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
	<ul class="list-group">
		<!-- 마우스 커서가 올라가면 active + 글자 strong -->
		<li class="list-group-item"><a href="userlist.jsp">회원관리</a></li>
		<li class="list-group-item"><a href="booklist.jsp">도서관리</a></li>
		<li class="list-group-item"><a href="inquirylist.jsp">문의관리</a></li>
		<li class="list-group-item"><a href="orderlist.jsp">주문관리</a></li>
	</ul>
</aside>
<form class="col-10">
   <h2 style="width: 820px">전체회원관리</h2>
   
   <%
   
   int currentPage = StringUtil.stringToInt(request.getParameter("page"),1);
   
   UserDao userDao = UserDao.getInstance();
   
   int totalRows = userDao.getTotalRows();
   
   Pagination pagination = new Pagination(totalRows, currentPage);
   
   List<User> users = userDao.getUsers(pagination.getBeginIndex(), pagination.getEndIndex());
  
   %>
   
   <table class="table">
   		<colgroup>
   			<col width="10%">
   			<col width="10%">
   			<col width="%">
   			<col width="16%">
   			<col width="14%">
   			<col width="14%">
   			<col width="14%">
   		</colgroup>
   		<thead>
   			<tr>
   				<th>회원번호</th>
   				<th>회원명</th>
   				<th>이메일</th>
   				<th>전화</th>
   				<th>가입일</th>
   				<th>Updated_date</th>
   				<th>회원정보</th>
   			</tr>
   		</thead>
   		<tbody class="table-group-divider">
   		<%
   			for(User user : users) {
   		%>
   			<tr>
   				<th><%=user.getNo() %></th>
   				<th><%=user.getName() %></th>
   				<th><%=user.getEmail() %></th>
   				<th><%=user.getTel() %></th>
   				<th><%=user.getCreatedDate() %></th>
   				<th><%=user.getUpdatedDate() %></th>
   				<th>
   					<div class="d-flex flex-nowrap">
   						<a href="user.jsp?userNo=<%=user.getNo() %>" class="btn btn-outline-info btn-sm">주문정보</a>
   						<a href="userdelete.jsp" class="btn btn-primary btn-sm">삭제</a>
   					</div>
   				</th>
   			</tr>
   		<%
			}
		%>
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
						<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="userlist.jsp?page=<%=pagination.getCurrentPage() -1%>">이전</a>
					</li>
					<%
					for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
					%>
					<li class="page-item <%=pagination.getCurrentPage() == num ? "active" : "" %>">
						<a class="page-link" href="userlist.jsp?page=<%=num %>"><%=num %></a>
					</li>
					<%
					}
					%>
					<li>	
						<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="userlist.jsp?page=<%=pagination.getCurrentPage() +1%>">다음</a>
					</li>
				</ul>
	   </nav>
   </div>
   
  
	<div class="d-flex mb-3">
		<div class="me-auto p-2"></div>
		<div class="p-2">
			<input class="form-control" style="width: 220px" type="text" name="keyword" value="" placeholder="검색어를 입력하세요." />
		</div>
		<div class="p-2">
			<button type="button" style="width: 60px" class="btn btn-outline-primary" onclick="searchKeyword()">검색</button>
		</div>
	</div>
			
		
	
</form>

</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>