<%@page import="util.StringUtil"%>
<%@page import="util.MultipartRequest"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="dao.InquiryDao"%>
<%@page import="vo.Inquiry"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 세션에 저장된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("게시글 등록은 로그인 후 사용가능한 서비스입니다.");
	}
	
	// multipart/form-data 요청을 처리하는 MultipartRequest 객체 생성하기
	MultipartRequest mr = new MultipartRequest(request, "C:\\eclipse\\workspace-web\\attached-file");	
	
	// 요청파라미터값을 조회한다.
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	// 업로드된 파일의 이름을 조회하다.
	// String filename = mr.getParameter("upfile");
	
	// inquiry 객체를 생성해서 게시글 정보를 저장한다.
	Inquiry inquiry = new Inquiry();
	inquiry.setTitle(title);
	inquiry.setUserNo(user.getNo());
	inquiry.setContent(content);
	// inquiry.setFilename(filename);

	// 게시글 정보를 데이터베이스에 저장시킨다.
	InquiryDao inquiryDao = InquiryDao.getInstance();
	inquiryDao.insertInquiry(inquiry);

	// 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("inquiry.jsp?page=1");
%>