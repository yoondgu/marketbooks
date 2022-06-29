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
	
	public List<OrderItem> getOrderItemsByOrderNo(int orderNo) throws SQLException {
		String sql = "SELECT O.ORDER_ITEM_NO, O.ORDER_NO, "
					+ "B.BOOK_NO, B.CATEGORY_NO, B.BOOK_TITLE, B.BOOK_AUTHOR, B.BOOK_PUBLISHER, "
					+ "B.BOOK_DESCRIPTION, B.BOOK_PRICE, B.BOOK_DISCOUNT_PRICE, "
					+ "B.BOOK_ON_SELL, B.BOOK_STOCK, B.BOOK_DELETED, "
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
			book.setCategoryNo(rs.getInt("category_no"));
			book.setTitle(rs.getString("book_title"));
			book.setAuthor(rs.getString("book_author"));
			book.setPublisher(rs.getString("book_publisher"));
			book.setDescription(rs.getString("book_description"));
			book.setPrice(rs.getInt("book_price"));
			book.setDiscountPrice(rs.getInt("book_discount_price"));
			book.setOnSell(rs.getString("book_on_sell"));
			book.setStock(rs.getInt("book_stock"));
			book.setDeleted(rs.getString("book_deleted"));
			
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
