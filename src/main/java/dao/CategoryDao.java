package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Category;

public class CategoryDao {

	private static CategoryDao instance = new CategoryDao();

	private CategoryDao() {
	}

	public static CategoryDao getInstance() {
		return instance;
	}

	private DaoHelper helper = DaoHelper.getInstance();

	public Category getCategoryName(int bookNo) throws SQLException {
		String sql = "select b.book_no, c.category_no, c.category_name "
					+ "from HTA_BOOK_CATEGORIES C, hta_books b "
					+ "where book_no = ? "
					+ "and b.category_no= c.category_no";
		
		return helper.selectOne(sql, rs -> {
			Category category = new Category();
			category.setName(rs.getString("category_name"));
			category.setNo(rs.getInt("category_no"));
			return category;
		}, bookNo);
	}
  
  /**
	 * 모든 카테고리 정보 객체를 반환한다.
	 * @return 모든 카테고리 정보 객체
	 * @throws SQLException
	 */
	public List<Category> getAllCategories() throws SQLException {
		String sql = "select category_name, category_no "
				   + "from HTA_BOOK_CATEGORIES "
				   + "order by category_no asc ";
		
		return helper.selectList(sql, rs-> {
			Category category = new Category();
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			
			return category;
		});
				   
	}
}
