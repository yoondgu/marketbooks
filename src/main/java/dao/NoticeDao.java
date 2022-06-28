package dao;

import java.sql.SQLException;
import java.util.List;

import dto.InquiryDto;
import helper.DaoHelper;
import vo.Inquiry;
import vo.Notice;

public class NoticeDao {

	
	private static NoticeDao instance = new NoticeDao();
	private NoticeDao() {}
	public static NoticeDao getInstance() {
		return instance;
	} 
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public void insertNotice(Notice notice) throws SQLException {
		String sql = "insert into hta_notices "
				   + "(notice_no, notice_title, notice_content) "
				   + "values "
				   + "(notices_seq.nextval, ?, ?) ";
		
		helper.insert(sql, notice.getTitle(), notice.getContent());
	}
	
	public int getTotalRows() throws SQLException {
	      String sql = "select count(*) cnt "
	               + "from hta_notices "
	               + "where notice_deleted = 'N' ";
	      
	      return helper.selectOne(sql, rs -> {
	         return rs.getInt("cnt");
	      });
	   }
	
	public int getTotalRows(String keyword) throws SQLException {
	      String sql = "select count(*) cnt "
	               + "from hta_notices "
	               + "where notice_deleted = 'N' and notice_title like '%' || ? || '%' ";
	               
	      return helper.selectOne(sql, rs -> {
	         return rs.getInt("cnt");
	      }, keyword);
   }
	
	/**
	 * 모든 공지사항 조회
	 * @param beginIndex
	 * @param endIndex
	 * @return
	 * @throws SQLException
	 */
	public List<Notice> getAllNotices(int beginIndex, int endIndex) throws SQLException {
		String sql = "SELECT NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DELETED, NOTICE_CREATED_DATE, NOTICE_UPDATED_DATE, NOTICE_VIEWCOUNT "
				   + "FROM (SELECT NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DELETED, NOTICE_CREATED_DATE, NOTICE_UPDATED_DATE, NOTICE_VIEWCOUNT, "
				   + "ROW_NUMBER() OVER (ORDER BY NOTICE_NO DESC) R "
				   + "FROM HTA_NOTICES WHERE NOTICE_DELETED ='N') "
				   + "WHERE R >= ? AND R <= ? "
				   + "ORDER BY NOTICE_NO DESC ";
	
		return helper.selectList(sql, rs-> {
			Notice notice = new Notice();
					
			notice.setNo(rs.getInt("notice_no"));
			notice.setTitle(rs.getString("notice_title"));
			notice.setContent(rs.getString("notice_content"));
			notice.setDeleted(rs.getString("notice_deleted"));
			notice.setCreatedDate(rs.getDate("notice_created_date"));
			notice.setUpdatedDate(rs.getDate("notice_updated_date"));
			notice.setViewCount(rs.getInt("notice_viewcount"));
			
			return notice;
		},beginIndex, endIndex);
	}
	
	public List<Notice> getAllNotices(int beginIndex, int endIndex, String keyword) throws SQLException {
		String sql = "SELECT NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DELETED, NOTICE_CREATED_DATE, NOTICE_UPDATED_DATE, NOTICE_VIEWCOUNT "
				   + "FROM (SELECT NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DELETED, NOTICE_CREATED_DATE, NOTICE_UPDATED_DATE, NOTICE_VIEWCOUNT, "
				   + "ROW_NUMBER() OVER (ORDER BY NOTICE_NO DESC) R "
				   + "FROM HTA_NOTICES "
				   + "WHERE NOTICE_TITLE like '%' || ? || '%' AND NOTICE_DELETED ='N') "
				   + "WHERE R >= ? AND R <= ? "
				   + "ORDER BY NOTICE_NO DESC ";
	
		return helper.selectList(sql, rs-> {
			Notice notice = new Notice();
					
			notice.setNo(rs.getInt("notice_no"));
			notice.setTitle(rs.getString("notice_title"));
			notice.setContent(rs.getString("notice_content"));
			notice.setDeleted(rs.getString("notice_deleted"));
			notice.setCreatedDate(rs.getDate("notice_created_date"));
			notice.setUpdatedDate(rs.getDate("notice_updated_date"));
			notice.setViewCount(rs.getInt("notice_viewcount"));
			
			return notice;
		},keyword, beginIndex, endIndex);
	}
	
	/**
	 * 번호를 전달받아 공지사항 정보 조회
	 * @param noticeNo
	 * @return
	 * @throws SQLException
	 */
	public Notice getNoticeByNo(int noticeNo) throws SQLException {
		String sql = "SELECT NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DELETED, NOTICE_CREATED_DATE, NOTICE_UPDATED_DATE, NOTICE_VIEWCOUNT "
				   + "FROM HTA_NOTICES "
				   + "WHERE NOTICE_NO = ? ";
		
		return helper.selectOne(sql, rs-> {
			Notice notice = new Notice();
			
			notice.setNo(rs.getInt("notice_no"));
			notice.setTitle(rs.getString("notice_title"));
			notice.setContent(rs.getString("notice_content"));
			notice.setDeleted(rs.getString("notice_deleted"));
			notice.setCreatedDate(rs.getDate("notice_created_date"));
			notice.setUpdatedDate(rs.getDate("notice_updated_date"));
			notice.setViewCount(rs.getInt("notice_viewcount"));
			return notice;
		}, noticeNo);
	}
	
	public void updateNotice(Notice notice) throws SQLException {
		String sql = "UPDATE HTA_NOTICES "
				   + "SET "
				   + " 		NOTICE_TITLE = ?, "
				   + "		NOTICE_CONTENT = ?, "
				   + "		NOTICE_DELETED = ?, "
				   + "		NOTICE_UPDATED_DATE = SYSDATE, "
				   + "      NOTICE_VIEWCOUNT = ? "
				   + "WHERE NOTICE_NO = ? ";
		
	    helper.update(sql, notice.getTitle(), notice.getContent(), notice.getDeleted(), notice.getViewCount(), notice.getNo());
	}
}
