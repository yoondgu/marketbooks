<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>마켓북스 : 회원가입</title>
        <link rel="stylesheet" href="css/join.css">
        <link href="css/home.css" rel="stylesheet">
        
        <!-- Favicons -->
        <link rel="shortcut icon" href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png" type="image/x-icon">
    
    </head>
    <body>
    <!-- header include -->
	<jsp:include page="common/header.jsp"></jsp:include>
    <div class="container">
        <!-- header -->
        <div id="header">
            <h1>회원가입</h1>
        </div>
		<div class="row">
		<div class="col">
		<%
			// 요청파라미터에서 오류 원인을 조회한다.(이메일)
			String fail = request.getParameter("fail");
		%>

		<%
			if ("email".equals(fail)) {
				String duplictedEmail = request.getParameter("email");
		%>
			<div class="alert alert-danger">
				<strong>회원가입 실패</strong> [<%=duplictedEmail %>]은 이미 사용중인 이메일입니다.
			</div>
		<%
			}
		%>
        <!-- wrapper -->
        <div id="wrapper">
		<form method="post" action="register.jsp" onsubmit="return submitRegisterForm()">
            <!-- content-->
            <div id="content">

                <!-- EMAIL -->
                <div>
                    <h3 class="join_title">
                        <label for="email">이메일</label>
                    </h3>
                    <span class="box int_email">
                        <input type="text" id="email" class="int" placeholder="예: marketbooks@books.com ">
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- PW1 -->
                <div>
                    <h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
                    <span class="box int_pass">
                        <input type="password" id="pswd1" class="int" maxlength="20" placeholder="비밀번호를 입력해주세요">
                        <span id="alertTxt">사용불가</span>
                        <img src="images/icon-pass.png" id="pswd1_img1" class="pswdImg" >
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- PW2 -->
                <div>
                    <h3 class="join_title"><label for="pswd2">비밀번호 확인</label></h3>
                    <span class="box int_pass_check">
                        <input type="password" id="pswd2" class="int" maxlength="20" placeholder="비밀번호를 한번 더 입력해주세요">
                        <img src="images/icon-check-disable.png" id="pswd2_img1" class="pswdImg">
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- NAME -->
                <div>
                    <h3 class="join_title"><label for="name">이름</label></h3>
                    <span class="box int_name">
                        <input type="text" id="name" class="int" maxlength="20" placeholder="이름을 입력해주세요">
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- MOBILE -->
                <div>
                    <h3 class="join_title"><label for="phoneNo">휴대폰</label></h3>
                    <span class="box int_mobile">
                        <input type="tel" id="mobile" class="int" maxlength="16" placeholder="번호를 입력해주세요">
                    </span>
                    <span class="error_next_box"></span>    
                </div>

                <!-- ADDRESS -->
                <div>
                    <h3 class="join_title"><label for="address">주소</label></h3>
                    <span class="box int_address">
                        <input type="text" id="address" class="int" placeholder="주소를 입력해주세요">
                    </span>
                </div>                


                <!-- JOIN BTN-->
                <div class="btn_area">
                    <button type="submit" id="btnJoin">
                        <span>가입하기</span>
                    </button>
                </div>
            </div>
          </form> 
        </div>
    </div> 
   </div> 
  </div> 
        <!-- footer include -->
	<jsp:include page="common/footer.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
    <script>

    /*변수 선언*/
    let email = document.querySelector('#email');

    let pw1 = document.querySelector('#pswd1');
    let pwMsg = document.querySelector('#alertTxt');
    let pwImg1 = document.querySelector('#pswd1_img1');

    let pw2 = document.querySelector('#pswd2');
    let pwImg2 = document.querySelector('#pswd2_img1');
    let pwMsgArea = document.querySelector('.int_pass');

    let userName = document.querySelector('#name');

    let mobile = document.querySelector('#mobile');
    
    let address = document.querySelector('#address');

    let error = document.querySelectorAll('.error_next_box');

    /*이벤트 핸들러 연결*/
    email.addEventListener("focusout", checkEmail);
    pw1.addEventListener("focusout", checkPw);
    pw2.addEventListener("focusout", comparePw);
    userName.addEventListener("focusout", checkName);

    mobile.addEventListener("focusout", checkPhoneNum);

    /*콜백 함수*/
    function checkEmail() {
        let emailPattern = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/;
        if(email.value === "") {
            error[0].innerHTML = "필수 정보입니다.";
            error[0].style.display = "block";
        } else if(!emailPattern.test(email.value)) {
            error[0].innerHTML = "이메일 형식으로 입력해주세요";
            error[0].style.display = "block";
        } else {
            error[0].innerHTML = "사용 가능한 이메일입니다.";
            error[0].style.color = "#08A600";
            error[0].style.display = "block";
        }
    }

    function checkPw() {
        let pwPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}/;
        if(pw1.value === "") {
            error[1].innerHTML = "필수 정보입니다.";
            error[1].style.display = "block";
        } else if(!pwPattern.test(pw1.value)) {
            error[1].innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
            pwMsg.innerHTML = "사용불가";
            pwMsgArea.style.paddingRight = "93px";
            error[1].style.display = "block";
            
            pwMsg.style.display = "block";
            pwImg1.src = "images/icon-not-use.png";
        } else {
            error[1].style.display = "none";
            pwMsg.innerHTML = "안전";
            pwMsg.style.display = "block";
            pwMsg.style.color = "#03c75a";
            pwImg1.src = "images/icon-safe.png";
        }
    }

    function comparePw() {
        if(pw2.value === pw1.value && pw2.value != "") {
            pwImg2.src = "images/icon-check-enable.png";
            error[2].style.display = "none";
        } else if(pw2.value !== pw1.value) {
            pwImg2.src = "images/icon-check-disable.png";
            error[2].innerHTML = "비밀번호가 일치하지 않습니다.";
            error[2].style.display = "block";
        } 

        if(pw2.value === "") {
            error[2].innerHTML = "필수 정보입니다.";
            error[2].style.display = "block";
        }
    }

    function checkName() {
        let namePattern = /[a-zA-Z가-힣]/;
        if(userName.value === "") {
            error[3].innerHTML = "필수 정보입니다.";
            error[3].style.display = "block";
        } else if(!namePattern.test(userName.value) || userName.value.indexOf(" ") > -1) {
            error[3].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
            error[3].style.display = "block";
        } else {
            error[3].style.display = "none";
        }
    }

    function checkPhoneNum() {
        let isPhoneNum = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;

        if(mobile.value === "") {
            error[4].innerHTML = "필수 정보입니다.";
            error[4].style.display = "block";
        } else if(!isPhoneNum.test(mobile.value)) {
            error[4].innerHTML = "형식에 맞지 않는 번호입니다.";
            error[4].style.display = "block";
        } else {
            error[4].style.display = "none";
        }
    }
    
    function submitRegisterForm() {
		if (email.value === '') {
			alert("이메일은 필수입력값입니다.");
			email.focus();
			return false;
		}
		
		if (pw1.value === '') {
			alert("비밀번호는 필수입력값입니다.");
			pw1.focus();
			return false;
		}
		
		if (pw2.value === '') {
			alert("비밀번호 확인을 바랍니다.");
			pw2.focus();
			return false;
		}
		
		if (userName.value === '') {
			alert("이름은 필수입력값입니다.");
			userName.focus();
			return false;
		}
		
		if (mobile.value === '') {
			alert("휴대폰은 필수입력값입니다.");
			mobile.focus();
			return false;
		}
		
		if (address.value === '') {
			alert("주소는 필수입력값입니다.");
			address.focus();
			return false;
		}
		
		return true;
	}
    

    </script>
    </body>
</html>