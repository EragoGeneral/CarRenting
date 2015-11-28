package com.sz.erago.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sz.erago.dao.SystemMenuDao;
import com.sz.erago.model.SystemMenu;
import com.sz.erago.model.common.TreeNode;

@Service("systemService")
public class SystemServiceImpl implements ISystemService {

	@Resource
	private SystemMenuDao menuDao;
	
	@Override
	public SystemMenu getMenuByID(Integer id) {
		return this.menuDao.getMenuInfoByID(id);
	}
	
	public List<SystemMenu> buildMenus(){
		List<SystemMenu> menus = this.menuDao.queryAllMenus();
		
//		SystemMenu root = new SystemMenu(-1, "ÏµÍ³²Ëµ¥", "/", 0, -99, 0, "0", false, 1, new Timestamp(System.currentTimeMillis()), 1, new Timestamp(System.currentTimeMillis()));
		List<SystemMenu> firstLevel = new ArrayList<SystemMenu>();
		Map<Integer, SystemMenu> levelMap = new HashMap<Integer, SystemMenu>();
		for(SystemMenu menu : menus){
			if(menu.getLevel() == 1){
				firstLevel.add(menu);
				levelMap.put(menu.getId(), menu);
			}else{
				SystemMenu firstLevelMenu = levelMap.get(menu.getParentId());
				if(firstLevelMenu !=null){
					List<SystemMenu> secondLevel = firstLevelMenu.getChildren();
					if(secondLevel == null) {
						secondLevel = new ArrayList<SystemMenu>();
					}
					secondLevel.add(menu);
					firstLevelMenu.setChildren(secondLevel);
				}
			}
		}
//		root.setChildren(firstLevel);
		
		return firstLevel;
	
	}

	public List<TreeNode> loadMenu(){
		List<TreeNode> nodes = new ArrayList<TreeNode>();
		List<SystemMenu> menus = this.buildMenus();
		for(SystemMenu menu : menus){
			System.out.println(menu.getName());
			System.out.println(menu.getLevel());
			TreeNode node = menu.buildTreeNode();
			nodes.add(node);
			Map<String, String> attrs = new HashMap<String, String>();
			attrs.put("parentID", menu.getParentId().toString());
			attrs.put("level", menu.getLevel().toString());
			node.setAttributes(attrs);
			if(menu.getChildren() != null && menu.getChildren().size()>0){
				List<TreeNode> subNodes = new ArrayList<TreeNode>();
				for(SystemMenu m2 : menu.getChildren()){
					TreeNode n2 = m2.buildTreeNode();
					Map<String, String> subAttrs = new HashMap<String, String>();
					subAttrs.put("url", m2.getLink());
					subAttrs.put("parentID", m2.getParentId().toString());
					subAttrs.put("level", m2.getLevel().toString());
					n2.setAttributes(subAttrs);
					subNodes.add(n2);
				}
				node.setChildren(subNodes);
			}
		}
		
		return nodes;
	}
	
	public int saveMenu(SystemMenu menu){
		Integer menuID = menu.getId();
		if(menuID == null){
			SystemMenu parentMenu = menuDao.getMenuInfoByID(menu.getParentId());
			String path = parentMenu.getPath();
			
			menu.setCreateBy(1);
			menu.setUpdateBy(1);
			menu.setCreateDate(new Timestamp(System.currentTimeMillis()));
			menu.setUpdateDate(new Timestamp(System.currentTimeMillis()));
			menu.setIsDeleted(false);
			menuDao.insertSelective(menu);
			path = path + "." + menu.getId();
			menu.setPath(path);
			menuID = menuDao.updateByPrimaryKey(menu);
		}else{
			menuDao.updateByPrimaryKeySelective(menu);
		}
		
		return menuID.intValue();
	}
	
	public int disabledMenuByID(int menuID){
		int flag = menuDao.disabledMenuByID(menuID);
		
		return flag;
	}
}
