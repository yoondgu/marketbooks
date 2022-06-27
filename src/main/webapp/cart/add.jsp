<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.CartItem"%>
<%@page import="dao.CartItemDao"%>
<%@page import="vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BookDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BookDao bookDao = BookDao.getInstance();
	CartItemDao cartItemDao = CartItemDao.getInstance();

	// 세션객체에 저장된 로그인 사용자 정보 획득: 사용자 정보가 NULL일 경우 로그인페이지로 이동하고, 관련 메시지를 띄우는 fail=deny값을 전달한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int userNo = user.getNo();
	
	// 응답정보로 보낼 맵 객체
	// key: success, value: 성공하면 true, 실패하면 false
	// key: quantity, value: 저장한 장바구니 건수
	Map<String, Object> result = new HashMap<>();
	result.put("success", true);
	
	// '전체 상품 다시 담기' 기능을 사용할 경우 bookNo는 여러 개가 올 수 있다.
	// 전달받은 도서번호를 이용해 장바구니 객체를 만들어 HTA_CART_ITEMS에 저장한다.
	// 해당 사용자에게 동일한 도서번호의 장바구니아이템이 존재할 경우 수량만 증가시킨다.
	String[] bookNoValues = request.getParameterValues("bookNo");
	
	// quantity 전달값이 없으면 값은 1이다.
	// 복수 개의 도서를 장바구니에 담을시에는 수량 값을 전달하지 않는다. (모두 1개씩만 담을 수 있음)
	// 한 개의 도서를 담을 시에는 quantity값이 그대로 반영된다.
	int quantity = StringUtil.stringToInt(request.getParameter("quantity"), 1);
	
	
	if (bookNoValues != null) {
		
		int totalBookQuantity = 0;
		for (String value : bookNoValues) {
			
			int bookNo = StringUtil.stringToInt(value);
			Book book = bookDao.getBookByNo(bookNo);
			// 번호에 해당하는 도서정보가 없으면 비정상적인 요청이므로 예외를 던진다.
			if (book == null) {
				throw new RuntimeException("잘못된 요청입니다.");
			}

			// 기존 담겨있는 것을 포함해서 총 변경될, 장바구니에 담긴 수량이 재고보다 크면 실패로 응답해서, 모달창에서 내용을 알린다.
			int totalQuantity = cartItemDao.getCartItemQuantityByBookNo(bookNo) + quantity;
			if (totalQuantity > book.getStock()) {
				result.put("success", false);
				break;
			}
			
			CartItem cartItem = new CartItem();
			cartItem.setUserNo(userNo);
			cartItem.setBook(book);
			cartItem.setQuantity(quantity); 
			
			cartItemDao.insertCartItem(cartItem);
			
			// 몇건의 도서 종류 담았는지 체크
			totalBookQuantity += 1;
		}
		
		// 정상적으로 저장했으면 장바구니 도서 건수를 전달할 map객체에 저장한다.
		result.put("quantity", totalBookQuantity);
		
	} else {
		// 전달받은 bookNo값이 없으면 비정상적인 요청이므로 예외를 던진다.
		throw new RuntimeException("잘못된 요청입니다.");
	}
	
	Gson gson = new Gson();
	String jsonText = gson.toJson(result);
	out.write(jsonText); // 이 페이지에 요청을 보낸 곳으로 응답정보를 보낸다.
%>