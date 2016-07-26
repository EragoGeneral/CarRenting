package com.sz.erago.model.common;

public class ResourceTree {
	private int id;
	private String name;
	private String description;
	private String url;
	private int displayOrder;
	private int parentID;
	private int type;
	private String isDeleted;
	
	public ResourceTree(int id, String name, String description, String url, int displayOrder,
			int parentID, int type, String isDeleted) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.url = url;
		this.displayOrder = displayOrder;
		this.parentID = parentID;
		this.type = type;
		this.isDeleted = isDeleted;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription(){
		return description;
	}
	
	public void setDescription(String description){
		this.description = description;
	}
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getParentID() {
		return parentID;
	}

	public void setParentID(int parentID) {
		this.parentID = parentID;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}

	public int getDisplayOrder() {
		return displayOrder;
	}

	public void setDisplayOrder(int displayOrder) {
		this.displayOrder = displayOrder;
	}
}
