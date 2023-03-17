package com.model2.mvc;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.ProductService;


//==> ȸ������ Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	

	@Value("#{commonProperties['pageUnit'] ?: 6}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 2}") 
	int pageSize;
	
	

	@RequestMapping(value="addProduct", method=RequestMethod.POST ) // ��ǰ �߰�
	public String addProduct(@ModelAttribute("product") Product product, 
			MultipartHttpServletRequest file ,Model model, HttpServletRequest request ) throws Exception {

		System.out.println("addProduct POST���");
					
		List<MultipartFile> fileList = file.getFiles("file");
		
		String path = request.getServletContext().getRealPath("/images/uploadFiles/");
		//String path = "/Users/sojaeyeon/workspace/11.Model2MVCShop/src/main/webapp/images/uploadFiles/";
		
		String listFile = ""; // ������ ���� ���� ��
		
		for(MultipartFile mf : fileList) {
			
			String FileName = System.currentTimeMillis() + "_" + mf.getOriginalFilename().trim();
						
			if(mf.getOriginalFilename().equals("")) {
				product.setFileName("");
			} else {
				mf.transferTo(new File(path + FileName)); // ��ο� ���� ���� 
				listFile += FileName + "/";
				
				if(fileList.size() == fileList.size()) {
					product.setFileName(listFile.substring(0, listFile.length() - 1));
				}
			}	
		}
		
		if(product.getFileName() != null) { // �̹��� �ְ� Ȯ�ο�
			List<String> image = new ArrayList<String>();
			StringTokenizer str = new StringTokenizer(listFile , "/");
			
			while(str.hasMoreTokens()) {
				image.add(str.nextToken());
			}
			
			model.addAttribute("image", image);
		}
		
		productService.insertProduct(product);
		model.addAttribute("pro", product);
		
		return "forward:/product/productView.jsp";
	}
	
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET) // ��ǰ ���� Ȯ��
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception {
		
		System.out.println("getProduct GET ���");
		
		Product product = productService.findProduct(prodNo);
		

		System.out.println("���δ�Ʈ �̹��� Ȯ�ο� :   " + product);
		
		// ���� �̹����� ��쿡 ���
		if(product.getFileName() != null) {
			System.out.println("������ ������ Ȯ�ο�");
			
			List<String> image = new ArrayList<String>();
			
			StringTokenizer str = new StringTokenizer(product.getFileName(), "/");
			
			while(str.hasMoreTokens()) {
				image.add(str.nextToken());
			}
		
			System.out.println("image ����Ʈ �� Ȯ�� :   " + image);
			
			model.addAttribute("image", image);
		}
		
		model.addAttribute("pro", product);
		model.addAttribute("search", "search");
		
		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping(value="listProduct") // ��ǰ ����Ʈ
	public String listProduct( @ModelAttribute("search") Search search , Model model, @RequestParam("menu") String menu) throws Exception{
		
		
		System.out.println("listProduct GET/POST");
		
		String window = "";
		
		if(search.getPage() ==0 ){
			search.setPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getPage(), ((Integer)map.get("totalCount")).intValue(), 
									pageUnit, pageSize);
	
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		//model.addAttribute("window", "product");
			
		if(menu.equals("search")) {
			window = "forward:/homepage.jsp";
		} else if (menu.equals("manage")) {
			window = "forward:/product/listProduct.jsp";
		}
		
		return window;
	}
	
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET) // ������Ʈ �� Ȯ��
	public String updateProduct( @RequestParam("prodNo") int prodNo, Model model ) throws Exception{

		System.out.println("updateProductView GET ���");
		
		Product product = productService.findProduct(prodNo);
		
		model.addAttribute("pro", product);
		
		return "forward:/product/updateProductView.jsp"; 
	}

	@RequestMapping(value="updateProduct", method=RequestMethod.POST) 
	public String updateProduct(@ModelAttribute("product") Product product , Model model
			, MultipartHttpServletRequest file, HttpServletRequest request) throws Exception{

		System.out.println("updateProduct POST ���");
		
		
		List<MultipartFile> fileList = file.getFiles("file");
		System.out.println("����Ʈ Ȯ�� :    " + fileList);
		
		String path = request.getServletContext().getRealPath("/images/uploadFiles/");
		//String path = "/Users/sojaeyeon/workspace/11.Model2MVCShop/src/main/webapp/images/uploadFiles/";
		
		String listFile = ""; // ������ ���� ���� ��
		
		for(MultipartFile mf : fileList) {
			
			String FileName = System.currentTimeMillis() + "_" + mf.getOriginalFilename().trim();
						
			if(mf.getOriginalFilename().equals("")) {
				product.setFileName(product.getFileName()); // ���� �������ϸ� ������ ����
			} else {
				mf.transferTo(new File(path + FileName)); 
				listFile += FileName + "/";
				
				if(fileList.size() == fileList.size()) {
					product.setFileName(listFile.substring(0, listFile.length() - 1));
				}
			}
		}
		
		if(product.getFileName() != null) { // �̹��� �ְ� Ȯ��
			
			List<String> image = new ArrayList<String>();
			
			StringTokenizer str = new StringTokenizer(product.getFileName(), "/");
			
			while(str.hasMoreTokens()) {
				image.add(str.nextToken());
			}
		
			System.out.println("image ����Ʈ �� Ȯ�� :   " + image);
			
			model.addAttribute("image", image);
		}

		productService.updateProduct(product);
		
		model.addAttribute("pro", product);
		
		return "forward:/product/getProduct.jsp"; 
	}

}