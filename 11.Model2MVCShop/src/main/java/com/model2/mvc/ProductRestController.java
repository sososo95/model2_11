package com.model2.mvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.ProductService;
import com.model2.mvc.service.UserService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;


//==> ȸ������ RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception{
		
		System.out.println("/product/json/getProduct : GET ���");
		
		Product product = productService.findProduct(prodNo);
		
		return product;
	}
	
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public List<Object> addProduct( @RequestBody  Product product ) throws Exception {

		System.out.println("/addProduct POST ���");

		productService.insertProduct(product);
		
		System.out.println("body�� ����  Ȯ�� :  " + product);
		
		List<Object>  list = new ArrayList<Object>();
		list.add(product.getManuDate());
		list.add(product.getPrice());
		list.add(product.getProdNo());
		list.add(product.getProdName());
		list.add(product.getProdDetail());
		
		System.out.println("���� ���� �����ϴ� ����Ʈ :   " + list);
		
		return list;
	}
	
	
	@RequestMapping( value="json/listProduct", method=RequestMethod.POST )
	public List<Product> listProduct( @RequestBody Search search) throws Exception{
		
		System.out.println("/product/json/listProduct");
		
		search.setPageSize(pageSize);
		
		Map<String , Object> map = productService.getProductList(search);
		List<Product> list = (List<Product>) map.get("list");
		
		System.out.println("list list list list :::::" + list);
		
		return list;
	}
	
	
	@RequestMapping( value="/json/autocomplete" , method=RequestMethod.POST )
	public @ResponseBody Map<String, Object> autocomplete( @RequestParam Map<String, Object> paramMap) throws Exception{
		
		System.out.println("autoList  POST");

		List<Map<String, Object>> autoList = productService.autocomplete(paramMap);
		paramMap.put("autoList", autoList);
		
		return paramMap;
	}
	
}