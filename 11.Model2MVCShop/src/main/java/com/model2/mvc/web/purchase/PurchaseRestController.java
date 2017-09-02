package com.model2.mvc.web.purchase;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("purchase/json/*")
public class PurchaseRestController {

	/*Field*/
	@Autowired
	@Qualifier("purchaseService")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 3}")
	int pageSize;
	
	/*Constructor*/
	public PurchaseRestController(){
		System.out.println(getClass());
	}
	
	/*Method*/
	@RequestMapping( value="addPurchase/{prodNo}", method=RequestMethod.GET )
	public Product addPurchase(	@PathVariable int prodNo) throws Exception{
		return productService.getProduct(prodNo);
	}
	
	@RequestMapping( value="addPurchase", method=RequestMethod.POST )
	public Purchase addPurchase(	@RequestBody Purchase purchase	) throws Exception{

		purchaseService.addPurchase(purchase);
		
		return purchase;
	}
	
	@RequestMapping( value="getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase(	@PathVariable int tranNo	)throws Exception{
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase = purchaseService.getPurchase(purchase);
		
		return purchase;
	}
	
	@RequestMapping( value="updatePurchase", method=RequestMethod.POST )
	public Purchase updatePurchase(	@RequestBody Purchase purchase	) throws Exception{
		
		purchaseService.updatePurchase(purchase);
		
		return purchaseService.getPurchase(purchase);
	}
	
	@RequestMapping( value="listPurchase" )
	public Map<String, Object> listPurchase(	@RequestBody Search search	) throws Exception{
		
		return this.getList(search);
	}
	
	@RequestMapping( value="updateTranCode/{menu}", method=RequestMethod.POST )
	public Map<String, Object> updateTranCode(	@PathVariable String menu,
									@RequestBody Purchase purchase	) throws Exception{
		
		Purchase updatePurchase = purchaseService.getPurchase(purchase);
		updatePurchase.setTranCode(purchase.getTranCode());
		
		purchaseService.updatePurchase(updatePurchase);
		
		Search search = new Search();
		if(menu.equals("manage")){
			search.setSearchKeyword("purchaseList");
		}else{
			search.setSearchKeyword("saleList");
		}
		return this.getList(search);
	}
	
	@RequestMapping( value="updateTranCode/{tranNo}/{tranCode}", method=RequestMethod.GET )
	public boolean updateTranCode(	@PathVariable int tranNo,
									@PathVariable String tranCode	) throws Exception{
		
		Purchase updatePurchase = new Purchase();
		updatePurchase.setTranNo(tranNo);
		updatePurchase = purchaseService.getPurchase(updatePurchase);
		updatePurchase.setTranCode(tranCode);
		
		purchaseService.updatePurchase(updatePurchase);
		
		return true;
	}
	
	
	
	private Map<String, Object> getList(Search search) throws Exception{

		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);

		Map<String, Object> map = purchaseService.getPurchaseList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		map.put("serarch", search);
		
		return map;
	}
	
}
