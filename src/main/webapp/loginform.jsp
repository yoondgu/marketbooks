<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
    <meta name="generator" content="Hugo 0.88.1">
    <title>마켓북스 : 로그인</title>

    <link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/sign-in/">

    

    <!-- Bootstrap core CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Favicons -->
<link rel="shortcut icon" href="https://res.kurly.com/images/marketkurly/logo/favicon_v2.png" type="image/x-icon">

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">
  </head>
  <body class="text-center">
  
<main class="form-signin">
  <form method="post" action="login.jsp" onsubmit="return submitLoginForm()">
    <img src="images/marketbooks-logo.png" alt="" width="144" height="114">
    <h1 class="h3 mb-3 fw-normal">로그인</h1>
	<%
		String fail = request.getParameter("fail");
	%>
		<!--
			아이디 혹은 비밀번호가 일치하지 않는 경우 아래 내용이 출력된다.
		-->
	<%
		if ("invalid".equals(fail)) {
	%>
		<div class="alert alert-danger">
			<strong>로그인 실패</strong>
			<p>아이디 또는 비밀번호 오류입니다.</p>
		</div>
	<%
		}
	%>
		<!--
			로그아웃 상태에서 로그인이 필요한 페이지 요청을 했을 경우 아래 내용이 출력된다.
		-->
	<%
		if ("deny".equals(fail)) {
	%>
		<div class="alert alert-danger">
			<strong>접근 제한</strong> 로그인이 필요한 기능입니다.
		</div>
	<%
		}
	%>
    <div class="form-floating">
      <input type="email" class="form-control mb-2" id="floatingInput" name="email" placeholder="name@example.com">
      <label for="floatingInput">이메일을 입력해주세요</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password">
      <label for="floatingPassword">비밀번호를 입력해주세요</label>
    </div>

    <button class="w-100 btn btn-lg btn-primary mb-2" type="submit">로그인</button>
    <a href="registerform.jsp" class="w-100 btn btn-lg btn-secondary">회원가입</a>
  </form>
</main>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		function submitLoginForm() {
			let emailField = document.querySelector("input[name=email]");
			if (emailField.value === '') {
				alert("이메일은 필수입력값입니다.");
				emailField.focus();
				return false;
			}
			let passwordField = document.querySelector("input[name=password]");
			if (passwordField.value === '') {
				alert("비밀번호는 필수입력값입니다.");
				passwordField.focus();
				return false;
			}
			return true;
		}
	</script>	    
  </body>
</html>