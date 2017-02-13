package com.sz.erago.controller.webserver;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sz.erago.framework.constant.GlobalConstant;
import com.sz.erago.framework.utils.HttpRequestUtils;
import com.sz.erago.model.common.Json;
import com.sz.erago.model.webserver.GamesStatisticsInfo;
import com.sz.erago.service.IGSDataService;
import com.sz.erago.service.IWebserverService;

@Controller
@RequestMapping("/webserver")
public class WebserverController {
	
	@Autowired
	private IGSDataService gdDataService;
	
	@Autowired 
	private IWebserverService webserverService;
	
	@RequestMapping("/manage")
	public String manage(){
		
		return "/webserver/query_data";
	}
	
	@RequestMapping("/querydata")
	@ResponseBody
	public Json queryData(HttpServletRequest request) {
		String author = request.getParameter("author");
		String page = request.getParameter("page");
		String cookie = request.getParameter("cookie");
		
		String param = "q=" + author + "&search_field=4&post_time=0&sort=-1&read_num=0&page=" + page;
		String response = HttpRequestUtils.sendGet(GlobalConstant.GSDATA_URL, param, cookie);
		gdDataService.handleData(response);
		
		Json j = new Json();
		
		return j;
	} 
	
	@RequestMapping("/statisticsGames")
	@ResponseBody
	public Json statiscsGameCount(HttpServletRequest request){
		String name = request.getParameter("game");
		String reqPath = request.getQueryString();
		
		GamesStatisticsInfo game = new GamesStatisticsInfo(reqPath, name, 1);
		List<GamesStatisticsInfo> list = webserverService.queryGameInfo(game);
		if(list != null && !list.isEmpty()){
			webserverService.updateGame(game);
		}else{
			webserverService.addGame(game);
		}
		
		Json j = new Json();
		Map<String, String> ret = new HashMap<String, String>();
		ret.put("name", name);
		ret.put("count", String.valueOf(game.getCount()));
		j.setObj(ret);
		
		return j;
	}
}
