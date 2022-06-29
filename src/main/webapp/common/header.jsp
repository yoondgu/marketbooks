<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="header">

	<!-- 화면 최상단 가입이벤트문구(링크) -->
	<div class="bnr_header" id="top-message">
		<a href="" id="eventLanding">
			" 지금 가입하고 인기상품 "
			<b>100원</b>
			에 받아가세요!
			<img src="https://res.kurly.com/pc/ico/1908/ico_arrow_fff_84x84.png" class="bnr_arr">
		</a>
		<div class="bnr_top">
			<div class="inner_top_close">
				<button type="button" id="top-message-close" class="btn_top_bnr" onclick="bnrHeaderClose()">가입하고 혜택받기</button>
			</div>
		</div>
	</div>
	<!-- 유저 메뉴 -->
	<div class="row">
		<div id="userMenu">
			<ul class="list_menu">
					<% 
						User user = (User) session.getAttribute("LOGINED_USER");
						if (user != null) {
							if("admin@gmail.com".equals(user.getEmail())) {
					%>
						<li class="menu none_sub menu_login"><a href="/marketbooks/admin/home.jsp"
						class="link_menu"><strong>관리자 홈</strong></a></li>
					<%
							}
					%>
						<li class="menu lst"><a href="" class="link_menu"><%=user.getName() %>님</a>
							<ul class="sub">
								<li><a href="/marketbooks/mypage/orderlist.jsp" onclick="">주문 내역</a></li>
								<li><a href="/marketbooks/mypage/addressList.jsp" onclick="">선문 내역</a></li>
								<li><a href="" onclick="">찜한 상품</a></li>
								<li><a href="" onclick="">배송지 관리</a></li>
								<li><a href="" onclick="">상품 후기</a></li>
								<li><a href="" onclick="">상품 문의</a></li>
								<li><a href="" onclick="">적립금</a></li>
								<li><a href="" onclick="">쿠폰</a></li>
								<li><a href="" onclick="">개인 정보 수정</a></li>
								<li><a href="/marketbooks/logout.jsp" onclick="">로그아웃</a></li>
							</ul>
						</li>
						
						<li class="menu none_sub menu_login"><a href="/marketbooks/logout.jsp"
						class="link_menu">로그아웃</a></li>
					<% 
						} else if(user == null) {
					%>
						<li class="menu none_sub menu_join"><a href="registerform.jsp"
						class="link_menu">회원가입</a></li>
						<li class="menu none_sub menu_login"><a href="/marketbooks/loginform.jsp"
							class="link_menu">로그인</a></li>
					<%
						}
					%>
				<li class="menu lst"><a href="" class="link_menu">고객센터</a>
					<ul class="sub">
						<li><a href="/marketbooks/board/list.jsp" onclick="">공지사항</a></li>
						<li><a href="/marketbooks/board/faq.jsp" onclick="">자주하는 질문</a></li>
						<li><a href="/marketbooks/board/inquiry.jsp" onclick="">1:1 문의</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<!-- 헤더 로고 -->
	<div class="row">
		<div id="headerLogo" class="layout-wrapper">
			<h1 class="logo">
				<a href="http://localhost/marketbooks/home.jsp" class="link_main">
					<span id="gnbLogoContainer"></span> 
					<img src="/marketbooks/images/marketbooks-logo.png" class="img-thumbnail" style="border:0;">

				</a>
			</h1>

		<!-- 배송안내버튼 -->
		<!-- 
		<a href="" onclick="" class="bnr_delivery"> 
			<img src="https://res.kurly.com/pc/service/common/2011/delivery_210801.png"	alt="샛별, 택배 배송안내" width="121" height="22">
		</a> 		
		-->
		</div>
	</div>
	
	<!-- GROUP NAV BAR -->
	<div id="gnb" class="">
		<div class="fixed_container">
			<h2 class="screen_out">메뉴</h2>
			<div id="gnbMenu" class="gnb_mb">
				<div class="inner_gnb_mb">
					<div class="gnb_main">
					
						<!-- 카테고리 그룹 NAV -->
						<ul class="gnb">
					  		<li class="menu1">
								<a href="" class="">
									<span class="ico"></span>
									<span class="txt">전체 카테고리</span>
								</a>
								<ul class="gnb_sub">
									<li><span class="txt" onclick="location.href='/marketbooks/book/list.jsp?category=인문학'">인문학</span></li>
									<li><span class="txt" onclick="location.href='/marketbooks/book/list.jsp?category=사회과학'">사회과학</span></li>
									<li><span class="txt" onclick="location.href='/marketbooks/book/list.jsp?category=소설'">소설</span></li>
									<li><span class="txt" onclick="location.href='/marketbooks/book/list.jsp?category=역사'">역사</span></li>
									<li><span class="txt" onclick="location.href='/marketbooks/book/list.jsp?category=예술/대중문화'">예술/대중문화</span></li>
								</ul>
							</li>
							<li class="menu2">
							 	<a href="/marketbooks/book/new.jsp" class="link new ">
							 		<span class="txt">신작</span>
								</a>
							 </li>
							 <li class="menu3">
							 	<a href="/marketbooks/book/bestseller.jsp" class="link best ">
							 		<span class="txt">베스트셀러</span>
							 	</a>
					 		</li> 
							<li class="menu4">
							 	<a href="/marketbooks/book/frugalshopping.jsp" class="link bargain ">
							 		<span class="txt">알뜰쇼핑</span>
							 	</a>
						 	</li>
						 	<li class="lst">
						 		<a href="/marketbooks/book/specialBenefits.jsp" class="link event ">
						 			<span class="txt">특가/혜택</span>
					 			</a>
				 			</li>
			 			</ul>
			 			
			 			<!-- 검색창 -->
		 				<div id="side_search" class="gnb_search">
			 				<form action="/marketbooks/book/list.jsp?page=1" onsubmit="">
				 				<input name="keyword" type="text" value="" required="required" label="검색어" placeholder="검색어를 입력해주세요." autocomplete="off" class="inp_search">
				 				<input type="image" src="https://res.kurly.com/pc/service/common/1908/ico_search_x2.png" class="btn_search">
				 				<div class="init">
				 					<button type="button" id="searchInit" class="btn_delete">검색어 삭제하기</button>
			 					</div>
	 						</form>
						</div>
						
						<!-- 장바구니버튼 -->
						<div class="cart_count">
							<div class="inner_cartcount">
								<a href="/marketbooks/cart/list.jsp" class="btn_cart">							
									<span class="screen_out">장바구니</span>
									<span id="cart_item_count" class="num realtime_cartcount" style="display: none;"></span>
								</a>
							</div>
							<div id="addMsgCart" class="msg_cart">
								<span class="point"></span>
								<div class="inner_msgcart">
									<img src="https://res.kurly.com/images/common/bg_1_1.gif" alt="" class="thumb">
									<p id="msgReaddedItem" class="desc">
										<span class="tit"></span>
										<span class="txt">장바구니에 상품을 담았습니다.
											<span class="repeat">이미 담으신 상품이 있어 추가되었습니다.</span>
										</span>
									</p>
								</div>
							</div>
						</div>
						
						<!-- 배송지 설정 버튼 -->
						<div class="location_set">
							<button type="button" class="btn_location on">배송지 설정하기</button>
							<div class="layer_location">
								<div class="no_address">
									<span class="emph">배송지를 등록</span>
									하고<br> 구매 가능한 상품을 확인하세요! 
									<div class="group_button double">
										<button type="button" class="btn default login" style="padding:0px;" onclick="goLoginPage()">로그인</button>
										<button type="button" class="btn active searchAddress" style="padding:0px;">
											<span class="ico"></span>주소검색
										</button>
									</div>
								</div>
							</div>
						</div>

						<!-- 찜하기 버튼 -->
						<div class="gnbPick">
							<a href="" class="btn_pick">찜한 상품 보기</a>
						</div>
						
					</div>
										
				</div>
			</div>
		</div>
	</div>
</div>

<script>
function bnrHeaderClose() {
	let bnrRow = document.querySelector('#top-message');
	bnrRow.style.display='none';
}

function goLoginPage() {
	location.href="/marketbooks/loginform.jsp";
}
</script>