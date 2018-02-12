package com.example.spring.common.interceptor;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.example.spring.management.controller.MenuTreeController;

public class AuthorityInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthorityInterceptor.class);
	
	//preHandle()
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
	
		HttpSession session = request.getSession();
		
		if(session.getAttribute("adminYn").equals("Y")) {
			return true;
		}else {
			ArrayList<HashMap<String,Object>> userAuthList 
					= (ArrayList<HashMap<String,Object>>)session.getAttribute("userAuthList");
			
			String mnUrl;
			
			for(int i = 0; i<userAuthList.size(); i++) {
				mnUrl = "/"+(String)userAuthList.get(i).get("mnUrl");
				
				if(mnUrl.equals(request.getServletPath())) {
					
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
					
					Date atrAplyStrt = sdf.parse((String)userAuthList.get(i).get("atrAplyStrt"));
					Date atrAplyFini = sdf.parse((String)userAuthList.get(i).get("atrAplyFini"));
					
					Date today = new Date();

					if(atrAplyStrt.compareTo(today)<=0 && atrAplyFini.compareTo(today)>=0) {
						return true;
					}//if
					
				}//if
			}//for
			
			response.setContentType("text/html; charset=UTF-8");

		    PrintWriter out = response.getWriter();
            out.println("<script>alert('메뉴 접근 권한이 없습니다.'); history.go(-1);</script>"); 
            out.flush(); 
            
			return false;
		}//if else
	}//preHandle
}//AuthorityInterceptor

