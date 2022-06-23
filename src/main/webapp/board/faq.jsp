<%@page import="vo.Inquiry"%>
<%@page import="dao.InquiryDao"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
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
									<li class="on"><a href="/marketbooks/board/faq.jsp">자주하는
											질문</a></li>
									<li><a href=/marketbooks/board/inquiry.jsp>1:1 문의</a></li>
								</ul>
							</div>
							<a href="/marketbooks/board/form.jsp" class="link_inquire"><span
								class="emph">도움이 필요하신가요 ?</span> 1:1 문의하기</a>
						</div>
						<div class="page_section">
							<div class="head_aticle">
								<h2 class="tit">
									자주하는 질문 <span class="tit_sub">고객님들께서 가장 자주하시는 질문을 모두
										모았습니다.</span>
								</h2>
							</div>
							<form name="frmList" action="" onsubmit="">
								<input type="hidden" name="id" value="notice">
								<table width="100%" align="center" cellpadding="0"
									cellspacing="0">
									<tbody>
										<tr>
											<td>
												<div
													class="xans-element- xans-myshop xans-myshop-couponserial ">
													<table width="100%" class="xans-board-listheader"
														cellpadding="0" cellspacing="0">
														<tbody>
															<tr>
																<th width="70" class="input-txt">번호</th>
																<th width="135" class="input_txt">카테고리</th>
																<th class="input_txt">제목</th>
															</tr>
														</tbody>
													</table>
													<div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_67">
																<tbody>
																	<tr>
																		<td width="70" align="center">129</td>
																		<td width="135" align="center">서비스 이용</td>
																		<td style="cursor: pointer">마켓컬리는 어떤 회사인가요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ About 마켓컬리<br> <br> 마켓컬리에서는 사람을
																				소중히 하는 마음으로, 산지에서 친환경 혹은 유기농 인증을 받은 제품들을 꼼꼼히 선택하여
																				판매합니다. <br> <br> 제품을 최대한 신선하게 배송해 드리기 위해,
																				<br> <br> 샛별배송지역은 밤 11시 전까지 주문하신 경우 다음날 아침
																				7시까지 (대구/부산/울산 샛별배송 지역은 밤 8시 전까지 주문하신 경우 다음날 아침 8시
																				까지), <br> <br> 택배지역은 밤 10시까지 주문한 경우 택배
																				시스템을 통해 다음날 밤 11시 전까지 제품을 배송해 드립니다.<br> <br>
																				또한 수령하신 제품에 문제가 발생할 경우를 대비해 고객만족보장제도를 운영하고 있으며, <br>
																				<br> 1:1 문의에 사진 (사진으로 확인할 수 있는 경우) 및 불편사항을 접수해
																				주시면 확인 후 환불, 교환도 드리고 있습니다. <br> <br> "우리가
																				곧 고객이다" 라는 신념으로 좋은 제품을 선택하고 검수하며,<br> <br>
																				문제 발생 시 고객님의 편에서 조치를 드리고 있으니, 안심하고 이용해 주시기 바랍니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_166">
																<tbody>
																	<tr>
																		<td width="70" align="center">128</td>
																		<td width="135" align="center">취소/교환/환불</td>
																		<td style="cursor: pointer">교환(반품) 진행 시, 배송비가 부과
																			되나요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 교환(반품) 진행 시, 배송비 안내<br> <br> <br>
																				- 단순변심에 의한 교환/반품 시 배송비 6,000원 (주문건 배송비를 낸 경우
																				3,000원)을 고객님께서 부담하셔야합니다. <br> <br> <br>
																				▶ 가공식품 및 일부 비식품류에 한해서만 반품 가능<br> <br> ①
																				상품에 이상이 없거나 상품의 특성적인 부분인 경우<br> <br> ② 단순
																				변심에 의해 교환 및 반품하는 경우<br> <br> ③ 옵션 및 상품을 잘못
																				선택하여 잘못 주문했을 경우<br> <br> <br> ▶ 판매자
																				과실 등 상품에 문제로 인해 교환 시 판매자 부담<br> <br> ① 수령한
																				상품이 불량인 경우<br> <br> ② 수령한 상품이 파손된 경우 <br>
																				<br> ③ 상품이 상품상세정보와 다른 경우<br> <br> ④
																				주문한 상품과 다른 상품이 배송된 경우 등
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_168">
																<tbody>
																	<tr>
																		<td width="70" align="center">127</td>
																		<td width="135" align="center">선물하기</td>
																		<td style="cursor: pointer">PC에서 선물하기 주문을 할 수는
																			없나요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 선물하기 주문 : 오직 모바일 어플(APP) 에서만 가능<br> <br>
																				- 현재 기준으로 선물하기 주문은 PC에서 불가합니다.<br> <br> -
																				오로지 모바일 어플(APP)을 통해서만 주문 가능한 점 양해 부탁드립니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_199">
																<tbody>
																	<tr>
																		<td width="70" align="center">126</td>
																		<td width="135" align="center">배송/포장</td>
																		<td style="cursor: pointer">종이포장재 회수는 어떻게 요청하나요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 종이 포장재 회수 안내<br> <br> - 대상지역 :
																				수도권 샛별배송 지역<br> <br> - 회수대상 : 종이박스 (1회 최대
																				3개)<br> <br> * 기타 종이소재 포장재( 완충재, 종이봉투,
																				종이테이프등) 및 아이스팩은 미회수<br> <br> - 회수방법 : <br>
																				<br> ① 상품 수령 후 박스에서 송장 제거<br> <br> ②
																				새로운 주문 완료 후, 박스를 펼쳐 자택 문앞 놓아두기<br> <br> ③
																				새로운 주문이 배송 됨과 동시에 배송 기사님께서 종이박스를 회수 진행<br> <br>
																				<br> [참고]<br> <br> ▣ 송장이 붙어있는 경우 소중한
																				개인정보 보호를 위해 수거되지 않습니다.<br> <br> ▣ 간혹, 배송
																				매니저님들께서 깜빡하고 회수를 잊으시거나 <br> <br> 부득이하게 회수가
																				어려운 경우 회수가 누락 될 수 있습니다. 고객님의 너그러운 양해 부탁 드립니다.<br>
																				<br> ▣ 만일, 다음 배송시까지 보관이 어려우신 경우에는 직접 재활용 폐기를
																				부탁드리며 <br> <br> 추후에는 매니저님께서 꼭 회수하실 수 있도록
																				당부드리겠습니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_213">
																<tbody>
																	<tr>
																		<td width="70" align="center">125</td>
																		<td width="135" align="center">이벤트/쿠폰/적립금</td>
																		<td style="cursor: pointer">제세공과금이 무엇인가요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 제세공과금<br> <br> - 이벤트 참여 후 경품 등에
																				당첨되신 경우, 기타 소득이 발생 된 것으로 간주하여 국가에서 세금을 부과하고 있습니다.<br>
																				- 5만원 초과 경품의 한하여 경품가 22% 대하여 신고 및 납부가 필요합니다. <br>
																				<br> [참고]<br> ▣ 이벤트 별로 제세공과금을 당사에서 부담하기도
																				하며, 이에 대해 동의 확인차 경품 지급 전으로 별도 개인정보를 수집하는 점 참고
																				부탁드립니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_226">
																<tbody>
																	<tr>
																		<td width="70" align="center">124</td>
																		<td width="135" align="center">셀프픽업</td>
																		<td style="cursor: pointer">셀프픽업 서비스는 무엇인가요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 셀프픽업 <br> <br> - 셀프픽업 서비스는 컬리에서
																				상품을 구매(결제)한 후, 고객님께서 직접 지정한 매장에 방문하여 상품을 픽업하는 형태의
																				서비스 입니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_229">
																<tbody>
																	<tr>
																		<td width="70" align="center">123</td>
																		<td width="135" align="center">주문/결제/대량주문</td>
																		<td style="cursor: pointer">구매 영수증은 어떻게 발급 받나요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 구매 영수증 출력<br> <br> - 구매 직 후, 해당
																				주문서의 맨 아래에 [영수증 출력] 버튼을 클릭합니다. ( 마이컬리&gt;주문내역&gt;영수증
																				출력 )<br> <br> - 토스페이먼츠의 결제내역 확인 페이지에서 결제하신
																				수단의 카테고리를 클릭합니다.<br> <br> ( 신용·체크 카드 /
																				계좌이체 / 가상계좌 / 휴대폰 )<br> <br> - 각 결제수단별 조회
																				조건을 입력하신 후, [동의 후 조회하기] 버튼을 클릭합니다.<br> <br>
																				- 조회 된 영수증을 출력합니다.<br> <br> <br> [참고]<br>
																				<br> ▣ 간편결제 서비스를 이용하여 구매하실 경우에는 해당 결제사를 통해서 영수증
																				발급이 가능합니다.<br> <br> ▣카드승인 번호는 각 카드사를 통해서
																				조회하실 수 있습니다.<br> <br> ▣ [영수증 출력] 버튼이 보이지
																				않을 경우 컬리 카카오톡 고객센터로 문의 부탁드립니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_230">
																<tbody>
																	<tr>
																		<td width="70" align="center">122</td>
																		<td width="135" align="center">상품</td>
																		<td style="cursor: pointer">컬리패스 주문내역은 어디서 확인하나요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 컬리패스 주문(결제)내역 확인 가능 경로<br> <br>
																				- 웹 : 마이컬리 &gt; 컬리패스 &gt; 결제내역 확인<br> <br>
																				- 앱 : 마이컬리 &gt; 컬리패스 &gt; 결제내역
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_231">
																<tbody>
																	<tr>
																		<td width="70" align="center">121</td>
																		<td width="135" align="center">회원</td>
																		<td style="cursor: pointer">개명을 하여 회원정보의 이름을 바꾸고
																			싶습니다.</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 개명으로 인한 회원정보 수정 방법<br> <br> -
																				개명하신 경우, 컬리홈 로그인 후 [마이컬리]에서 수정하실 수 있습니다.<br> <br>
																				- [마이컬리 &gt; 개인정보 수정 &gt; 재로그인 &gt; 이름 변경]<br>
																				<br> <br> [참고]<br> <br> ▣ 아이디는
																				변경이 불가합니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_7">
																<tbody>
																	<tr>
																		<td width="70" align="center">120</td>
																		<td width="135" align="center">회원</td>
																		<td style="cursor: pointer">아이디, 비밀번호를 잊어버렸습니다.</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 아이디, 비밀번호 찾기 안내<br> <br> <br>
																				- 하기 경로를 통해 아이디 및 비밀번호 찾기가 가능하며, 임시 비밀번호의 경우 회원가입 시
																				등록한 이메일 주소로 발송 됩니다.<br> <br> <br>
																				(PC) 컬리홈 상단 [로그인] &gt; 화면 아래 [아이디 찾기] [비밀번호 찾기]<br>
																				<br> (모바일) 아래 탭에서 [마이컬리] &gt; 로그인 화면 아래 [아이디
																				찾기] [비밀번호 찾기]<br> <br> <br> [참고]<br>
																				<br> ▣ 가입시 기재한 메일 주소가 기억나지 않으시거나 오류가 발생하는 경우
																				고객센터로 문의 바랍니다.<br> <br> ▣ 상담시에는 고객님의
																				개인정보보호를 위해 기존에 사용하시던 비밀번호는 안내가 불가하며, 개인정보 확인 후
																				임시비밀번호를 설정해드립니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_27">
																<tbody>
																	<tr>
																		<td width="70" align="center">119</td>
																		<td width="135" align="center">서비스 이용</td>
																		<td style="cursor: pointer">상품 후기는 어떻게 작성하나요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 상품 후기 작성 방법<br> <br> <br> -
																				배송완료일로부터 30일 동안 상품 후기를 작성하실 수 있습니다.<br> <br>
																				( 30일 경과 시, 후기작성이 불가합니다. )<br> <br> <br>
																				(PC) 나의 주문내역 &gt; 해당 주문 건 &gt; 후기작성 혹은 주문하신 상품상세
																				&gt; 상품후기 &gt; 상품후기 작성<br> <br> (모바일) 마이컬리
																				&gt; 상품 후기 혹은 주문하신 상품상세 &gt; 상품후기 &gt; 상품후기 작성<br>
																				<br> <br> [참고]<br> <br> ▣
																				교환/환불/배송/쿠폰사용 등에 대한 문의는 고객센터로 문의 남겨주시면 신속히 도움드리겠습니다.<br>
																				<br> ▣ 근거없는 비망 및 욕설이 기재되어 있을 경우 삭제됩니다. <br>
																				<br> ▣ 타인의 주관적인 의견으로 인하여 상품의 기능이나 효과 등에 오해가 있을
																				수 있는 상품후기는 삭제될 수 있습니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_45">
																<tbody>
																	<tr>
																		<td width="70" align="center">118</td>
																		<td width="135" align="center">이벤트/쿠폰/적립금</td>
																		<td style="cursor: pointer">적립금은 어떻게 누적하나요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 적립금 누적 방법 안내<br> <br> <br>
																				- 적립금은 컬리 회원 대상으로 주어지는 혜택입니다.<br> <br> -
																				주문 결제 / 후기 작성 / 이벤트 참여 등으로 누적 할 수 있습니다.<br> <br>
																				<br> [참고]<br> <br> ▣ 1원 단위부터 주문서에서 사용
																				가능 합니다.<br> <br> ▣ 일부 상품의 경우 적립금 미지급품목이므로
																				구매 시 참고 바랍니다.
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_156">
																<tbody>
																	<tr>
																		<td width="70" align="center">117</td>
																		<td width="135" align="center">상품</td>
																		<td style="cursor: pointer">친환경/유기농/무농약이 어떻게
																			다른가요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 친환경 인증이란?<br> <br> <br> 친환경
																				농산물은 인체와 생태환경에 해로운 화학비료, 농약, 제초제 등을 최대한 사용하지 않고 재매한
																				농산물을 일컬으며 이 중, 화학비료와 농약 사용량에 따라 저농약, 무농약, 유기농으로
																				구분됩니다.<br> <br> <br> - 저농약 : 일반 농산물
																				대비 적은 양의 농약을 사용한 농산물<br> <br> - 무농약 : 농약은
																				사용하지 않되, 화학비료를 사용한 농산물<br> <br> - 유기농 :
																				화학비료와 농약을 일체 사용하지 않고 재배한 농산물<br> <br> <br>
																				[참고]<br> <br> ▣ 인증서와 관련 된 다양한 정보는 아래 경로로
																				상세히 확인 할 수 있습니다.<br> <br> (웹) 컬리홈 &gt; 메인
																				페이지 맨 마지막 하단 &gt; "컬리소개" 클릭 &gt; "1. 컬리의 품질기준" 조회<br>
																				<br> (모바일) 컬리APP &gt; 하단 오른쪽 마이컬리 &gt; "컬리소개"
																				클릭 &gt; "1. 컬리의 품질기준" 조회
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_165">
																<tbody>
																	<tr>
																		<td width="70" align="center">116</td>
																		<td width="135" align="center">취소/교환/환불</td>
																		<td style="cursor: pointer">교환(반품) 어떻게 진행 되나요?</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 교환(반품) 진행 방법<br> <br> <br>
																				- 받으신 상품을 교환(반품) 하실 경우, 교환 사유+문제가 발생한 부분을 확인할 수 있는
																				사진과 함께 고객센터로 문의 바랍니다. <br> <br> - 상담사를 통한
																				상담 이 후, 교환(반품) 절차가 진행 됩니다.<br> <br> (PC)
																				홈페이지 상단 고객센터 &gt; 1:1 문의 또는 홈페이지 하단 1:1문의<br> <br>
																				(모바일) 마이컬리 &gt; 1:1 문의 또는 마이컬리 &gt; 고객센터 &gt; 1:1 문의
																				또는 카카오톡 문의
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div>
															<table width="100%" class="table_faq"
																onclick="view_content(this)" id="faq_169">
																<tbody>
																	<tr>
																		<td width="70" align="center">115</td>
																		<td width="135" align="center">선물하기</td>
																		<td style="cursor: pointer">선물하기 주문을 취소하고 싶어요</td>
																	</tr>
																</tbody>
															</table>
															<div
																style="display: none; padding: 30px; border-top: 1px solid #e6e6e6">
																<table cellpadding="0" cellspacing="0" border="0">
																	<tbody>
																		<tr valign="top">
																			<th
																				style="color: #0000bf; width: 40px; padding-top: 1px;"></th>
																			<td>■ 선물하기 주문 취소 방법 <br> <br> - 선물
																				수락대기 : 주문자 직접 취소 가능 ( 경로 : 마이컬리-선물내역 )<br> <br>
																				[참고] <br> <br> ▣ 배송지 입력 후 주문 취소가 필요하시다면
																				마켓컬리 고객행복센터 카카오톡으로 문의해주세요. <br> <br> 다만,
																				상품 포장이 시작되었다면 취소가 어려울 수 있는 점 양해 바랍니다
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
													</div>
													<div style="padding: 1px; border-top: 1px solid #e6e6e6"></div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>

								<div class="layout-pagination">
									<div class="pagediv">
										<a href="list.php?id=notice&amp;page=1"
											class="layout-pagination-button layout-pagination-first-page">맨
											처음 페이지로 가기</a> <a href="list.php?id=notice&amp;page=1"
											class="layout-pagination-button layout-pagination-prev-page">이전
											페이지로 가기</a> <strong
											class="layout-pagination-button layout-pagination-number __active">1</strong>
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

	<script>
		var preContent;

		function view_content(obj) {
			var div = obj.parentNode;

			for (var i = 1, m = div.childNodes.length; i < m; i++) {
				if (div.childNodes[i].nodeType != 1)
					continue; // text node.
				else if (obj == div.childNodes[i])
					continue;

				obj = div.childNodes[i];
				break;
			}

			if (preContent && obj != preContent) {
				obj.style.display = "block";
				preContent.style.display = "none";
			} else if (preContent && obj == preContent)
				preContent.style.display = (preContent.style.display == "none" ? "block"
						: "none");
			else if (preContent == null)
				obj.style.display = "block";

			preContent = obj;
		}

		{ // 초기출력
			var no = "faq_";
			if (document.getElementById(no))
				view_content(document.getElementById(no));
		}
	</script>


</body>
</html>

