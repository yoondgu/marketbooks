<%@page import="util.MultipartRequest"%>
<%@page import="dto.InquiryDto"%>
<%@page import="dao.InquiryDao"%>
<%@page import="vo.Inquiry"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	User user = (User) session.getAttribute("LOGINED_USER");
	if (!"admin@gmail.com".equals(user.getEmail())) {
		throw new RuntimeException("답변은 관리자만 가능한 서비스 입니다.");
	}
	
	// 요청파라미터에서 게시글 번호와 페이지번호를 조회한다.
	
	int inquiryNo = StringUtil.stringToInt(request.getParameter("no"));
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	
	// 게시글 번호에 해당하는 게시글 정보를 조회한다.
	InquiryDao inquiryDao = InquiryDao.getInstance();
	InquiryDto inquiry = inquiryDao.getInquiryByNo(inquiryNo);
	
	if ("Y".equals(inquiry.getAnswerStatus())) {
		throw new RuntimeException("이미 답변등록이 되었습니다.");
	}
	// 게시글 정보가 없으면 재요청URL을 응답으로 보낸다.
	if (inquiry == null) {
		throw new RuntimeException("게시글 정보가 존재하지 않습니다.");
	}
	
	// 요청파라미터에서 수정된 제목과 내용을 조회한다.
	String answerContent = request.getParameter("answerContent");
	
	// 조회된 게시글 정보의 제목과 내용을 갱신한다.
	inquiry.setAnswerContent(answerContent);
	inquiry.setAnswerStatus("Y");
	// 갱신된 게시글정보를 데이터베이스에 반영시킨다.
	inquiryDao.updateInquiry(inquiry);
	
	// 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("detail.jsp?no="+inquiry.getNo()+"&page="+currentPage);
%>