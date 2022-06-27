<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// session객체를 무효화(로그아웃)
	session.invalidate();

	// HttpSession객체를 변경(저장/변경/삭제) 후 재요청URL을 응답으로 보낸다.
	response.sendRedirect("home.jsp");
	
%>