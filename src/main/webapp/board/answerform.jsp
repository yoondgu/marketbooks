<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
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
<link rel="stylesheet" href="../css/board.css">
<link rel="stylesheet" href="../css/home.css">
</head>
<%  User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("새 게시글 작성은 로그인 후 사용가능한 서비스입니다.");
	}
%>
<body class="board-list">
<!-- header -->
	<div id="header">
		<jsp:include page="../common/header.jsp">
			<jsp:param name="menu" value="answer" />
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
									<li class="on"><a href="/marketbooks/board/inquiry.jsp">1:1
											문의</a></li>
								</ul>
							</div>
							<a href="/marketbooks/board/form.jsp" class="link_inquire"><span
								class="emph">도움이 필요하신가요 ?</span> 1:1 문의하기</a>
						</div>
						<div class="page_section">
							<!--
							요청파라미터에서 게시글 번호를 조회하고, 게시글 번호에 맞는 글 정보를 조회해서 출력한다.
						-->
							<%
							// 요청파라미터에서 게시글 번호를 조회한다.
							int inquiryNo = StringUtil.stringToInt(request.getParameter("no"));
							int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
							
							InquiryDao inquiryDao = InquiryDao.getInstance();
							// 게시글 번호에 해당하는 게시글 정보를 조회한다.
							InquiryDto inquiry = inquiryDao.getInquiryByNo(inquiryNo);
							if (inquiry == null) {
								throw new RuntimeException("게시글 정보가 존재하지 않습니다.");
							}
							
							// 미구현 조회수 증가시키기
							// inquiry.setViewCount(inquiry.getViewCount() + 1);
							// inquiry.updateBoard(board);
							
							// 미구현 이 게시글를 추천한 사용자명 조회하기
							// List<String> userNames = inquiryDao.getLikeUserNames(inquiryNo);
							
						%>
						<style>
						  table {
						    width: 100%;
						    border: 1px solid #f4f4f4;
						    border-collapse: collapse;
						  }
						  tr, th, td {
						    border: 1px solid #f4f4f4;
						    padding: 20px;
						  	vertical-align: middle;
						  }
						  .content {
						  	height: 200px;
						  }
						  
						  .btn {
						  	background-color:#5f0080;
						  	color:#f7f7f7;
						  }
						</style>
							<div class="head_aticle">
								<h2 class="tit">1:1 문의</h2>
							</div>
									<table class="table">
									<colgroup>
										<col width="15%">
										<col width="85%">
									</colgroup>
									<tbody>
										<tr>
											<th class="table-light text-center">작성자</th>
											<td><%=inquiry.getUserName()%></td>
										</tr>
										<tr>
											<th class="table-light text-center">등록일</th>
											<td><%=inquiry.getCreatedDate()%></td>
										</tr>
										<tr>
											<th class="table-light text-center">제목</th>
											<td><%=inquiry.getTitle()%></td>
										</tr>
										<tr>
											<th class="table-light text-center content">내용</th>
											<td><%=inquiry.getHtmlContent()%></td>
										</tr>
									</tbody>
									</table>
									
								<form name="frmList" class="g-3 border bg-light mx-1 " method="post"
									method="post" action="answer.jsp"
									onsubmit="return submitBoardForm()"
									style="border-radius: 8px;">
									<input type="hidden" name="no" value="<%=inquiry.getNo() %>" />
									<input type="hidden" name="page" value="<%=currentPage %>" />
									<div class="col-12">
										<label class="form-label" style="font-size: 16px; margin:5px;">답변내용</label>
										<textarea rows="10" class="form-control" name="answerContent"></textarea>
									</div>
									
									<div style="margin:0px 0px 0px 250px;">
									<button class="bhs_button yb" type="submit" style="float: none;">등록</button>
									<a href="detail.jsp?no=<%=inquiry.getNo()%>&page=<%=currentPage%>" class="bhs_button yb" style="float: none; margin-left:30px;">취소</span></a>
									</div>
										
									
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
</html>