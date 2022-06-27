<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.NoticeDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마켓북스</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="shortcut icon"
	href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"
	type="image/x-icon">
<link rel="stylesheet" href="../css/board.css">
<link rel="stylesheet" href="../css/home.css">
</head>
<body class="board-list">
<!-- header -->
	<div id="header">
		<jsp:include page="../common/header.jsp">
			<jsp:param name="menu" value="list" />
		</jsp:include>
	</div>
		<%
				NoticeDao noticeDao = NoticeDao.getInstance();

				int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
				int rows = StringUtil.stringToInt(request.getParameter("rows"), 10);
				String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));

				// 전체 데이터 갯수 조회
				int totalRows = 0;
				if (keyword.isEmpty()) {
					totalRows = noticeDao.getTotalRows();
				} else {
					totalRows = noticeDao.getTotalRows(keyword);
				}
				// 페이징처리에 필요한 정보를 제공하는 객체 생성
				Pagination pagination = new Pagination(rows, totalRows, currentPage);
				
				List<Notice> noticeList = null;
				if (keyword.isEmpty()) {
					noticeList = noticeDao.getAllNotices(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
				} else {
					noticeList = noticeDao.getAllNotices(pagination.getBeginIndex(), pagination.getEndIndex());
				}
		%>
	<div id="wrap">
		<div id="container">
			<div id="main">
				<div id="content">
					<div class="page_aticle">
						<div id="snb" class="snb_cc">
							<h2 class="tit_snb">고객센터</h2>
							<div class="inner_snb">
								<ul class="list_menu">
									<li class="on"><a href="/marketbooks/board/list.jsp">공지사항</a>
									</li>
									<li><a href="/marketbooks/board/faq.jsp">자주하는 질문</a></li>
									<li><a href="/marketbooks/board/inquiry.jsp">1:1 문의</a></li>
								</ul>
							</div>
							<a href="/marketbooks/board/form.jsp" class="link_inquire"><span
								class="emph">도움이 필요하신가요 ?</span> 1:1 문의하기</a>
						</div>
						<div class="page_section">
							<div class="head_aticle">
								<h2 class="tit">
									공지사항 <span class="tit_sub">컬리의 새로운 소식들과 유용한 정보들을 한곳에서
										확인하세요.</span>
								</h2>
							</div>
							<form name="frmList" action="" onsubmit="">
								<input type="hidden" name="id" value="notice">
								<style>
								.notice .layout-pagination {
									margin: 0
								}
								
								.eng2 {
									color: #939393
								}
								
								.xans-board-listheader {
									font-size: 12px
								}
								</style>
								<table width="100%" align="center" cellpadding="0"
									cellspacing="0">
									<tbody>
										<tr>
											<td>
												<div
													class="xans-element- xans-myshop xans-myshop-couponserial ">
													<table width="100%" class="xans-board-listheader"
														cellpadding="0" cellspacing="0">
														<thead>
															<tr>
																<th>번호</th>
																<th>제목</th>
																<th>작성자</th>
																<th>작성일</th>
																<th>조회</th>
															</tr>
														</thead>
														<tbody>
														<%
														for (Notice notice : noticeList) {
														%>
															<tr>
																<td width="50" nowrap="" align="center">공지</td>
																<td
																	style="padding-left: 10px; text-align: left; color: #999">
																	<a href="view.jsp?no=<%=notice.getNo()%>&page=<%=currentPage%>"><b><%=notice.getTitle() %></b></a>
																</td>
																<td width="100" nowrap="" align="center">MarketKurly</td>
																<td width="100" nowrap="" align="center" class="eng2"><%=notice.getCreatedDate() %></td>
																<td width="30" nowrap="" align="center" class="eng2"><%=notice.getViewCount() %></td>
															</tr>
														<%
														}
														%>
														</tbody>
													</table>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<%
									User user = null;
								
									if ((user = (User) session.getAttribute("LOGINED_USER")) != null) {
										if("admin@gmail.com".equals(user.getEmail())) {
								%>
									<table width="100%">

									<tbody>
										<tr>
											<td align="right"><a href="/marketbooks/board/noticeform.jsp?page=<%=currentPage%>">
													<span class="bhs_button yb" style="float: none;">공지사항 작성하기</span>
											</a></td>
										</tr>
									</tbody>
								</table>
								<%
										}
									} else { 
								%>
								<%
									}
								%>
								<input type="hidden" name="page" value="<%=currentPage %>" />
								<div class="layout-pagination">
									<div class="pagediv">
										<a href="list.jsp?page=<%=pagination.getCurrentPage() - 1%>"
											class="layout-pagination-button layout-pagination-prev-page">
											</a>
										<%
										for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
										%>
										<a href="list.jsp?page=<%=num%>"
											class="layout-pagination-button layout-pagination-number <%=pagination.getCurrentPage() == num ? "__active" : ""%>"><%=num %>
											</a>
										<%
										}
										%>
										<a href="list.jsp?page=<%=pagination.getCurrentPage() + 1%>"
											class="layout-pagination-button layout-pagination-next-page">
										</a>
									</div>
								</div>

								<table class="xans-board-search xans-board-search2">
									<tbody>
										<tr>
											<td class="input_txt">검색어</td>
											<td class="stxt"><input type="checkbox"
												name="search[name]">이름 <input type="checkbox"
												name="search[subject]">제목 <input type="checkbox"
												name="search[contents]">내용&nbsp;</td>
											<td class="input_txt">&nbsp;</td>
											<td>
												<div class="search_bt">
													<a href="javascript:document.frmList.submit()"><img
														src="../images/search.jpeg" align="absmiddle"></a> <input
														type="text" name="search[word]" value="" required="">
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
<!-- footer include -->
<jsp:include page="../common/footer.jsp"></jsp:include>
</html>

