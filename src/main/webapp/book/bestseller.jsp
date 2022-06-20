<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@page import="dao.BookDao"%>
<%@page import="vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="container">

	<div class="row">
		<div class="col-5 d-flex justify-content-between p-3">
			<span class="">베스트셀러</span>
		</div>
	</div>

	<div class="row">

		<div class="col-3 mb-3">
			<%
			int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
			int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
			String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));

			BookDao bookDao = BookDao.getInstance();
			// 전체 데이터 갯수 조회
			int totalRows = 0;
			if (keyword.isEmpty()) {
				totalRows = bookDao.getTotalRows();
			} else {
				totalRows = bookDao.getTotalRows(keyword);
			}
			// 페이징처리에 필요한 정보를 제공하는 객체 생성
			Pagination pagination = new Pagination(rows, totalRows, currentPage);

			// 요청한 페이지번호에 맞는 데이터 조회하기
			List<Book> bookList = null;
			if (keyword.isEmpty()) {
				bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex());
			} else {
				bookList = bookDao.getBooks(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
			}
			%>

			<div class="flex-row row">

				<div class="col-4 p-5">
					<img src="images/sample.jpeg" class="card-img-top" />
					<div class="card-body">
						<h5 class="card-title lh-sm">작별인사</h5>
						<p class="card-text lh-sm">김영하</p>
						<p class="fw-semibold lh-sm">12,600</p>
						<p class="text-decoration-line-through lh-sm">14,000</p>
					</div>
				</div>
				<div class="col-4 p-5">
					<img src="images/sample.jpeg" class="card-img-top" />
					<div class="card-body">
						<h5 class="card-title lh-sm">작별인사</h5>
						<p class="card-text lh-sm">김영하</p>
						<p class="fw-semibold lh-sm">12,600</p>
						<p class="text-decoration-line-through lh-sm">14,000</p>
					</div>
				</div>
				<div class="col-4 p-5">
					<img src="images/sample.jpeg" class="card-img-top" />
					<div class="card-body">
						<h5 class="card-title lh-sm">작별인사</h5>
						<p class="card-text lh-sm">김영하</p>
						<p class="fw-semibold lh-sm">12,600</p>
						<p class="text-decoration-line-through lh-sm">14,000</p>
					</div>
				</div>
				<div class="col-4 p-5">
					<img src="images/sample.jpeg" class="card-img-top" />
					<div class="card-body">
						<h5 class="card-title lh-sm">작별인사</h5>
						<p class="card-text lh-sm">김영하</p>
						<p class="fw-semibold lh-sm">12,600</p>
						<p class="text-decoration-line-through lh-sm">14,000</p>
					</div>
				</div>

			</div>


		</div>
	</div>
</div>