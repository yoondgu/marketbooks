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
															<tr>
																<td width="50" nowrap="" align="center">공지</td>
																<td
																	style="padding-left: 10px; text-align: left; color: #999">
																	<a href="view.php?id=notice&amp;no=1591"><b>[마켓컬리]
																			KURLY BIRTH WEEK 럭키기프트 이벤트 당첨 안내</b></a><b> </b>
																</td>
																<td width="100" nowrap="" align="center">
																	MarketKurly</td>
																<td width="100" nowrap="" align="center" class="eng2">2022-05-23</td>
																<td width="30" nowrap="" align="center" class="eng2">7784</td>
															</tr>
															<tr>
																<td width="50" nowrap="" align="center">공지</td>
																<td
																	style="padding-left: 10px; text-align: left; color: #999">
																	<a href="view.php?id=notice&amp;no=64"><b>마켓컬리
																			배송 안내</b></a><b> </b>
																</td>
																<td width="100" nowrap="" align="center">
																	MarketKurly</td>
																<td width="100" nowrap="" align="center" class="eng2">2016-01-08</td>
																<td width="30" nowrap="" align="center" class="eng2">3173223</td>
															</tr>
															<tr>
																<td width="50" nowrap="" align="center">공지</td>
																<td
																	style="padding-left: 10px; text-align: left; color: #999">
																	<a href="view.php?id=notice&amp;no=931"><b>[마켓컬리]
																			포장재 회수 서비스 안내</b></a><b> </b>
																</td>
																<td width="100" nowrap="" align="center">
																	MarketKurly</td>
																<td width="100" nowrap="" align="center" class="eng2">2021-06-18</td>
																<td width="30" nowrap="" align="center" class="eng2">49407</td>
															</tr>
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
											class="layout-pagination-button layout-pagination-first-page">맨
											처음 페이지로 가기</a> 
										<a href="list.php?id=notice&amp;page=1"
											class="layout-pagination-button layout-pagination-prev-page">이전
											페이지로 가기</a> 
										<strong class="layout-pagination-button layout-pagination-number __active">1</strong>
										<a href="list.php?id=notice&amp;page=2"
											class="layout-pagination-button layout-pagination-number">2</a>
										<a href="list.php?id=notice&amp;page=3"
											class="layout-pagination-button layout-pagination-number">3</a>
										<a href="list.php?id=notice&amp;page=4"
											class="layout-pagination-button layout-pagination-number">4</a>
										<a href="list.php?id=notice&amp;page=5"
											class="layout-pagination-button layout-pagination-number">5</a>
										<a href="list.php?id=notice&amp;page=6"
											class="layout-pagination-button layout-pagination-number">6</a>
										<a href="list.php?id=notice&amp;page=7"
											class="layout-pagination-button layout-pagination-number">7</a>
										<a href="list.php?id=notice&amp;page=8"
											class="layout-pagination-button layout-pagination-number">8</a>
										<a href="list.php?id=notice&amp;page=9"
											class="layout-pagination-button layout-pagination-number">9</a>
										<a href="list.php?id=notice&amp;page=10"
											class="layout-pagination-button layout-pagination-number">10</a>
										<a href="list.php?id=notice&amp;page=2"
											class="layout-pagination-button layout-pagination-next-page">다음
											페이지로 가기</a> <a href="list.php?id=notice&amp;page=145"
											class="layout-pagination-button layout-pagination-last-page">맨
											끝 페이지로 가기</a>
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
</html>

