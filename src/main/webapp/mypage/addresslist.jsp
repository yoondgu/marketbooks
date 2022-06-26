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
				<jsp:param name="menu" value="address"/>
			</jsp:include>
   		</div>
   		<div class="col-9 p-3">
   			<!-- 해당 메뉴 HTML 들어갈 곳 -->
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