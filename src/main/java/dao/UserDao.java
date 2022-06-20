package dao;

import java.sql.SQLException;
import java.util.List;
import helper.DaoHelper;
import vo.User;
import vo.UserAddress;

public class UserDao {

	private static UserDao instance = new UserDao();
	private UserDao() {}
	public static UserDao getInstance() {
		return instance;
	}
  
	
	private DaoHelper helper = helper.getInstance();
    
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
	
	public User getUserByNo(int userNo) throws SQLException {
		String sql = "select u.user_no, u.user_email, u.user_name, u.user_tel, u.user_deleted, u.user_created_date, u.user_updated_date, "
				   +	     "a.user_address, a.user_detail_address, a.postal_code "
				   + "from hta_users u, hta_user_addresses a "
				   // 관리자는 userlist에서 제외시킨다.
				   + "where u.user_email != 'admin@gmail.com' "
				   + "and u.user_no = a.user_no "
				   + "and u.user_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setEmail(rs.getString("user_email"));
			user.setName(rs.getString("user_name"));
			user.setTel(rs.getString("user_tel"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
			user.setUpdatedDate(rs.getDate("user_updated_date"));
			
			UserAddress address = new UserAddress();
			address.setAddress(rs.getString("user_address"));
			address.setDetailAddress(rs.getString("user_detail_address"));
			address.setPostalCode(rs.getInt("postal_code"));
			user.setAddress(address);
			
			return user;
		}, userNo);
    
	
	public List<User> getUsers(int beginIndex, int endIndex) throws SQLException {
		String sql = "select user_no, user_email, user_name, user_tel, user_deleted, user_created_date, user_updated_date "
				   + "from (select row_number() over (order by user_no desc) row_number, user_no, user_email, "
				   + "		 user_name, user_tel, user_deleted, user_created_date, user_updated_date "
				   + "		from hta_users "
				   + "		where user_email != 'admin@gmail.com' "
				   + "		and user_deleted = 'N') "
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
		String sql = "select count(*) cnt "
				   + "from hta_users "
				   + "where user_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
	
	public void updateUser(User user) throws SQLException {
		String sql = "update hta_users "
				   + "set "
				   + "		user_email = ?, "
				   + "		user_password = ?, "
				   + "		user_name = ?, "
				   + "		user_tel = ?, "
				   + "		user_deleted = ?, "
				   + "		user_created_date = ?, "
				   + "		user_updated_date = sysdate "
				   + "where user_no = ?";
		
		helper.update(sql, user.getEmail(), user.getPassword(), user.getName(), user.getTel(), user.getDeleted(), user.getCreatedDate(), user.getNo());
				   
	}
}
