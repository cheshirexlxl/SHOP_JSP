package shop.dao;

import java.util.List;

import shop.dto.Order;
import shop.dto.Product;
import shop.dto.User;

public class OrderRepository extends JDBConnection {

	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		
		String sql = " INSERT INTO order(orderNo, cartId, shipName, zipCode, country, address, date, userId, totalPrice, phone, orderPw )"
				   + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, order.getOrderNo());
			psmt.setString(2, order.getCartId());
			psmt.setString(3, order.getShipName());
			psmt.setString(4, order.getZipCode());
			psmt.setString(5, order.getCountry());
			psmt.setString(6, order.getAddress());
			psmt.setString(7, order.getDate());
			psmt.setString(8, order.getUserId());
			psmt.setInt(8, order.getTotalPrice());
			psmt.setString(8, order.getPhone());
			psmt.setString(8, order.getOrderPw());
			result = psmt.executeUpdate();
			
			rs = psmt.executeQuery();
            
            if (rs.next()) {
            	order = new Order();                               
            	order.setOrderNo(rs.getInt("order_no"));
            }
		} catch (Exception e) {
			System.err.println("회원 등록 시, 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		return 0;
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		return null;
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		return null;		
	}
	
}
