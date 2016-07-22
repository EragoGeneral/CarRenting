package com.sz.erago.controller.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sz.erago.framework.constant.GlobalConstant;
import com.sz.erago.model.SystemUsers;
import com.sz.erago.model.common.Json;
import com.sz.erago.model.common.SessionInfo;
import com.sz.erago.service.IUserService;

@Controller
@RequestMapping("/admin")
public class IndexController{

	@Autowired
	private IUserService userService;

	/*@Autowired
	private ResourceServiceI resourceService;*/

	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
		if ((sessionInfo != null) && (sessionInfo.getId() != null)) {
			return "/index";
		}
		return "/login";
	}

	@ResponseBody
	@RequestMapping("/login")
	public Json login(SystemUsers user, HttpSession session) {
		Json j = new Json();
		SystemUsers sysuser = userService.getLoginUserInfo(user.getLoginName(), user.getPassword());
		if (sysuser != null) {
			j.setSuccess(true);
			j.setMsg("登陆成功！");

			SessionInfo sessionInfo = new SessionInfo();
			sessionInfo.setId(sysuser.getId().longValue());
			sessionInfo.setLoginname(sysuser.getLoginName());
			sessionInfo.setName(sysuser.getUserName());
//			sessionInfo.setResourceList(userService.listResource(sysuser.getId()));
			//sessionInfo.setResourceAllList(resourceService.listAllResource());
			session.setAttribute(GlobalConstant.SESSION_INFO, sessionInfo);
		} else {
			j.setMsg("用户名或密码错误！");
		}
		return j;
	}

	@ResponseBody
	@RequestMapping("/logout")
	public Json logout(HttpSession session) {
		Json j = new Json();
		if (session != null) {
			session.invalidate();
		}
		j.setSuccess(true);
		j.setMsg("注销成功！");
		return j;
	}

}
