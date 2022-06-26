<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container homeMain">

<!-- 1. 이미지 이벤트 영역 -->
<div class="sectionRow">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	
	<!-- 이미지 이벤트 캐러셀 -->
	<div id="demo" class="carousel slide" data-ride="carousel">	
		<div class="carousel-inner">
			<!-- 슬라이드 쇼 -->
			<div class="carousel-item active">
				<!--가로-->
				<img class=""
					src="https://img-cf.kurly.com/banner/main/pc/img/5a5ecfbd-6615-4593-955f-2725c82134d7"
					alt="First slide">
				<div class="carousel-caption d-none d-md-block">
					<h5></h5>
					<p></p>
				</div>
			</div>
			<div class="carousel-item">
				<img class=""
					src="https://img-cf.kurly.com/banner/main/pc/img/1f4eb174-ec9b-4d34-8465-07487048ff11"
					alt="Second slide">
			</div>
			<div class="carousel-item">
				<img class=""
					src="https://img-cf.kurly.com/banner/main/pc/img/f8bd5d2f-5c6b-4da1-a7c4-13d5e2489149"
					alt="Third slide">
			</div>
			<!-- / 슬라이드 쇼 끝 -->

			<!-- 왼쪽 오른쪽 화살표 버튼 -->
			<a class="carousel-control-prev" href="#demo" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<!-- <span>Previous</span> -->
			</a> <a class="carousel-control-next" href="#demo" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<!-- <span>Next</span> -->
			</a>
			<!-- / 화살표 버튼 끝 -->

			<!-- 인디케이터 -->
			<ul class="carousel-indicators">
				<li data-target="#demo" data-slide-to="0" class="active"></li>
				<!--0번부터시작-->
				<li data-target="#demo" data-slide-to="1"></li>
				<li data-target="#demo" data-slide-to="2"></li>
			</ul>
			<!-- 인디케이터 끝 -->
		</div>
	</div>
</div>

<!-- 2. 베스트셀러 섹션 -->
<div class="sectionRow">
	<jsp:include page="../book/bestsellerList.jsp"></jsp:include>
</div>

<!-- 3. sns 섹션 -->
<div class="sectionRow">
	
</div>

</div>