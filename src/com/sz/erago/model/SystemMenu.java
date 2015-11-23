package com.sz.erago.model;

import java.sql.Timestamp;
import java.util.List;

import com.sz.erago.model.common.TreeNode;

public class SystemMenu {
    private Integer id;

    private String name;

    private String link;

    private Integer displayOrder;

    private Integer parentId;

    private Integer level;

    private String path;

    private Boolean isDeleted;

    private Integer createBy;

    private Timestamp createDate;

    private Integer updateBy;

    private Timestamp updateDate;
    
	private List<SystemMenu> children;

	public SystemMenu(){
		super();
	}
	
    public SystemMenu(Integer id, String name, String link,
			Integer displayOrder, Integer parentId, Integer level, String path,
			Boolean isDeleted, Integer createBy, Timestamp createDate,
			Integer updateBy, Timestamp updateDate) {
		super();
		this.id = id;
		this.name = name;
		this.link = link;
		this.displayOrder = displayOrder;
		this.parentId = parentId;
		this.level = level;
		this.path = path;
		this.isDeleted = isDeleted;
		this.createBy = createBy;
		this.createDate = createDate;
		this.updateBy = updateBy;
		this.updateDate = updateDate;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link == null ? null : link.trim();
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path == null ? null : path.trim();
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
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

	public List<SystemMenu> getChildren() {
		return children;
	}

	public void setChildren(List<SystemMenu> children) {
		this.children = children;
	}
    
	public TreeNode buildTreeNode(){
		TreeNode tn = new TreeNode(this.getId(), this.getName(), false, "open");
		
		return tn;
	}
    
}