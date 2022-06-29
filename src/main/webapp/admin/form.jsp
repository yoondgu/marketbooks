<%@page import="vo.User"%>
<%@page import="vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
    <!-- 관리자만 접속할 수 있게 합니다. -->
<%     
	// 세션에 저장된 사용자정보를 조회한다.
	User logineduser = (User) session.getAttribute("LOGINED_USER");
	if(logineduser == null) {
		throw new RuntimeException("관리자 홈페이지에 접속하실 수 없습니다.");
	}
	if(!"admin@gmail.com".equals(logineduser.getEmail())) {
		throw new RuntimeException("관리자 홈페이지에 접속하실 수 없습니다.");
	} 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓컬리 - 관리자페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png" type="image/x-icon">
<link rel="stylesheet" href="../css/board.css">
<style>
	#button {
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
		<nav class="navbar navbar-expand-lg bg-light">
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
						<div class="head_aticle">
							<h2 class="tit">새 도서 등록<span class="tit_sub">새로운 도서정보를 입력하여 도서 목록을 업데이트하세요.</span>
							</h2>
						</div>
					<div>
						<form class="row g-3 border bg-light mx-1" method="post" action="add.jsp" enctype="multipart/form-data" onsubmit="return submitAddForm()">
							<div class="col-12">
								<label class="form-label">카테고리</label>
								<select class="form-select" id="top-category-combobox" name="categoryNo">
									<option selected="selected" disabled="disabled">선택하세요</option>
									<%
										CategoryDao categoryDao = CategoryDao.getInstance();
										List<Category> categories = categoryDao.getAllCategories();
										
										for(Category cat : categories) {
									%>
											<option value="<%=cat.getNo()%>"><%=cat.getName() %></option>
									<%
										}
									%>
								</select>
							</div>
							
							<div class="col-12">
								<label class="form-label">책이름</label>
								<input class="form-control" type="text" name="title" />
							</div>
							<div class="col-6">
								<label class="form-label">저자</label>
								<input class="form-control" type="text" name="author" />
							</div>
							
							<div class="col-6">
								<label class="form-label">출판사</label>
								<input class="form-control" type="text" name="publisher" />
							</div>
							
							<div class="col-5">
								<label class="form-label">정가</label>
								<input class="form-control" type="number" name="price" />
							</div>
							<div class="col-5">
								<label class="form-label">할인가격</label>
								<input class="form-control" type="number" name="discount-price" />
								
							</div>
							<div class="col-2">
								<label class="form-label">재고</label>
								<input class="form-control" type="number" name="stock" />
							</div>
							
							<div class="col-12">
								<label class="form-label">도서 설명</label>
								<textarea rows="10" class="form-control" name="discription"></textarea>
							</div>
							<div class="col-12">
								<label class="form-label">책 이미지 업로드</label>
								<input class="form-control" type="file" name="upfile"/>
							</div>
							<div class="col-12 text-end mb-3">
								<a href="booklist.jsp" class="btn btn-secondary">취소</a>
								<button type="submit" class="btn btn-primary">등록</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function submitAddForm() {
		let titleField = document.querySelector("input[name=title]");
		if (titleField.value === '') {
			alert("도서 제목은 필수입력값입니다.");
			titleField.focus();
			return false;
		}
		let authorField = document.querySelector("input[name=author]");
		if (authorField.value === '') {
			alert("도서 저자는 필수입력값입니다.");
			authorField.focus();
			return false;
		}
		let publisherField = document.querySelector("input[name=publisher]");
		if (publisherField.value === '') {
			alert("도서 저자는 필수입력값입니다.");
			publisherField.focus();
			return false;
		}
		let priceField = document.querySelector("input[name=price]");
		if (priceField.value === '') {
			alert("도서 가격은 필수입력값입니다.");
			priceField.focus();
			return false;
		}
		return true;
	}
</script>
</body>
</html>
