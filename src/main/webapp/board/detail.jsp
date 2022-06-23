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
</head>
<%  User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("새 게시글 작성은 로그인 후 사용가능한 서비스입니다.");
	}
%>
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
								<form name="frmList" class="row"
									method="post" action="add.jsp" enctype="multipart/form-data"
									onsubmit="return submitBoardForm()">
								
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
								</form>
								<div class="row">
									<div class="col">
										<!--  
											비로그인 상태일 때 아래 버튼은 전부 비활성화한다.
											수정/삭제 버튼은 작성자의 사용자번호와 로그인한 사용자의 사용자 번호가 동일할 때만 활성화한다.
											추천 버튼은 작성자의 사용자번호와 로그인한 사용자의 사용자 번호가 다를 때만 활성화한다.
											로그인한 사용자가 이 게시글에 대해서 좋아요를 등록한 경우 추천 버튼을 비활성화한다. 
										-->
									<%
									
										// 수정/삭제버튼 비활성화 여부
										boolean isDisabled = true;
										
										// 로그인된 사용자정보가 존재하고, 글의 작성자 번호와 로그인한 사용자 번호가 일치하면 수정/삭제버튼 활성화한다.
										if (user != null && inquiry.getUserNo() == user.getNo()) {
											isDisabled = false;
										}
										
									%>
										<a href="modifyform.jsp?no=<%=inquiryNo %>&page=<%=currentPage %>" class="btn"  <%=isDisabled ? "disabled" : "" %>">수정</a>
										<a href="delete.jsp?no=<%=inquiryNo %>&page=<%=currentPage %>" class="btn"  <%=isDisabled ? "disabled" : "" %>">삭제</a>
									</div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
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