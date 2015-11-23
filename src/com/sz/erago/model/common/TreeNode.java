package com.sz.erago.model.common;

import java.util.List;
import java.util.Map;

public class TreeNode {
	private int id;
	private String text;
	private String iconCls;
	private boolean checked;
	private String state;
	private List<TreeNode> children;
	private Map<String, String> attributes;
	
	public TreeNode(int id, String text, boolean checked, String state) {
		super();
		this.id = id;
		this.text = text;
		this.checked = checked;
		this.state = state;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getIconCls() {
		return iconCls;
	}
	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public List<TreeNode> getChildren() {
		return children;
	}
	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}
	public Map<String, String> getAttributes() {
		return attributes;
	}
	public void setAttributes(Map<String, String> attributes) {
		this.attributes = attributes;
	}
}
