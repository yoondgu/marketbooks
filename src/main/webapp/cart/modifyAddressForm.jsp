<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.UserAddress"%>
<%@page import="dao.UserAddressDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마켓북스</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon"
	href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png"
	type="image/x-icon">
</head>
<style type="text/css">
	input[type=text] {
		font-size: 14px;
	}
</style>
</head>
<body>
<div class="container" style="min-width: 300px; max-width: 500px">
   <div class="title p-3 text-center">
   		<div class="fs-4 mb-1"><strong>배송지 수정하기</strong></div>
   		<span class="text-muted">배송지 상세주소를 수정하세요.</span>
   </div>
   <%
		// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
		User user = (User) session.getAttribute("LOGINED_USER");
		if (user == null) {
			response.sendRedirect("../loginform.jsp?fail=deny");
			return;
		}
		int userNo = user.getNo();
		
		// 사용자의 기본 배송지 번호 획득
		int defAddressNo = 0;
		if (user.getAddress() != null) {
			defAddressNo = user.getAddress().getNo();
		}
		
		
		// 수정할 배송지 번호 획득
		int addressNo = StringUtil.stringToInt(request.getParameter("modifyAddressNo"));

		// addressNo로 배송지 객체 획득하기
  		UserAddressDao userAddressDao = UserAddressDao.getInstance();
   		UserAddress userAddr = userAddressDao.getAddressByNo(addressNo);
   		
   		if (userAddr == null) {
   			throw new RuntimeException("배송지 정보가 존재하지 않습니다.");
   		}
   		
   		// input태그에 저장해 폼제출시 전달
   		String location = StringUtil.nullToBlank(request.getParameter("location"));
   %>
   <div class="formwrapper p-3">
		<form id="address-form" method="post" action="">
   		<!-- form 전달값 -->
   			<!-- 사용자가 주문제출을 위해 선택한 배송지 번호 input 태그에 저장 -->
   		<%
			int selectedAddressNo = StringUtil.stringToInt(request.getParameter("selectedAddressNo"));
   		%>
   			<input type="hidden" name="selectedAddressNo" id="hidden-selectedAddressNo" value="<%=selectedAddressNo %>" />   	
   			<!-- 재요청 시 마이페이지, 장바구니 중 어디로 보낼지 결정하는 값 -->
   			<input type="hidden" name="location" id="hidden-location" value="<%=location %>" />		
			<!-- addressList.jsp에 전달하기 위한, list.jsp의 체크된 아이템 번호 전달받기 -->
	 	<%
	 		// list.jsp페이지에서 체크된 아이템번호 값을 getParameters로 꺼내서 반복문으로 hidden타입의 input태그를 만든다.
	 		// form 전송 시 이 값이 함께 전달된다.
			String[] checkedValues = request.getParameterValues("checkedItemNo");
	 		if (checkedValues != null) {
	 			for (String value : checkedValues) {
		%>
			<input type="hidden" name="checkedItemNo" id="checkedItemNo" value="<%=StringUtil.stringToInt(value) %>"/>
		<%
	 			}
	 		}
		%>
			<!-- 전달받은 배송지 번호와 정보를 hidden타입의 input태그에 저장하고, 정보를 화면에 출력한다. -->
			<input type="hidden" name="defAddressNo" id="defAddressNo" value="<%=defAddressNo %>"/>
			<input type="hidden" id="addressNo" name="addressNo" value="<%=addressNo %>"/>
			<input type="hidden" id="postcode" name="postcode" value="<%=userAddr.getPostalCode() %>"/>
			<input type="hidden" id="address" name="address" value="<%=userAddr.getAddress() %>"/>
			<input type="text" id="addressPreview" value="<%=userAddr.getAddress() %>" disabled class="form-control mb-3 " />
			<input type="text" id="detailAddress" name="detailAddress" value="<%=StringUtil.nullToBlank(userAddr.getDetailAddress()) %>" class="form-control mb-3" />
			<div class="d-grid gap-2">
				<button type="button" class="btn" style="background-color:#5f0080; color:white;" onclick="modifyAddress();">저장</button>
				<button type="button" class="btn mb-3" style="border-color:#5f0080; color:#5f0080;" onclick="deleteAddress();">삭제</button>
			</div>
			<input type="checkbox" style="color:#5f0080" name="isChecked" value="yes" /><span> 기본 배송지로 저장</span>
		</form>
   </div>
	
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	/*
		폼이 제출될때 실행되는 이벤트핸들러 함수. 전달값 중 하나라도 누락되면 alert창을 띄우고 false를 반환한다.
	*/
	function checkInputValue() {
		
		let addrField = document.getElementById("address");
		if (addrField.value === '주소지를 선택하세요' || addrField.value === '' || addrField.value === ' ') {
			alert('주소지를 입력하세요.')
			return false;
		}
		
		let postcodeField = document.getElementById("postcode");
		if (parseInt(postcodeField.value) == NaN) {
			alert('우편번호가 유효하지 않습니다.')
			return false;
		}
		
		return true;
	}
	
	/*
		저장 버튼을 누르면 실행되는 이벤트핸들러 함수. 
		아래 조건과 상관없이 수정하려는 배송지가 현재 화면에 선택된 배송지일 경우 부모창으로 폼을 제출하고, 현재 창을 닫는다.
		-'기본 배송지로 저장' 체크박스에 체크되어있고, 현재 화면에 선택된 배송지와 기본 배송지가 모두 없을 경우 부모창으로 폼을 제출하고, 현재 창을 닫는다.
		-'기본 배송지로 저장' 체크박스에 체크되어있고, 현재 화면에 선택된 배송지가 기본 배송지일 경우 부모창으로 폼을 제출하고, 현재 창을 닫는다.
		-'기본 배송지로 저장' 체크박스에 체크되어있지 않고, 수정하려는 배송지가 선택된 배송지가 아닐 경우 현재 창으로 폼을 제출한다.
	*/
	function modifyAddress() {
		if (!checkInputValue()) {
			return;
		}
		
		let form = document.getElementById("address-form");
		
		// selectedAddressNo, defAddressNo는 값이 없을 경우 0이 value에 저장되므로, 둘 다 없을 경우에 조건식 defAddressNo === selectedAddressNo을 만족한다.
		let selectedAddressNo = document.getElementById("hidden-selectedAddressNo").value;
		let defAddressNo = document.getElementById("defAddressNo").value;
		let modifyAddressNo = document.getElementById("addressNo").value;
		
		let isCheckedStatus = document.querySelector("input[name=isChecked]").checked;
		
		let location = document.querySelector("input[name=location]").value;
		if (location === "mypage") {
			// 마이페이지에서 연 창이면 무조건 부모창으로 폼을 제출한다.
			window.opener.name = 'parentName'
			form.setAttribute("target", 'parentName');
			form.setAttribute("action", '/marketbooks/cart/modifyAddress.jsp');

			form.submit();
			window.close();
				
		} else if (modifyAddressNo == selectedAddressNo || (isCheckedStatus && defAddressNo === selectedAddressNo)) {
			// 부모창(list.jsp페이지를 보고있던 브라우저)으로 폼을 제출한다.
			window.opener.name = 'parentName'
			form.setAttribute("target", 'parentName');
			form.setAttribute("action", '/marketbooks/cart/modifyAddress.jsp');

			form.submit();
			window.close();
		} else {
			form.setAttribute("action", '/marketbooks/cart/modifyAddress.jsp');
			form.submit();
		}
	}

	/*
		삭제 버튼을 누르면 실행되는 이벤트핸들러 함수. 
		삭제하는 배송지가 선택된 배송지인 경우 부모창으로 폼을 제출하고, 현재 창을 닫는다.
		삭제하는 배송지가 선택된 배송지가 아닌 경우 현재 창으로 폼을 제출한다.
	*/
	function deleteAddress() {
		
		let form = document.getElementById("address-form");
		
		let selectedAddressNo = document.getElementById("hidden-selectedAddressNo").value;
		let deleteAddressNo = document.getElementById("addressNo").value;
		
		let location = document.querySelector("input[name=location]").value;
		if (location === "mypage") {
			// 마이페이지에서 연 창이면 무조건 부모창으로 폼을 제출한다.
			window.opener.name = 'parentName'
			form.setAttribute("target", 'parentName');
			form.setAttribute("action", '/marketbooks/cart/deleteAddress.jsp');

			form.submit();
			window.close();
			
		} else if (selectedAddressNo === deleteAddressNo) {
			// 부모창(list.jsp페이지를 보고있던 브라우저)으로 폼을 제출한다.
			window.opener.name = 'parentName'
			form.setAttribute("target", 'parentName');
			form.setAttribute("action", '/marketbooks/cart/deleteAddress.jsp');

			form.submit();
			window.close();
		} else {
			form.setAttribute("action", '/marketbooks/cart/deleteAddress.jsp');
			form.submit();
		}
	}
	
</script>
</body>
</html>