<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓북스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon"
	href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"
	type="image/x-icon">
<link href="../css/home.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container" style="min-width: 600px; max-width: 600px;">
	<div class="row align-items-center" style="min-height: 600px;">
		<div class="col-12 text-center" id="complete-title">
			<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#5f0080" class="bi bi-dash-circle" viewBox="0 0 16 16">
			  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
			  <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
			</svg>
			<h2 class="fw-bold m-5">오류 페이지</h2>
			<p class="fs-4">요청 처리중 오류가 발생하였습니다.</p>
			<%
				exception.printStackTrace();
			%>
			<p class="fs-4 text-danger"><%=exception.getMessage() %></p>
		</div>
	</div>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>