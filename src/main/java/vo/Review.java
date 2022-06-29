package vo;

import java.util.Date;

public class Review {
	private int no;
	private String title;
	private String content;
	private int bookNo;
	private int userNo;
	private User writer;
	private String deleted;
	private Date reviewCreatedDate;
	private Date reviewUpdatedDate;
	private int reviewViewcount;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
	
	public String getHtmlContent() {
		if (content == null) {
			return "";
		}
		return content.replace(System.lineSeparator(), "<br />");
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	
	public User getWriter() {
		return writer;
	}

	public void setWriter(User writer) {
		this.writer = writer;
	}
	
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public Date getReviewCreatedDate() {
		return reviewCreatedDate;
	}
	public void setReviewCreatedDate(Date reviewCreatedDate) {
		this.reviewCreatedDate = reviewCreatedDate;
	}
	public Date getReviewUpdatedDate() {
		return reviewUpdatedDate;
	}
	public void setReviewUpdatedDate(Date reviewUpdatedDate) {
		this.reviewUpdatedDate = reviewUpdatedDate;
	}
	public int getReviewViewcount() {
		return reviewViewcount;
	}
	public void setReviewViewcount(int reviewViewcount) {
		this.reviewViewcount = reviewViewcount;
	}
	
	
}
