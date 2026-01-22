package shop.dao;

import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {

	/**
	 * 상품 목록
	 * @return
	 */
	public List<Product> list() {
		String sql = "SELECT * FROM product ORDER BY product_id ASC";
        List<Product> list = new ArrayList<>();
        try {
            psmt = con.prepareStatement(sql);
            rs = psmt.executeQuery();
            while(rs.next()) {
            	Product p = new Product();
                p.setProductId(rs.getString("product_id"));
                p.setName(rs.getString("name"));
                p.setUnitPrice(rs.getInt("unit_price"));
                p.setDescription(rs.getString("description"));
                p.setManufacturer(rs.getString("manufacturer"));
                p.setCategory(rs.getString("category"));
                p.setUnitsInStock(rs.getInt("units_in_stock"));
                p.setCondition(rs.getString("condition"));
                p.setFile(rs.getString("file"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;		
	}
	
	
	/**
	 * 상품 목록 검색
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		String sql = " SELECT * "
				   + " FROM product "
				   + " WHERE CONCAT( "
				   + "       IFNULL(name, ''), ' ', "
				   + "       IFNULL(description, ''), ' ', "
				   + "       IFNULL(manufacturer, ''), ' ', "
				   + "       IFNULL(category, '') "
				   + "       ) LIKE ? "
				   + " ORDER BY product_id ASC ";
		List<Product> list = new ArrayList<>();
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, "%" + keyword + "%"); // 검색어
            rs = psmt.executeQuery();
            while(rs.next()) {
            	Product p = new Product();
                p.setProductId(rs.getString("product_id"));
                p.setName(rs.getString("name"));
                p.setUnitPrice(rs.getInt("unit_price"));
                p.setDescription(rs.getString("description"));
                p.setManufacturer(rs.getString("manufacturer"));
                p.setCategory(rs.getString("category"));
                p.setUnitsInStock(rs.getInt("units_in_stock"));
                p.setCondition(rs.getString("condition"));
                p.setFile(rs.getString("file"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
	}
	
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		String sql = "SELECT * FROM product WHERE product_id = ?";
		
	    Product product = null;
	    
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, productId);

	        rs = psmt.executeQuery();

	        if (rs.next()) {  // 단일 조회니까 while 아님
	            product = new Product();
	            product.setProductId(rs.getString("product_id"));
	            product.setName(rs.getString("name"));
	            product.setUnitPrice(rs.getInt("unit_price"));
	            product.setDescription(rs.getString("description"));
	            product.setManufacturer(rs.getString("manufacturer"));
	            product.setCategory(rs.getString("category"));
	            product.setUnitsInStock(rs.getInt("units_in_stock"));
	            product.setCondition(rs.getString("condition"));
	            product.setFile(rs.getString("file"));
	            product.setQuantity(rs.getInt("quantity"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return product;
	}
	
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		String sql = " INSERT INTO product (product_id, name, unit_price, description, manufacturer, category, units_in_stock, `condition`, file, quantity) "
                   + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
	     int result = 0;
	     try {
	         psmt = con.prepareStatement(sql);
	         psmt.setString(1, product.getProductId());
	         psmt.setString(2, product.getName());
	         psmt.setInt(3, product.getUnitPrice());
	         psmt.setString(4, product.getDescription());
	         psmt.setString(5, product.getManufacturer());
	         psmt.setString(6, product.getCategory());
	         psmt.setLong(7, product.getUnitsInStock());
	         psmt.setString(8, product.getCondition());
	         psmt.setString(9, product.getFile());
	         psmt.setInt(10, product.getQuantity());         
	         result = psmt.executeUpdate();
	     } catch (Exception e) {
	         System.err.println("상품 등록 중 에러 발생");
	         e.printStackTrace();
	     }
	     return result;
	}
	
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;
		
		String sql = " UPDATE product "
				   + " SET name = ?, unit_price = ?, description = ?, manufacturer = ?, category = ?, units_in_stock = ?, `condition` = ?, file = ?, quantity = ? "
				   + " WHERE product_id = ? ";
		
		try {		
			psmt = con.prepareStatement(sql);			
			psmt.setString(1, product.getName());
			psmt.setInt(2, product.getUnitPrice());
			psmt.setString(3, product.getDescription());
			psmt.setString(4, product.getManufacturer());
			psmt.setString(5, product.getCategory());
			psmt.setLong(6, product.getUnitsInStock());
			psmt.setString(7, product.getCondition());
			psmt.setString(8, product.getFile());
			psmt.setInt(9, product.getQuantity());
			psmt.setString(10, product.getProductId());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("상품 수정 시, 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		String sql = "DELETE FROM product WHERE product_id = ?";
		int result = 0;
        try {            
            psmt = con.prepareStatement(sql);
	        psmt.setString(1, productId);
	        result = psmt.executeUpdate();
        } catch (Exception e) {
            System.err.println("상품 삭제 중 에러 발생");
            e.printStackTrace();
        }
        return result;
	}
	
}
