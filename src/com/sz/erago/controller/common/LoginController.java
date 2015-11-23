package com.sz.erago.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class LoginController {
	
	@RequestMapping("/Main")
	public String LoadMainPage(){
		
		//验证登录名与密码，正确则跳转
		
		return "common/main";
	}
}
