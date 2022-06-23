<%@page import="dto.InquiryDto"%>
<%@page import="dao.InquiryDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="common/500.jsp"%>
<%
	// 세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("게시글 삭제는 로그인 후 사용가능한 서비스입니다.");
	}
	
	// 요청파라미터에서 게시글번호를 조회한다.
	int inquiryNo = StringUtil.stringToInt(request.getParameter("no"));
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	
	// 게시글번호에 해당하는 게시글 정보를 조회한다.
	InquiryDao inquiryDao = InquiryDao.getInstance();
	InquiryDto inquiry = inquiryDao.getInquiryByNo(inquiryNo);
	
	// 게시글정보가 없으면 재요청 URL을 응답으로보낸다.
	if (inquiry == null) {
		throw new RuntimeException("게시글 정보가 존재하지 않습니다.");
	}
	
	// 게시글 작성자번호와 로그인한 사용자 번호가 다르면 재요청 URL을 응답으로 보낸다.
	if (inquiry.getUserNo() != user.getNo()) {
		throw new RuntimeException("다른 사람이 작성한 글은 삭제할 수 없습니다.");
	}
	
	// 게시글 정보의 삭제여부를 Y로 변경한다.
	inquiry.setDeleted("Y");
	// 변경된 게시글 정보를 데이터베이스에 반영시킨다.
	inquiryDao.updateInquiry(inquiry);
	
	// 게시글목록을 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("inquiry.jsp?page=" +currentPage);
	
%>