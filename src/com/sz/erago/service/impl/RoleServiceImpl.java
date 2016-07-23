package com.sz.erago.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sz.erago.dao.SystemRoleDao;
import com.sz.erago.model.SystemRole;
import com.sz.erago.service.IRoleService;

@Service("roleService")
public class RoleServiceImpl implements IRoleService {

	@Autowired
	private SystemRoleDao roleDao;
	
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
	public void saveRole(SystemRole role) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteRole(Long id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public SystemRole getRoleInfo(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void grantRole(SystemRole role) {
		// TODO Auto-generated method stub
		
	}

}
