package com.sz.erago.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sz.erago.dao.WebserverDao;
import com.sz.erago.model.webserver.GamesStatisticsInfo;
import com.sz.erago.service.IWebserverService;

@Service("webserverService")
public class WebserverServiceImpl implements IWebserverService {

	@Autowired
	private WebserverDao webserverDao;
	
	@Override
	public List<GamesStatisticsInfo> queryGameInfo(GamesStatisticsInfo game) {
		return webserverDao.queryGameInfo(game);
	}

	@Override
	public int addGame(GamesStatisticsInfo game) {
		return webserverDao.addGame(game);
	}

	@Override
	public int updateGame(GamesStatisticsInfo game) {
		return webserverDao.updateGame(game);
	}

}
