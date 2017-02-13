package com.sz.erago.model.webserver;

import java.sql.Timestamp;

public class GamesStatisticsInfo {
	private Integer id;
	private String reqPath;
	private String name;
	private Integer count;
	private Timestamp createdTime;
	private Timestamp updatedTime;
	
	public GamesStatisticsInfo(Integer id, String reqPath, String name, Integer count, Timestamp createdTime, Timestamp updatedTime) {
		super();
		this.id = id;
		this.reqPath = reqPath;
		this.name = name;
		this.count = count;
		this.createdTime = createdTime;
		this.updatedTime = updatedTime;
	}

	public GamesStatisticsInfo(String reqPath, String name, Integer count) {
		super();
		this.reqPath = reqPath;
		this.name = name;
		this.count = count;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getReqPath() {
		return reqPath;
	}
	public void setReqPath(String reqPath) {
		this.reqPath = reqPath;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}

	public Timestamp getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Timestamp createdTime) {
		this.createdTime = createdTime;
	}

	public Timestamp getUpdatedTime() {
		return updatedTime;
	}

	public void setUpdatedTime(Timestamp updatedTime) {
		this.updatedTime = updatedTime;
	}
}
