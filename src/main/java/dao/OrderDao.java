package dao;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
	 * 사용자번호와 해당 연도를 전달받아 해당하는 연도의 사용자 주문정보 행 수를 반환한다.
	 * -1을 전달받으면 전체 기간의 데이터 개수를 반환한다.
	 * 0을 전달받으면 현재 연도의 데이터 개수를 반환한다.
	 * @param years
	 * @return 데이터의 행 수
	 * @throws SQLException
	 * @throws ParseException 
	 */
	
	public int getTotalRowsByPeriod(int periodYear, int userNo) throws SQLException, ParseException {
		
		if (periodYear < 0) {
			String sql = "SELECT COUNT(*) CNT "
					+ "FROM HTA_ORDERS "
					+ "WHERE USER_NO = ?";
			
			return helper.selectOne(sql, rs -> {
				return rs.getInt("CNT");
			}, userNo);
		}
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date beginDate = dateFormat.parse(String.valueOf(periodYear) + "-01-01 00:00:00");
		Date endDate = dateFormat.parse(String.valueOf(periodYear + 1) + "-01-01 00:00:00");
		
		String sql = "SELECT COUNT(*) CNT "
				+ "FROM HTA_ORDERS "
				+ "WHERE ORDER_CREATED_DATE >= ? AND ORDER_CREATED_DATE < ? "
				+ "AND USER_NO = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("CNT");
		}, beginDate, endDate, userNo);
	}

	/**
	 * 사용자번호와 해당 연도, 페이지 번호를 전달받아 해당 연도의 사용자 주문정보 중 전달받은 페이지 범위에 해당하는 정보를 리스트로 반환한다.
	 * 해당 연도로 음의 정수를 전달받으면 전체 기간의 데이터를 반환한다.
	 * @param years
	 * @param userNo
	 * @param beginIndex
	 * @param endIndex
	 * @return
	 * @throws SQLException
	 * @throws ParseException
	 */
	public List<Order> getOrdersByPeriod(int periodYear, int userNo, int beginIndex, int endIndex) throws SQLException, ParseException {
		
		if (periodYear < 0) {
			String sql = "SELECT * "
					+ "FROM (SELECT ORDER_NO, USER_NO, ORDER_TITLE, ORDER_TOTAL_PRICE, ORDER_TOTAL_PAY_PRICE, ORDER_TOTAL_QUANTITY, "
					+ "        ORDER_CREATED_DATE, ORDER_STATUS, ORDER_PAY_METHOD, ADDRESS_NO, IS_FREE_SHIPPING, "
					+ "        ROW_NUMBER() OVER (ORDER BY ORDER_NO DESC) ROW_NUM "
					+ "        FROM HTA_ORDERS "
					+ "        WHERE USER_NO = ?) "
					+ "WHERE ROW_NUM >= ? AND ROW_NUM <= ? "
					+ "ORDER BY ORDER_NO DESC";
			
			return helper.selectList(sql, rs -> {
				Order order = new Order();
				order.setNo(rs.getInt("order_no"));
				order.setUserNo(rs.getInt("user_no"));
				order.setTitle(rs.getString("order_title"));
				order.setTotalPrice(rs.getInt("order_total_price"));
				order.setTotalPayPrice(rs.getInt("order_total_pay_price"));
				order.setTotalQuantity(rs.getInt("order_total_quantity"));
				order.setCreatedDate(rs.getDate("order_created_date"));
				order.setStatus(rs.getString("order_status"));
				order.setPayMethod(rs.getString("order_pay_method"));
				order.setAddressNo(rs.getInt("address_no"));
				order.setIsFreeShipping(rs.getString("is_free_shipping"));
				
				return order;
			}, userNo, beginIndex, endIndex);
		}
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date beginDate = dateFormat.parse(String.valueOf(periodYear) + "-01-01 00:00:00");
		Date endDate = dateFormat.parse(String.valueOf(periodYear + 1) + "-01-01 00:00:00");
		
		String sql = "SELECT * "
				+ "FROM (SELECT ORDER_NO, USER_NO, ORDER_TITLE, ORDER_TOTAL_PRICE, ORDER_TOTAL_PAY_PRICE, ORDER_TOTAL_QUANTITY, "
				+ "        ORDER_CREATED_DATE, ORDER_STATUS, ORDER_PAY_METHOD, ADDRESS_NO, IS_FREE_SHIPPING, "
				+ "        ROW_NUMBER() OVER (ORDER BY ORDER_NO DESC) ROW_NUM "
				+ "        FROM HTA_ORDERS "
				+ "        WHERE  ORDER_CREATED_DATE >= ? AND ORDER_CREATED_DATE < ? "
				+ "        AND USER_NO = ?) "
				+ "WHERE ROW_NUM >= ? AND ROW_NUM <= ? "
				+ "ORDER BY ORDER_NO DESC";
		
		return helper.selectList(sql, rs -> {
			Order order = new Order();
			order.setNo(rs.getInt("order_no"));
			order.setUserNo(rs.getInt("user_no"));
			order.setTitle(rs.getString("order_title"));
			order.setTotalPrice(rs.getInt("order_total_price"));
			order.setTotalPayPrice(rs.getInt("order_total_pay_price"));
			order.setTotalQuantity(rs.getInt("order_total_quantity"));
			order.setCreatedDate(rs.getDate("order_created_date"));
			order.setStatus(rs.getString("order_status"));
			order.setPayMethod(rs.getString("order_pay_method"));
			order.setAddressNo(rs.getInt("address_no"));
			order.setIsFreeShipping(rs.getString("is_free_shipping"));
			
			return order;
		}, beginDate, endDate, userNo, beginIndex, endIndex);		
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
