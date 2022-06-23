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
  
	
	private DaoHelper helper = DaoHelper.getInstance();
    
  	public User getUserByEmail(String email) throws SQLException {
		String sql = "select u.user_no, u.user_email, u.user_name, u.user_password, u.user_tel, u.user_deleted, u.user_created_date, u.user_updated_date, "
				   +	     "a.address_no, a.user_address, a.user_detail_address, a.postal_code "
				   + "from hta_users u, hta_user_addresses a "
				   // 로그인 시 세션객체 획득할 때 사용하는 메소드이므로 관리자 아이디도 조회된다.
				   // 배송지정보 중 기본배송지만 조회한다. 기본배송지가 없을 시 배송지 관련 값은 모두 null이다.
				   + "where u.user_default_ad_no = a.address_no(+) "
				   + "and u.user_email = ? ";
		
		return helper.selectOne(sql, rs -> {
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setEmail(rs.getString("user_email"));
			user.setName(rs.getString("user_name"));
			user.setPassword(rs.getString("user_password"));
			user.setTel(rs.getString("user_tel"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
			user.setUpdatedDate(rs.getDate("user_updated_date"));
			
			// 기본 배송지번호가 존재할 경우에만 address 객체를 생성해 user객체에 저장한다.
			int addressNo = rs.getInt("address_no");
			if (addressNo != 0) {
				UserAddress address = new UserAddress();
				address.setNo(addressNo);
				address.setUserNo(rs.getInt("user_no"));
				address.setAddress(rs.getString("user_address"));
				address.setDetailAddress(rs.getString("user_detail_address"));
				address.setPostalCode(rs.getInt("postal_code"));
				user.setAddress(address);
			}
			
			return user;
		}, email);
	}
	
	public User getUserByNo(int userNo) throws SQLException {
		String sql = "select u.user_no, u.user_email, u.user_name, u.user_password, u.user_tel, u.user_deleted, u.user_created_date, u.user_updated_date, "
				   +	     "a.address_no, a.user_address, a.user_detail_address, a.postal_code "
				   + "from hta_users u, hta_user_addresses a "
				   // 관리자는 userlist에서 제외시킨다.
				   + "where u.user_email != 'admin@gmail.com' "
				   // 배송지정보 중 기본배송지만 조회한다. 기본배송지가 없을 시 배송지 관련 값은 모두 null이다.
				   + "and u.user_default_ad_no = a.address_no(+) "
				   + "and u.user_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setEmail(rs.getString("user_email"));
			user.setName(rs.getString("user_name"));
			user.setPassword(rs.getString("user_password"));
			user.setTel(rs.getString("user_tel"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
			user.setUpdatedDate(rs.getDate("user_updated_date"));
			
			// 기본 배송지번호가 존재할 경우에만 address 객체를 생성해 user객체에 저장한다.
			int addressNo = rs.getInt("address_no");
			if (addressNo != 0) {
				UserAddress address = new UserAddress();
				address.setNo(addressNo);
				address.setUserNo(userNo);
				address.setAddress(rs.getString("user_address"));
				address.setDetailAddress(rs.getString("user_detail_address"));
				address.setPostalCode(rs.getInt("postal_code"));
				user.setAddress(address);
			}
			
			return user;
		}, userNo);
	}
	
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
				   + "		user_updated_date = sysdate, "
				   + "		user_default_ad_no = ? "
				   + "where user_no = ?";
		

				   
	}
}
