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
					+ " ORDER_TOTAL_QUANTITY, ORDER_PAY_METHOD, ADDRESS_NO, IS_FREE_SHIPPING) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		helper.insert(sql, order.getNo(), order.getUserNo(), order.getTitle(), order.getTotalPrice(), order.getTotalPayPrice(), 
					order.getTotalQuantity(), order.getPayMethod(), order.getAddressNo(), order.getIsFreeShipping());
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
					+ "		ORDER_PAY_METHOD = ?, "
					+ "		ADDRESS_NO = ?, "
					+ "		IS_FREE_SHIPPING = ?,"
					+ "		ORDER_UPDATED_DATE = SYSDATE "
					+ "WHERE ORDER_NO = ? ";
		
		helper.insert(sql, order.getTitle(), order.getTotalPrice(), order.getTotalPayPrice(), order.getTotalQuantity(), order.getStatus(), 
				order.getPayMethod(), order.getAddressNo(), order.getIsFreeShipping(), order.getNo());	
	}
	
	/**
	 * 주문번호를 전달받아 해당 번호를 가진 주문정보 객체를 반환한다.
	 * @param orderNo 주문번호
	 * @return 주문정보 객체
	 * @throws SQLException
	 */
	public Order getOrderByNo(int orderNo) throws SQLException {
		String sql = "SELECT ORDER_NO, USER_NO, ORDER_TITLE, ORDER_TOTAL_PRICE, ORDER_TOTAL_PAY_PRICE, ORDER_TOTAL_QUANTITY, ORDER_CREATED_DATE, ORDER_UPDATED_DATE, "
					+ "ORDER_STATUS, ORDER_PAY_METHOD, ADDRESS_NO, IS_FREE_SHIPPING "
					+ "FROM HTA_ORDERS "
					+ "WHERE ORDER_NO = ? ";
		
		return helper.selectOne(sql, rs -> {
			Order order = new Order();
			
			order.setNo(rs.getInt("order_no"));
			order.setUserNo(rs.getInt("user_no"));
			order.setTitle(rs.getString("order_title"));
			order.setTotalPrice(rs.getInt("order_total_price"));
			order.setTotalPayPrice(rs.getInt("order_total_pay_price"));
			order.setTotalQuantity(rs.getInt("order_total_quantity"));
			order.setCreatedDate(rs.getDate("order_created_date"));
			order.setUpdatedDate(rs.getDate("order_updated_date"));
			order.setStatus(rs.getString("order_status"));
			order.setPayMethod(rs.getString("order_pay_method"));
			order.setAddressNo(rs.getInt("address_no"));
			order.setIsFreeShipping(rs.getString("is_free_shipping"));
			
			return order;
		}, orderNo);
	}
	
}
