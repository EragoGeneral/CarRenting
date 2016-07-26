package com.sz.erago.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sz.erago.controller.common.UtilTools;
import com.sz.erago.dao.SystemResourceDao;
import com.sz.erago.model.common.ResourceTree;
import com.sz.erago.model.common.SessionInfo;
import com.sz.erago.model.common.Tree;
import com.sz.erago.model.system.SystemResource;
import com.sz.erago.service.IResourceService;

@Service("resourceService")
public class ResourceServiceImpl implements IResourceService {
	
	@Autowired
	private SystemResourceDao resourceDao;
	
	public List<ResourceTree> treeGrid(){
		List<ResourceTree> treeList = new ArrayList<ResourceTree>();
		Map<String, Object> param = new HashMap<String, Object>();
		List<SystemResource> resources = resourceDao.queryAllResources(param);
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
		int currentUserID = session.getId();
		resource.setCreateBy(currentUserID);
		resource.setCreateDate(UtilTools.getCurrentTime());
		resource.setUpdateBy(currentUserID);
		resource.setUpdateDate(UtilTools.getCurrentTime());
		resource.setIsDeleted("0");
		return resourceDao.addResource(resource);
	}
	
	public int updateResource(SystemResource resource, SessionInfo sessionInfo){
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
		
		return null;
	}
}
