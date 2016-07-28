package com.sz.erago.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sz.erago.controller.common.UtilTools;
import com.sz.erago.dao.SystemResourceDao;
import com.sz.erago.model.SystemMenu;
import com.sz.erago.model.common.ResourceTree;
import com.sz.erago.model.common.SessionInfo;
import com.sz.erago.model.common.Tree;
import com.sz.erago.model.system.SystemResource;
import com.sz.erago.service.IResourceService;

@Service("resourceService")
public class ResourceServiceImpl implements IResourceService {
	
	@Autowired
	private SystemResourceDao resourceDao;
	
	public List<ResourceTree> treeGrid(SessionInfo sessionInfo){
		List<ResourceTree> treeList = new ArrayList<ResourceTree>();
		List<SystemResource> resources = new ArrayList<SystemResource>();
		Map<String, Object> param = new HashMap<String, Object>();
		if ("admin".equalsIgnoreCase(sessionInfo.getLoginname())){
			resources = resourceDao.queryAllResources(param);
		}else{
			param.put("id", sessionInfo.getId());
			resources = resourceDao.queryAccessResourceForUser(param);
		}
		
		if(resources != null && resources.size() > 0){
			for(SystemResource resource : resources){
				ResourceTree node = new ResourceTree(resource.getId(), resource.getName(), 
						resource.getDescription(), resource.getUrl(), resource.getDisplayOrder(), 
						resource.getParentID(), resource.getType(), resource.getIsDeleted());
				treeList.add(node);
			}
		}
		
		return treeList;
	}

	@Override
	public List<Tree> queryResourceByCondition(boolean flag) {
		List<SystemResource> rsList = new ArrayList<SystemResource>();
		List<Tree> lt = new ArrayList<Tree>();
		
		Map<String, Object> param = new HashMap<String, Object>(); 
		if(flag){
			param.put("type", 1);
		}
		rsList = resourceDao.queryAllResources(param);
		
		if(rsList != null && rsList.size() > 0){
			for (SystemResource r : rsList) {
				Tree tree = new Tree();
				tree.setId(r.getId().toString());
				tree.setText(r.getName());
				tree.setState("open");
				tree.setPid(r.getParentID().toString());
				/*if (r.getResource() != null) {
					tree.setPid(r.getResource().getId().toString());
				} else {
					tree.setState("closed");
				}*/
				
				//tree.setIconCls(r.getIcon());
				Map<String, Object> attr = new HashMap<String, Object>();
				attr.put("url", r.getUrl());
				tree.setAttributes(attr);
				lt.add(tree);
			}
		}
		
		return lt;
	}
	
	@Override
	public SystemResource getResourceInfo(Integer id){
		
		return resourceDao.getResourceInfoByID(id);
	}
	
	@Override
	public int addResource(SystemResource resource, SessionInfo session) {
		SystemResource parentResource = resourceDao.getResourceInfoByID(resource.getParentID());
		if(parentResource != null && parentResource.getLevel() != null){
			resource.setLevel(parentResource.getLevel()+1);
		}
		int currentUserID = session.getId();
		resource.setCreateBy(currentUserID);
		resource.setCreateDate(UtilTools.getCurrentTime());
		resource.setUpdateBy(currentUserID);
		resource.setUpdateDate(UtilTools.getCurrentTime());
		resource.setIsDeleted("0");
		return resourceDao.addResource(resource);
	}
	
	public int updateResource(SystemResource resource, SessionInfo sessionInfo){
		SystemResource parentResource = resourceDao.getResourceInfoByID(resource.getParentID());
		if(parentResource != null && parentResource.getLevel() != null){
			resource.setLevel(parentResource.getLevel()+1);
		}
		Integer currentUserID = sessionInfo.getId();
		resource.setUpdateBy(currentUserID);
		resource.setUpdateDate(UtilTools.getCurrentTime());
		
		return resourceDao.updateResource(resource);
	}
	
	public int deleteResource(Integer id){
		return resourceDao.deleteResource(id);
	}

	@Override
	public List<Tree> queryResourceByOwner(SessionInfo sessionInfo, boolean flag) {
		List<Tree> lt = new ArrayList<Tree>();
		List<SystemResource> resources = new ArrayList<SystemResource>();
		Map<String, Object> param = new HashMap<String, Object>();
		if("admin".equalsIgnoreCase(sessionInfo.getLoginname())){
			param.put("type", 1);
			resources = resourceDao.queryAllResources(param);
		}else{
			param.put("type", 1);
			param.put("id", sessionInfo.getId());
			resources = resourceDao.queryAccessResourceForUser(param);
		}
		
		if(resources != null && resources.size() > 0){
			for (SystemResource r : resources) {
				Tree tree = new Tree();
				tree.setId(r.getId().toString());
				tree.setText(r.getName());
				tree.setState("open");
				tree.setPid(r.getParentID().toString());
				Map<String, Object> attr = new HashMap<String, Object>();
				attr.put("url", r.getUrl());
				tree.setAttributes(attr);
				lt.add(tree);
			}
		}
		
		return lt;
	}

	@Override
	public List<SystemResource> createMainMenu(SessionInfo sessionInfo) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", sessionInfo.getId());
		param.put("type", "1");
		List<SystemResource> menus = resourceDao.queryAccessResourceForUser(param);
		
		List<SystemResource> firstLevel = new ArrayList<SystemResource>();
		Map<Integer, SystemResource> levelMap = new HashMap<Integer, SystemResource>();
		for(SystemResource menu : menus){
			if(menu.getLevel() == 1){
				firstLevel.add(menu);
				levelMap.put(menu.getId(), menu);
			}else{
				SystemResource firstLevelMenu = levelMap.get(menu.getParentID());
				if(firstLevelMenu !=null){
					List<SystemResource> secondLevel = firstLevelMenu.getChildren();
					if(secondLevel == null) {
						secondLevel = new ArrayList<SystemResource>();
					}
					secondLevel.add(menu);
					firstLevelMenu.setChildren(secondLevel);
				}
			}
		}
		
		return firstLevel;
	}
}
