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
		String sql = "SELECT * FROM product WHERE CONCAT(name,' ',description) LIKE ? ORDER BY product_id ASC";
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
		return 0;
	}
	
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		return 0;
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		return 0;
	}
	
}
