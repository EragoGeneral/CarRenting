package com.sz.erago.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.sz.erago.model.webserver.ArticleInfo;
import com.sz.erago.service.IGSDataService;

@Service("gdDataService")
public class GSDataServiceImpl implements IGSDataService {

	@Override
	public void handleData(String response) {
		
		response = response.substring(response.indexOf("<ul class=\"article-ul\">"));
		response = response.substring(0, response.indexOf("</ul>") + 5);
		response = response.substring(response.indexOf("<li>"), response.indexOf("</ul>"));
		String[] msgItems = response.split("<li>");
		//System.out.println(msgItems.length);
		List<ArticleInfo> articleList = new ArrayList<ArticleInfo>();
		for (int idx = 1; idx < msgItems.length; idx++) {
			// get the address
			String str = msgItems[idx];
			
			String articleUrl = "";
			String title = "";
			String subTitle = "";
			String author = "";
			String publishTime = "";
			String browserNum = "";
			String praiseNum = "";
			
			String pattern = "<a[^>]*href=\"([^\"]*)\"[^>]*>([\\S\\s]*?|[\\u4E00-\\u9FFF]*?)<\\/a>";
			Pattern r = Pattern.compile(pattern);
			Matcher m = r.matcher(str);
			//System.out.println(m.matches());
			boolean result = m.find();
			// 使用循环找出模式匹配的内容替换之,再将内容加到sb里
			if (result) {
				articleUrl = m.group(1);
				result = m.find();
			}

			// get the title  &&  get the subtitle
			String pattern1 = "<a[^>]*href=\"([^\"]*)\"[^>]*>(.*?)<\\/a>";
			Pattern r1 = Pattern.compile(pattern1);
			Matcher m1 = r1.matcher(str);
			int counter = 0;
			result = m1.find();
			while(result){
				if(counter==1){
					title = m1.group(2);
				}
				if(counter==2){
					subTitle = m1.group(2);
				}
				result = m1.find();
				counter++;
			}
//			System.out.println("title: " + title);
//			System.out.println("subTitle: " + subTitle);
			
			String pattern2 = "<span[^>]*>(.*?)<\\/span>";

			Pattern r2 = Pattern.compile(pattern2);
			Matcher m2 = r2.matcher(str);
			
			result = m2.find();
			counter = 0;
			while(result){
				if(counter == 0){
					author = m2.group(1);
				}
				if(counter == 1){
					publishTime = m2.group(1);
					break;
				}
				counter++;
				result = m2.find();
			}
//			System.out.println("author: " + author);
//			System.out.println("publishTime: " + publishTime.substring(5));
			
			// get the publish time, author, browser and praise number.
			
			String pattern3 = "<font>([\\s\\S]+)</font>";
			Pattern r3 = Pattern.compile(pattern3);
			Matcher m3 = r3.matcher(str);
			
			result = m3.find();
			String numInfo = m3.group(1);
			String[] infos = numInfo.split("<i");
			for(String info : infos){
				info = StringUtils.trim(info);
				if(StringUtils.isNotEmpty(info)){
					if(info.indexOf("fa-book") != -1){
						browserNum = info.substring(info.indexOf("</i>")+4);
						continue;
					}
					if(info.indexOf("fa-thumbs-o-up") != -1){
						praiseNum = info.substring(info.indexOf("</i>")+4);
						continue;
					}
				}
			}
//			System.out.println("browserNum: " + browserNum);
//			System.out.println("praiseNum: " + praiseNum);
			
			ArticleInfo article = new ArticleInfo(author, title, subTitle, publishTime, 
					browserNum, praiseNum, articleUrl);
			articleList.add(article);
		}
		
		for(ArticleInfo a : articleList){
			System.out.println("Title: " + a.getTitle());
			System.out.println("SubTitle: " + a.getSubTitle());
			System.out.println("Author: " + a.getAuthor());
			System.out.println("BrowserNum: " + a.getBrowserNum());
			System.out.println("PraiseNum: " + a.getPraiseNum());
			System.out.println("Url: " + a.getArticleUrl());
			System.out.println("Pub Time: " + a.getPublishTime());
			
			System.out.println("======================================");
		}
	}
	
}
