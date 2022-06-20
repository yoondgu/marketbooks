package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.InquiryDto;
import helper.DaoHelper;
import vo.Inquiry;

public class InquiryDao {

	private static InquiryDao instance = new InquiryDao();
	private InquiryDao() {}
	public static InquiryDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	/**
	 * 모든 1:1 문의글 조회하기 
	 * @return 
	 * @throws SQLException
	 */
	public List<InquiryDto> getAllInquiries() throws SQLException {
		String sql = "SELECT I.INQUIRY_NO, I.USER_NO, U.USER_NAME, I.INQUIRY_TITLE, I.INQUIRY_CONTENT, I.INQUIRY_DELETED, I.INQUIRY_CREATED_DATE, I.INQUIRY_UPDATED_DATE, I.INQUIRY_ANSWER_CONTENT,I.INQUIRY_ANSWER_CREATED_DATE, I.INQUIRY_ANSWER_UPDATED_DATE, I.INQUIRY_ANSWER_STATUS "
				   + "FROM HTA_INQUIRIES I, HTA_USERS U "
				   + "WHERE I.USER_NO = U.USER_NO ";
		return helper.selectList(sql, rs-> {
			InquiryDto inquiry = new InquiryDto();
					
			inquiry.setNo(rs.getInt("inquiry_no"));
			inquiry.setUserNo(rs.getInt("user_no"));
			inquiry.setUserName(rs.getString("user_name"));
			inquiry.setTitle(rs.getString("inquiry_title"));
			inquiry.setContent(rs.getString("inquiry_content"));
			inquiry.setDeleted(rs.getString("inquiry_deleted"));
			inquiry.setCreatedDate(rs.getDate("inquiry_created_date"));
			inquiry.setUpdatedDate(rs.getDate("inquiry_updated_date"));
			inquiry.setAnswerContent(rs.getString("inquiry_answer_content"));
			inquiry.setAnswerCreatedDate(rs.getDate("inquiry_answer_created_date"));
			inquiry.setAnswerUpdatedDate(rs.getDate("inquiry_answer_updated_date"));
			inquiry.setAnswerStatus(rs.getString("inquiry_answer_status"));
					
			return inquiry;
		});

	}
}
