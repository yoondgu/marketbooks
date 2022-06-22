package util;

import java.sql.SQLException;

import dao.CartItemDao;

public class QueryStringUtil {

	/**
	 * 장바구니아이템 번호로 이루어진 문자열 배열을 전달받아 쿼리스트링 형태로 반환한다.
	 * @param values 장바구니아이템 번호로 이루어진 문자열 배열 
	 * @param paramName 쿼리스트링으로 전달할 name값
	 * @return queryString, 만약 전달할 값이 없다면 빈 문자열을 반환한다.
	 * @throws SQLException
	 */
	public static String generateCartItemQueryString(String[] values, String paramName) throws SQLException {
		String queryString = "";
		
		if (paramName == null) {
			return queryString;
		}
		
		CartItemDao cartItemDao = CartItemDao.getInstance();
		if (values != null) {
			queryString = "?";
			for (String number : values) {
				int itemNo = StringUtil.stringToInt(number);
				// 아이템번호에 해당하는 카트가 없으면 덧붙일 queryString이 없다.
				if (cartItemDao.getCartItemByNo(itemNo) == null) {
					continue;
				}
				
				queryString += "?".equals(queryString) ? paramName + "=" + itemNo : "&" + paramName + "=" + itemNo;
			}
			
			if ("?".equals(queryString)) {
				queryString = "";
			}
		}
		return queryString;
	}
}
