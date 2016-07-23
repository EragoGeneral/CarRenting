package com.sz.erago.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sz.erago.model.SystemRole;
import com.sz.erago.model.common.Grid;
import com.sz.erago.model.common.Json;
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
	
	@RequestMapping("/add")
	@ResponseBody
	public Json add(SystemRole role) {
		Json j = new Json();
		try {
			roleService.saveRole(role);
			j.setSuccess(true);
			j.setMsg("添加成功！");
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
	public String editPage(HttpServletRequest request, Long id) {
		SystemRole r = roleService.getRoleInfo(id);
		request.setAttribute("role", r);
		return "/admin/roleEdit";
	}

	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(SystemRole role) {
		Json j = new Json();
		try {
			roleService.saveRole(role);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
	
	@RequestMapping("/grantPage")
	public String grantPage(HttpServletRequest request, Long id) {
		SystemRole r = roleService.getRoleInfo(id);
		request.setAttribute("role", r);
		return "/admin/roleGrant";
	}

	@RequestMapping("/grant")
	@ResponseBody
	public Json grant(SystemRole role) {
		Json j = new Json();
		try {
			roleService.grantRole(role);
			j.setMsg("授权成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
}
