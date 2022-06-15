<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" herf="css/home.css">
<style>
.bnr_header {
	position: relative;
	min-width: 1050px;
	text-align: center;
	line-height: 42px;
	font-size: 14px;
	background-color: #5f0080;
	color: #fff;
	display: block;
	height: 42px;
}

.btn-group {
	float: right;
}
</style>
</head>
<body>
	<div class="container">
	
		<!-- header -->
		<div class="header">
			<jsp:include page="common/header.jsp">
				<jsp:param name="menu" value="home" />
			</jsp:include>
		</div>
		
		<!-- main -->
		<div class="main">
			<jsp:include page="common/main.jsp">
				<jsp:param name="menu" value="home" />
			</jsp:include>
		</div>

		<!-- footer include -->
		<div class="footer">
			<jsp:include page="common/footer.jsp">
				<jsp:param name="menu" value="home" />
			</jsp:include>
		</div>
		
	</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>