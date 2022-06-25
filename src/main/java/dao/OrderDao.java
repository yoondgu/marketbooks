package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.Order;

public class OrderDao {

	private static OrderDao instance = new OrderDao();
	private OrderDao() {}
	public static OrderDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance(); 
	
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from hta_orders ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});	   
	}
	
	/**
	 * 주문번호로 사용하는 시퀀스번호를 하나 발행하여 반환한다.
	 * @return 주문 시퀀스번호
	 * @throws SQLException
	 */
	public int getOrderSequence() throws SQLException {
		String sql = "SELECT ORDERS_SEQ.NEXTVAL SEQ FROM DUAL";
		return helper.selectOne(sql, rs -> {
			return rs.getInt("SEQ");
		});
	}
	
	/**
	 * 주문정보 객체를 하나 전달하여 HTA_ORDERS 테이블에 저장한다.
	 * @param order
	 * @throws SQLException
	 */
	public void insertOrder(Order order) throws SQLException {
		String sql = "INSERT INTO HTA_ORDERS "
					+ "(ORDER_NO, USER_NO, ORDER_TITLE, ORDER_TOTAL_PRICE, ORDER_TOTAL_PAY_PRICE,"
					+ " ORDER_TOTAL_QUANTITY, ADDRESS_NO, IS_FREE_SHIPPING) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		helper.insert(sql, order.getNo(), order.getUserNo(), order.getTitle(), order.getTotalPrice(), order.getTotalPayPrice(), 
					order.getTotalQuantity(), order.getAddressNo(), order.getIsFreeShipping());
	}
	
	/**
	 * 주문정보 객체를 하나 전달하여 HTA_ORDERS 테이블에서 해당 객체의 주문번호를 가진 주문정보를 업데이트한다.
	 * @param order
	 * @throws SQLException
	 */
	public void updateOrder(Order order) throws SQLException {
		String sql = "UPDATE HTA_ORDERS "
					+ "SET "
					+ "		ORDER_TITLE = ?, "
					+ "		ORDER_TOTAL_PRICE = ?, "
					+ "		ORDER_TOTAL_PAY_PRICE= ?, "
					+ "		ORDER_TOTAL_QUANTITY = ?, "
					+ "		ORDER_STATUS = ?, "
					+ "		ADDRESS_NO = ?, "
					+ "		IS_FREE_SHIPPING = ?,"
					+ "		ORDER_UPDATED_DATE = SYSDATE "
					+ "WHERE ORDER_NO = ? ";
		
		helper.insert(sql, order.getTitle(), order.getTotalPrice(), order.getTotalPayPrice(), 
				order.getTotalQuantity(), order.getStatus(), order.getAddressNo(), order.getIsFreeShipping(), order.getNo());	
	}
	
}
