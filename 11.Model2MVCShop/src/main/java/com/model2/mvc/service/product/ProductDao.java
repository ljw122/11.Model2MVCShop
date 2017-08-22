package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Reply;

public interface ProductDao {
	
	public void addProduct(Product product) throws Exception;
	
	public Product getProduct(int prodNo) throws Exception;
	
	public Map<String, Object> getProductList(Search search) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public List<Reply> getProductCommentList(int prodNo) throws Exception;
	
	public void insertProductComment(Product product) throws Exception;

	public List<String> getProductNames(String prodName) throws Exception;

}
