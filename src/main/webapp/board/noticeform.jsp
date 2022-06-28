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
<link rel="stylesheet" href="../css/home.css">
</head>

<body>
<!-- header -->
	<div id="header">
		<jsp:include page="../common/header.jsp">
			<jsp:param name="menu" value="noticeform" />
		</jsp:include>
	</div>
<%
int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
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
							<form method="post" 
							action="notice.jsp"
							onsubmit="return submitBoardForm()">
								<table class="boardView" width="100%" align="center" cellpadding="0"
									cellspacing="0">
									<tbody>
										<tr>
											<th scope="row" style="border: none;">제목</th>
											<td>
											<input type="text" name="title" style="width:100%; border:0; outline:none;"/>
											</td>
										</tr>
										<tr>
											<th scope="row">작성자</th>
											<td>MarketKurly</td>
										</tr>
										<tr>
											<th scope="row" style="border: none;">내용</th>
											<td>
											<textarea rows="10" class="form-control" name="content" style="width:100%; border:0; outline:none;"></textarea>
											</td>
										</tr>
										
									</tbody>
								</table>
								<a href=list.jsp?page=<%=currentPage %> class="bhs_button yb" style="float:center; margin-left:30px;">취소</span></a>
								<input type="submit" class="bhs_button yb" style="float:center; margin-left:30px;" value="등록">
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
<!-- footer include -->
<jsp:include page="../common/footer.jsp"></jsp:include>
</html>