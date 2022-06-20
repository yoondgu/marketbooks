<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body">
	<div id="wrap">
	<div id="container" class="">
		<!-- header -->
		<div id="header">
			<jsp:include page="common/header.jsp">
				<jsp:param name="menu" value="home" />
			</jsp:include>
		</div>
		<!-- main -->
		<div id="main">
			<jsp:include page="/main.jsp">
				<jsp:param name="menu" value="home" />
			</jsp:include>
		</div>
		<!-- footer include -->
		<div id="footer">
			<jsp:include page="common/footer.jsp">
				<jsp:param name="menu" value="home" />
			</jsp:include>
		</div>
	</div>
</div>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>