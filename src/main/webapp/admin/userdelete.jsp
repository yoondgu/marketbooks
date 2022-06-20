<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	// 요청파라미터에서 사용자번호를 조회한다.
	int userNo = StringUtil.stringToInt(request.getParameter("no"));
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	
	// 사용자번호에 해당하는 유저 정보를 조회한다.
	UserDao userDao = UserDao.getInstance();
	User user = userDao.getUserByNo(userNo);
	
	// 유저정보가 없으면 재요청 URL을 응답으로 보낸다.
	if (user == null) {
		throw new RuntimeException("회원 정보가 존재하지 않습니다.");
	}
	
	// 유저 정보의 삭제여부를 Y로 변경한다.
	user.setDeleted("Y");
	// 변경된 유저 정보를 데이터베이스에 반영시킨다.
	userDao.updateUser(user);
	
	// 유저목록을 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("../userlist.jsp");
%>