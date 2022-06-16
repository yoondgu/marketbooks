package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import helper.DaoHelper;
import util.ConnectionUtil;
import vo.User;

public class UserDao {

	private static UserDao instance = new UserDao();
	private UserDao() {}
	public static UserDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public User getUserByNo(int userNo) throws SQLException {
		String sql = "select user_no, user_email, user_name, user_tel, user_deleted, user_created_date, user_updated_date "
				   + "from (select row_number() over (order by user_no desc) row_number, user_no, user_email, "
				   + "			   user_name, user_tel, user_deleted, user_created_date, user_updated_date "
				   + "      from hta_users"
				   // 관리자는 userlist에서 제외시킨다.
				   + "		where user_email != 'admin@gmail.com'"
				   + "		) "
				   + "where user_no = ? ";
		
	}
	
	public List<User> getAllUsers() throws SQLException {
		
	}
	
	public List<User> getUsers(int beginIndex, int endIndex) throws SQLException {
		String sql = "select user_no, user_email, user_name, user_tel, user_deleted, user_created_date, user_updated_date "
				   + "from (select row_number() over (order by user_no desc) row_number, user_no, user_email, "
				   + "			   user_name, user_tel, user_deleted, user_created_date, user_updated_date "
				   + "      from hta_users"
				   // 관리자는 userlist에서 제외시킨다.
				   + "		where user_email != 'admin@gmail.com'"
				   + "		) "
				   + "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
			
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setEmail(rs.getString("user_email"));
			user.setName(rs.getString("user_name"));
			user.setTel(rs.getString("user_tel"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
			user.setUpdatedDate(rs.getDate("user_updated_date"));
			
			return user;
		}, beginIndex, endIndex);
	}
	
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt from hta_users ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
}
