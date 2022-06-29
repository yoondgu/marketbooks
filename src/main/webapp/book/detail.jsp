<%@page import="vo.Category"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.Book"%>
<%@page import="dao.BookDao"%>
<%@page import="util.StringUtil"%>
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
<!-- header -->
<jsp:include page="/common/header.jsp">
	<jsp:param name="menu" value="book" />
</jsp:include>
<!-- main -->
<div class="layout-wrapper">
   <!-- 제목,부제,저자,출판사,출간일 -->
   <div class="row m-3">
   		<div class="mt-3 mb-3">   		
   		
		<!--
			요청파라미터에서 게시글 번호를 조회하고, 게시글 번호에 맞는 글 정보를 조회해서 출력한다.
		-->
		<%
			// 요청파라미터에서 게시글 번호를 조회한다.
			int bookNo = StringUtil.stringToInt(request.getParameter("bookNo"));
			
			BookDao bookDao = BookDao.getInstance();
			// 게시글 번호에 해당하는 게시글 정보를 조회한다.
			Book book = bookDao.getBookByNo(bookNo);
			if (book == null) {
				throw new RuntimeException("게시글 정보가 존재하지 않습니다.");
			}
			
			String title = book.getTitle();
			String maintitle;
			String subtitle;
			if (title.contains("-")) {
				maintitle = title.substring(0, title.lastIndexOf(" - "));
				subtitle = title.substring(title.lastIndexOf(" - ")+1);
		%>
	   		<span class="fs-2 float-left me-1"><%=maintitle %></span><span class="fs-6 float-right"> <%=subtitle %></span>
		<%
			} else {
				maintitle = title;
		%>
		   	<span class="fs-2 float-left me-1"><%=maintitle %></span>
		<%
			}	
		%>
   		</div>
   		<span class="m-2 "><%=book.getAuthor() %> / <%=book.getPublisher() %> / <%=book.getCreatedDate() %></span>
   		
   		<!-- 공유하기 버튼 -->
   		<span class="btn_share">
	   		<button id="btnShare" data-goodsno="4475">공유하기</button>
   		</span>
   </div>
   
   <!-- 가로줄 -->
   <div class="border-bottom m-4"></div>
   
   <!-- 이미지,상세정보,결제 -->
   <div class="row m-3">
   		<div class="col mt-2">
   			<img src="/marketbooks/images/bookcover/book-<%=book.getNo() %>.jpg" class="">
   		</div>
   		<div class="col mt-2">
   			<!-- 가격 -->
   			<div class="row">
				<div class="m-2">
					<span class="fs-5 m-2 min-width:200px">정가</span>
					<span class="fs-5 m-3"><%=book.getPrice() %>원</span>
				</div>
				<div class="m-2">
					<span class="fs-5 m-2">판매가</span>					
					<span class="fs-4 m-3"><%=book.getDiscountPrice() %>원 </span>
					<span class="">(10%,550원 할인)</span>
				</div>
	   		</div>
   		   			
	 
  			<!-- 배송료 -->
  			<div class="row">
				<div class="m-2">
					<span class="fs-5 m-2">배송료</span>
					<span class="fs-5 m-2">
						<!-- <button type="button" onclick="" class="btn btn-link p-0 ps-2 align-top">무료/안내</button> -->
						<span class="">무료</span>
					</span>
				</div>
  			</div>
  			
  			<!-- 수령예상일 -->
  			<div class="row">
				<div class="m-2">
					<span class="fs-6 m-2 float-start">수령예상일</span>
					<div class="fs-5 m-2">
						<span class="m-2 fs-6">지금 택배로 주문하면 내일 수령</br></span>
						<span class="m-2 fs-6">주소 <button type="button" onclick="" class="btn btn-link p-0">지역변경</button></span>
					</div>
				</div>
  			</div>
  			
  			<!-- 카테고리-->
  			<%
  				CategoryDao categoryDao = CategoryDao.getInstance();
  				Category category = categoryDao.getCategoryName(bookNo);
  			%>
  			<div class="row">
				<div class="m-2"> 
  					<span class="fs-6 m-2">카테고리</span>
  					<span class="m-2"><%=category.getName() %></span>
  				</div>		
  			</div>
  			<!-- 출간일-->
  			<div class="row">
				<div class="m-2"> 
  					<span class="fs-6 m-2">출간일</span>
	  				<span class="m-3"><%=book.getCreatedDate() %></span>
  				</div>		
  			</div>
			
  			<!-- 장바구니, 구매버튼 -->
			<div class="m-3 float-end">
				<button class="btn btn-primary me-2" onclick="location.href='/marketbooks/cart/list.jsp'" onclick="">장바구니 담기</button>
				<button class="btn btn-primary" onclick="location.href=''">바로구매</button>
			</div>
  			
   		</div>
   </div>
   
   <!-- 설명글 -->
   <div class="row m-3">
   		<span class="ms-3 mt-2 book-description"><%=book.getDescription() %></span>
   </div>
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="menu" value="home" />
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>