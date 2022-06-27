<%@page import="dao.NoticeDao"%>
<%@page import="vo.Notice"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("게시글 등록은 로그인 후 사용가능한 서비스입니다.");
	}
	// 요청파라미터값을 조회한다.
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);

	System.out.println(title);
	System.out.println(content);
	
	// notice 객체를 생성해서 공지사항 정보를 저장한다.
	Notice notice = new Notice();
	notice.setTitle(title);
	notice.setContent(content);
	
	// 공지사항 정보를 데이터베이스에 저장시킨다.
	NoticeDao noticeDao = NoticeDao.getInstance();
	noticeDao.insertNotice(notice);
	
	// 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("list.jsp?page=" + currentPage);
%>
