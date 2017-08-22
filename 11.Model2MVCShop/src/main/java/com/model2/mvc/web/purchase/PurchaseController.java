package com.model2.mvc.web.purchase;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("purchase/*")
public class PurchaseController {

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
	public PurchaseController(){
		System.out.println(getClass());
	}
	
	/*Method*/
	@RequestMapping( value="addPurchase", method=RequestMethod.GET )
	public String addPurchase(@RequestParam("prodNo") int prodNo, Model model) throws Exception{
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:addPurchaseView.jsp";
	}
	
	@RequestMapping( value="addPurchase", method=RequestMethod.POST )
	public String addPurchase(	@ModelAttribute("purchase") Purchase purchase	) throws Exception{

		purchaseService.addPurchase(purchase);
		
		return "forward:addPurchase.jsp";
	}
	
	@RequestMapping( value="getPurchase", method=RequestMethod.GET )
	public String getPurchase(	@ModelAttribute("purchase") Purchase purchase,
								Model model	)throws Exception{
		purchase = purchaseService.getPurchase(purchase);
		model.addAttribute("purchase", purchase);
		
		return "forward:getPurchase.jsp";
	}
	
	@RequestMapping( value="updatePurchase", method=RequestMethod.GET )
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase, Model model) throws Exception{
		purchase = purchaseService.getPurchase(purchase);
		model.addAttribute("purchase", purchase);
		
		return "forward:updatePurchaseView.jsp";
	}
	
	@RequestMapping( value="updatePurchase", method=RequestMethod.POST )
	public String updatePurchase(	@ModelAttribute("purchase") Purchase purchase	) throws Exception{
		
		purchaseService.updatePurchase(purchase);
		
		return "redirect:getPurchase?tranNo="+purchase.getTranNo();
	}
	
	@RequestMapping( value="listPurchase" )
	public String listPurchase(	@ModelAttribute("search") Search search,
								Model model		) throws Exception{
		
		this.getList(search, model);
		
		return "forward:listPurchase.jsp";
	}
	
	@RequestMapping( value="listSale" )
	public String listSale(	@ModelAttribute("search") Search search,
							Model model) throws Exception{
		
		this.getList(search, model);
		
		return "forward:listSale.jsp";
	}

	@RequestMapping( value="updateTranCode", method=RequestMethod.GET )
	public String updateTranCode(	@RequestParam("menu") String menu,
									@ModelAttribute("purchase") Purchase purchase	) throws Exception{
		
		Purchase updatePurchase = purchaseService.getPurchase(purchase);
		updatePurchase.setTranCode(purchase.getTranCode());
		
		purchaseService.updatePurchase(updatePurchase);
		
		if(menu.equals("manage")){
			return "forward:listSale?searchKeyword=saleList";
		}else{
			return "forward:listPurchase?searchCondition="+purchase.getBuyer().getUserId()+"&searchKeyword=purchaseList";
		}
	}
	
	
	
	private void getList(Search search, Model model) throws Exception{

		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);

		Map<String, Object> map = purchaseService.getPurchaseList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
	}
	
}
