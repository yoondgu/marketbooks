package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Book;
import vo.CartItem;

/**
 * 장바구니 아이템과 관련된 데이터베이스 CRUD 기능을 제공하는 클래스
 * @author doyoung
 *
 */
public class CartItemDao {

	private static CartItemDao instance = new CartItemDao();
	private CartItemDao() {}
	public static CartItemDao getInstance() {
		return instance;
	}
	
	DaoHelper helper = DaoHelper.getInstance();
	
	/**
	 * 장바구니아이템 번호를 전달받아 해당하는 장바구니아이템을 반환한다.
	 * @param itemNo 장바구니아이템 번호
	 * @return cartItem 장바구니아이템, 만약 해당하는 장바구니아이템이 없으면 null을 반환한다.
	 */
	public CartItem getCartItemByNo(int itemNo) throws SQLException {
		String sql = "SELECT C.CART_ITEM_NO, C.USER_NO, B.BOOK_NO, B.BOOK_TITLE, B.BOOK_AUTHOR, B.BOOK_PUBLISHER, "
				+ "B.BOOK_PRICE, B.BOOK_DISCOUNT_PRICE, B.BOOK_STOCK, C.CART_ITEM_QUANTITY, C.CART_ITEM_CREATED_DATE "
				+ "FROM HTA_CART_ITEMS C, HTA_BOOKS B "
				+ "WHERE C.BOOK_NO = B.BOOK_NO "
				+ "AND C.CART_ITEM_NO = ? ";
		
		return helper.selectOne(sql, rs -> {
			CartItem cartItem = new CartItem();
			cartItem.setNo(rs.getInt("cart_item_no"));
			cartItem.setUserNo(rs.getInt("user_no"));
			
			// 장바구니 변경 시 재고 체크해야 하므로 book의 값도 NOT NULL 모두 받아오기
			Book book = new Book();
			book.setNo(rs.getInt("book_no"));
			book.setTitle(rs.getString("book_title"));
			book.setAuthor(rs.getString("book_author"));
			book.setPublisher(rs.getString("book_publisher"));
			book.setPrice(rs.getInt("book_price"));
			book.setDiscountPrice(rs.getInt("book_discount_price"));
			book.setStock(rs.getInt("book_stock"));
			
			cartItem.setBook(book);
			cartItem.setQuantity(rs.getInt("cart_item_quantity"));
			cartItem.setCreatedDate(rs.getDate("cart_item_created_date"));

			return cartItem;
		}, itemNo);
	}

	/**
	 * 도서번호를 전달받아 해당하는 장바구니아이템이 존재할 경우 장바구니 수량을 반환한다.
	 * @param bookNo 도서번호
	 * @return 장바구니 수량, 장바구니 아이템이 존재하지 않을 경우 0을 반환한다.
	 */
	public int getCartItemQuantityByBookNo(int bookNo) throws SQLException {
		String sql = "SELECT CART_ITEM_QUANTITY QTY "
					+ "FROM HTA_CART_ITEMS "
					+ "WHERE BOOK_NO = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("QTY");
		}, bookNo);
	}
	
	/**
	 * 사용자 번호를 전달받아 해당하는 장바구니아이템을 모두 반환한다.
	 * @param userNo 사용자 번호
	 * @return cartItemList 장바구니아이템 리스트
	 * @throws SQLException
	 */
	public List<CartItem> getCartItemsByUser(int userNo) throws SQLException {
		String sql = "SELECT C.CART_ITEM_NO, C.USER_NO, B.BOOK_NO, B.BOOK_TITLE, B.BOOK_AUTHOR, B.BOOK_PUBLISHER, "
				+ "B.BOOK_PRICE, B.BOOK_DISCOUNT_PRICE, B.BOOK_STOCK, C.CART_ITEM_QUANTITY, C.CART_ITEM_CREATED_DATE "
				+ "FROM HTA_CART_ITEMS C, HTA_BOOKS B "
				+ "WHERE C.BOOK_NO = B.BOOK_NO "
				+ "AND C.USER_NO = ? "
				+ "ORDER BY C.CART_ITEM_CREATED_DATE DESC ";
		
		return helper.selectList(sql, rs -> {
			CartItem cartItem = new CartItem();
			cartItem.setNo(rs.getInt("cart_item_no"));
			cartItem.setUserNo(rs.getInt("user_no"));
			
			Book book = new Book();
			book.setNo(rs.getInt("book_no"));
			book.setTitle(rs.getString("book_title"));
			book.setAuthor(rs.getString("book_author"));
			book.setPublisher(rs.getString("book_publisher"));
			book.setPrice(rs.getInt("book_price"));
			book.setDiscountPrice(rs.getInt("book_discount_price"));
			book.setStock(rs.getInt("book_stock"));
			
			cartItem.setBook(book);
			cartItem.setQuantity(rs.getInt("cart_item_quantity"));
			cartItem.setCreatedDate(rs.getDate("cart_item_created_date"));
			
			return cartItem;
		}, userNo);	
	}
		
	/**
	 * 장바구니아이템 번호를 전달받아 해당하는 장바구니아이템을 DB에서 영구적으로 삭제한다.
	 * @param itemNo 장바구니아이템 번호
	 * @throws SQLException
	 */
	public void deleteCartItem(int itemNo) throws SQLException {
		String sql = "DELETE FROM HTA_CART_ITEMS WHERE CART_ITEM_NO = ? ";
		
		helper.delete(sql, itemNo);
	}
	
	/**
	 * 장바구니아이템 객체를 전달받아 동일한 번호의 장바구니아이템 정보를 DB에서 업데이트한다.
	 * @param cartItem 장바구니아이템 객체
	 * @throws SQLException
	 */
	public void updateCartItem(CartItem cartItem) throws SQLException {
		String sql = "UPDATE HTA_CART_ITEMS "
					+ "SET "
					+ "		USER_NO = ?, "
					+ "		BOOK_NO = ?, "
					+ "		CART_ITEM_QUANTITY = ?, "
					+ "		CART_ITEM_UPDATED_DATE = SYSDATE "
					+ "WHERE CART_ITEM_NO = ? ";
		
		helper.update(sql, cartItem.getUserNo(), cartItem.getBook().getNo(), cartItem.getQuantity(), cartItem.getNo());
	}

	/**
	 * 장바구니아이템 객체를 전달받아 DB에 새로 저장한다. 이미 같은 사용자에게 해당 장바구니아이템의 도서가 존재할 경우, 수량을 증가시킨다.
	 * @param cartItem 장바구니아이템 객체
	 * @throws SQLException
	 */
	public void insertCartItem(CartItem cartItem) throws SQLException {
		String sql = "MERGE "
					+ "    INTO HTA_CART_ITEMS C "
					+ "USING DUAL "
					+ "    ON (C.USER_NO = ? AND C.BOOK_NO = ?) "
					+ "WHEN MATCHED THEN "
					+ "    UPDATE "
					+ "        SET "
					+ "            C.CART_ITEM_QUANTITY = C.CART_ITEM_QUANTITY + ?, "
					+ "            C.CART_ITEM_UPDATED_DATE = SYSDATE "
					+ "WHEN NOT MATCHED THEN "
					+ "    INSERT (CART_ITEM_NO, USER_NO, BOOK_NO, CART_ITEM_QUANTITY) "
					+ "    VALUES (CART_ITEMS_SEQ.nextval, ?, ?, ?)";
		
		helper.insert(sql, cartItem.getUserNo(), cartItem.getBook().getNo(), cartItem.getQuantity(), cartItem.getUserNo(), cartItem.getBook().getNo(), cartItem.getQuantity());
	}
	
}
