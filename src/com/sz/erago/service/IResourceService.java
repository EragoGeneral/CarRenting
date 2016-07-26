package com.sz.erago.service;

import java.util.List;

import com.sz.erago.model.common.ResourceTree;
import com.sz.erago.model.common.SessionInfo;
import com.sz.erago.model.common.Tree;
import com.sz.erago.model.system.SystemResource;

public interface IResourceService {
	public List<ResourceTree> treeGrid();
	
	public List<Tree> queryResourceByCondition(boolean flag);
	
	public SystemResource getResourceInfo(Integer id);
	
	public int addResource(SystemResource resource, SessionInfo session);
	
	public int updateResource(SystemResource resource, SessionInfo sessionInfo);
	
	public int deleteResource(Integer id);
	
	public List<Tree> queryResourceByOwner(SessionInfo sessionInfo, boolean flag);
}
