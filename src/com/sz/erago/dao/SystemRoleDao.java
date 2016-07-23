package com.sz.erago.dao;

import java.util.List;
import java.util.Map;

import com.sz.erago.model.SystemRole;

public interface SystemRoleDao {
	public Long getRoleCount(SystemRole role);
	
	public List<SystemRole> queryRoleList(Map<String, Object> paramMap);
}
