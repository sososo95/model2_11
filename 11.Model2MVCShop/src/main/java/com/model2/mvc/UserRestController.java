package com.model2.mvc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.model2.mvc.service.UserService;
import com.model2.mvc.service.domain.User;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		// ���̵� ���ٸ�.
		if( dbUser==null ) {
			dbUser = new User();
		}
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
	
		return dbUser;
	}
	
	
	@RequestMapping( value="json/addUser", method=RequestMethod.POST )
	public Map<String, User> addUser( @RequestBody  User user ) throws Exception {

		System.out.println("/addUser POST ���");
		//Business Logic
		userService.addUser(user);
				
		Map<String, User>  map = new HashMap<String, User>();
		map.put("user", user);
		
		System.out.println("���� ���� �����ϴ� �� :   " + map);
		
		return map;
	}
	
	@RequestMapping( value="json/updateUser/{userId}", method=RequestMethod.GET )
	public User updateUser( @PathVariable String userId ) throws Exception{

		System.out.println("updateUser GET ���");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		
		return user;
	}
	
	
	@RequestMapping( value="json/updateUser", method=RequestMethod.POST )
	public Map<String, User> updateUser( @RequestBody User user) throws Exception{

		System.out.println("updateUser POST ���");
		//Business Logic
		System.out.println("���̵� Ȯ�� :   " + user);
		userService.updateUser(user);
		System.out.println("������Ʈ ���࿩�� Ȯ��");
		
		Map<String, User> map = new HashMap<String, User>();
		map.put("user", user);
		
		System.out.println("�ʰ� Ȯ�� : " + map);
		
		return map;
	}
	
	
	@RequestMapping( value="/json/autocomplete" , method=RequestMethod.POST )
	public @ResponseBody Map<String, Object> autocomplete( @RequestParam Map<String, Object> paramMap) throws Exception{
		
		System.out.println("autoList  POST");

		
		List<Map<String, Object>> autoList = userService.autocomplete(paramMap);
		paramMap.put("autoList", autoList);
		//System.out.println("Ȯ�ο� ������1111 :::::   " + autoList);
		//System.out.println("Ȯ�ο� ������2222 :::::   " + paramMap);
		
		return paramMap;
	}
	
	
	@RequestMapping( value="/json/listUser" , method=RequestMethod.POST )
	public List<User> listUser(  @RequestBody Search search ) throws Exception{
		
		System.out.println("/user/json/listUser");
		
		search.setPageSize(pageSize);
		
		System.out.println("search �� Ȯ�� :::: " + search);
		
		Map<String , Object> map=userService.getUserList(search);
		List<User> list = (List<User>) map.get("list");
				
		System.out.println("list �� Ȯ�� �� : " + list);
		
		return list;
	}
	
}