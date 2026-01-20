package shop.dao;

import java.util.ArrayList;
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
		
		String sql = " INSERT INTO order(order_no, ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone )"
				   + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, order.getOrderNo());			
			psmt.setString(2, order.getShipName());
			psmt.setString(3, order.getZipCode());
			psmt.setString(4, order.getCountry());
			psmt.setString(5, order.getAddress());
			psmt.setString(6, order.getDate());
			psmt.setString(7, order.getOrderPw());
			psmt.setString(8, order.getUserId());
			psmt.setInt(9, order.getTotalPrice());
			psmt.setString(10, order.getPhone());
			
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
		String sql =  "SELECT * FROM `order` WHERE user_id = ? ORDER BY order_no DESC";
		List<Product> list = new ArrayList<>();
		try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, userId);
            rs = psmt.executeQuery();            
            while(rs.next()) {
            	Product p = new Product();
            	p.setOrderNo(rs.getInt("order_no"));            	
            	p.setUserId(rs.getString("user_id")); 
            	p.setProductId(rs.getString("product_id"));
                p.setName(rs.getString("name"));
                p.setUnitPrice(rs.getInt("unit_price"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
		
        return list;	
        
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
