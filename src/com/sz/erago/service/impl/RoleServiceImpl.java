package com.sz.erago.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sz.erago.controller.common.UtilTools;
import com.sz.erago.dao.SystemResourceDao;
import com.sz.erago.dao.SystemRoleDao;
import com.sz.erago.model.system.SystemResource;
import com.sz.erago.model.system.SystemRole;
import com.sz.erago.model.system.SystemRoleResource;
import com.sz.erago.service.IRoleService;

@Service("roleService")
public class RoleServiceImpl implements IRoleService {

	@Autowired
	private SystemRoleDao roleDao;
	
	@Autowired
	private SystemResourceDao resourceDao;
	
	@Override
	public Map<String, Object> queryRoles(SystemRole role, Integer page,
			Integer rows) {
		Integer startIndex = (page-1)*rows;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("role", role);
		paramMap.put("startIndex", startIndex);
		paramMap.put("rows", rows);
		
		Long cnt = roleDao.getRoleCount(role);
		List<SystemRole> users = roleDao.queryRoleList(paramMap);
		Map<String, Object> dgMap = new HashMap<String, Object>();
		dgMap.put("rows", users);
		dgMap.put("total", cnt);
		
		return dgMap;
	}

	@Override
	public int addRole(SystemRole role) {
		role.setCreateBy(1);
		role.setCreateDate(UtilTools.getCurrentTime());
		role.setUpdateBy(1);
		role.setUpdateDate(UtilTools.getCurrentTime());
		role.setIsDeleted("0");			
		return roleDao.addRole(role);
	}
	
	@Override
	public int updateRole(SystemRole role) {	
		role.setUpdateBy(1);
		role.setUpdateDate(UtilTools.getCurrentTime());
		return roleDao.updateRole(role);
	}

	@Override
	public int deleteRole(Long id) {
		return roleDao.deleteRole(id);
	}

	@Override
	public SystemRole getRoleInfo(Long id) {
		SystemRole role = roleDao.getRoleInfoByID(id);
		List<SystemResource> resList = resourceDao.getResourceByRole(id);
		StringBuffer buf = new StringBuffer();
		if(resList != null && resList.size() > 0){
			for(SystemResource res : resList){
				buf.append(",").append(res.getId().toString());
			}
		}
		if (buf.length() > 0){
			buf.deleteCharAt(0);
		}
		role.setResourceIds(buf.toString());
		
		return role;
	}

	@Override
	public void grantRole(SystemRole role) {
		String[] resArray = role.getResourceIds().split(",");
		List<SystemRoleResource> relList = new ArrayList<SystemRoleResource>();
		for(String s : resArray){
			SystemRoleResource srr = new SystemRoleResource();
			srr.setRoleID(role.getId());
			srr.setResID(Integer.parseInt(s));
			srr.setIsDeleted("0");
			relList.add(srr);
		}
	}

}
