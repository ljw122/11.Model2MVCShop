package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("user/json/*")
public class UserRestController {

	/*Field*/
	@Autowired
	@Qualifier("userService")
	private UserService userService;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 3}")
	int pageSize;
	
	
	/*Constructor*/
	public UserRestController(){
		System.out.println(getClass());
	}
	
	/*Field*/
//	@RequestMapping( value="json/addUser", method=RequestMethod.GET )
//	public String addUser() throws Exception{
//		return "redirect:addUserView.jsp";
//	}
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public Map<String, Object> addUser(	@RequestBody User user ) throws Exception{

		Map<String, Object> map = new HashMap<String, Object>();
		String message = "환영합니다, "+user.getUserName()+"님!";
		if(userService.addUser(user)==0){
			message = "잘못된 정보를 입력하였습니다.";
		}
		map.put("message", message);
		
		return map;
	}
	
	@RequestMapping( value="getUser/{userId}", method=RequestMethod.GET )
	public User getUser(  @PathVariable String userId ) throws Exception{

		return userService.getUser(userId);

	}
	
//	@RequestMapping( value="json/updateUser", method=RequestMethod.GET )
//	public String updateUser( @RequestParam("userId") String userId, Model model) throws Exception{
//
//		User user = userService.getUser(userId);
//		
//		model.addAttribute("user", user);
//		
//		return "forward:updateUser.jsp";
//	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public User updateUser( @RequestBody User user ) throws Exception{
		
		userService.updateUser(user);
		
		return userService.getUser(user.getUserId());
	}
	
//	@RequestMapping( value="json/login", method=RequestMethod.GET )
//	public String login() throws Exception{
//		return "redirect:loginView.jsp";
//	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public User login( @RequestBody User user, HttpSession session) throws Exception{
		User dbUser = userService.getUser(user.getUserId());
		
		if(user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
//	@RequestMapping( value="json/logout", method=RequestMethod.GET )
//	public String logout(HttpSession session) throws Exception{
//		session.invalidate();
//		
//		return "redirect:../index.jsp";
//	}
	
	@RequestMapping( value="checkDuplication/{userId}", method=RequestMethod.GET )
	public boolean checkDuplication( @PathVariable String userId ) throws Exception{

		return userService.checkDuplication(userId);
	}
	
	@RequestMapping( value="listUser" )
	public Map<String, Object> listUser( @RequestBody Search search ) throws Exception{
		
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = userService.getUserList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
}
