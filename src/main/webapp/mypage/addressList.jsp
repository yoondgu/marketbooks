<%@page import="vo.User"%>
<%@page import="vo.UserAddress"%>
<%@page import="java.util.List"%>
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
<link href="../css/home.css" rel="stylesheet">
</head>
<body>
<%
	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 에러페이지를 띄운다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("로그인 후 이용가능한 서비스입니다.");
	}
	int userNo = user.getNo();
	
	// 사용자의 기본 배송지 번호 획득
	int defAddressNo = 0;
	if (user.getAddress() != null) {
		defAddressNo = user.getAddress().getNo();
	}
	 
	// 사용자가 주문제출을 위해 선택한 배송지 번호는 스크립트에서 로컬스토리지로 꺼낸다.
	
	// 해당 사용자의 배송지 정보 리스트 획득
	UserAddressDao userAddressDao = UserAddressDao.getInstance();
	List<UserAddress> addrList = userAddressDao.getAllAddressesByUser(userNo);
%>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container mb-5" style="min-width: 1200px; max-width: 1200px;">
	<div class="row">
	   		<div class="col-3 p-3">
	   			<!-- 마이페이지 메뉴리스트 import -->
				<jsp:include page="../common/mypagemenu.jsp">
					<jsp:param name="menu" value="address"/>
				</jsp:include>
	   		</div>
	   		<!-- TO DO : ../cart/addressList.jsp 복사해온 부분. include로 처리할 수 있는지 보기, 복사해온 링크(add,delete,modify포함) 절대경로로 수정 -->
	   		<div class="col-9 p-3">
		   			<!-- 해당 메뉴 HTML 들어갈 곳 -->
		  			<div class=" py-3 border-bottom border-2 border-dark mb-3">
		  				<span class="fs-5 py-3 align-middle ps-0 mb-3 fw-bold">배송지 관리</span>
		  			</div>
					<form id="address-form" method="get" action="">
						<input type="hidden" name="modifyAddressNo" id="hidden-modifyAddressNo"/>
						<input type="hidden" name="selectedAddressNo" id="hidden-selectedAddressNo"/>
						<!-- 재요청 시 마이페이지, 장바구니 중 어디로 보낼지 결정하는 값 -->
   						<input type="hidden" name="location" id="hidden-location" />
			  			<!-- 스크립트에서 사용하기 위한 기본 배송지 정보 -->
			  			<input type="hidden" id="defAddressNo" value="<%=defAddressNo %>"/>
					   <div class="tablewrapper text-middle-center text-center">
					   		<table class="table">
					   			<colgroup>
					   				<col width="10%">
					   				<col width="*">
					   				<col width="10%">
					   			</colgroup>
					   			<thead>
					   				<tr>
					   					<td class="align-middle">선택</td>
					   					<td class="align-middle">배송정보</td>
					   					<td class="align-middle">수정</td>
					   				</tr>
					   			</thead>
					   			<tbody>
					   			<!-- for문으로 배송지 정보를 출력한다. -->
					   			<%
					   				for (UserAddress addr : addrList) {
					   			%>
					   				<tr id="item-row-<%=addr.getNo() %>">
					   					<td class="align-middle">
				   						<!-- 스크립트에서 선택한 배송지 정보만 checked 상태로 변경한다. -->
					   						<input type="checkbox" id="item-checkbox-<%=addr.getNo() %>" onchange="changeSelectedAddress(<%=addr.getNo() %>);"/>
					   					</td>
					   					<td class="text-start align-middle">
				   						<!-- 기본 배송지 정보에만 '기본배송지' 텍스트를 추가한다. -->
				   						<%
				   							if (defAddressNo == addr.getNo()) {
				   						%>
				 							<div class="mb-1 ms-0"><small class="text-muted text-bg-light rounded p-1">기본 배송지</small></div>
					   					<%
				   							}
					   					%>
					   						<div id="item-address-<%=addr.getNo() %>"><%=addr.getAddress() %> <%=StringUtil.nullToBlank(addr.getDetailAddress()) %></div>
					   						<div id="item-user-<%=addr.getNo() %>">
					   							<!--
					   							<small class="border-end pe-1">받는이</small>
					   							<small class="pe-1">전화번호</small>
					   							 추후 받는이,전화번호 정보 작업 나중에 추가 -->
					   						</div>
					   					</td>
					   					<td class="align-middle">
					   						<a href="javascript:openModifyForm(<%=addr.getNo() %>);">
					   							<!-- 부트스트랩 아이콘 -->
						   						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="black" class="bi bi-pen" viewBox="0 0 16 16">
					  								<path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001zm-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708l-1.585-1.585z"/>
												</svg>
					   						</a>
					   					</td>
					   				</tr>
					   			<%
					   				}
					   			%>
					   			</tbody>
					   			<tfoot>
					   				<tr>
					   					<td colspan="3" class="align-middle">
					   						<a href="javascript:openAddForm();" class="link-dark text-decoration-none">
					   							<strong>+ 새 배송지 추가</strong>
					   						</a>
					   					</td>
					   				</tr>
					   			</tfoot>
					   		</table>
					   </div>
				  </form>
	   		</div>
	 </div>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">	

	// 모든 체크박스의 클래스 중 checked를 모두 false로 만든다. 
	let checkboxElements = document.querySelectorAll("input[id^='item-checkbox-']");
	if (checkboxElements != null) {
		for (let element of checkboxElements) {
			element.checked = false;
		}
		
		// 로컬스토리지에 선택배송지 번호가 존재한다면, 그 번호를 선택배송지로 설정한다.
		// 배송지 번호에 해당하는 체크박스만 checked 클래스를 추가한다.
		let selectedAddrNo = localStorage.getItem('selectedAddressNo');
		if (selectedAddrNo != null) {
			let selectedCheckboxElement = document.getElementById("item-checkbox-" + selectedAddrNo);
			selectedCheckboxElement.checked = true;
		} else {
			// 로컬스토리지에 선택배송지 번호가 없을 경우 기본배송지를 로컬스토리지에 저장하고 checked 클래스를 추가한다.
			let defAddressNo = document.getElementById("defAddressNo").value;
			if (defAddressNo != 0) {
				
				selectedAddrNo = defAddressNo;
				localStorage.setItem('selectedAddressNo', selectedAddrNo);
				
				let selectedCheckboxElement = document.getElementById("item-checkbox-" + selectedAddrNo);
				selectedCheckboxElement.checked = true;
				
				// 로컬스토리지를 이용해 조회한 선택배송지를 input태그에도 저장한다.
				document.querySelector("input[name=selectedAddressNo]").value = selectedAddressNo;
			}
		}
	}
	

	// 주문 폼에 제출할 선택 배송지를 변경한다. 
	function changeSelectedAddress(addressNo) {
		// 선택 배송지를 로컬스토리지에 저장하고 새로고침한다. 
		localStorage.setItem('selectedAddressNo', addressNo);
		location.reload(true);
	}
	
	
	// 수정, 추가, 삭제는 새 창을 띄워 폼입력값으로 정보를 전달한다.
	// mypage=yes 파라미터를 전달해서 재요청 시 마이페이지 내 배송지리스트로 오도록 한다.
	function submitFormNewWindow(requestURL, windowname) {
		window.open(requestURL, windowname, 'width=500,height=750'); 
		
		let form = document.getElementById("address-form");
		
		form.setAttribute("target", windowname);
		form.setAttribute("action", requestURL);
		
		form.submit();
	}
	
	function openModifyForm(addressNo) {		
		// 히든태그 값 수정
		document.getElementById("hidden-modifyAddressNo").value = addressNo;
		document.getElementById("hidden-location").value = "mypage";
		
		// 새 창을 띄워 제출한다.
		
		submitFormNewWindow("../cart/modifyAddressForm.jsp", "modify");
		
	}
	
	function openAddForm() {
		// 히든태그 값 수정
		document.getElementById("hidden-location").value = "mypage";
		// 새 창을 띄워 제출한다.
		submitFormNewWindow("../cart/addAddressForm.jsp", "add");
	}
	
</script></body>
</html>