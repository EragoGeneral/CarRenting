package com.sz.erago.service;

import java.util.List;
import java.util.Map;

import com.sz.erago.model.SystemUsers;
import com.sz.erago.model.common.SessionInfo;
import com.sz.erago.model.system.SystemRole;

public interface IUserService {
	
	public Map<String, Object> queryAllUsers(SystemUsers user, Integer page, Integer rows);
	
	public SystemUsers getUserInfoByID(Integer id);

	public int saveUser(SystemUsers user);
	
	public List<SystemUsers> getUserInfoBySelectedID(String selectedIDs);
	
	public int disableUserBySelectedID(String selectedIDs);
	
	public SystemUsers getLoginUserInfo(String name, String pwd);
	
	public Map<String, List<SystemRole>> loadRoleListByUser(Integer id, SessionInfo sessionInfo);
	
	public void grantRole(Integer userID, String selectedRole, SessionInfo sessionInfo);
}
