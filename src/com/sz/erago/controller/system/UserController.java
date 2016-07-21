package com.sz.erago.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sz.erago.model.SystemUsers;
import com.sz.erago.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private IUserService userService;
	
	@RequestMapping("/list")
	public @ResponseBody Map<String, Object> loadAllUser(SystemUsers user,@RequestParam(required = false) Integer page, //�ڼ�ҳ
            @RequestParam(required = false) Integer rows){
		if(user == null) user = new SystemUsers();
		//user.setUserName("ϵͳ");
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
			map.put("msg", "ɾ���ɹ�");
		}else{
			map.put("msg", "ɾ��ʧ��");
		}
		
		return map;
	}
}
