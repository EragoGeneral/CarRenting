package com.sz.erago.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sz.erago.model.SystemMenu;
import com.sz.erago.model.common.TreeNode;
import com.sz.erago.service.ISystemService;

@Controller
@RequestMapping("/system")
public class SystemController {

	@Resource
	private ISystemService menuService;
	
	@RequestMapping("/menu")
	public String showMenu(HttpServletRequest request, Model model){
		int menuId = Integer.parseInt(request.getParameter("id"));
		SystemMenu menu = this.menuService.getMenuByID(menuId);		
		model.addAttribute("menu", menu);
		
		return "showMenu";
	}
	
	@RequestMapping("/jsonMenu")
	public @ResponseBody SystemMenu JsonMenu(HttpServletRequest request){
		int menuId = Integer.parseInt(request.getParameter("id"));
		SystemMenu menu = this.menuService.getMenuByID(menuId);		
		
		return menu; 
	}
	
	@RequestMapping("/MainMenu")
	public @ResponseBody List<SystemMenu> buildMenus(){		
		List<SystemMenu> menus = menuService.buildMenus();
		
		return menus;
	}
	
	@RequestMapping("/menumanagement")
	public String goToMenuMgt(){
		
		return "/system/menu_mgt";
	}
	
	@RequestMapping("/usermanagement")
	public String goToUserMgt(){
		
		return "/system/user_mgt";
	}

	@RequestMapping("/loadMenu")
	public @ResponseBody List<TreeNode> loadMenus(){
		List<TreeNode> nodes = menuService.loadMenu();
		TreeNode root = new TreeNode(-1, "系统菜单", false, "open");
		root.setIconCls("cut.png");
		root.setChildren(nodes);
		List<TreeNode> menus = new ArrayList<TreeNode>();
		menus.add(root);
		
		return menus;
	}
	
	@RequestMapping("/getMenuInfo")
	public @ResponseBody SystemMenu getMenuInfo(HttpServletRequest req){
		SystemMenu menu = menuService.getMenuByID(Integer.parseInt(req.getParameter("id")));
		
		return menu;
	}
	
	@RequestMapping(value="/saveMenu", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> saveMenu(SystemMenu menu){
		System.out.println("菜单名称: " + menu.getName());
		System.out.println("菜单链接: " + menu.getLink());
		System.out.println("菜单显示顺序: " + menu.getDisplayOrder());
		System.out.println("菜单级别: " + menu.getLevel());
		System.out.println("菜单父ID: " + menu.getParentId());
		
		int menuID = menuService.saveMenu(menu);
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("success", "true");
		m.put("menu", menu);
		
		return m;
	}
	
	@RequestMapping(value="/deleteMenuInfo", method = RequestMethod.POST)
	public @ResponseBody Map<String, String> deleteMenuInfo(Integer id){
		Map<String, String> res = new HashMap<String, String>();
		int flag = menuService.disabledMenuByID(id);
		if(flag == 1){
			res.put("success", "true");
		}else{
			res.put("success", "false");
		}
		
		return res;
	}
}
