package com.sz.erago.model.webserver;

public class GamesStatisticsInfo {
	private Integer id;
	private String name;
	private Integer count;
	
	
	public GamesStatisticsInfo(Integer id, String name, Integer count) {
		super();
		this.id = id;
		this.name = name;
		this.count = count;
	}

	public GamesStatisticsInfo(String name, Integer count) {
		super();
		this.name = name;
		this.count = count;
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
		this.name = name;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
}
