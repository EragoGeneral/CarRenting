package com.sz.erago.dao;

import java.util.List;
import java.util.Map;

import com.sz.erago.model.system.SystemResource;

public interface SystemResourceDao {
	public List<SystemResource> queryAllResources(Map<String, Object> param);
	
	public int addResource(SystemResource resource);
	
	public SystemResource getResourceInfoByID(Integer id);
	
	public int updateResource(SystemResource resource);
	
	public int deleteResource(Integer id);
	
	public List<SystemResource> getResourceByRole(Long id);
	
	public List<SystemResource> queryAccessResourceForUser(Map<String, Object> param);
}
