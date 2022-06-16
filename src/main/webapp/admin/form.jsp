<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<nav></nav>
<header class="align-middle text-center">
	<div style="height:200px">
		<p><h6 class="align-middle text-end">관리자님 안녕하세요 | 로그아웃 </h6></p>
		<h1><p>market</p><p>books</p></h1>
	</div>
</header>
<div class="container" style="width: 1172px">
<div class="mx-auto" style="width: 1050px">
	<div>
		<h2>새 도서 등록</h2>
	</div>
	<div>
		<form class="row g-3 border bg-light mx-1" action="">
			<div class="col-12">
				<label class="form-label">카테고리</label>
				<select class="form-select" id="top-category-combobox" name="categoryNo">
					<option selected="selected" disabled="disabled">선택하세요</option>
				</select>
			</div>
			
			<div class="col-6">
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
			<div class="col-6">
				<label class="form-label">출간일시</label>
				<input class="form-control" type="date" id="created-date" />
			</div>
			
			<div class="col-5">
				<label class="form-label">정가</label>
				<input class="form-control" type="text" name="price" />
			</div>
			<div class="col-5">
				<label class="form-label">할인가격</label>
				<input class="form-control" type="text" name="discount-price" />
				
			</div>
			<div class="col-2">
				<label class="form-label">재고</label>
				<input class="form-control" type="text" name="stock" />
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
