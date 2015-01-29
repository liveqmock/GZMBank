package com.gdbocom.util;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import com.viatt.util.GzLog;

public class DebugUtils {
	/**打印Request中的全部Cookie
	 * @param request
	 */
	public static void printCookies(HttpServletRequest request) {
		GzLog log=new GzLog();
		
		if(!Constants.Log.ENABLE_LOG){
			return;
		}
		
		StringBuffer sb = new StringBuffer();
		Cookie[] cs = request.getCookies();
		if (cs == null) {
			log.Write("cookieInfo:null");
			return;
		}
		for (int i = 0; i < cs.length; i++) {
			Cookie obj = cs[i];
			sb.append("\n" + obj.getName() + ":" + obj.getValue());
		}
		log.Write("cookieInfo:" + sb.toString());
	}

	/**打印日志
	 * @param request
	 * @param logStr
	 */
	public static void log(HttpServletRequest request,String logStr) {
		GzLog log=new GzLog();
		if(!Constants.Log.ENABLE_LOG){
			return;
		}	
		
		String uri = request.getRequestURI();
		log.Write("url:"+uri+" "+logStr);
	}
	
	/**打印日志
	 * @param request
	 * @param logStr
	 */
	public static void log(String logStr) {
		GzLog log=new GzLog();
		
		if(!Constants.Log.ENABLE_LOG){
			return;
		}	
		log.Write(logStr);
	}
	
	/**将map的全部值打印出来
	 * @param request
	 * @param map
	 */
	public static void printMap(HttpServletRequest request,Map map) {
	    Set paSet=map.entrySet();
		Iterator iter=paSet.iterator();
		int i=0;
	    while(iter.hasNext()){
	    	Map.Entry e=(Entry) iter.next();
	    	DebugUtils.log(request,"##MAP##"+(++i)+": "+e.getKey().toString()+":"+e.getValue().toString());
	    }
	}
}