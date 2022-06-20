<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
   		<span class="text-muted">배송지 주소를 수정하세요.</span>
   </div>
   <%
   		int addressNo = StringUtil.stringToInt(request.getParameter("modifyAddressNo"));
   		// addressNo로 주소 정보 찾아서 form 입력값에 넣기
   %>
   <div class="formwrapper p-3">
		<form id="address-form" method="post" action="" onsubmit="return checkInputValue();">
   		<!-- form 전달값 -->
			<!-- 이전 페이지에서 선택한 주소와 우편번호를 전달받아서 hidden타입의 input태그에 저장하고, 화면에도 출력한다. -->
			<input type="hidden" id="postcode" name="postcode" />
			<input type="hidden" id="address" name="address" />
			<input type="text" id="addressPreview" value="" disabled class="form-control mb-3 " />
			<input type="text" id="detailAddress" name="detailAddress" placeholder="나머지 주소를 입력해주세요" class="form-control mb-3" />
			<div class="d-grid gap-2">
				<button type="button" class="btn btn-primary" onclick="submitForm('modifyAddress.jsp');">저장</button>
				<button type="button" class="btn btn-outline-danger mb-3" onclick="submitForm('deleteAddress.jsp');">삭제</button>
			</div>
			<input type="checkbox" name="isChecked" value="yes" /><span> 기본 배송지로 저장</span>
		</form>
   </div>
	
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	/*
		검색 버튼을 누르면 실행되는 이벤트핸들러 함수. 주소지 검색창이 뜨고, 클릭한 주소지의 내용이 input태그에 담긴다.
	*/
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                // 주소정보에는 참고항목 값을 더해서 같이 전달한다.
                document.getElementById("address").value = addr + extraAddr;
                document.getElementById("addressPreview").value = addr + extraAddr;
                
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
                
            }
        }).open();
    }
	

	/*
		폼이 제출될때 실행되는 이벤트핸들러 함수. 전달값 중 하나라도 누락되면 alert창을 띄우고 false를 반환한다.
	*/
	function checkInputValue() {
		
		let addrField = document.getElementById("address");
		if (addrField.value === '주소지를 선택하세요' || addrField.value === '' || addrField.value === ' ') {
			alert('주소지를 입력하세요.')
			return false;
		}

		let detailAddrField = document.getElementById("detailAddress");
		if (detailAddrField.value === '나머지 주소를 입력해주세요' || detailAddrField.value === '' || detailAddrField.value === ' ') {
			alert('나머지 주소를 입력하세요.')
			detailAddrField.focus();
			return false;
		}
		
		let postcodeField = document.getElementById("postcode");
		if (typeof(postcodeField.value) !== number ) {
			alert('우편번호가 유효하지 않습니다.')
			return false;
		}
		
		return true;
	}
	
	/*
		저장 또는 삭제 버튼을 누르면 실행되는 이벤트핸들러 함수. 
	*/
	function submitForm(requestURL) {
		let form = document.getElementById("address-form");
		form.setAttribute("action", requestURL);
		form.submit();
	}
	
</script>
</body>
</html>