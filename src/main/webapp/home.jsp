<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>market books</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- <link href="css/home.css" rel="stylesheet"> -->
</head>
<body>
<!-- header -->
<jsp:include page="common/header.jsp">
	<jsp:param name="menu" value="home" />
</jsp:include>
<!-- main -->
<jsp:include page="common/main.jsp">
	<jsp:param name="menu" value="home" />
</jsp:include>
<!-- footer include -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="menu" value="home" />
</jsp:include>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>