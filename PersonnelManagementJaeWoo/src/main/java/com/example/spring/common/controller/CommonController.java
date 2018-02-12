package com.example.spring.common.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.common.service.CommonService;
import com.mysql.cj.api.Session;

@Controller
public class CommonController {
	
	@Autowired
	private CommonService commonService;
	String PRE_VIEW_PATH = "common/"; //common path
	
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

	//공통 사이드 메뉴 리스트 
	@RequestMapping(value="/navList.ajax")
	public @ResponseBody HashMap<String,Object> navMenu(@RequestParam HashMap<String,String> map) {
		
		HashMap<String,Object> menuMap = new HashMap<String,Object>();
		menuMap.put("mnPrntMap",commonService.selectMenu(map));
		menuMap.put("navList",commonService.navList());
		
		return menuMap;
	}//navMenu
	
	//로그인 페이지로 이동
	@RequestMapping(value="/login.do")
	public String loginForm() {
		return "login";
	}//loginForm
	
	//로그인 작업 실행
	@RequestMapping(value="/loginProcess")
	public @ResponseBody HashMap<String,Object> loginProcess(@RequestParam HashMap<String,Object> map,HttpSession session) {
		
		HashMap<String,Object> userMap = commonService.loginProcess(map);
		
		if(userMap!=null) {
			if(session.getAttribute("userEmno") != null) {
				session.removeAttribute("userEmno");
			}//기존 세션값 삭제
			session.setAttribute("userEmno", userMap.get("empEmno"));
			session.setAttribute("userId", userMap.get("empId"));
			session.setAttribute("adminYn", userMap.get("empAdminYn"));
			session.setAttribute("userAuthList",commonService.authorityProcess(userMap));
			
		}//if 정상적인 로그인 인 경우 
		
		return userMap;
	}//loginProcess
	
	//로그아웃
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "login";
	}//logout
	
	@RequestMapping(value="main.do")
	public String main() {
		return "main"; 
	}

}//CommonController
