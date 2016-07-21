package com.sz.erago.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sz.erago.controller.common.UtilTools;
import com.sz.erago.dao.SystemUserDao;
import com.sz.erago.model.SystemUsers;
import com.sz.erago.service.IUserService;

@Service("userService")
public class UserServiceImpl implements IUserService {

	@Resource
	private SystemUserDao userDao;
	
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
			user.setIsDeleted(false);			
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
}
