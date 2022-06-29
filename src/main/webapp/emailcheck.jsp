<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 요청 파라미터로 중복체크를 의뢰할 아이디를 조회
	String userEmail = request.getParameter("email");
	
	UserDao userDao = UserDao.getInstance();
	// 아이디에 해당하는 사용자 정보를 조회
	User user = userDao.getUserByEmail(userEmail);
	
	// 아이디 존재여부를 저장하는 HashMap객체 생성
	Map<String, Boolean> result = new HashMap<>();
	if (user != null) {
		result.put("exist", true);
	} else {
		result.put("exist", false);
	}
	
	// 자바의 객체/배열/콜렉션 등을 JSON 형식의 텍스트로 변환하는 제공하는 라이브러리
	Gson gson = new Gson();
	// result가 참조하는 HashMap객체를 JSON 형식의 텍스트로 변환한다
	String jsonText = gson.toJson(result);	// "{"exist":true}"
	// 브라우저에 응답으로 전송함.
	out.write(jsonText);
%> 