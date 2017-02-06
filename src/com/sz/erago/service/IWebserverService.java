package com.sz.erago.service;

import java.util.List;

import com.sz.erago.model.webserver.GamesStatisticsInfo;

public interface IWebserverService {
	
	public List<GamesStatisticsInfo> queryGameInfo(GamesStatisticsInfo game);
	
	public int addGame(GamesStatisticsInfo game);
	
	public int updateGame(GamesStatisticsInfo game);
}
