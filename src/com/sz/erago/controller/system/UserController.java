package com.sz.erago.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	public @ResponseBody Map<String, Object> loadAllUser(SystemUsers user,@RequestParam(required = false) Integer page, //�ڼ�ҳ
            @RequestParam(required = false) Integer rows){
		if(user == null) user = new SystemUsers();
		
		return userService.queryAllUsers(user, page, rows);
	}
	
	@RequestMapping("/addPage")
	public String addPage() {
		return "/system/userAdd";
	}
	
	@RequestMapping("/editPage")
	public String editPage(HttpServletRequest request, HttpServletResponse response, Integer id) {
		SystemUsers user = userService.getUserInfoByID(id);
		request.setAttribute("user", user);
		if(user == null){
			request.setAttribute("msg", "��ǰ�༭���û�������");
			return "/common/error";			
		}else{
			return "/system/userEdit";
		}
	}
	
	@RequestMapping("/save")
	public @ResponseBody Map<String, Object> saveUser(SystemUsers user){
		if(user == null) user = new SystemUsers();
		String msg = "�û����";
		if (user.getId() != null){
			msg = "�û��޸�";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		int flag = userService.saveUser(user);
		if(flag ==1){
			map.put("success", true);
			map.put("msg", msg+"�ɹ�");
		}else{
			map.put("success", false);
			map.put("msg", msg+"ʧ��");
		}
		
		return map;
	}
	
	@RequestMapping("/del")
	public @ResponseBody Map<String, Object> disableUserBySelectedID(String selectedIDs){
		Map<String, Object> map = new HashMap<String, Object>();
		int flag = userService.disableUserBySelectedID(selectedIDs);
		map.put("success", flag);
		if(flag ==1){
			map.put("msg", "ɾ���ɹ�");
		}else{
			map.put("msg", "ɾ��ʧ��");
		}
		
		return map;
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
	
	@RequestMapping("/grantPage")
	public String grantPage(HttpServletRequest request, Integer id) {
		SystemUsers r = userService.getUserInfoByID(id);
		request.setAttribute("user", r);
		return "/system/userGrant";
	}
	
	@RequestMapping("/grant")
	@ResponseBody
	public Json grant(HttpServletRequest request, String selectedRole, Integer userID) {
		Json j = new Json();
		SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute((GlobalConstant.SESSION_INFO));
		try {
			userService.grantRole(userID, selectedRole, sessionInfo);
			j.setMsg("��Ȩ�ɹ���");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
}
