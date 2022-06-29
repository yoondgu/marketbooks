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
<link rel="stylesheet" href="../css/board.css?123">
<link rel="stylesheet" href="../css/home.css">
</head>
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
<body class="board-list">
	<!-- header -->
	<div id="header">
		<jsp:include page="../common/header.jsp">
			<jsp:param name="menu" value="inquiry" />
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
									<li><a href="/marketbooks/board/list.jsp?page=1">공지사항</a></li>
									<li><a href="/marketbooks/board/faq.jsp?page=1">자주하는 질문</a></li>
									<li class="on"><a
										href="/marketbooks/board/inquiry.jsp?page=1">1:1 문의</a></li>
								</ul>
							</div>
							<a href="/marketbooks/board/form.jsp" class="link_inquire"><span
								class="emph">도움이 필요하신가요 ?</span> 1:1 문의하기</a>
						</div>
						<%
						User user=(User) session.getAttribute("LOGINED_USER");
						if (user == null) {
							response.sendRedirect("../loginform.jsp?fail=deny");
							return;
						}
							
						InquiryDao inquiryDao = InquiryDao.getInstance();

						int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
						int rows = StringUtil.stringToInt(request.getParameter("rows"), 10);
						String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
						String status = StringUtil.nullToBlank(request.getParameter("status"));
						// 전체 데이터 갯수 조회
						int totalRows = 0;
						if ("admin@gmail.com".equals(user.getEmail())) {
							if (status == "") {
							totalRows = inquiryDao.getTotalRows();
							} else if (status != null) {
							totalRows = inquiryDao.getTotalRows(status);	
							}
						} else if (keyword.isEmpty()) {
							if (status == "") {
							totalRows = inquiryDao.getTotalRows(user.getNo());
							} else if (status != null) {
							totalRows = inquiryDao.getTotalRows(user.getNo(),status);	
							}
						} else {
							totalRows = inquiryDao.getTotalRows(keyword, user.getNo());
						}
						
						// 페이징처리에 필요한 정보를 제공하는 객체 생성
						Pagination pagination = new Pagination(rows, totalRows, currentPage);
						
						// 요청한 페이지번호에 맞는 데이터 조회하기
						List<InquiryDto> inquiryList = null;
						if("admin@gmail.com".equals(user.getEmail())) {
							if (status == "") {
							inquiryList = inquiryDao.getAllInquiries(pagination.getBeginIndex(), pagination.getEndIndex());
							} else if (status != null){
							inquiryList = inquiryDao.getAllInquiries(pagination.getBeginIndex(), pagination.getEndIndex(), status);
							}
						} else if (keyword.isEmpty()) {
							if (status == "") {
							inquiryList = inquiryDao.getInquiries(pagination.getBeginIndex(), pagination.getEndIndex(), user.getNo());
							} else if (status != null){
							inquiryList = inquiryDao.getInquiries(pagination.getBeginIndex(), pagination.getEndIndex(), user.getNo(), status);	
							}
						}
						%>
						
						<div class="page_section">
							<div class="head_aticle">
								<h2 class="tit">1:1 문의
								<select class="form-select mb-3 w-25 float-end" name="status" onchange="changeStatus();">
									<option value ="" <%="".equals(status) ? "selected" : "" %>> 모두보기 </option>
									<option value ="Y" <%="Y".equals(status) ? "selected" : "" %>> 답변완료 </option>
									<option value ="N" <%="N".equals(status) ? "selected" : "" %>> 답변대기 </option>
								</select>
								</h2>
							</div>
							<form id="frmList" name="frmList" method ="get" action="inquiry.jsp">
								<input type="hidden" name="page" />
								<input type="hidden" name="status" />
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
																<th width="620px">제목</th>
																<th width="100px">작성자</th>
																<th width="100px">작성일</th>
																<th width="100px">답변상태</th>
															</tr>
														</thead>
														<tbody>
															<%
															for (InquiryDto inq : inquiryList) {
																String answerStatus = null;
																String cl = null;
																if("Y".equals(inq.getAnswerStatus())) {
																	answerStatus = "답변완료";
																	cl = "seccess";
																} else if ("N".equals(inq.getAnswerStatus())) {
																	answerStatus = "답변대기";
																	cl = "Nonseccess";
																}
															%>
															<tr>
																<td width="50" nowrap="" align="center"><b> <a
																		href="detail.jsp?no=<%=inq.getNo()%>&page=<%=pagination.getCurrentPage()%>"><%=inq.getTitle()%></a></b></td>
																<td width="50" nowrap="" align="center"><b><%=inq.getUserName()%></b></td>
																<td width="100" nowrap="" align="center" class="eng2"><%=inq.getCreatedDate()%></td>
																<td class=<%=cl%> width="30" nowrap="" align="center" class="eng2"><%=answerStatus%></td>
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
								<table width="100%">
									<tbody>
										<tr>
											<td align="right"><a href="/marketbooks/board/form.jsp">
													<span class="bhs_button yb" style="float: none;">문의하기</span>
											</a></td>
										</tr>
									</tbody>
								</table>
								<div class="layout-pagination">
									<div class="pagediv">
										<a href="javascript:clickPageNo(<%=pagination.getCurrentPage() - 1%>)"
											class="layout-pagination-button layout-pagination-prev-page">
										</a>
										<%
										for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
										%>
										<a href="javascript:clickPageNo(<%=num%>)"
											class="layout-pagination-button layout-pagination-number <%=pagination.getCurrentPage() == num ? "__active" : ""%>"><%=num %>
										</a>
										<%
										}
										%>
										<a href="javascript:clickPageNo(<%=pagination.getCurrentPage() + 1%>)"
											class="layout-pagination-button layout-pagination-next-page">
										</a>
									</div>
								</div>
								

							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
.seccess {
	color: #5f0080;
	font-weight: bold;
}
</style>	
<!-- footer include -->
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
<script>
function changeStatus() {
	document.querySelector("input[name=page]").value =1;
	document.querySelector("input[name=status]").value = document.querySelector("select[name=status]").value;
	document.getElementById("frmList").submit();
}

function clickPageNo(pageNo) {
	document.querySelector("input[name=page]").value = pageNo;
	document.querySelector("input[name=status]").value = document.querySelector("select[name=status]").value;
	document.getElementById("frmList").submit();
}
</script>
</html>