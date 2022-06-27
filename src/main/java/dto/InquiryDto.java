package dto;

import java.util.Date;

public class InquiryDto {
	private int no;
	private int userNo;
	private String userName;
	private String title;
	private String content;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;
	private String answerContent;
	private String answerStatus;
	private Date answerCreatedDate;
	private Date answerUpdatedDate;
	
	public InquiryDto() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public String getHtmlContent() {
		if (content == null) {
			return "";
		}
		return content.replace(System.lineSeparator(), "<br />");
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getAnswerContent() {
		return answerContent;
	}

	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}
	
	public String getHtmlAnswerContent() {
		if (answerContent == null) {
			return "";
		}
		return answerContent.replace(System.lineSeparator(), "<br />");
	}

	public String getAnswerStatus() {
		return answerStatus;
	}

	public void setAnswerStatus(String answerStatus) {
		this.answerStatus = answerStatus;
	}

	public Date getAnswerCreatedDate() {
		return answerCreatedDate;
	}

	public void setAnswerCreatedDate(Date answerCreatedDate) {
		this.answerCreatedDate = answerCreatedDate;
	}

	public Date getAnswerUpdatedDate() {
		return answerUpdatedDate;
	}

	public void setAnswerUpdatedDate(Date answerUpdatedDate) {
		this.answerUpdatedDate = answerUpdatedDate;
	}
	
	
	
}
