<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="header">

	<!-- 화면 최상단 가입이벤트문구(링크) -->
	<div class="bnr_header" id="top-message" style="display:">
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
				</ul></li>
		</ul>
	</div>

	<!-- 헤더 로고 -->
	<div id="headerLogo" class="layout-wrapper">
		<h1 class="logo">
			<a href="http://localhost/marketbooks/home.jsp" class="link_main">
				<span id="gnbLogoContainer"></span> <img
				src="images/logo_marketbooks.png" alt="마켓컬리 로고"
				style="display: block;">
			</a>
		</h1>
		<!-- 배송안내버튼 -->
		<a href="" onclick="" class="bnr_delivery"> <img
			src="https://res.kurly.com/pc/service/common/2011/delivery_210801.png"
			alt="샛별, 택배 배송안내" width="121" height="22">
		</a>
	</div>

	<!-- 헤더 nav -->
	<!-- 
	<div id="gnb">
		<div class="fixed_container">
			<h2 class="screen_out">메뉴</h2>
			<div id="gnbMenu" class="gnb_kurly">
				<div class="inner_gnbkurly">
					<div class="gnb_main">
						<ul class="gnb">
							<li class="menu1"><a href="#none" class=""><span
									class="ico"></span><span class="txt">전체 카테고리</span></a></li>
							<li class="menu2"><a href="" class="link new "><span
									class="txt">신작</span></a></li>
							<li class="menu3"><a href="" class="link best "><span
									class="txt">베스트셀러</span></a></li>
							<li class="menu4"><a href="" class="link bargain "><span
									class="txt">중고서적</span></a></li>
							<li class="lst"><a href="" class="link event "><span
									class="txt">특가/혜택</span></a></li>
						</ul>
						<div id="side_search" class="gnb_search">
							<form action="" onsubmit="return searchTracking(this)">
								<input type="hidden" name="searched" value="Y"> <input
									type="hidden" name="log" value="1"> <input
									type="hidden" name="skey" value="all"> <input
									type="hidden" name="hid_pr_text" value=""> <input
									type="hidden" name="hid_link_url" value=""> <input
									type="hidden" id="edit" name="edit" value=""> <input
									name="sword" type="text" value="" required="required"
									label="검색어" placeholder="검색어를 입력해주세요." autocomplete="off"
									class="inp_search"> <input type="image"
									src="https://res.kurly.com/pc/service/common/1908/ico_search_x2.png"
									class="btn_search">
								<div class="init">
									<button type="button" id="searchInit" class="btn_delete">검색어
										삭제하기</button>
								</div>
							</form>
						</div>
						<div class="cart_count">
							<div class="inner_cartcount">
								<a href="" class="btn_cart"><span class="screen_out">장바구니</span>
									<span id="cart_item_count" class="num realtime_cartcount"
									style="display: none;"></span></a>
							</div>
							<div id="addMsgCart" class="msg_cart">
								<span class="point"></span>
								<div class="inner_msgcart">
									<img src="https://res.kurly.com/images/common/bg_1_1.gif"
										alt="" class="thumb">
									<p id="msgReaddedItem" class="desc">
										<span class="tit"></span> <span class="txt"> 장바구니에 상품을
											담았습니다. <span class="repeat">이미 담으신 상품이 있어 추가되었습니다.</span>
										</span>
									</p>
								</div>
							</div>
						</div>
						<div class="location_set">
							<button type="button" class="btn_location on">배송지 설정하기</button>
							<div class="layer_location">
								<div class="no_address">
									<span class="emph">배송지를 등록</span>하고<br> 구매 가능한 상품을 확인하세요!
									<div class="group_button double">
										<button type="button" class="btn default login">로그인</button>
										<button type="button" class="btn active searchAddress">
											<span class="ico"></span>주소검색
										</button>
									</div>
								</div>
							</div>
						</div>
						<div class="gnbPick">
							<a href="/shop/mypage/mypage_pick.php" class="btn_pick">찜한 상품
								보기</a>
						</div>
					</div>

					<div class="gnb_sub" style="display: none; width: 219px;">
						<div class="inner_sub">
							<ul data-default="219" data-min="219" data-max="731"
								class="gnb_menu" style="height: auto;">
								<li class=""><a class="menu"><span class="ico"><img
											src=""
											alt="카테고리 아이콘" class="ico_off"> <img
											src=""
											alt="카테고리 아이콘" class="ico_on"></span> <span class="tit"><span
											class="txt">채소</span></span></a>
									<ul class="sub_menu">
										<li><a class="sub"><span class="name">친환경</span></a> </li>
										<li><a class="sub"><span class="name">고구마·감자·당근</span></a>
											</li>
										<li><a class="sub"><span class="name">시금치·쌈채소·나물</span></a>
											</li>
										<li><a class="sub"><span class="name">브로콜리·파프리카·양배추</span></a>
											</li>
										<li><a class="sub"><span class="name">양파·대파·마늘·배추</span></a>
											</li>
										<li><a class="sub"><span class="name">오이·호박·고추</span></a>
											</li>
										<li><a class="sub"><span class="name">냉동·이색·간편채소</span></a>
											</li>
										<li><a class="sub"><span class="name">콩나물·버섯</span></a> </li>
									</ul></li>
							</ul>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
 	--!>


		<!-- 기존코드 -->
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container-fluid">
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">
								전체 카테고리 </a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" href="http://localhost/marketbooks/book/list.jsp"> 인문학 </a></li>
								<li><a class="dropdown-item" href="#"> 사회/과학 </a></li>
								<li><a class="dropdown-item" href="#"> 소설 </a></li>
								<li><a class="dropdown-item" href="#"> 역사 </a></li>
								<li><a class="dropdown-item" href="#"> 예술/대중문화 </a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link" href="#">신상품</a></li>
						<li class="nav-item"><a class="nav-link" href="#">베스트</a></li>
						<li class="nav-item"><a class="nav-link" href="#">알뜰쇼핑</a></li>
						<li class="nav-item"><a class="nav-link" href="#">특가/혜택</a></li>
					</ul>
					<!-- 검색창 -->
					<form class="d-flex">
						<input class="form-control me-5" type="search"
							placeholder="검색어를 입력해주세요." aria-label="Search"> <input
							type="image"
							src="https://res.kurly.com/pc/service/common/1908/ico_search_x2.png"
							class="btn_search">
					</form>

				</div>
			</div>
		</nav>

	</div>