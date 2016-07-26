package com.sz.erago.dao;

import java.util.List;
import java.util.Map;

import com.sz.erago.model.system.SystemRole;

public interface SystemRoleDao {
	public Long getRoleCount(SystemRole role);
	
	public List<SystemRole> queryRoleList(Map<String, Object> paramMap);
	
	public SystemRole getRoleInfoByID(Long id);
	
	public int addRole(SystemRole role);
	
	public int updateRole(SystemRole role);
	
	public int deleteRole(Long id);
	
	public SystemRole queryResourceByRole(Long id);
}
