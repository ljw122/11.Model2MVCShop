package com.model2.mvc.web.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Reply;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("product/*")
public class ProductController {

	/*Field*/
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 3}")
	int pageSize;

	@Autowired
	@Qualifier("uploadFilePath")
	private FileSystemResource fsr;
	
	
	/*Constructor*/
	public ProductController(){
		System.out.println(getClass());
	}
	
	/*Method*/
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public ModelAndView addProduct() throws Exception{
		return new ModelAndView("forward:addProductView.jsp");
	}
	
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public ModelAndView addProduct( @ModelAttribute("product") Product product,
									@RequestParam(value="file", required=false) MultipartFile file		) throws Exception{
		
		product.setFileName("");
		if(file != null && !file.isEmpty()){
			product.setFileName(file.getOriginalFilename());
		}
		
		productService.addProduct(product);
		
		return new ModelAndView("forward:addProduct.jsp");
	}
	
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public ModelAndView getProduct(	@RequestParam("menu") String menu,
									@RequestParam("prodNo") int prodNo,
									@CookieValue(value="history", required=false) String history, 
									HttpServletResponse response	) throws Exception{
		
		Product product = productService.getProduct(prodNo);
		product.setReplyList(productService.getProductCommentList(prodNo));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("product", product);
		modelAndView.addObject("replyList", product.getReplyList());
		
		String viewName = "redirect:updateProduct?prodNo="+prodNo;
		
		if(menu.equals("search")){
			String newHistory = prodNo + "";

			if(history != null){
				for(String h : history.split(",")){
					if(!CommonUtil.null2str(h).equals(new Integer(prodNo).toString())){
						newHistory += "," + h;
					}
				}
			}
			history = newHistory;
			
			Cookie cookie = new Cookie("history",history);
			cookie.setPath("/");
			response.addCookie(cookie);
			
			viewName = "forward:getProduct.jsp";
		}
		
		modelAndView.setViewName(viewName);
		
		return modelAndView;
	}
	
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public ModelAndView updateProduct(	@ModelAttribute("product") Product product,
										@RequestParam(value="file", required=false) MultipartFile file	) throws Exception{

		product.setFileName("");
		if(file != null && !file.isEmpty()){
			product.setFileName(file.getOriginalFilename());
		}
		
		productService.updateProduct(product);
		product=productService.getProduct(product.getProdNo());
		
		return new ModelAndView("forward:getProduct.jsp?menu=manage&prodNo="+product.getProdNo(), "product", product);
	}
	
	@RequestMapping( value="updateProduct", method=RequestMethod.GET )
	public ModelAndView updateProduct( @RequestParam("prodNo") int prodNo) throws Exception{
		Product product = productService.getProduct(prodNo);
		
		return new ModelAndView("forward:updateProductView.jsp", "product", product);
	}
	
	
	
	@RequestMapping( value="listProduct" )
	public ModelAndView listProduct(@ModelAttribute("search") Search search, @RequestParam("menu") String menu) throws Exception{
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		if(search.getSearchCondition() == null){
			search.setSearchCondition("1");
		}
		if(menu.equals("manage")){
			search.setStockView(true);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
				
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:listProduct.jsp?menu="+menu);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		
		return modelAndView;
	}
	
	@RequestMapping( value="addProductComment", method=RequestMethod.POST )
	public ModelAndView addProductComment(@ModelAttribute("product") Product product, @ModelAttribute("reply") Reply reply) throws Exception{
		List<Reply> list = new ArrayList<Reply>();
		
		list.add(reply);
		product.setReplyList(list);
		
		productService.addProductComment(product);
		
		return new ModelAndView("redirect:getProduct?menu=search&prodNo="+product.getProdNo());
	}
	

}
