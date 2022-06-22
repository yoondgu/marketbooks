package helper;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 데이터베이스 엑세스 헬프 클래스다.
 * @author lee_e
 *
 */
public class DaoHelper {

	private static DaoHelper instance = new DaoHelper();
	private DaoHelper() {}
	public static DaoHelper getInstance() {
		return instance;
	}
	
	/**
	 * SELECT문을 실행한다.
	 * * @param <T> 조회결과를 저장하는 객체
	 * @param sql SELECT SQL 문
	 * @param rowMapper ResultSet을 지정된 객체로 매핑하는 객체
	 * @return 조회결과가 저장된 객체, 조회결과가 없으면 null을 반환한다.
	 * @throws SQLException
	 */
	public <T> T selectOne(String sql, RowMapper<T> rowMapper) throws SQLException {
		return queryForObject(sql, rowMapper, new Object[] {});
	}
	
	/**
	 * SELECT문을 실행한다.
	 * @param <T> 조회결과를 저장하는 객체
	 * @param sql SELECT SQL 문
	 * @param rowMapper ResultSet을 지정된 객체로 매핑하는 객체
	 * @param parameters SELECT 문의 ?에 바인딩되는 값
	 * @return 조회결과가 저장된 객체, 조회결과가 없으면 null을 반환한다.
	 * @throws SQLException
	 */
	public <T> T selectOne(String sql, RowMapper<T> rowMapper, Object ...parameters) throws SQLException {
		return queryForObject(sql, rowMapper, parameters);
	}

	/**
	 * SELECT문을 실행한다.
	 * @param <T> 조회결과를 저장하는 객체
	 * @param sql SELECT SQL 문
	 * @param rowMapper ResultSet을 지정된 객체로 매핑하는 객체
	 * @return 조회결과가 포함된 List객체
	 * @throws SQLException
	 */
	public <T> List<T> selectList(String sql, RowMapper<T> rowMapper) throws SQLException {
		return queryForList(sql, rowMapper, new Object[] {});
	}
	
	/**
	 * SELECT문을 실행한다.
	 * @param <T> 조회결과를 저장하는 객체
	 * @param sql SELECT SQL 문
	 * @param rowMapper ResultSet을 지정된 객체로 매핑하는 객체
	 * @return 조회결과가 포함된 List객체
	 * @param parameters SELECT 문의 ?에 바인딩되는 값
	 * @return 조회결과가 포함된 List객체
	 * @throws SQLException
	 */
	public <T> List<T> selectList(String sql, RowMapper<T> rowMapper, Object ...parameters) throws SQLException {
		return queryForList(sql, rowMapper, parameters);
	}
	
	/**
	 * INSERT문을 실행한다.
	 * @param sql INSERT SQL 문
	 * @throws SQLException
	 */
	public void insert(String sql) throws SQLException {
		executeUpdate(sql, new Object[] {});
	}
	
	/**
	 * INSERT문을 실행한다.
	 * @param sql INSERT SQL 문
	 * @param parameters INSERT 문의 ?에 바인딩되는 값
	 * @throws SQLException
	 */
	public void insert(String sql, Object ...parameters) throws SQLException {
		executeUpdate(sql, parameters);
	}
	
	/**
	 * UPDATE문을 실행한다.
	 * @param sql UPDATE SQL 문
	 * @throws SQLException
	 */
	public void update(String sql) throws SQLException {
		executeUpdate(sql, new Object[] {});
	}
	
	/**
	 * UPDATE문을 실행한다.
	 * @param sql UPDATE SQL 문
	 * @param parameters UPDATE 문의 ?에 바인딩되는 값
	 * @throws SQLException
	 */
	public void update(String sql, Object ...parameters) throws SQLException  {
		executeUpdate(sql, parameters);
	}
	
	/**
	 * DELETE문을 실행한다.
	 * @param sql DELETE SQL 문
	 * @throws SQLException
	 */
	public void delete(String sql) throws SQLException {
		executeUpdate(sql, new Object[] {});
	}
	
	/**
	 * DELETE문을 실행한다.
	 * @param sql DELETE SQL 문
	 * @param parameters DELETE 문의 ?에 바인딩되는 값
	 * @throws SQLException
	 */
	public void delete(String sql, Object ...parameters) throws SQLException {
		executeUpdate(sql, parameters);
	}
	
	private <T> T queryForObject(String sql, RowMapper<T> rowMapper, Object... parameters) throws SQLException {
		T t = null;
		Connection connection = this.getConnection();
		PreparedStatement pstmt = createPreparedStatement(connection, sql, parameters);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			t = rowMapper.mapRow(rs);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return t;
	}
	
	private <T> List<T> queryForList(String sql, RowMapper<T> rowMapper, Object... parameters) throws SQLException {
		List<T> list = new ArrayList<>();
		Connection connection = this.getConnection();
		PreparedStatement pstmt = createPreparedStatement(connection, sql, parameters);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			list.add(rowMapper.mapRow(rs));			
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return list;
	}

	private void executeUpdate(String sql, Object ...parameters) throws SQLException {
		Connection connection = this.getConnection();
		PreparedStatement pstmt = createPreparedStatement(connection, sql, parameters);
		pstmt.executeUpdate();
		pstmt.close();
		connection.close();
	}
	
	private PreparedStatement createPreparedStatement(Connection connection, String sql, Object ...parameters) throws SQLException {
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		int position = 1;
		for (Object obj : parameters) {
			if (obj == null) {
				pstmt.setNull(position++, Types.NULL);
				continue;
			}
			if (obj instanceof Integer) {
				pstmt.setInt(position++, ((Integer) obj).intValue());
			} else if (obj instanceof Long) {
				pstmt.setLong(position++, ((Long) obj).longValue());
			} else if (obj instanceof Double) {
				pstmt.setDouble(position++, ((Double) obj).doubleValue());
			} else if (obj instanceof String) {
				pstmt.setString(position++, obj.toString());
			} else if (obj instanceof Date) {
				pstmt.setDate(position++, new java.sql.Date(((Date) obj).getTime()));
			}
		}
		return pstmt;
	}
	
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER_NAME = "semi";
	private static final String PASSWORD = "zxcv1234";
	
	static {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}
	
	private Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER_NAME, PASSWORD);
	}
	
	/**
	 * ResultSet객체가 포함하고 있는 행의 정보를 지정된 객체에 담아서 반환한다.
	 * @author lee_e
	 *
	 * @param <T>
	 */
	public interface RowMapper<T> {

		/**
		 * ResultSet객체에서 현재 커서와 위치한 행의 정보를 조회해서 지정된 객체로 반환한다.
		 * @param rs
		 * @return
		 * @throws SQLException
		 */
		T mapRow(ResultSet rs) throws SQLException;
	}
	
	   /**
	    * CLOB 타입의 값을 읽어서 문자열로 반환합니다.
	    * <pre>
	    *    public List<Blog> getAllBlogs() throws SQLException {
	    *       String sql = "select * from blog";
	    *       return helper.selectList(sql, rs -> {
	    *          Blog blog = new Blog();
	    *          blog.setNo(rs.getInt("blog_no"));
	    *          blog.setTitle(rs.getString("blog_title"));
	    *          // blog_content는 Oracle DataType이 CLOB로 설정된 컬럼이다.
	    *          blog.setContent(DaoHelper.clobToString(rs.getClob("blog_content")));
	    *          blog.setCreatedDate(rs.getDate("blog_created_date"));
	    *          
	    *          return blog;
	    *       });
	    *    }
	    * </pre>
	    * @param clob CLOB 데이터
	    * @return 문자열
	    * @throws SQLException
	    */
	   public static String clobToString(Clob clob) throws SQLException {
	      if (clob == null) {
	         return null;
	      }
	      StringBuilder builder = new StringBuilder();

	      try (BufferedReader reader = new BufferedReader(clob.getCharacterStream())) {
	         reader.lines().forEach(text -> builder.append(text).append(System.lineSeparator()));
	         return builder.toString();
	      } catch (IOException e) {
	         return null;
	      }
	   } 
}
