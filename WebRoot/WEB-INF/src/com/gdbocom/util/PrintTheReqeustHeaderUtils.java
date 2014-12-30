package com.gdbocom.util;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

/**
 * @version <1.0>
 * @author 张竞辉
 * @date Sep 18, 2009
 */
public class PrintTheReqeustHeaderUtils {
	
	public static void printAttr(HttpServletRequest request) {
		Enumeration e = request.getAttributeNames();
		
		int i=1;
		String name = null;
		while (e.hasMoreElements()) {
			name = (String) e.nextElement();
			DebugUtils.log(request,"attr"+i+":"+name+"="+request.getAttribute(name));
			i++;
		}
	}
	
	public static void printParam(HttpServletRequest request) {
		Enumeration e = request.getParameterNames();
		
		int i=1;
		String name = null;
		while (e.hasMoreElements()) {
			name = (String) e.nextElement();
			DebugUtils.log(request,"param"+i+":"+name+"="+request.getParameter(name));
			i++;
		}
	}
	
	public static void printHeader(HttpServletRequest request) {
		Enumeration e = request.getHeaderNames();
		int i=1;
		StringBuffer sb=null;
		String name = null;
		while (e.hasMoreElements()) {
			sb=new StringBuffer();
			name = (String) e.nextElement();
            Enumeration headers = request.getHeaders(name);  
            sb.append(name).append(":");  
            while(headers.hasMoreElements()) {  
                sb.append(headers.nextElement()).append(" ");  
            }  
            sb.append("\n");  
			
			DebugUtils.log(request,"header"+i+"   "+sb.toString());
			i++;
		}
	}
}