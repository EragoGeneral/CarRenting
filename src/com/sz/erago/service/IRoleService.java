package com.sz.erago.service;

import java.util.Map;

import com.sz.erago.model.system.SystemRole;

public interface IRoleService {
	/**
	 * 查询角色列表
	 * @param role	查询条件角色实体
	 * @param page	当前页
	 * @param rows	每页行数
	 * @return
	 */
	public Map<String, Object> queryRoles(SystemRole role, Integer page, Integer rows);

	public SystemRole getRoleInfo(Long id);
	
	public int addRole(SystemRole role);
	
	public int updateRole(SystemRole role);
	
	public int deleteRole(Long id);
	
	public void grantRole(SystemRole role);
}
