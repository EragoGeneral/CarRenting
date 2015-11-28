package com.sz.erago.controller.common;

import java.sql.Timestamp;

public class UtilTools {
	
	public static Timestamp getCurrentTime(){
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		
		return ts;
	}
}
