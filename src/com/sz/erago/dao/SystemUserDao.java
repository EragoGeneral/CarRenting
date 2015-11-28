package com.sz.erago.dao;

import java.util.List;
import java.util.Map;

import com.sz.erago.model.SystemUsers;

public interface SystemUserDao {
	
	public Integer getUserCount(SystemUsers user);
	
	public List<SystemUsers> queryAllUsers(SystemUsers user);
	
	public List<SystemUsers> queryAllUsers1(Map<String, Object> paramMap);
	
	public SystemUsers getUserInfoByID(Integer id);
	
	public int insertSelective(SystemUsers user);
	
	public int updateByPrimaryKeySelective(SystemUsers record);
	
	public List<SystemUsers> getUserInfoBySelectedID(String[] selectedIDs);
	
	public int disableUserBySelectedID(String[] selectedIDs);
}
