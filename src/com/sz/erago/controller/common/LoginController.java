package com.sz.erago.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class LoginController {
	
	@RequestMapping("/Main")
	public String LoadMainPage(){
		
		//��֤��¼�������룬��ȷ����ת
		
		return "common/main";
	}
}
