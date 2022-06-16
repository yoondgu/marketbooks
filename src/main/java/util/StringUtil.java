package util;

public class StringUtil {

	/**
	 * value가 null이면 빈 문자열을 반환한다
	 * @param value 텍스트
	 * @return 빈 문자열 혹은 원래 문자열
	 */
	public static String nullToBlank(String value) {
		return value == null ? "" : value;
	}
	
	/**
	 * 문자열을 정수로 변환한다. 
	 * @param value 문자열
	 * @return 정수, 숫자로 변환되지 않는 경우, 0을 반환한다.
	 */
	public static int stringToInt(String value) {
		return stringToInt(value, 0);
	}
	
	/**
	 * 문자열을 정수로 변환한다.
	 * @param value 문자열
	 * @param defaultValue 기본값
	 * @return 정수, 숫자로 변환되지 않는 경우 defaultValue로 지정한 값이 반환된다.
	 */
	public static int stringToInt(String value, int defaultValue) {
		try {
			return Integer.parseInt(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	
	/**
	 * 문자열을 정수로 변환한다.
	 * @param value 문자열
	 * @return 정수, 숫자로 변환되지 않는 경우 0L이 반환된다.
	 */
	public static long stringToLong(String value) {
		return stringToLong(value, 0L);
	}
	
	/**
	 * 문자열을 정수로 변환한다.
	 * @param value 문자열
	 * @param defaultValue 기본값
	 * @return 정수, 숫자로 변환되지 않는 경우 defaultValue로 지정한 값이 반환된다.
	 */
	public static long stringToLong(String value, long defaultValue) {
		try {
			return Long.parseLong(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	
	/**
	 * 문자열을 실수로 변환한다.
	 * @param value 문자열
	 * @return 실수, 숫자로 변환되지 않는 경우 0.0을 반환한다.
	 */
	public static double stringToDouble(String value) {
		return stringToDouble(value, 0.0);
	}
	
	/**
	 * 문자열을 정수로 변환한다.
	 * @param value 문자열
	 * @param defaultValue 기본값
	 * @return 정수, 숫자로 변환되지 않는 경우 defaultValue로 지정한 값이 반환된다.
	 */
	public static double stringToDouble(String value, double defaultValue) {
		try {
			return Double.parseDouble(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
}
