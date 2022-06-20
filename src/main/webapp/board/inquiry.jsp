<%@page import="dto.inquiryDto"%>
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
<link rel="stylesheet" href="../css/board.css">
</head>
<body class="board-list">
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
									<li class="on"><a href="/marketbooks/board/inquiry.jsp">1:1
											문의</a></li>
								</ul>
							</div>
							<a href="/mypage/inquiry/form" class="link_inquire"><span
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
														InquiryDao inquiryDao = InquiryDao.getInstance();
														List<inquiryDto> inquiryList = inquiryDao.getAllInquiries();
														
														System.out.println(inquiryList);
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
															for (inquiryDto inq : inquiryList) {
															%> 
															<tr>
																<td width="50" nowrap="" align="center"><b><a href="view.jsp?"><%=inq.getTitle()%></a></b></td>
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

										<a href="list.php?id=notice&amp;page=1"
											class="layout-pagination-button layout-pagination-prev-page">이전
											페이지로 가기</a> <a href="list.php?id=notice&amp;page=2"
											class="layout-pagination-button layout-pagination-next-page">다음
											페이지로 가기</a>

									</div>
								</div>

								<table width="100%">

									<tbody>
										<tr>
											<td align="right"><a href="inquiry/form"> <span
													class="bhs_button yb" style="float: none;">문의하기</span></a></td>
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
</html>