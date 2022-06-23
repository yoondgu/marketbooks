<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String menu = request.getParameter("menu");

	// 세션객체에 저장된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
%>
<nav class="navbar navbar-expand-lg navbar navbar-dark bg-dark mb-3 ">
	<div class="container">
		<a class="navbar-brand" href="/board-app/home.jsp">커뮤니티</a>
		<button class="navbar-toggler" type="button"
			data-bs-toggle="collapse" data-bs-target="#navbarNav"
			aria-controls="navbarNav" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link <%="home".equals(menu) ? "active" : "" %>" aria-current="page" href="/marketbooks/list.jsp">공지사항</a>
				</li>
				<li class="nav-item">
					<a class="nav-link <%="board".equals(menu) ? "active" : "" %>" aria-current="page" href="/marketbooks/board/inquiry.jsp?page=1">게시판</a>
				</li>
			</ul>
			<!-- 
				로그인이 완료되면 아래 내용을 출력한다. 이름은 실제 로그인한 사용자의 이름을 출력한다. 
			-->
		<% 
			if (user != null) {
		%>
			<span class="navbar-text"><strong class="text-white"><%=user.getName() %></strong>님 환영합니다.</span>
		<%
			}
		%>
			<ul class="navbar-nav">
				<!-- 
					로그인하지 않은 경우 로그인/회원가입 메뉴를 출력한다. 
				-->
		<%
			if (user == null) {
		%>
				<li class="nav-item">
					<a class="nav-link <%="login".equals(menu) ? "active" : "" %>" aria-current="page" href="/marketbooks/loginform.jsp">로그인</a>
				</li>
				<li class="nav-item">
					<a class="nav-link <%="register".equals(menu) ? "active" : "" %>" aria-current="page" href="/marketbooks/registerform.jsp">회원가입</a>
				</li>
		<%
			} else {
		%>
				<!-- 
					로그인이 완료되면 로그아웃 메뉴를 출력한다. 
				-->
				<li class="nav-item">
					<a class="nav-link" aria-current="page" href="/marketbooks/logout.jsp">로그아웃</a>
				</li>	
		<%
			}
		%>			
			</ul>
		</div>
	</div>
</nav>