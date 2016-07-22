package com.sz.erago.dao;

import java.util.Map;

import com.sz.erago.model.SystemUsers;

public interface LoginDao {
	public SystemUsers getLoginUser(Map<String, String> loginParam);
}
