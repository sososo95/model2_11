package com.model2.mvc;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.ProductService;
import com.model2.mvc.service.PurchaseService;
import com.model2.mvc.service.UserService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;


//==> ȸ������ Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 3}") 
	int pageSize;
	
	
	
	@RequestMapping(value = "addPurchase", method = RequestMethod.POST) // ���� ����
	public ModelAndView addPurchase( @ModelAttribute("purchase") Purchase purchase,
					@RequestParam("buyerId") String userId, @RequestParam("prodNo") int prodNo) throws Exception {

		System.out.println("addPurchase POST ���");
	
		purchase.setBuyer(userService.getUser(userId)); // id��
		purchase.setPurchaseProd(productService.findProduct(prodNo)); // prodno��
		purchase.setTranCode("1"); // Ʈ�� �ڵ�� ������ ����
		purchaseService.addPurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("pur", purchase);
		
		modelAndView.setViewName("forward:/purchase/addPurchase.jsp");
		
		return modelAndView;
	}
	
	
	
	@RequestMapping(value = "addPurchase", method = RequestMethod.GET) // ���� ����â
	public ModelAndView addPurchasevView( @RequestParam("prod_no") int prod_no) throws Exception {

		System.out.println("addPurchase GET ���");
	
		Product product = productService.findProduct(prod_no);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("pro", product);
		
		modelAndView.setViewName("forward:/purchase/addPurchaseView.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value = "listPurchase") // ��ǰ ����Ʈ
	public ModelAndView listPurchase( @ModelAttribute("search") Search search) throws Exception{
		
		
		System.out.println("listPurchase GET/POST");
		
		if(search.getPage() ==0 ){
			search.setPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map=purchaseService.getPurchaseList(search);
		Page resultPage = new Page( search.getPage(), ((Integer)map.get("totalCount")).intValue(), 
									pageUnit, pageSize);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		modelAndView.setViewName("forward:/purchase/listPurchase.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value = "getPurchase", method = RequestMethod.GET) // ���Ż�ǰ Ȯ��
	public ModelAndView getPurchase( @RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("getPurchase GET ���");
		
		Purchase purchase = purchaseService.getPurchase(prodNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("pur", purchase);
		
		modelAndView.setViewName("forward:/purchase/getPurchase.jsp");
		
		return modelAndView;
	}

	
	@RequestMapping(value = "updatePurchase", method = RequestMethod.GET) // ������Ʈ �� Ȯ��
	public ModelAndView updatePurchase( @RequestParam("prodNo") int prodNo) throws Exception{

		System.out.println("updatePurchase GET ���");
		
		Purchase purchase = purchaseService.getPurchase(prodNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("pur", purchase);
		
		modelAndView.setViewName("forward:/purchase/updatePurchaseView.jsp");
		
		return modelAndView;
	}
	

	@RequestMapping(value = "updatePurchase", method = RequestMethod.POST) // ���� ������Ʈ
	public ModelAndView updatePurchase(@ModelAttribute("purchase") Purchase purchase ,
			@RequestParam("buyerId") String userId, @RequestParam("prodNo") int prodNo) throws Exception{

		System.out.println("updatePurchase POST ���");
		
		purchase.setBuyer(userService.getUser(userId)); // id��
		purchase.setPurchaseProd(productService.findProduct(prodNo)); // prodno
		purchaseService.updatePurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("pur", purchase);
		
		modelAndView.setViewName("forward:/purchase/getPurchase.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value = "updateTranCode", method = RequestMethod.GET )
	public ModelAndView updateTranCode(@ModelAttribute("purchase") Purchase purchase,
			@RequestParam("tranCode") String tranCode) throws Exception{

		System.out.println("updateTranCode GET ���");
		
		purchaseService.updateTranCode(purchase);
				
		ModelAndView modelAndView = new ModelAndView();	
		modelAndView.setViewName("forward:/purchase/listPurchase");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value = "updateTranCodeByProd", method = RequestMethod.GET )
	public ModelAndView updateTranCodeByProd(@RequestParam("tranCode") String tranCode, @RequestParam("prodNo") int prodNo) throws Exception{

		System.out.println("updateTranCodeByProd GET ���");
						
		Purchase purchase = purchaseService.getPurchase(prodNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/product/listProduct?menu=manage");
		
		return modelAndView;
	}

}