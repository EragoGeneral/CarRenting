package com.sz.erago.dao;

import java.util.List;

import com.sz.erago.model.SystemMenu;

public interface SystemMenuDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SystemMenu record);

    SystemMenu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SystemMenu record);

    public List<SystemMenu> queryAllMenus();
    
    public SystemMenu getMenuInfoByID(Integer menuID);
    
    public int insertSelective(SystemMenu menu);
    
    public int updateByPrimaryKey(SystemMenu record);
    
    public int disabledMenuByID(Integer menuID);
}