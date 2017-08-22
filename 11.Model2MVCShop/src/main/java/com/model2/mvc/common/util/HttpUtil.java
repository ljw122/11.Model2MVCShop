package com.model2.mvc.common.util;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.service.domain.User;


public class HttpUtil {
	
	/*Field*/
	public static final String TO_LOGIN_PAGE = "redirect:/user/loginView.jsp";
	
	/*Constructor*/
	public HttpUtil(){
	}
	
	/*Method*/
	public static void forward(HttpServletRequest request, HttpServletResponse response, String path){
		try{
			RequestDispatcher dispatcher = request.getRequestDispatcher(path);
			dispatcher.forward(request, response);
		}catch(Exception ex){
			System.out.println("forward ���� : " + ex);
			throw new RuntimeException("forward ���� : " + ex);
		}
	}
	
	public static void redirect(HttpServletResponse response, String path){
		try{
			response.sendRedirect(path);
		}catch(Exception ex){
			System.out.println("redirect ���� : " + ex);
			throw new RuntimeException("redirect ����  : " + ex);
		}
	}
	
	public static boolean isLogin(HttpServletRequest request){
		if( (User)request.getSession().getAttribute("user")==null ){
			System.out.println("user ������ �����ϴ�!");
			return false;
		} else {
			return true;
		}
	}
}