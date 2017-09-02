package com.model2.mvc.web.product;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Reply;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("product/json/*")
public class ProductRestController {

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
	public ProductRestController(){
		System.out.println(getClass());
	}
	
	/*Method*/
//	@RequestMapping( value="addProduct", method=RequestMethod.GET )
//	public ModelAndView addProduct() throws Exception{
//		return new ModelAndView("forward:addProductView.jsp");
//	}
	
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public Product addProduct( @RequestParam("product") /*Map<String, Object> map*/ String json,
									@RequestParam("file") MultipartFile file		) throws Exception{
		
//		Product product = (Product)map.get("product");
//		MultipartFile file = (MultipartFile)map.get("file");
		
		Product product = new ObjectMapper().readValue(json.toString(), Product.class);
		
		product.setFileName("");
		if(!file.isEmpty()){
			FileOutputStream fos = new FileOutputStream(new File(fsr.getPath(), file.getOriginalFilename()));
			fos.write(file.getBytes());
			fos.flush();
			fos.close();
			product.setFileName(file.getOriginalFilename());
		}
		
		productService.addProduct(product);
		
		return product;
	}

	@RequestMapping( value="uploadFile", method=RequestMethod.POST )
	public boolean uploadFile( @RequestParam("file") MultipartFile file ) throws Exception{
		
		boolean result = false;
		
		if(!file.isEmpty()){
			try{
				file.transferTo(new File(fsr.getPath(),file.getOriginalFilename()));
				result = true;
			}catch(Exception e){
				System.out.println(file.getOriginalFilename()+" upload fail;");
			}
		}
		
		return result;
	}
	
	@RequestMapping( value="getProduct/{menu}/{prodNo}", method=RequestMethod.GET )
	public Map<String, Object> getProduct(	@PathVariable String menu,
									@PathVariable int prodNo	) throws Exception{
		
		Product product = productService.getProduct(prodNo);
		product.setReplyList(productService.getProductCommentList(prodNo));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("product", product);
		map.put("replyList", product.getReplyList());
		
		return map;
	}
	
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public Product updateProduct(	@RequestBody Product product,
										@RequestParam("file") MultipartFile file	) throws Exception{


		if(!file.isEmpty()){
			file.transferTo(new File(fsr.getPath(), file.getOriginalFilename()));
			product.setFileName(file.getOriginalFilename());
		}
		
		productService.updateProduct(product);
		product=productService.getProduct(product.getProdNo());
		
		return product;
	}
	
//	@RequestMapping( value="updateProduct", method=RequestMethod.GET )
//	public ModelAndView updateProduct( @RequestParam("prodNo") int prodNo) throws Exception{
//		Product product = productService.getProduct(prodNo);
//		
//		return new ModelAndView("forward:updateProductView.jsp", "product", product);
//	}
	
	
	
	@RequestMapping( value="listProduct/{menu}" )
	public Map<String, Object> listProduct(@RequestBody Search search, @PathVariable String menu) throws Exception{
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		if(menu.equals("manage")){
			search.setStockView(true);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		if(search.getSearchCondition() != null && search.getSearchCondition().equals("2")){
			try{
				Integer.parseInt(search.getSearchKeyword());
			}catch(NumberFormatException e){
				search.setSearchKeyword("");
			}
			try{
				Integer.parseInt(search.getSearchKeyword2());
			}catch(NumberFormatException e){
				search.setSearchKeyword2("");
			}
		}
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		
		return map;
	}
	
	@RequestMapping( value="addProductComment", method=RequestMethod.POST )
	public List<Reply> addProductComment(@RequestBody Product product, @RequestBody Reply reply) throws Exception{
		List<Reply> list = new ArrayList<Reply>();
		
		list.add(reply);
		product.setReplyList(list);
		
		productService.addProductComment(product);
		
		return list;
	}
	
	@RequestMapping( value="getHistory", method=RequestMethod.GET)
	public List<String> getHistory(@CookieValue("history") String history){
		List<String> list = new ArrayList<String>();
		if(history != null){
			for(String h : history.split(",")){
				list.add(h);
			}
		}
		return list;
	}
	
	@RequestMapping( value="getProductNames", method=RequestMethod.POST)
	public List<String> getProductNames(@RequestBody Search search) throws Exception{
		List<String> list = productService.getProductNames(search.getSearchKeyword()); 
		return list;
	}
	
	//ÇÑ±ÛÀÎÄÚµù¹®Á¦ ¹ß»ý...Áê·èÁê·è
	@RequestMapping( value="getProductNames/{value}", method=RequestMethod.GET)
	public List<String> getProductNames(@PathVariable String value) throws Exception{
		List<String> list = productService.getProductNames(value); 
		return list;
	}
	
	@RequestMapping( value="getIndexProductList", method=RequestMethod.GET )
	public Map<String, Object> getIndexProductList() throws Exception{
		return productService.getIndexProductList();
	}
	
}
