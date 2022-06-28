<%@page import="vo.Notice"%>
<%@page import="dao.NoticeDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="common/500.jsp"%>
<%
	// 세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (!"admin@gmail.com".equals(user.getEmail())) {
		throw new RuntimeException("공지사항 삭제는 관리자만 사용가능한 서비스입니다.");
	}
	
	// 요청파라미터에서 공지사항 번호를 조회한다.
	int noticeNo = StringUtil.stringToInt(request.getParameter("no"));
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	
	// 공지사항 번호에 해당하는 게시글 정보를 조회한다.
	NoticeDao noticeDao = NoticeDao.getInstance();
	Notice notice = noticeDao.getNoticeByNo(noticeNo);
	
	// 공지사항 정보가 없으면 재요청 URL을 응답으로보낸다.
	if (notice == null) {
		throw new RuntimeException("게시글 정보가 존재하지 않습니다.");
	}
	
	// 게시글 정보의 삭제여부를 Y로 변경한다.
	notice.setDeleted("Y");
	// 변경된 게시글 정보를 데이터베이스에 반영시킨다.
	noticeDao.updateNotice(notice);
	
	// 게시글목록을 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("list.jsp?page="+currentPage);
%>