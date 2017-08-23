package com.model2.mvc.web.user;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("user/*")
public class UserController {

	/*Field*/
	@Autowired
	@Qualifier("userService")
	private UserService userService;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 3}")
	int pageSize;
	
	
	/*Constructor*/
	public UserController(){
		System.out.println(getClass());
	}
	
	/*Method*/
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
		return "redirect:addUserView.jsp";
	}
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser(	@ModelAttribute("user") User user ) throws Exception{
		userService.addUser(user);
		
		return "redirect:loginView.jsp";
	}
	
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser(  @RequestParam("userId") String userId, Model model) throws Exception{

		User user = userService.getUser(userId);
		
		model.addAttribute("user", user);
		
		return "forward:getUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId, Model model) throws Exception{

		User user = userService.getUser(userId);
		
		model.addAttribute("user", user);
		
		return "forward:updateUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user, Model model, HttpSession session) throws Exception{
		
		userService.updateUser(user);
		
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		return "redirect:getUser?userId="+user.getUserId();
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login( @ModelAttribute("user") User user, HttpSession session) throws Exception{
		User dbUser = userService.getUser(user.getUserId());
		
		if(dbUser != null && user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
			return "redirect:../index.jsp";
		}else{
			return "redirect:loginView.jsp";
		}
		
	}
	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session, HttpServletResponse response) throws Exception{
		session.invalidate();
		Cookie cookie = new Cookie("history", "");
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		return "redirect:../index.jsp";
	}
	
	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userId") String userId, Model model) throws Exception{
		boolean result = userService.checkDuplication(userId);
		
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);
		
		return "forward:checkDuplication.jsp";
	}
	
	@RequestMapping( value="listUser" )
	public String listUser(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception{
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = userService.getUserList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:listUser.jsp";
	}
}
