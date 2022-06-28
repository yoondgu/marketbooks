<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
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
<style type="text/css">
	.text-middle-center {
	    justify-content: center;
	    align-items: center;
	}
</style>
</head>
<body>
<!-- 사용자 상호작용 관련 작업
	1. 체크박스 클릭 - (list.jsp의 체크된 아이템번호 전달하기)
	2. 수정버튼 클릭 - 수정폼 페이지 새 창 팝업
	3. 배송지추가 버튼 클릭 - 추가폼 페이지 새 창 팝업
 -->
<!-- DB 관련 작업
	1. 세션에서 사용자정보 획득, 로그인 체크
	2. 주소 정보 List<Address> 획득하기
	3. addressList.isEmpty()가 true이면 '배송지 정보가 없습니다.'
	4. false이면 for문으로 뿌리기
	5. 체크박스 클릭하면 user_default_ad_no 변경, list.jsp 리로드
 -->
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
	 
	// 선택 배송지번호는 로컬스토리지를 통해 태그에 담고 꺼낸다.
	
	// 해당 사용자의 배송지 정보 리스트 획득
	UserAddressDao userAddressDao = UserAddressDao.getInstance();
	List<UserAddress> addrList = userAddressDao.getAllAddressesByUser(userNo);
%>
<div class="container" style="min-width: 300px; max-width: 500px">
   <div class="title p-3 border-2 border-bottom border-dark">
   		<span class="fs-4"><strong>배송지</strong></span>
   </div>
   <form id="address-form" method="get" action="">
   		<!-- form 전달값 -->
	 	<%
	 		// 부모창에서 전달받은, list.jsp페이지에서 체크된 아이템번호 값을 getParameters로 꺼내서 반복문으로 hidden타입의 input태그를 만든다.
	 		// form 전송 시 이 값이 함께 전달된다.
			String[] checkedValues = request.getParameterValues("checkedItemNo");
	 		if (checkedValues != null) {
	 			for (String value : checkedValues) {
		%>
		<input type="hidden" name="checkedItemNo" id="hidden-checkedItemNo" value="<%=StringUtil.stringToInt(value) %>"/>
		<%
	 			}
	 		}
		%>
		<!-- 로컬스토리지, ajax에서 사용하기 위한 배송지번호 저장 -->
		<input type="hidden" name="modifyAddressNo" id="hidden-modifyAddressNo"/>
		<input type="hidden" name="selectedAddressNo" id="hidden-changeSelectedAddressNo" value="<%=defAddressNo %>"/>
	   <div class="tablewrapper text-middle-center text-center">
	   		<table class="table">
	   			<colgroup>
	   				<col width="20%">
	   				<col width="*">
	   				<col width="20%">
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
   						<!-- 스크립트에서 선택한 배송지 정보만 checked 상태로 출력한다. -->
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
			}
		}
	}


	// 주문 폼에 제출할 선택 배송지를 변경한다. 부모창의 화면이 바뀌므로 부모창으로 폼 제출, 이 화면은 닫는다.
	function changeSelectedAddress(addressNo) {
		let form = document.getElementById("address-form");
		
		// 히든태그 값 수정
		document.getElementById("hidden-changeSelectedAddressNo").value = addressNo;
		// 이 때 다른 페이지에서도 선택배송지를 반영하도록 로컬스토리지에 값을 저장한다.
		localStorage.setItem('selectedAddressNo', addressNo);
		
		// 부모창(list.jsp페이지를 보고있던 브라우저)으로 폼을 제출한다.
		// 다른 페이지를 거칠 필요 없이, 체크박스아이템번호와 변경된 선택된 배송지번호가 제출되어 화면에 반영된다.
		window.opener.name = 'parentName'
		form.setAttribute("target", 'parentName');
		form.setAttribute("action", 'list.jsp');

		form.submit();
		window.close();
	}
	
	function openModifyForm(addressNo) {		
		// 히든태그 값 수정
		document.getElementById("hidden-modifyAddressNo").value = addressNo;
		
		// 새 창을 띄우지 않고 같은 창에서 페이지 변경한다.
		let form = document.getElementById("address-form");
		form.setAttribute("action", "modifyAddressForm.jsp");
		form.submit();
		
	}
	
	function openAddForm() {
		// 새 창을 띄우지 않고 같은 창에서 페이지 변경한다.
		let form = document.getElementById("address-form");
		form.setAttribute("action", "addAddressForm.jsp");
		form.submit();
	}
	
</script>
</body>
</html>