package com.model2.mvc.service.test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Reply;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mybatis.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-transaction.xml",
									"classpath:config/context-aspect.xml"})
public class ProductServiceTest {

	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;
	
	//@Test
	public void testGetInnerComment() throws Exception{
		
		System.out.println("hi");
		Product pr = new Product();
		
		pr.setReplyList(productService.getProductCommentList(10070));
		
		System.out.println(pr.getReplyList());
	}
	
	@Test
	public void testInsertInnerComment() throws Exception{
		
		System.out.println("hi");
		
		Product pr = new Product();
		
		Reply rp = new Reply();
		rp.setReplyNo(10049);
		rp.setCmt("대댓글입력테스트중입니다");
		rp.setUserId("admin");
		
		List<Reply> rl = new ArrayList<Reply>();
		rl.add(rp);
		
		pr.setProdNo(10070);
		pr.setReplyList(rl);
		
		productService.addProductComment(pr);
		
		System.out.println(productService.getProductCommentList(10070));
	}
	
}
