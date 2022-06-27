<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓북스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"	type="image/x-icon">
<link href="../css/home.css" rel="stylesheet">
</head>
<body>
<!-- header -->
<jsp:include page="/common/header.jsp">
	<jsp:param name="menu" value="book" />
</jsp:include>
<script>
	
</script>

<!-- main -->
<div class="container m-5 align-middle">
   
   <!-- 제목,부제,저자,출판사,출간일 -->
   <div class="row m-3">
   		<div class="mt-3 mb-3">
	   		<span class="fs-2 float-left me-1">원피스 102</span><span class="fs-6 float-right"> - 천왕산</span>
   		</div>
   		<span class="m-2 ">오다 에이치로 (지은이)대원씨아이(만화)2022-06-27원제 : ONE PIECE 102</span>
   </div>
   
   <!-- 가로줄 -->
   <div class="border-bottom m-4"></div>
   
   <!-- 이미지,상세정보,결제 -->
   <div class="row m-3">
   		<div class="col mt-2">
   			<img src="/marketbooks/images/bookcover/book-<%=book.getNo()%>.jpg" class="">
   		</div>
   		<div class="col mt-2">
   			<!-- 가격 -->
   			<div class="row">
				<div class="m-2">
					<span class="fs-5 m-2 min-width:200px">정가</span>
					<span class="fs-5 m-3">5,500원</span>
				</div>
				<div class="m-2">
					<span class="fs-5 m-2">판매가</span>					
					<span class="fs-4 m-3">4,950원 </span>
					<span class="">(10%,&nbsp&nbsp550원 할인)</span>
				</div>
	   		</div>
   		   			
	 
  			<!-- 배송료 -->
  			<div class="row">
				<div class="m-2">
					<span class="fs-5 m-2">배송료</span>
					<span class="fs-5 m-2">
						<!-- <button type="button" onclick="" class="btn btn-link p-0 ps-2 align-top">무료/안내</button> -->
						<span class="">무료</span>
					</span>
				</div>
  			</div>
  			
  			<!-- 수령예상일 -->
  			<div class="row">
				<div class="m-2">
					<span class="fs-5 m-2 float-start">수령예상일</span>
					<div class="fs-5 m-2">
						<span class="m-2">지금 택배로 주문하면 내일 수령</br></span>
						<span class="m-2">(고양시 일산동구 위시티1로 11번길 기준) <button type="button" onclick="" class="btn btn-link p-0 align-top">지역변경</button></span>
					</div>
				</div>
  			</div>
  			
  			<!-- 카테고리-->
  			<div class="row">
				<div class="m-2"> 
  					<span class="fs-5 m-2">카테고리</span>
  					<span class="fs-5 m-2">인문학</span>
  				</div>		
  			</div>
  			<!-- 출간일-->
  			<div class="row">
				<div class="m-2"> 
  					<span class="fs-5 m-2">출간일</span>
	  				<span class="m-3">2022-06-27</span>
  				</div>		
  			</div>
  			

  			
  			<!-- 할인,할부,소득공제버튼 -->
			<div class="">
				<div class="m-2"> 			
				    <ul>
				        <li><a href="" class=""> 카드/간편결제 할인<img src="" class=""></a></li>
				        <li><a href="" class=""> 무이자 할부<img src="" class=""></a>
				            <div style="position:absolute; right:0; z-index:1; display:none;">
				                <div class="" style="background-color:white;height:290px;">
				                    <h3 class=" "> 무이자 할부 안내 </h3>
				                    <div class=""><a href=""><img src="//image.aladin.co.kr/img/shop/2018/btn_top_close1.png"></a></div>
				                    <div class=""></div>
				                    <div class="">
				                        <ul>
				                            <li>
				                                * 2~4개월 무이자 : 롯데 <br>
				                                * 2~6개월 무이자 : 삼성 <br>
				                                * 2~7개월 무이자 : 우리(BC아님), 국민, 비씨, 신한, 현대 <br>
				                                * 2~8개월 무이자 : 하나, 농협 <br><br>
				                                ※ 제휴 신용카드 결제시 무이자+제휴카드 혜택 가능합니다.<br>
				                                ※ 오프라인결제/Non ActiveX 결제(간편결제)/카카오페이/네이버페이/페이코 등 간편결제/법인/체크/선불/기프트/문화누리/은행계열카드/ 알라딘 캐시와
				                                같은 정기과금 결제 등은 행사대상에서 제외됩니다.<br>
				                                ※ 무이자할부 결제 시 카드사 포인트 적립에서 제외될 수 있습니다.<br>
				                                ※ 본 행사는 카드사 사정에 따라 변경 또는 중단될 수 있습니다.<br>
				                            </li>
				                        </ul>
				                    </div>
				                </div>
				            </div>
				        </li>
				        <li><a href="" class="Ere_sub_blue">소득공제 230원 <img src="//image.aladin.co.kr/img/shop/2022/p_arrow_down.gif" class=""></a></li>
				    </ul>
		    	</div>
			</div>		
			
  			<!-- 장바구니, 구매버튼 -->
			<div class="">
				<a onclick="" href="">장바구니 담기</a>
			</div>
			<div class="">
				<a href="" onclick="">바로구매</a>
			</div>

  			
   		</div>
   </div>
   
   <!-- 설명글 -->
   <div class="row m-3">
   		<p>설명글이 적히는 공간입니다.설명글이 적히는 공간입니다.설명글이 적히는 공간입니다.설명글이 적히는 공간입니다.설명글이 적히는 공간입니다.설명글이 적히는 공간입니다.설명글이 적히는 공간입니다.</p>
   </div>
   
   <!-- 리뷰 -->   
   <!-- 기본정보 -->
   <!-- 이벤트 -->
   <!-- 책소개 -->
   <!-- 목차 -->
   <!-- 책속에서 -->
   <!-- 저자 및 역자소개 -->
   <!-- 출판사 제공 책소개 -->
   <!-- 관련상품 -->
   <!-- 반품/교환안내 -->
   
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="menu" value="home" />
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>