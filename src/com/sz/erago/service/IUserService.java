package com.sz.erago.service;

import java.util.List;
import java.util.Map;

import com.sz.erago.model.SystemUsers;

public interface IUserService {
	
	public Map<String, Object> queryAllUsers(SystemUsers user, Integer page, Integer rows);
	
	public SystemUsers getUserInfoByID(Integer id);

	public int saveUser(SystemUsers user);
	
	public List<SystemUsers> getUserInfoBySelectedID(String selectedIDs);
	
	public int disableUserBySelectedID(String selectedIDs);
	
	public SystemUsers getLoginUserInfo(String name, String pwd);
}
