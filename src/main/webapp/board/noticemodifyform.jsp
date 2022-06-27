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
int noticeNo = Integer.parseInt(request.getParameter("no"));
int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);

NoticeDao noticeDao = NoticeDao.getInstance();
Notice notice = noticeDao.getNoticeByNo(noticeNo);

%>
	<div id="wrap">
		<div id="container">
			<div id="header">
				<div class="tit_page">
					<h2 class="tit">공지사항</h2>
					<p class="sub">공지사항 글을 작성하세요.</p>
				</div>
			</div>
			<div id="main">
				<div id="content">
					<div class="layout-wrapper">
						<div class="xans-element- xans-myshop xans-myshop-couponserial ">
								<form name="frmList" method="post" action="noticemodify.jsp"
								onsubmit="return submitBoardForm()">
								<input type="hidden" name="no" value="<%=notice.getNo()%>"/>
								<input type="hidden" name="page" value="<%=currentPage%>"/>
								<table class="boardView" width="100%" align="center" cellpadding="0"
									cellspacing="0">
									<tbody>
										<tr>
											<th scope="row" style="border: none;">제목</th>
											<td><input type="text" name="title" style="width:100%; border:0; outline:none;" value="<%=notice.getTitle()%>"/></td>
										</tr>
										<tr>
											<th scope="row">작성자</th>
											<td>MarketKurly</td>
										</tr>
										<tr>
											<th scope="row" style="border: none;">내용</th>
											<td><textarea rows="10" class="form-control" name="content" style="width:100%; border:0; outline:none;"><%=notice.getContent() %></textarea></td>
										</tr>
										
									</tbody>
								</table>
											<a href="view.jsp?no=<%=notice.getNo()%>&page=<%=currentPage%>" class="bhs_button yb" style="float:center; margin-left:30px;">취소</span></a>
											<button class="bhs_button yb" type="submit" style="float:center; margin-left:30px;">등록</button>
						</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	
	function submitBoardForm() {
		let titleField = document.querySelector("input[name=title]");
		if (titleField.value === '') {
			alert("제목은 필수입력값입니다.");
			titleField.focus();
			return false;
		}
		let contentField = document.querySelector("textarea[name=content]");
		if (contentField.value === '') {
			alert("내용은 필수입력값입니다.");
			contentField.focus();
			return false;
		}
		return true;
	}
	</script>
</body>
</html>