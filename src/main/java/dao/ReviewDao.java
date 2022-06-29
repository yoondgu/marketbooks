package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Book;
import vo.Review;
import vo.User;

public class ReviewDao {
	
	private static ReviewDao instance = new ReviewDao();
	private ReviewDao() {}
	public static ReviewDao getInstance() {
		return instance;
	} 
	
private DaoHelper helper = DaoHelper.getInstance();
	
	public void insertReview(Review review) throws SQLException {
		String sql = "insert into hta_book_reviews "
				   + "(review_no, review_title, review_content) "
				   + "values "
				   + "(reviews_seq.nextval, ?, ?) ";
		
		helper.insert(sql, review.getTitle(), review.getContent());
	}
	
	public int getTotalRows(int bookNo) throws SQLException {
	      String sql = "select count(*) cnt "
	               + "from hta_book_reviews "
	               + "where review_deleted = 'N' "
	               + "and book_no = ? ";
	      
	      return helper.selectOne(sql, rs -> {
	         return rs.getInt("cnt");
	      },bookNo);
	   }
	
	
	/**
	 * 모든 리뷰 조회
	 * @param beginIndex
	 * @param endIndex
	 * @return
	 * @throws SQLException
	 */
	public List<Review> getAllReviews(int beginIndex, int endIndex) throws SQLException {
		String sql = "SELECT REVIEW_NO, REVIEW_TITLE, REVIEW_CONTENT, BOOK_NO, USER_NO, REVIEW_DELETED, REVIEW_CREATED_DATE, REVIEW_UPDATED_DATE, REVIEW_VIEWCOUNT "
				   + "FROM (SELECT REVIEW_NO, REVIEW_TITLE, REVIEW_CONTENT, BOOK_NO, USER_NO, REVIEW_DELETED, REVIEW_CREATED_DATE, REVIEW_UPDATED_DATE, REVIEW_VIEWCOUNT, "
				   + "ROW_NUMBER() OVER (ORDER BY REVIEW_NO DESC) R "
				   + "FROM HTA_BOOK_REVIEWS WHERE REVIEW_DELETED ='N') "
				   + "WHERE R >= ? AND R <= ? "
				   + "ORDER BY REVIEW_NO DESC ";
	
		return helper.selectList(sql, rs-> {
			Review review = new Review();
					
			review.setNo(rs.getInt("review_no"));
			review.setTitle(rs.getString("review_title"));
			review.setContent(rs.getString("review_content"));
			review.setBookNo(rs.getInt("book_no"));
			review.setUserNo(rs.getInt("user_no"));
			review.setDeleted(rs.getString("review_deleted"));
			review.setReviewCreatedDate(rs.getDate("review_created_date"));
			review.setReviewUpdatedDate(rs.getDate("review_updated_date"));
			review.setReviewViewcount(rs.getInt("review_viewcount"));
			
			return review;
		},beginIndex, endIndex);
	}
	
	
	/**
	 * 책번호를 전달받아 리뷰 정보 조회
	 * @param bookNo
	 * @return
	 * @throws SQLException
	 */
	public List<Review> getReviewsByNo(int bookNo, int beginIndex, int endIndex) throws SQLException {
		String sql = "SELECT R.REVIEW_NO, R.REVIEW_TITLE, R.REVIEW_CONTENT, R.BOOK_NO, R.USER_NO, U.USER_NAME, R.REVIEW_DELETED, R.REVIEW_CREATED_DATE, R.REVIEW_UPDATED_DATE "
				   + "FROM (SELECT REVIEW_NO, REVIEW_TITLE, REVIEW_CONTENT, BOOK_NO, USER_NO, REVIEW_DELETED, REVIEW_CREATED_DATE, REVIEW_UPDATED_DATE, "
				   + "ROW_NUMBER() OVER (ORDER BY REVIEW_NO DESC) R "
				   + "FROM HTA_BOOK_REVIEWS "
				   + "WHERE REVIEW_DELETED ='N' "
				   + "AND BOOK_NO = ? ) R , HTA_USERS U "
				   + "WHERE R.R >= ? AND R.R <= ? "
				   + "AND R.USER_NO = U.USER_NO "
				   + "ORDER BY R.REVIEW_NO DESC ";
		
		return helper.selectList(sql, rs-> {
			Review review = new Review();
					
			review.setNo(rs.getInt("review_no"));
			review.setTitle(rs.getString("review_title"));
			review.setContent(rs.getString("review_content"));
			review.setBookNo(rs.getInt("book_no"));
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setName(rs.getString("user_name"));
			review.setWriter(user);
			
			review.setDeleted(rs.getString("review_deleted"));
			review.setReviewCreatedDate(rs.getDate("review_created_date"));
			review.setReviewUpdatedDate(rs.getDate("review_updated_date"));
			
			return review;
		},bookNo, beginIndex, endIndex);
	}
	
	public void updateReview(Review review) throws SQLException {
		String sql = "UPDATE HTA_book_reivews "
				   + "SET "
				   + " 		REVIEW_TITLE = ?, "
				   + "		REVIEW_CONTENT = ?, "
				   + "		REVIEW_DELETED = ?, "
				   + "		REVIEW_UPDATED_DATE = SYSDATE, "
				   + "      REVIEW_VIEWCOUNT = ? "
				   + "WHERE REVIEW_NO = ? ";
		
	    helper.update(sql, review.getTitle(), review.getContent(), review.getDeleted(), review.getReviewViewcount(), review.getNo());
	}
}
	
	
