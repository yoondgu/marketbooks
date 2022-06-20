package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Book;
import vo.Order;
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
}
