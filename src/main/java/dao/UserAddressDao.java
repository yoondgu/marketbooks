package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.UserAddress;

public class UserAddressDao {

	private static UserAddressDao instance = new UserAddressDao();
	private UserAddressDao() {}
	public static UserAddressDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	// 배송지번호 시퀀스 생성
	public int getAddressSequence() throws SQLException {
		String sql = "select ADDRESSES_ITEMS_SEQ.nextval seq from dual";
		return helper.selectOne(sql, rs -> {
			return rs.getInt("seq");
		});
	}

	// 배송지 저장
	public void insertAddress(UserAddress userAddr) throws SQLException {
		String sql = "INSERT INTO HTA_USER_ADDRESSES (ADDRESS_NO, USER_NO, USER_ADDRESS, USER_DETAIL_ADDRESS, POSTAL_CODE) "
					+ "VALUES (?, ?, ?, ?, ?) ";
		
		helper.insert(sql, userAddr.getNo(), userAddr.getUserNo(), userAddr.getAddress(), userAddr.getDetailAddress(), userAddr.getPostalCode());
	}
	
	// 배송지 삭제 
	
	// 배송지 업데이트
	
	// 배송지 번호로 배송지 조회
	public UserAddress getAddressByNo(int addrNo) throws SQLException {
		String sql = "SELECT ADDRESS_NO, USER_NO, USER_ADDRESS, USER_DETAIL_ADDRESS, POSTAL_CODE "
				+ "FROM HTA_USER_ADDRESSES "
				+ "WHERE ADDRESS_NO = ? ";
	
	return helper.selectOne(sql, rs -> {
		UserAddress userAddr = new UserAddress();
		userAddr.setNo(rs.getInt("address_no"));
		userAddr.setUserNo(rs.getInt("user_no"));
		userAddr.setAddress(rs.getString("user_address"));
		userAddr.setDetailAddress(rs.getString("user_detail_address"));
		userAddr.setPostalCode(rs.getInt("postal_code"));
		return userAddr;
		}, addrNo);
	}
	
	// 사용자정보로 모든 배송지 조회
	public List<UserAddress> getAllAddressesByUser(int userNo) throws SQLException {
		String sql = "SELECT ADDRESS_NO, USER_NO, USER_ADDRESS, USER_DETAIL_ADDRESS, POSTAL_CODE "
					+ "FROM HTA_USER_ADDRESSES "
					+ "WHERE USER_NO = ? ";
		
		return helper.selectList(sql, rs -> {
			UserAddress userAddr = new UserAddress();
			userAddr.setNo(rs.getInt("address_no"));
			userAddr.setUserNo(rs.getInt("user_no"));
			userAddr.setAddress(rs.getString("user_address"));
			userAddr.setDetailAddress(rs.getString("user_detail_address"));
			userAddr.setPostalCode(rs.getInt("postal_code"));
			return userAddr;
		}, userNo);
	}
	
}
