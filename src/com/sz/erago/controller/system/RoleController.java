package com.sz.erago.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sz.erago.framework.constant.GlobalConstant;
import com.sz.erago.model.common.Grid;
import com.sz.erago.model.common.Json;
import com.sz.erago.model.common.SessionInfo;
import com.sz.erago.model.system.SystemRole;
import com.sz.erago.service.IRoleService;

@Controller
@RequestMapping("/role")
public class RoleController {
	
	@Autowired
	private IRoleService roleService;
	
	@RequestMapping("/manage")
	public String manager() {
		return "/system/role";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Grid dataGrid(SystemRole role, @RequestParam(required = false) Integer page, //第几页
            @RequestParam(required = false) Integer rows) {
		Grid grid = new Grid();
		Map<String, Object> res = new HashMap<String, Object>();
		res = roleService.queryRoles(role, page, rows);
		grid.setRows((List) res.get("rows"));
		grid.setTotal((Long) res.get("total"));
		return grid;
	}
	
	@RequestMapping("/addPage")
	public String addPage() {
		return "/system/roleAdd";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public Json add(SystemRole role) {
		Json j = new Json();
		try {
			int flag = roleService.addRole(role);
			if(flag == 1){
				j.setSuccess(true);
				j.setMsg("角色添加成功！");
			}else{
				j.setSuccess(false);
				j.setMsg("角色添加失败！");
			}
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Long id) {
		Json j = new Json();
		try {
			roleService.deleteRole(id);
			j.setMsg("删除成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/get")
	@ResponseBody
	public SystemRole get(Long id)  {
		return roleService.getRoleInfo(id);
	}
	
	@RequestMapping("/editPage")
	public String editPage(HttpServletRequest request, HttpServletResponse response, Long id) {
		SystemRole r = roleService.getRoleInfo(id);
		request.setAttribute("role", r);
		if(r == null){
			request.setAttribute("msg", "当前编辑的角色不存在");
			return "/common/error";			
		}else{
			return "/system/roleEdit";
		}
	}

	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(SystemRole role) {
		Json j = new Json();
		try {
			int flag = roleService.updateRole(role);
			if(flag == 1)
			{
				j.setSuccess(true);
				j.setMsg("角色更新成功！");
			}
			else
			{
				j.setSuccess(false);
				j.setMsg("角色更新失败！");
			}
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
	
	@RequestMapping("/grantPage")
	public String grantPage(HttpServletRequest request, Long id) {
		SystemRole r = roleService.getRoleInfo(id);
		request.setAttribute("role", r);
		return "/system/roleGrant";
	}

	@RequestMapping("/grant")
	@ResponseBody
	public Json grant(HttpServletRequest request, SystemRole role) {
		Json j = new Json();
		SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute((GlobalConstant.SESSION_INFO));
		try {
			roleService.grantRole(role, sessionInfo);
			j.setMsg("授权成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
}
