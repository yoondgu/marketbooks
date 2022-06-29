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
	
	// 배송지 업데이트
	public void updateAddress(UserAddress userAddr) throws SQLException {
		String sql = "UPDATE HTA_USER_ADDRESSES "
					+ "SET "
					+ "		USER_ADDRESS = ?, "
					+ "		USER_DETAIL_ADDRESS = ?, "
					+ "		POSTAL_CODE = ?, "
					+ "		USER_ADDRESS_DELETED = ? "
					+ "WHERE ADDRESS_NO = ? ";
		
		helper.update(sql, userAddr.getAddress(), userAddr.getDetailAddress(), userAddr.getPostalCode(), userAddr.getDeleted(), userAddr.getNo());
	}
	
	// 배송지 번호로 등록된 배송지 조회
	// (주문정보를 조회할 때는, 현재는 삭제된 배송지 번호로 배송지 정보를 조회할 수도 있으므로 DELETED 값과 상관없이 모두 조회할것) 
	public UserAddress getAddressByNo(int addrNo) throws SQLException {
		String sql = "SELECT ADDRESS_NO, USER_NO, USER_ADDRESS, USER_DETAIL_ADDRESS, POSTAL_CODE "
				+ "FROM HTA_USER_ADDRESSES "
				+ "WHERE USER_ADDRESS_DELETED = 'N' "
				+ "AND ADDRESS_NO = ? ";
	
	return helper.selectOne(sql, rs -> {
		UserAddress userAddr = new UserAddress();
		userAddr.setNo(rs.getInt("address_no"));
		userAddr.setUserNo(rs.getInt("user_no"));
		userAddr.setAddress(rs.getString("user_address"));
		userAddr.setDetailAddress(rs.getString("user_detail_address"));
		userAddr.setPostalCode(rs.getInt("postal_code"));
		userAddr.setDeleted("N");
		return userAddr;
		}, addrNo);
	}

	// 삭제된 배송지를 포함해서 배송지 번호로 등록된 배송지 조회
	public UserAddress getAddressWithHistoryByNo(int addrNo) throws SQLException {
		String sql = "SELECT ADDRESS_NO, USER_NO, USER_ADDRESS, USER_DETAIL_ADDRESS, POSTAL_CODE, USER_ADDRESS_DELETED "
				+ "FROM HTA_USER_ADDRESSES "
				+ "WHERE ADDRESS_NO = ? ";
		
		return helper.selectOne(sql, rs -> {
			UserAddress userAddr = new UserAddress();
			userAddr.setNo(rs.getInt("address_no"));
			userAddr.setUserNo(rs.getInt("user_no"));
			userAddr.setAddress(rs.getString("user_address"));
			userAddr.setDetailAddress(rs.getString("user_detail_address"));
			userAddr.setPostalCode(rs.getInt("postal_code"));
			userAddr.setDeleted(rs.getString("user_address_deleted"));
			return userAddr;
		}, addrNo);
	}
	
	// 사용자정보로 모든 등록된 배송지 조회
	public List<UserAddress> getAllAddressesByUser(int userNo) throws SQLException {
		String sql = "SELECT ADDRESS_NO, USER_NO, USER_ADDRESS, USER_DETAIL_ADDRESS, POSTAL_CODE "
					+ "FROM HTA_USER_ADDRESSES "
					+ "WHERE USER_ADDRESS_DELETED = 'N' "
					+ "AND USER_NO = ? ";
		
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
