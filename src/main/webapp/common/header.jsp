<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="header">

	<!-- 화면 최상단 가입이벤트문구(링크) -->

	<div class="bnr_header" id="top-message">
		<a href="" id="eventLanding"> 지금 가입하고 인기상품 <b>100원</b>에 받아가세요!<img
			src="https://res.kurly.com/pc/ico/1908/ico_arrow_fff_84x84.png"
			class="bnr_arr">
			<div class="bnr_top">
				<div class="inner_top_close">
					<button id="top-message-close" class="btn_top_bnr">가입하고
						혜택받기</button>
				</div>
			</div>
		</a>
	</div>


	<!-- 유저 메뉴 -->
	<div class="row">
		<div id="userMenu">
			<ul class="list_menu">
				<li class="menu none_sub menu_join"><a href="registerform.jsp"
					class="link_menu">회원가입</a></li>
				<li class="menu none_sub menu_login"><a href="loginform.jsp"
					class="link_menu">로그인</a></li>
				<li class="menu lst"><a href="" class="link_menu">고객센터</a>
					<ul class="sub">
						<li><a href="#none" onclick="">공지사항</a></li>
						<li><a href="#none" onclick="">Q&A</a></li>
						<li><a href="#none" onclick="">자주하는 질문</a></li>
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
					<img src="/marketbooks/images/marketbooks-logo.png" class="img-thumbnail" style="width:103px; height:79px;">

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
			<div id="gnbMenu" class="gnb_kurly">
				<div class="inner_gnbkurly">
					<div class="gnb_main">
					
						<!-- 카테고리 그룹 NAV -->
						<ul class="gnb">					
					  		<li class="menu1">
								<a href="" class="">
									<span class="ico"></span>									
									<span class="txt">전체 카테고리</span>
								</a>
								<ul class="sub">
									<li><a href="#none" onclick="">인문학</a></li>
									<li><a href="#none" onclick="">사회과학</a></li>
									<li><a href="#none" onclick="">소설</a></li>
									<li><a href="#none" onclick="">역사</a></li>
									<li><a href="#none" onclick="">예술/대중문화</a></li>
								</ul>
							</li>							

							<li class="menu2">
							 	<a href="/marketbooks/book/newlist.jsp" class="link new ">
							 		<span class="txt">신상품</span>
								</a>
							 </li>
							 <li class="menu3">
							 	<a href="/marketbooks/book/bestseller.jsp" class="link best ">
							 		<span class="txt">베스트셀러</span>
							 	</a>
					 		</li> 
							<li class="menu4">
							 	<a href="" class="link bargain ">
							 		<span class="txt">알뜰쇼핑</span>
							 	</a>
						 	</li>
						 	<li class="lst">
						 		<a href="" class="link event ">
						 			<span class="txt">특가/혜택</span>
					 			</a>
				 			</li>
			 			</ul>
			 			
			 			<!-- 검색창 -->
		 				<div id="side_search" class="gnb_search">
			 				<form action="list.jsp" onsubmit="return searchTracking(this)">
				 				<input type="hidden" name="searched" value="Y">
				 				<input type="hidden" name="log" value="1">
				 				<input type="hidden" name="skey" value="all">
				 				<input type="hidden" name="hid_pr_text" value="">
				 				<input type="hidden" name="hid_link_url" value="">
				 				<input type="hidden" id="edit" name="edit" value="">
				 				<input name="sword" type="text" value="" required="required" label="검색어" placeholder="검색어를 입력해주세요." autocomplete="off" class="inp_search">
				 				<input type="image" src="https://res.kurly.com/pc/service/common/1908/ico_search_x2.png" class="btn_search">
				 				<div class="init">
				 					<button type="button" id="searchInit" class="btn_delete">검색어 삭제하기</button>
			 					</div>
	 						</form>
						</div>
						
						<!-- 장바구니버튼 -->
						<div class="cart_count">
							<div class="inner_cartcount">
								<a href="/shop/goods/goods_cart.php" class="btn_cart">
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
						
						<!--  -->
						<div class="location_set">
							<button type="button" class="btn_location on">배송지 설정하기</button>
							<div class="layer_location">
								<div class="no_address">
									<span class="emph">배송지를 등록</span>
									하고<br> 구매 가능한 상품을 확인하세요! 
									<div class="group_button double">
										<button type="button" class="btn default login">로그인</button>
										<button type="button" class="btn active searchAddress">
											<span class="ico"></span>주소검색
										</button>
									</div>
								</div>
							</div>
						</div>

						<!-- 찜하기 버튼 -->
						<div class="gnbPick">
							<a href="/shop/mypage/mypage_pick.php" class="btn_pick">찜한 상품 보기</a>
						</div>
						
					</div>
					
					<!-- 서브카테고리 --> 
					<div class="gnb_sub" style="display: none; width: 219px;">
						<div class="inner_sub">
							<ul data-default="219" data-min="219" data-max="731" class="gnb_menu" style="height: auto;">
								<li>
									<a class="menu">
										<span class="ico">
											<img src="https://img-cf.kurly.com/category/icon/pc/25040bd0-5889-4d8c-b863-13f71750a8e6" alt="카테고리 아이콘" class="ico_off">
											<img src="https://img-cf.kurly.com/category/icon/pc/e9ba198b-d9da-46b7-a4a4-6058613732bd" alt="카테고리 아이콘" class="ico_on">
										</span>
										<span class="tit">
											<span class="txt">채소</span>
										</span>
									</a>
									<ul class="sub_menu">
										<li><a class="sub"><span class="name">인문학</span></a></li>
										<li><a class="sub"><span class="name">사회과학</span></a></li>
										<li><a class="sub"><span class="name">소설</span></a></li>
										<li><a class="sub"><span class="name">역사</span></a></li>
										<li><a class="sub"><span class="name">예술/대중문화</span></a></li>
										<li><a class="sub">		
									</ul>
								</li>
							</ul>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>