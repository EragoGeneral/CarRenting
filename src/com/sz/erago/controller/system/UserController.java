package com.sz.erago.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sz.erago.framework.constant.GlobalConstant;
import com.sz.erago.model.SystemUsers;
import com.sz.erago.model.common.Json;
import com.sz.erago.model.common.SessionInfo;
import com.sz.erago.model.system.SystemRole;
import com.sz.erago.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private IUserService userService;
	
	@RequestMapping("/manage")
	public String manager() {
		return "/system/user";
	}
	
	@RequestMapping("/list")
	public @ResponseBody Map<String, Object> loadAllUser(SystemUsers user,@RequestParam(required = false) Integer page, //第几页
            @RequestParam(required = false) Integer rows){
		if(user == null) user = new SystemUsers();
		//user.setUserName("系统");
//		List<SystemUsers> userList = userService.queryAllUsers(user, page, rows);		
//		Map<String, Object> res = new HashMap<String, Object>();
//		res.put("total", userList.size());
//		res.put("rows", userList);
		
		return userService.queryAllUsers(user, page, rows);
	}
	
	@RequestMapping("/save")
	public @ResponseBody Map<String, Object> saveUser(SystemUsers user){
		if(user == null) user = new SystemUsers();
		Map<String, Object> map = new HashMap<String, Object>();
		int flag = userService.saveUser(user);
		if(flag ==1){
			map.put("success", true);
		}else{
			map.put("success", false);
		}
		
		return map;
	}
	
	@RequestMapping("/del")
	public @ResponseBody Map<String, Object> getUserInfoBySelectedID(String selectedIDs){
		Map<String, Object> map = new HashMap<String, Object>();
//		List<SystemUsers> users = userService.getUserInfoBySelectedID(selectedIDs);
		int flag = userService.disableUserBySelectedID(selectedIDs);
		map.put("success", flag);
		if(flag ==1){
			map.put("msg", "删除成功");
		}else{
			map.put("msg", "删除失败");
		}
		
		return map;
	}
	
	@RequestMapping("/grantPage")
	public String grantPage(HttpServletRequest request, Integer id) {
		SystemUsers r = userService.getUserInfoByID(id);
		request.setAttribute("user", r);
		return "/system/userGrant";
	}
	
	@RequestMapping("/loadRole")
	@ResponseBody
	public Json loadRole(HttpServletRequest request, Integer id){
		Json j = new Json();
		
		SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
		Map<String, List<SystemRole>> map = userService.loadRoleListByUser(id, sessionInfo);
		j.setObj(map);
		
		return j;
	}
	
	@RequestMapping("/grant")
	@ResponseBody
	public Json grant(HttpServletRequest request, String selectedRole, Integer userID) {
		Json j = new Json();
		SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute((GlobalConstant.SESSION_INFO));
		try {
			userService.grantRole(userID, selectedRole, sessionInfo);
			j.setMsg("授权成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
}
