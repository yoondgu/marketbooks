<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	
	.modalimage { display: block; margin: 0 auto; width: 200px; object-fit: contain }
	
</style>
   	<!-- 전체 상품 다시 담기 모달 -->
	<div class="modal fade" id="addAllCarts" tabindex="-1" aria-labelledby="addAllCartsModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title fw-bold" id="addAllCartsModalLabel">
		        	장바구니 담기
		        </h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body border-bottom">
				<p class="text-center m-3 fs-6">
			        주문 상품을 모두 장바구니에 담으시겠습니까?
				</p>
		      </div>
		      <div class="modal-footer border-0 m-auto">
		        <button type="button" class="btn" data-bs-dismiss="modal" onclick="addAllCarts();">확인</button>
		      </div>
		    </div>
		  </div>
	</div>

	<!-- 장바구니 1건 수량 선택 담기 모달 -->
	<div class="modal fade" id="addCart" tabindex="-1" aria-labelledby="addCartModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		    	<div class="modal-header">
			        <h5 class="modal-title fw-bold" id="addCartModalLabel">
			        	장바구니 담기
			        </h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body border-bottom">
		      		<div id="bookInfo" class="m-3">
			      		<input type="hidden" name="addBookNo"/>
			      		<input type="hidden" name="discountPrice"/>
			      		<div class="mb-3">
				      		<img alt="cover image" class="modalimage img-thumbnail rounded" src="" id="addBookImg">
			      		</div>
		      			<p class="fs-6 text-center"><span id="addBookTitle"></span></p>
		      			<p class="fs-6 text-center text-muted"><span id="addBookAuthor"></span></p>
		      			<p class="fs-4 text-center text-muted fw-bold"><span id="totalPrice"></span> 원</p>
		      		</div>
					<div class="row d-flex justify-content-center">
						<div class="col-6 hstack gap-3">
							<button class="form-control btn btn-sm btn-light fs-4" onclick="this.parentNode.querySelector('input[type=number]').stepDown(); changeTotalPrice();">-</button>
							<input class="form-control form-control-lg fs-6 mx-auto" min="1" name="quantity" value="1" type="number" disabled>
							<button class="form-control btn btn-sm btn-light fs-4" onclick="this.parentNode.querySelector('input[type=number]').stepUp(); changeTotalPrice();">+</button>						
						</div>
					</div>
		      </div>
		      <div class="modal-footer border-0 m-auto">
		        <button type="button" class="btn btn-lg" data-bs-dismiss="modal" style="background-color:#5f0080; color:#fff;" onclick="addCart();">담기</button>
		      </div>
		    </div>
		  </div>
	</div>
	
	<!-- 장바구니 담기 결과 모달 -->
	<div class="modal fade" id="addCartResult" tabindex="-1" aria-labelledby="addCartResultModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title fw-bold" id="addCartResultModalLabel">
		        </h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body border-bottom">
		      	<p class="text-center m-3 fs-6" id="addCartResult-message">
			        장바구니에 <span id="result-quantity"></span>건의 아이템이 추가되었습니다.
		      	</p>
		      </div>
		    </div>
		  </div>
	</div>
<script type="text/javascript">
	let addAllCartsModal = new bootstrap.Modal(document.getElementById("addAllCarts"));
	let addCartModal = new bootstrap.Modal(document.getElementById("addCart"));	
	let addResultModal = new bootstrap.Modal(document.getElementById("addCartResult"));
	
	/*
	특정 주문아이템을 저장하기 위해 모달창을 띄운다.
	a태그를 클릭하면 모달창 input 태그에 도서번호를 저장하는 함수가 실행된다.
	모달 창에서 수량을 받는다.
	도서번호와 수량 value값을 쿼리셀렉터로 가져와서 ajax 요청한다. 
	응답을 받으면 모달창을 띄운다. (저장 성공, 실패 여부에 따라 다른 내용을 띄운다.)
	==> 상세정보 페이지에서도 같은 방식으로 담기
	*/
	function addCart() {
		
		// 모달을 숨긴다.
		addCartModal.hide();
		
		// 모달 폼입력태그에서 bookNo, quantity를 획득한다.
		let bookNo = document.querySelector("input[name=addBookNo]").value;
		let quantity = document.querySelector("input[name=quantity]").value;
		
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				let jsonText = xhr.responseText;
				let result = JSON.parse(jsonText);
				// 성공이면 addResultModal에 내용 넣기
				if (result.success) {
					let span = document.getElementById("result-quantity");
					span.textContent = result.quantity;
				} else {
					let message = document.getElementById("addCartResult-message");
					message.innerHTML = "장바구니 담기에 실패했습니다.<br/> 입력하신 수량보다 재고가 부족합니다.";
				}
				addResultModal.show();
			}
		}
		
		xhr.open("GET", "../cart/add.jsp?bookNo=" + bookNo + "&quantity=" + quantity);
		xhr.send();
		
	}
		
	/*
		모든 주문아이템의 도서번호를 전달해 장바구니아이템으로 저장하고 모달창을 띄운다.
		(수량은 모두 1이다.)
		저장 성공, 실패 여부에 따라 모달창에 다른 내용을 띄운다.
	*/
	function addAllCarts() {
		// 모달을 숨긴다.
		addAllCartsModal.hide();
		
		// bookNo를 전부 쿼리셀렉터로 가져온다.
		let bookNoElements = document.querySelectorAll("input[name=bookNo]");
		let queryString = "";
		for (let i=0; i<bookNoElements.length; i++) {
			queryString += "bookNo=" + bookNoElements[i].value;
			if (i < (bookNoElements.length - 1)) {
				queryString += "&";
			}
		}
		
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				let jsonText = xhr.responseText;
				let result = JSON.parse(jsonText);
				// 성공이면 addResultModal에 내용 넣기
				if (result.success) {
					let span = document.getElementById("result-quantity");
					span.textContent = result.quantity;
				} else {
					let message = document.getElementById("addCartResult-message");
					message.innerHTML = "장바구니 담기에 실패했습니다.<br/> 입력하신 수량보다 재고가 부족합니다.";
				}
				addResultModal.show();
			}
		}
		
		xhr.open("GET", "../cart/add.jsp?" + queryString);
		xhr.send();
		
	}
	
	// 수량에 대한 input태그에 onchange 이벤트가 발생하면 총 금액을 새로 출력한다.
	function changeTotalPrice() {
		
		// 한권의 가격과 수량을 획득한다.
		let bookPrice = document.querySelector("input[name=discountPrice]").value;
		let quantity = document.querySelector("input[name=quantity]").value;
		
		document.getElementById("totalPrice").textContent = (bookPrice*quantity).toLocaleString();
	}
</script>