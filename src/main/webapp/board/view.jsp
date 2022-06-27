<%@page import="vo.Notice"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.NoticeDao"%>
<%@page import="vo.User"%>
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
</head>

<body>
				<%
				NoticeDao noticeDao = NoticeDao.getInstance();

				int noticeNo = StringUtil.stringToInt(request.getParameter("no"));
				int nextNoticeNo = noticeNo + 1;
				int beforeNoticeNo = noticeNo - 1;
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
			
				// no를 받아 notice 정보 조회
				Notice notice = noticeDao.getNoticeByNo(noticeNo);
				Notice nextNotice = noticeDao.getNoticeByNo(nextNoticeNo);
				Notice beforeNotice = noticeDao.getNoticeByNo(beforeNoticeNo);
				
				// 조회수 증가시키기
				notice.setViewCount(notice.getViewCount() + 1);
				noticeDao.updateNotice(notice);
				
				%>
				
	<div id="wrap">
		<div id="container">
			<div id="header">
				<div class="tit_page">
					<h2 class="tit">공지사항</h2>
					<p class="sub">컬리의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요.</p>
				</div>
			</div>
			<div id="main">
				<div id="content">
					<div class="layout-wrapper">
						<div class="xans-element- xans-myshop xans-myshop-couponserial ">
							<table width="100%" align="center" cellpadding="0"
								cellspacing="0">
								<tbody>
									<tr>
										<td>
											<table width="100%">
												<tbody>
													<tr>
														<td>
															<table class="boardView" width="100%">
																<tbody>
																	<tr>
																		<th scope="row" style="border: none;">제목</th>
																		<td><%=notice.getTitle() %></td>
																	</tr>
																	<tr>
																		<th scope="row">작성자</th>
																		<td>MarketKurly</td>
																	</tr>
																	<tr class="etcArea">
																		<td colspan="2">
																			<ul>
																				<li class="date "><strong class="th">작성일</strong>
																					<span class="td"><%=notice.getCreatedDate() %></span></li>
																				<li class="hit "><strong class="th">조회수</strong>
																					<span class="td"><%=notice.getViewCount() %></span></li>
																			</ul>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
													<tr>
														<td align="right" class="eng" style="padding: 5px;"></td>
													</tr>
													<tr>
														<td style="padding: 10px;" height="200" valign="top"
															id="contents">
															<table width="100%" style="table-layout: fixed">
																<tbody>
																	<tr>
																		<td class="board_view_content"
																			style="word-wrap: break-word; word-break: break-all"
																			id="contents_1650" valign="top">
																			<%=notice.getContent() %>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
													<tr>
														<td height="1" bgcolor="#f4f4f4"></td>
													</tr>
												</tbody>
											</table>
											<br>
											<table width="100%" style="table-layout: fixed"
												cellpadding="0" cellspacing="0">
												<tbody>
													<tr>
														<td align="center" style="padding-top: 10px;">
															<table width="100%">
																<tbody>
																	<tr scope="rows">
																	<%
																		User user = null;
																	
																		if ((user = (User) session.getAttribute("LOGINED_USER")) != null) {
																			if("admin@gmail.com".equals(user.getEmail())) {
																	%>
																		<td align="left"><a href="noticemodifyform.jsp?no=<%=notice.getNo()%>&page=<%=currentPage%>">
																				<span class="bhs_button yb" style="float: left;">수정</span>
																		</a><a href="noticedelete.jsp?no=<%=notice.getNo()%>&page=<%=currentPage%>">
																				<span class="bhs_button yb" style="float: none; margin-left:10px;">삭제</span>
																		</a></td>
																	<%
																			}
																		} else {
																	%>
																	<%
																		}
																	%>
																		<td align="right"><a href="list.jsp?page=<%=currentPage %>">
																				<span class="bhs_button yb" style="float: right;">목록</span>
																		</a></td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
												</tbody>
											</table>
											<div
												class="xans-element- xans-board xans-board-movement-1002 xans-board-movement xans-board-1002 ">
												<ul>
												<% 
												 if (nextNotice != null) {
												%>
													<li class="prev "><strong>이전글</strong><a
														href="view.jsp?no=<%=nextNotice.getNo()%>"><%=nextNotice.getTitle()%></a></li>
												<%
												 }
												%>
												<%
												 if (beforeNotice != null) {
												%>
													<li class="next "><strong>다음글</strong><a
														href="view.jsp?no=<%=beforeNotice.getNo()%>"><%=beforeNotice.getTitle() %></a></li>
												<%
												 }
												%>
												</ul>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>