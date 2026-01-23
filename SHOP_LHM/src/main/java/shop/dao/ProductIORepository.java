package shop.dao;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product) {
		String sql = " INSERT INTO `product_io` (product_id, order_no, amount, type, user_id) "
                + " VALUES (?, ?, ?, ?, ?) ";
	     int result = 0;
	     try {
	         psmt = con.prepareStatement(sql);
	         psmt.setString(1, product.getProductId());
	         psmt.setInt(2, product.getOrderNo());
	         psmt.setInt(3, product.getQuantity());
	         psmt.setString(4, product.getType());
	         psmt.setString(5, product.getUserId());     
	         result = psmt.executeUpdate();
	     } catch (Exception e) {
	         System.err.println("상품 입출고 등록 중 에러 발생");
	         e.printStackTrace();
	     }
	     return result;
	}
	
}
