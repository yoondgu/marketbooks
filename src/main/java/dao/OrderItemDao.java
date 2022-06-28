package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Book;
import vo.OrderItem;

public class OrderItemDao {

	private static OrderItemDao instance = new OrderItemDao();
	private OrderItemDao() {}
	public static OrderItemDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from hta_order_items ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});	   
	}
	
	/*
	// 다시 작성예정인 부분입니다..
	public OrderItem getItemByUserNo(int userNo) throws SQLException{
		String sql = "select i.order_item_no, i.order_no, i.book_no, i.order_item_price, i.order_item_quantity, i.order_item_created_date, i.order_item_updated_date, "
				   + "       b.book_title, o.order_total_price, o.order_status "
				   + "from hta_order_items i, hta_orders o, hta_books b"
				   + "where i.order_no = o.order_no "
				   + "and i.book_no = b.book_no"
				   + "and o.user_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			OrderItem item = new OrderItem();
			item.setNo(rs.getInt("order_item_no"));
			item.setOrderNo(rs.getInt("order_no"));
			item.setBookNo(rs.getInt(rs.getInt("book_no")));
			item.setPrice(rs.getInt("order_item_price"));
			item.setQuantity(rs.getInt("order_item_quantity"));
			item.setCreatedDate(rs.getDate("order_item_created_date"));
			item.setUpdatedDate(rs.getDate("order_item_updated_date"));
			
			Book book = new Book();
			book.setTitle(rs.getString("book_title"));
			item.setBook(book);
			
			Order order = new Order();
			order.setTotalPrice(rs.getInt("order_total_price"));
			order.setStatus(rs.getString("order_status"));
			item.setOrder(order);
			
			return item;
		}, userNo);
	}
	*/
	
	public List<OrderItem> getOrderItemsByOrderNo(int orderNo) throws SQLException {
		String sql = "SELECT O.ORDER_ITEM_NO, O.ORDER_NO, B.BOOK_NO, B.BOOK_TITLE, B.BOOK_AUTHOR, B.BOOK_PUBLISHER, B.BOOK_PRICE, "
					+ "O.ORDER_ITEM_PRICE, O.ORDER_ITEM_QUANTITY, O.ORDER_ITEM_CREATED_DATE "
					+ "FROM HTA_ORDER_ITEMS O, HTA_BOOKS B "
					+ "WHERE O.ORDER_NO = ? "
					+ "AND O.BOOK_NO = B.BOOK_NO ";
		
		return helper.selectList(sql, rs -> {
			OrderItem orderItem = new OrderItem();
			orderItem.setNo(rs.getInt("order_item_no"));
			orderItem.setOrderNo(rs.getInt("order_no"));
			
			Book book = new Book();
			book.setNo(rs.getInt("book_no"));
			book.setTitle(rs.getString("book_title"));
			book.setAuthor(rs.getString("book_author"));
			book.setPublisher(rs.getString("book_publisher"));
			book.setPrice(rs.getInt("book_price"));
			
			orderItem.setBook(book);
			orderItem.setPrice(rs.getInt("order_item_price"));
			orderItem.setQuantity(rs.getInt("order_item_quantity"));
			orderItem.setCreatedDate(rs.getDate("order_item_created_date"));
			return orderItem;
		}, orderNo);
	}
	
	/**
	 * 주문아이템 객체를 하나 전달하여 HTA_ORDER_ITEMS 테이블에 저장한다.
	 * @param orderItem
	 * @throws SQLException
	 */
	public void insertOrderItem(OrderItem orderItem) throws SQLException {
		String sql = "INSERT INTO HTA_ORDER_ITEMS (ORDER_ITEM_NO, ORDER_NO, BOOK_NO, ORDER_ITEM_PRICE, ORDER_ITEM_QUANTITY) "
					+ "VALUES (ORDER_ITEMS_SEQ.NEXTVAL, ?, ?, ?, ?) ";
		
		helper.insert(sql, orderItem.getOrderNo(), orderItem.getBook().getNo(), orderItem.getPrice(), orderItem.getQuantity());
	}
}
