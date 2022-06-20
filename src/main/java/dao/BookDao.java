package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Book;
import vo.Category;

public class BookDao {

	private static BookDao instance = new BookDao();

	private BookDao() {
	}

	public static BookDao getInstance() {
		return instance;
	}

	private DaoHelper helper = DaoHelper.getInstance();

	public List<Book> getBooks(int beginIndex, int endIndex) throws SQLException {
		String sql = "select B.book_no, B.category_no, C.category_name, B.book_title, B.book_author, B.book_discount_price, B.book_price, B.book_created_date "
				+ "from (select book_no, category_no, book_title, book_author, book_discount_price, book_price, book_created_date, "
				+ "             row_number() over (order by book_no desc) row_number " + "      from hta_books "
				+ "      where book_deleted = 'N') B, hta_book_categories C "
				+ "where B.row_number >= ? and B.row_number <= ? " + "and B.category_no = C.category_no "
				+ "order by B.book_no desc ";

		return helper.selectList(sql, rs -> {
			Book book = new Book();
			book.setNo(rs.getInt("book_no"));

			Category category = new Category();
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));

			book.setCategoryNo(rs.getInt("category_no"));
			book.setTitle(rs.getString("book_title"));
			book.setAuthor(rs.getString("book_author"));
			book.setPrice(rs.getInt("book_price"));
			book.setDiscountPrice(rs.getInt("book_discount_price"));
			book.setCreatedDate(rs.getDate("book_created_date"));

			return book;
		}, beginIndex, endIndex);
	}

	public List<Book> getBooks(int beginIndex, int endIndex, String keyword) throws SQLException {
		String sql = "select B.book_no, B.category_no, C.category_name, B.book_title, B.book_author, B.book_discount_price, B.book_price, B.book_created_date "
				+ "from (select book_no, category_no, book_title, book_author, book_discount_price, book_price, book_created_date, "
				+ "             row_number() over (order by book_no desc) row_number " + "      from hta_books "
				+ "      where book_deleted = 'N' and book_title like '%' || ? || '%') B, hta_book_categories C "
				+ "where B.row_number >= ? and B.row_number <= ? " + "and B.category_no = C.category_no "
				+ "order by B.book_no desc ";

		return helper.selectList(sql, rs -> {
			Book book = new Book();
			book.setNo(rs.getInt("book_no"));

			Category category = new Category();
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));

			book.setCategoryNo(rs.getInt("category_no"));
			book.setTitle(rs.getString("book_title"));
			book.setAuthor(rs.getString("book_author"));
			book.setPrice(rs.getInt("book_price"));
			book.setDiscountPrice(rs.getInt("book_discount_price"));
			book.setCreatedDate(rs.getDate("book_created_date"));

			return book;
		}, keyword, beginIndex, endIndex);
	}

	public void insertbook(Book book) throws SQLException {
		String sql = "insert into hta_books "
				+ "(book_no, category_no, book_title, book_author, book_publisher, book_description, book_price, "
				+ "book_discount_price, book_on_sell, book_stock, book_createdDate, book_updatedDate, book_deleted) "
				+ "values " + "(sample_books_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		helper.insert(sql, book.getCategoryNo(), book.getTitle(), book.getAuthor(), book.getPublisher(),
				book.getDescription(), book.getPrice(), book.getDiscountPrice(), book.getOnSell(), book.getStock(),
				book.getCreatedDate(), book.getUpdatedDate());
	}

	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt " + "from hta_books " + "where book_deleted = 'N' ";

		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}

	public int getTotalRows(String keyword) throws SQLException {
		String sql = "select count(*) cnt " + "from hta_books "
				+ "where book_deleted = 'N' and book_title like '%' || ? || '%' ";

		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword);
	}

}
