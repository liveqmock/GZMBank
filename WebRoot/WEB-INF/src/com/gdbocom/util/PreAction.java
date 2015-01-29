package com.gdbocom.util;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.jsp.PageContext;
import javax.servlet.http.HttpServletRequest;

import com.viatt.util.MessManTool;

public class PreAction {

	/**
	 * 根据preSaveKey来保存上表单的数据到session
	 * @param pageContext
	 * @param request
	 * @param preSaveKey
	 */
	public static void savePreFormValue(PageContext pageContext, HttpServletRequest request, String preSaveKey){
		String[] preSaveKeys = preSaveKey.split("\\,");
		for(int i=0; i<preSaveKeys.length; i++){
			pageContext.setAttribute(preSaveKeys[i], request.getParameter(preSaveKeys[i]).trim(), PageContext.SESSION_SCOPE);
		}
		
	}

	/**
	 * 获取pageContext里面所有的session字段
	 * @param pageContext
	 * @return
	 */
	public static String strOfPageContext(PageContext pageContext){
		StringBuffer sb = new StringBuffer();
		sb.append("PageContext里面的字段如下：\n");
		String key;
		for (Enumeration e = pageContext.getSession().getAttributeNames(); e.hasMoreElements();){
			key = (String)e.nextElement();
			sb.append(key+":"+pageContext.getAttribute(key, PageContext.SESSION_SCOPE)+"\n");
		}
		
		return sb.toString();
	}

	/**
	 * 保存网关返回的数据
	 * @param pageContext
	 * @param responseContext
	 * @param saveKey
	 */
	public static void saveMidServerValue(PageContext pageContext, String responseContext, String saveKey){
		String[] saveKeys = saveKey.split("\\,");
		for(int i=0; i<saveKeys.length; i++){
			pageContext.setAttribute(saveKeys[i], MessManTool.getValueByName(responseContext, saveKeys[i]), PageContext.SESSION_SCOPE);
		}
	}

	/**
	 * 根据preSaveKey来保存上map的数据到pagecontext
	 * @param pageContext
	 * @param params
	 * @param preSaveKey
	 */
	public static void saveMapValue(PageContext pageContext, Map params, String preSaveKey){
		String[] preSaveKeys = preSaveKey.split("\\,");
		for(int i=0; i<preSaveKeys.length; i++){
			pageContext.setAttribute(preSaveKeys[i], params.get(preSaveKeys[i]), PageContext.SESSION_SCOPE);
		}
		
	}

}
