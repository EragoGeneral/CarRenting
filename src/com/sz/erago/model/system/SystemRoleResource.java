package com.sz.erago.model.system;

public class SystemRoleResource {
	private Integer id;
	private Integer RoleID;
	private Integer ResID;
	private String isDeleted;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getRoleID() {
		return RoleID;
	}
	public void setRoleID(Integer roleID) {
		RoleID = roleID;
	}
	public Integer getResID() {
		return ResID;
	}
	public void setResID(Integer resID) {
		ResID = resID;
	}
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}
}
