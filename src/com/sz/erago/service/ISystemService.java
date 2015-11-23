package com.sz.erago.service;

import java.util.List;

import com.sz.erago.model.SystemMenu;
import com.sz.erago.model.common.TreeNode;

public interface ISystemService {
	public SystemMenu getMenuByID(Integer id);
	
	public List<SystemMenu> buildMenus();
	
	public List<TreeNode> loadMenu();
}
