package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.InquiryDto;
import helper.DaoHelper;
import util.ConnectionUtil;
import vo.Inquiry;

public class InquiryDao {

	private static InquiryDao instance = new InquiryDao();
	private InquiryDao() {}
	public static InquiryDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public void insertInquiry(Inquiry inquiry) throws SQLException {
		String sql = "insert into hta_inquiries "
				   + "(inquiry_no, inquiry_title, inquiry_content, user_no) "
				   + "values "
				   + "(inquiries_seq.nextval, ?, ?, ?) ";
		
		helper.insert(sql, inquiry.getTitle(), inquiry.getContent(), inquiry.getUserNo());
	}
	
	/**
	 * 관리자가 조회하는 경우 모든 문의사항 Rows 조회
	 * @return
	 * @throws SQLException
	 */
	public int getTotalRows() throws SQLException {
	      String sql = "select count(*) cnt "
	               + "from hta_inquiries "
	               + "where inquiry_deleted = 'N' ";
	      
	      return helper.selectOne(sql, rs -> {
	         return rs.getInt("cnt");
	      });
	   }
	// 답변상태 구분하여 Rows 조회
	public int getTotalRows(String status) throws SQLException {
	      String sql = "select count(*) cnt "
	               + "from hta_inquiries "
	               + "where inquiry_deleted = 'N' "
	               + "and inquiry_answer_status = ? ";
	      
	      return helper.selectOne(sql, rs -> {
	         return rs.getInt("cnt");
	      }, status);
	   }
	
	
	public int getTotalRows(int userNo) throws SQLException {
	      String sql = "select count(*) cnt "
	               + "from hta_inquiries "
	               + "where inquiry_deleted = 'N' "
	               + "and user_no = ? ";
	      
	      return helper.selectOne(sql, rs -> {
	         return rs.getInt("cnt");
	      }, userNo);
	   }
	
	public int getTotalRows(int userNo, String status) throws SQLException {
	      String sql = "select count(*) cnt "
	               + "from hta_inquiries "
	               + "where inquiry_deleted = 'N' "
	               + "and user_no = ? "
	               + "and inquiry_answer_status = ? ";
	      
	      return helper.selectOne(sql, rs -> {
	         return rs.getInt("cnt");
	      }, userNo, status);
	   }
	   
    public int getTotalRows(String keyword, int userNo) throws SQLException {
	      String sql = "select count(*) cnt "
	               + "from hta_inquiries "
	               + "where inquiry_deleted = 'N' and inquiry_title like '%' || ? || '%' "
	               + "and user_no = ? ";
	      
	      return helper.selectOne(sql, rs -> {
	         return rs.getInt("cnt");
	      }, keyword, userNo);
    }
    
    /** 
	 * 관리자일 경우 모든 1:1 문의글 조회하기 
	 * @return inquiry 게시글 정보
	 * @throws SQLException
	 */
    
	public List<InquiryDto> getAllInquiries(int beginIndex, int endIndex) throws SQLException {
		String sql = "SELECT I.INQUIRY_NO, U.USER_NO, U.USER_NAME, I.INQUIRY_TITLE, I.INQUIRY_CONTENT, I.INQUIRY_DELETED, I.INQUIRY_CREATED_DATE, I.INQUIRY_UPDATED_DATE, I.INQUIRY_ANSWER_CONTENT,I.INQUIRY_ANSWER_CREATED_DATE, I.INQUIRY_ANSWER_UPDATED_DATE, I.INQUIRY_ANSWER_STATUS "
				   + "FROM (SELECT INQUIRY_NO, USER_NO, INQUIRY_TITLE, INQUIRY_CONTENT, INQUIRY_DELETED, INQUIRY_CREATED_DATE, INQUIRY_UPDATED_DATE, INQUIRY_ANSWER_CONTENT, INQUIRY_ANSWER_CREATED_DATE, INQUIRY_ANSWER_UPDATED_DATE, INQUIRY_ANSWER_STATUS, "
				   + "		ROW_NUMBER() OVER (ORDER BY INQUIRY_NO DESC) ROW_NUMBER "
				   + "		FROM HTA_INQUIRIES WHERE INQUIRY_DELETED = 'N') I , HTA_USERS U "
				   + "WHERE I.USER_NO = U.USER_NO "
				   + "AND I.ROW_NUMBER >= ? AND I.ROW_NUMBER <= ? "
				   + "ORDER BY I.INQUIRY_NO DESC ";
		
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
		}, beginIndex, endIndex);
	}
		
	/**
	 * 관리자일 경우 모든 1:1 문의글 조회하기 답변상태 구분 조회
	 * @return inquiry 게시글 정보
	 * @throws SQLException
	 */
    
	public List<InquiryDto> getAllInquiries(int beginIndex, int endIndex, String status) throws SQLException {
		String sql = "SELECT I.INQUIRY_NO, U.USER_NO, U.USER_NAME, I.INQUIRY_TITLE, I.INQUIRY_CONTENT, I.INQUIRY_DELETED, I.INQUIRY_CREATED_DATE, I.INQUIRY_UPDATED_DATE, I.INQUIRY_ANSWER_CONTENT,I.INQUIRY_ANSWER_CREATED_DATE, I.INQUIRY_ANSWER_UPDATED_DATE, I.INQUIRY_ANSWER_STATUS "
				   + "FROM (SELECT INQUIRY_NO, USER_NO, INQUIRY_TITLE, INQUIRY_CONTENT, INQUIRY_DELETED, INQUIRY_CREATED_DATE, INQUIRY_UPDATED_DATE, INQUIRY_ANSWER_CONTENT, INQUIRY_ANSWER_CREATED_DATE, INQUIRY_ANSWER_UPDATED_DATE, INQUIRY_ANSWER_STATUS, "
				   + "		ROW_NUMBER() OVER (ORDER BY INQUIRY_NO DESC) ROW_NUMBER "
				   + "		FROM HTA_INQUIRIES WHERE INQUIRY_DELETED = 'N' AND INQUIRY_ANSWER_STATUS = ?) I , HTA_USERS U "
				   + "WHERE I.USER_NO = U.USER_NO "
				   + "AND I.ROW_NUMBER >= ? AND I.ROW_NUMBER <= ? "
				   + "ORDER BY I.INQUIRY_NO DESC ";
		
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
		},status, beginIndex, endIndex);
		
	}
	
	/**
	 * 페이징처리한 1:1문의 게시글 조회하기
	 * @param beginIndex 페이지 시작번호
	 * @param endIndex 페이지 끝번호
	 * @return inquiry 게시글 정보
	 * @throws SQLException
	 */
	public List<InquiryDto> getInquiries(int beginIndex, int endIndex, int userNo) throws SQLException {
		String sql = "SELECT I.INQUIRY_NO, U.USER_NO, U.USER_NAME, I.INQUIRY_TITLE, I.INQUIRY_CONTENT, I.INQUIRY_DELETED, I.INQUIRY_CREATED_DATE, I.INQUIRY_UPDATED_DATE, I.INQUIRY_ANSWER_CONTENT,I.INQUIRY_ANSWER_CREATED_DATE, I.INQUIRY_ANSWER_UPDATED_DATE, I.INQUIRY_ANSWER_STATUS "
				   + "FROM (SELECT INQUIRY_NO, USER_NO, INQUIRY_TITLE, INQUIRY_CONTENT, INQUIRY_DELETED, INQUIRY_CREATED_DATE, INQUIRY_UPDATED_DATE, INQUIRY_ANSWER_CONTENT, INQUIRY_ANSWER_CREATED_DATE, INQUIRY_ANSWER_UPDATED_DATE, INQUIRY_ANSWER_STATUS, "
				   + "		ROW_NUMBER() OVER (ORDER BY INQUIRY_NO DESC) ROW_NUMBER "
				   + "		FROM HTA_INQUIRIES "
				   + "      WHERE USER_NO = ?"
				   + "		AND INQUIRY_DELETED = 'N') I , HTA_USERS U "
				   + "WHERE I.USER_NO = U.USER_NO "
				   + "AND I.ROW_NUMBER >= ? AND I.ROW_NUMBER <= ? "
				   + "ORDER BY I.INQUIRY_NO DESC ";
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
		},userNo, beginIndex, endIndex);
	}
	
	/**
	 * 페이징처리한 1:1문의 게시글 조회하기
	 * 답변상태 구분
	 * @param beginIndex 페이지 시작번호
	 * @param endIndex 페이지 끝번호
	 * @return inquiry 게시글 정보
	 * @throws SQLException
	 */
	public List<InquiryDto> getInquiries(int beginIndex, int endIndex, int userNo, String status) throws SQLException {
		String sql = "SELECT I.INQUIRY_NO, U.USER_NO, U.USER_NAME, I.INQUIRY_TITLE, I.INQUIRY_CONTENT, I.INQUIRY_DELETED, I.INQUIRY_CREATED_DATE, I.INQUIRY_UPDATED_DATE, I.INQUIRY_ANSWER_CONTENT,I.INQUIRY_ANSWER_CREATED_DATE, I.INQUIRY_ANSWER_UPDATED_DATE, I.INQUIRY_ANSWER_STATUS "
				   + "FROM (SELECT INQUIRY_NO, USER_NO, INQUIRY_TITLE, INQUIRY_CONTENT, INQUIRY_DELETED, INQUIRY_CREATED_DATE, INQUIRY_UPDATED_DATE, INQUIRY_ANSWER_CONTENT, INQUIRY_ANSWER_CREATED_DATE, INQUIRY_ANSWER_UPDATED_DATE, INQUIRY_ANSWER_STATUS, "
				   + "		ROW_NUMBER() OVER (ORDER BY INQUIRY_NO DESC) ROW_NUMBER "
				   + "		FROM HTA_INQUIRIES "
				   + "      WHERE USER_NO = ?"
				   + "		AND INQUIRY_DELETED = 'N' "
				   + "      AND INQUIRY_ANSWER_STATUS = ? ) I , HTA_USERS U "
				   + "WHERE I.USER_NO = U.USER_NO "
				   + "AND I.ROW_NUMBER >= ? AND I.ROW_NUMBER <= ? "
				   + "ORDER BY I.INQUIRY_NO DESC ";
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
		},userNo, status, beginIndex, endIndex);
	}
	
	/**
	 * 1:1 문의 게시글 번호를 입력받아 게시글 정보를 반환
	 * @param inquiryNo 1:1 문의 게시글 번호
	 * @return inquiry 게시글 정보
	 * @throws SQLException
	 */
	public InquiryDto getInquiryByNo(int inquiryNo) throws SQLException {
		String sql = "SELECT I.INQUIRY_NO, U.USER_NO, U.USER_NAME, I.INQUIRY_TITLE, I.INQUIRY_CONTENT, I.INQUIRY_DELETED, I.INQUIRY_CREATED_DATE, I.INQUIRY_UPDATED_DATE, I.INQUIRY_ANSWER_CONTENT,I.INQUIRY_ANSWER_CREATED_DATE, I.INQUIRY_ANSWER_UPDATED_DATE, I.INQUIRY_ANSWER_STATUS "
				   + "FROM HTA_INQUIRIES I, HTA_USERS U "
				   + "WHERE I.INQUIRY_NO = ? "
				   + "AND I.USER_NO = U.USER_NO ";
		
		return helper.selectOne(sql, rs-> { 
			
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
			
		}, inquiryNo);
	}
	
	public void updateInquiry(InquiryDto inquiry) throws SQLException {
		String sql = "UPDATE HTA_INQUIRIES "
				   + "SET "
				   + " 		INQUIRY_TITLE = ?, "
				   + "		INQUIRY_CONTENT = ?, "
				   + "		INQUIRY_DELETED = ?, "
				   + "		INQUIRY_ANSWER_CONTENT = ?, "
				   + "		INQUIRY_ANSWER_STATUS = ?, "
				   + "      INQUIRY_ANSWER_CREATED_DATE = SYSDATE, "
				   + "		INQUIRY_UPDATED_DATE = SYSDATE "
				   + "WHERE INQUIRY_NO = ? ";
		
	    helper.update(sql, inquiry.getTitle(), inquiry.getContent(), inquiry.getDeleted(), inquiry.getAnswerContent(), inquiry.getAnswerStatus(), inquiry.getNo());
	}
	
	public List<InquiryDto> getRecentInquiries() throws SQLException {
		String sql = "SELECT I.INQUIRY_NO, U.USER_NO, U.USER_NAME, I.INQUIRY_TITLE, I.INQUIRY_CONTENT, I.INQUIRY_DELETED, I.INQUIRY_CREATED_DATE, I.INQUIRY_UPDATED_DATE, I.INQUIRY_ANSWER_CONTENT,I.INQUIRY_ANSWER_CREATED_DATE, I.INQUIRY_ANSWER_UPDATED_DATE, I.INQUIRY_ANSWER_STATUS "
				   + "FROM (SELECT INQUIRY_NO, USER_NO, INQUIRY_TITLE, INQUIRY_CONTENT, INQUIRY_DELETED, INQUIRY_CREATED_DATE, INQUIRY_UPDATED_DATE, INQUIRY_ANSWER_CONTENT, INQUIRY_ANSWER_CREATED_DATE, INQUIRY_ANSWER_UPDATED_DATE, INQUIRY_ANSWER_STATUS, "
				   + "		ROW_NUMBER() OVER (ORDER BY INQUIRY_NO DESC) ROW_NUMBER "
				   + "		FROM HTA_INQUIRIES WHERE INQUIRY_DELETED = 'N') I , HTA_USERS U "
				   + "WHERE I.USER_NO = U.USER_NO "
				   + "AND I.ROW_NUMBER >= ? AND I.ROW_NUMBER <= ? "
				   + "ORDER BY I.INQUIRY_NO DESC ";
		
		List<InquiryDto> recentInq = new ArrayList<>();
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, 1);
		pstmt.setInt(2, 3);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
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
			
			recentInq.add(inquiry);
		}
		rs.close();
		connection.close();
		pstmt.close();
		
		return recentInq;
	}
}
