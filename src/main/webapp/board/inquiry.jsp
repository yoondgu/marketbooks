<%@page import="org.apache.jasper.runtime.PageContextImpl"%>
<%@page import="vo.User"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="dto.InquiryDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.InquiryDao"%>
<%@page import="vo.Inquiry"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓북스</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="shortcut icon"
	href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"
	type="image/x-icon">
<link rel="stylesheet" href="../css/board.css?ver=2">
</head>
<body class="board-list">
	<!-- header -->
	<div id="header">
		<jsp:include page="../common/nav.jsp">
			<jsp:param name="menu" value="faq" />
		</jsp:include>
	</div>
	<div id="wrap">
		<div id="container">
			<div id="main">
				<div id="content">
					<div class="page_aticle">
						<div id="snb" class="snb_cc">
							<h2 class="tit_snb">고객센터</h2>
							<div class="inner_snb">
								<ul class="list_menu">
									<li><a href="/marketbooks/board/list.jsp">공지사항</a></li>
									<li><a href="/marketbooks/board/faq.jsp">자주하는 질문</a></li>
									<li class="on"><a
										href="/marketbooks/board/inquiry.jsp?page=1">1:1 문의</a></li>
								</ul>
							</div>
							<a href="/marketbooks/board/form.jsp" class="link_inquire"><span
								class="emph">도움이 필요하신가요 ?</span> 1:1 문의하기</a>
						</div>
						<div class="page_section">

							<div class="head_aticle">
								<h2 class="tit">1:1 문의</h2>
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
	font-size: 15px
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
														<%
														User user = (User) session.getAttribute("LOGINED_USER");
														
														System.out.println(user);
														
														InquiryDao inquiryDao = InquiryDao.getInstance();
														// List<InquiryDto> inquiryList = inquiryDao.getAllInquiries(); 전체조회 Test

														int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
														int rows = StringUtil.stringToInt(request.getParameter("rows"), 10);
														String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));

														// 전체 데이터 갯수 조회
														int totalRows = 0;
														if (keyword.isEmpty()) {
															totalRows = inquiryDao.getTotalRows(user.getNo());
														} else {
															totalRows = inquiryDao.getTotalRows(keyword, user.getNo());
														}
														// 페이징처리에 필요한 정보를 제공하는 객체 생성
														Pagination pagination = new Pagination(rows, totalRows, currentPage);

														// 요청한 페이지번호에 맞는 데이터 조회하기
														List<InquiryDto> inquiryList = null;
														if (keyword.isEmpty()) {
															inquiryList = inquiryDao.getInquiries(pagination.getBeginIndex(), pagination.getEndIndex(), user.getNo());
														} else {
															inquiryList = inquiryDao.getInquiries(pagination.getBeginIndex(), pagination.getEndIndex(), keyword, user.getNo());
														}
														%>
														<thead>
															<tr>
																<th width="620px">제목</th>
																<th width="100px">작성자</th>
																<th width="100px">작성일</th>
																<th width="100px">답변상태</th>
															</tr>
														</thead>
														<tbody>
															<%
															for (InquiryDto inq : inquiryList) {
															%>
															<tr>
																<td width="50" nowrap="" align="center"><b> <a
																		href="detail.jsp?no=<%=inq.getNo()%>&page=<%=pagination.getCurrentPage()%>"><%=inq.getTitle()%></a></b></td>
																<td width="50" nowrap="" align="center"><b><%=inq.getUserName()%></b></td>
																<td width="100" nowrap="" align="center" class="eng2"><%=inq.getCreatedDate()%></td>
																<td width="30" nowrap="" align="center" class="eng2"><%=inq.getAnswerStatus()%></td>

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
								
								<div class="layout-pagination">
									<div class="pagediv">
										<a href="inquiry.jsp?page=<%=pagination.getCurrentPage() - 1%>"
											class="layout-pagination-button layout-pagination-prev-page">
											</a>
										<%
										for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
										%>
										<a href="inquiry.jsp?page=<%=num%>"
											class="layout-pagination-button layout-pagination-number <%=pagination.getCurrentPage() == num ? "__active" : ""%>"><%=num %>
											</a>
										<%
										}
										%>
										<a href="inquiry.jsp?page=<%=pagination.getCurrentPage() + 1%>"
											class="layout-pagination-button layout-pagination-next-page">
										</a>
									</div>
								</div>

								<table width="100%">

									<tbody>
										<tr>
											<td align="right"><a href="/marketbooks/board/form.jsp">
													<span class="bhs_button yb" style="float: none;">문의하기</span>
											</a></td>
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
<script>


</script>	
</body>
</html>