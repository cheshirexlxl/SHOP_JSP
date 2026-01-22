package shop.dao;

import java.sql.Statement;
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
		int orderNo = 0;		
		String sql = " INSERT INTO order(ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone )"
				   + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
		try {
			psmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
			psmt.setString(1, order.getShipName());
			psmt.setString(2, order.getZipCode());
			psmt.setString(3, order.getCountry());
			psmt.setString(4, order.getAddress());
			psmt.setString(5, order.getDate());
			psmt.setString(6, order.getOrderPw());
			psmt.setString(7, order.getUserId());
			psmt.setInt(8, order.getTotalPrice());
			psmt.setString(9, order.getPhone());
			
			int result = psmt.executeUpdate();
			
			if (result > 0) {
	            rs = psmt.getGeneratedKeys();
	            if (rs.next()) {
	                orderNo = rs.getInt(1); // 자동 생성된 order_no
	            }
	        }
		} catch (Exception e) {
			System.err.println("주문 등록 중, 예외 발생");
			e.printStackTrace();
		}
		return orderNo;
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
