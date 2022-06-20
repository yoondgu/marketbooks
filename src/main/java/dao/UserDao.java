package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.User;

public class UserDao {
	private static UserDao instance = new UserDao();
	private UserDao() {}
	public static UserDao getInstance() {
		return instance;
	}

	private DaoHelper helper = DaoHelper.getInstance();
	/**
	 * 지정된 이메일과 일치하는 사용자정보를 반환한다.
	 * @param email 이메일
	 * @return 사용자 정보, 일치하는 정보가 없으면 null이 반환된다.
	 * @throws SQLException
	 */
	public User getUserByEmail(String email) throws SQLException {
		String sql = "select * "
				   + "from hta_users "
				   + "where user_email = ? ";
		
		return helper.selectOne(sql, rs -> {
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setEmail(rs.getString("user_email"));
			user.setPassword(rs.getString("user_password"));
			user.setName(rs.getString("user_name"));
			user.setTel(rs.getString("user_tel"));
			user.setCreatedDate(rs.getDate("user_created_date"));
			
			return user;
		}, email);
	}
	
}
