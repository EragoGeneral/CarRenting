package com.sz.erago.model.webserver;

public class ArticleInfo {
	private String author;
	private String title;
	private String subTitle;
	private String publishTime;
	private String browserNum;
	private String praiseNum;
	private String articleUrl;
	
	public ArticleInfo(String author, String title, String subTitle,
			String publishTime, String browserNum, String praiseNum,
			String articleUrl) {
		this.author = author;
		this.title = title;
		this.subTitle = subTitle;
		this.publishTime = publishTime;
		this.browserNum = browserNum;
		this.praiseNum = praiseNum;
		this.articleUrl = articleUrl;
	}
	
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public String getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}
	public String getBrowserNum() {
		return browserNum;
	}
	public void setBrowserNum(String browserNum) {
		this.browserNum = browserNum;
	}
	public String getPraiseNum() {
		return praiseNum;
	}
	public void setPraiseNum(String praiseNum) {
		this.praiseNum = praiseNum;
	}
	public String getArticleUrl() {
		return articleUrl;
	}
	public void setArticleUrl(String articleUrl) {
		this.articleUrl = articleUrl;
	}
}
