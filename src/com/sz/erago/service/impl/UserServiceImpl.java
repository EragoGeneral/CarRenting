package com.sz.erago.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sz.erago.controller.common.UtilTools;
import com.sz.erago.dao.LoginDao;
import com.sz.erago.dao.SystemRoleDao;
import com.sz.erago.dao.SystemUserDao;
import com.sz.erago.model.SystemUsers;
import com.sz.erago.model.common.SessionInfo;
import com.sz.erago.model.system.SystemRole;
import com.sz.erago.model.system.SystemUserRole;
import com.sz.erago.service.IUserService;

@Service("userService")
public class UserServiceImpl implements IUserService {

	@Resource
	private SystemUserDao userDao;
	
	@Autowired
	private LoginDao loginDao;
	
	@Autowired
	private SystemRoleDao roleDao;
	
	@Override
	public Map<String, Object> queryAllUsers(SystemUsers user, Integer page, Integer rows) {
		Integer startIndex = (page-1)*rows;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", user);
		paramMap.put("startIndex", startIndex);
		paramMap.put("rows", rows);
		
		//return userDao.queryAllUsers(user);
		Integer cnt = userDao.getUserCount(user);
		List<SystemUsers> users = userDao.queryAllUsers1(paramMap);
		Map<String, Object> dgMap = new HashMap<String, Object>();
		dgMap.put("rows", users);
		dgMap.put("total", cnt);
		
		return dgMap;
	}

	@Override
	public SystemUsers getUserInfoByID(Integer id) {
		
		return userDao.getUserInfoByID(id);
	}

	public int saveUser(SystemUsers user){
		int flag = 0;
		if(user.getId() == null){
			user.setCreateBy(1);
			user.setCreateDate(UtilTools.getCurrentTime());
			user.setUpdateBy(1);
			user.setUpdateDate(UtilTools.getCurrentTime());
			user.setIsDeleted("0");			
			flag = userDao.insertSelective(user);
		}else{
			user.setUpdateBy(1);
			user.setUpdateDate(UtilTools.getCurrentTime());			
			flag = userDao.updateByPrimaryKeySelective(user);
		}
		
		return flag;
	}

	@Override
	public List<SystemUsers> getUserInfoBySelectedID(String selectedIDs) {
		String[] ids = selectedIDs.split(",");
		
		return userDao.getUserInfoBySelectedID(ids);
	}

	@Override
	public int disableUserBySelectedID(String selectedIDs) {
		String[] ids = selectedIDs.split(",");
		
		return userDao.disableUserBySelectedID(ids);
	}

	@Override
	public SystemUsers getLoginUserInfo(String name, String pwd) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("name", name);
		param.put("pwd", pwd);
		
		return loginDao.getLoginUser(param);
	}
	
	@Override
	public Map<String, List<SystemRole>> loadRoleListByUser(Integer id, SessionInfo sessionInfo){
		Map<String, List<SystemRole>> res = new HashMap<String, List<SystemRole>>();
		List<SystemRole> ownedRoles = new ArrayList<SystemRole>();
		List<SystemRole> toSelectedRoles = new ArrayList<SystemRole>();
		
		ownedRoles = roleDao.queryRoleByUserID(id);
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("id", id);
		param.put("curUserID", sessionInfo.getId());
		toSelectedRoles = roleDao.queryRoleAvailableForUser(param);
		
		res.put("OwnedRoles", ownedRoles);
		res.put("ToSelRoles", toSelectedRoles);
		
		return res;
	}
	
	@Override
	public void grantRole(Integer userID, String selectedRole, SessionInfo sessionInfo){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", userID);
		param.put("updateBy", sessionInfo.getId());
		param.put("updateDate", UtilTools.getCurrentTime());
		userDao.revokeRoleFromUser(param);
		
		List<SystemUserRole> surList = new ArrayList<SystemUserRole>();
		String[] rIdArray = selectedRole.split(",");
		for(String roleId : rIdArray){
			SystemUserRole userRole = new SystemUserRole();
			userRole.setUserID(userID);
			userRole.setRoleID(Integer.parseInt(roleId));
			userRole.setCreateBy(sessionInfo.getId());
			userRole.setCreateDate(UtilTools.getCurrentTime());
			userRole.setUpdateBy(sessionInfo.getId());
			userRole.setUpdateDate(UtilTools.getCurrentTime());
			userRole.setIsDeleted("0");
			surList.add(userRole);
		}
		
		if(surList.size() > 0){
			userDao.grantRoleToUser(surList);
		}
	}
	
}
