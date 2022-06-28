<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓북스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"	type="image/x-icon">
<link href="../css/home.css" rel="stylesheet">
</head>
<body>

<!-- header include -->
<jsp:include page="/common/header.jsp"></jsp:include>
<!-- bestsellerList include -->
<jsp:include page="/book/newlist.jsp"></jsp:include>
<!-- footer include -->
<jsp:include page="/common/footer.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>