package com.sz.erago.model.system;

import java.sql.Timestamp;

public class SystemRoleResource {
	
	private Integer id;
	
	private Integer roleID;
	
	private Integer resID;
	
	private Integer createBy;
	
	private Timestamp createDate;
	
	private Integer updateBy;
	
	private Timestamp updateDate;
	
	private String isDeleted;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getRoleID() {
		return roleID;
	}
	public void setRoleID(Integer roleID) {
		this.roleID = roleID;
	}
	public Integer getResID() {
		return resID;
	}
	public void setResID(Integer resID) {
		this.resID = resID;
	}
	public Integer getCreateBy() {
		return createBy;
	}
	public void setCreateBy(Integer createBy) {
		this.createBy = createBy;
	}
	public Timestamp getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}
	public Integer getUpdateBy() {
		return updateBy;
	}
	public void setUpdateBy(Integer updateBy) {
		this.updateBy = updateBy;
	}
	public Timestamp getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}
}
