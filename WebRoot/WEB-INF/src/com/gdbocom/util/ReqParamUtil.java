package com.gdbocom.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

/**
 *@author ken
 *@date 2014年12月8日 上午11:04:07
 */
public class ReqParamUtil {
	private static final String PARAM_INPUT_STRING_START="<input type=\"hidden\" name=\"";
	private static final String PARAM_INPUT_STRING_MID="\" value=\"";
	private static final String PARAM_INPUT_STRING_END="\"/>\n";
	private static final String DEF_PREFIX_STRING="aReq_";
	/**
	 * 默认不做处理的参数名称
	 */
	private static final List DEF_IGNORE_PARAM_NAME=new ArrayList();
	static{
		DEF_IGNORE_PARAM_NAME.add("MBK_BOCOMACC_PASSWORD");
	}
	
	/**在request对象中，获得参数的值<br/>
	 * 如果Parameter中没有，将查找Attribute，并且对其进行trim()操作。 如果获得的参数为null，就返回“”空白字符！
	 * @param request 请求对象
	 * @param paramName 参数名称
	 * @return
	 */
	public static String getParamAttr(HttpServletRequest request,String paramName){
		String val=reqParamTirm(request, paramName);
		if(StringUtils.isEmpty(val)){
			val=StringUtils.trimToEmpty((String)request.getAttribute(paramName));
		}
		
		return val;
	}
	
	/**在request对象中，获得参数的值，并且对其进行trim()操作。 如果获得的参数为null，就返回“”空白字符！
	 * @param request 请求对象
	 * @param paramName 参数名称
	 * @return
	 */
	public static String reqParamTirm(HttpServletRequest request,String paramName){
		String paramValue=request.getParameter(paramName);
		String value=StringUtils.trimToEmpty(paramValue);
		
		return value;
	}
	
	/**将Request中的全部参数，以input隐藏HTML标签的形式输出（注：所有值都已经被trim操作）
	 * @param request
	 * @return
	 */
	public static String reqParamToHtmlStr(HttpServletRequest request) {
		return reqParamToHtmlStr(request,null);
	}
	
	/**将Request中的全部参数，以input隐藏HTML标签的形式输出（注：所有值都已经被trim操作）
	 * @param request
	 * @param ignores 需忽略处理的参数名称
	 * @return
	 */
	public static String reqParamToHtmlStr(HttpServletRequest request,String[] ignores) {
		Map reqParamMap = trimParamVal(request,ignores);
		Iterator iter = reqParamMap.entrySet().iterator();

		StringBuffer sb = new StringBuffer();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			String key = (String) entry.getKey();
			String[] vals = (String[]) entry.getValue();
			//如果值是数组，将转换为“a;b;c”形式的字符串
			if (vals.length > 1) {
				sb.append(PARAM_INPUT_STRING_START).append(key)
						.append(PARAM_INPUT_STRING_MID)
						.append(StringComUtils.arrayToString(vals))
						.append(PARAM_INPUT_STRING_END);
			} else {
				sb.append(PARAM_INPUT_STRING_START).append(key)
				.append(PARAM_INPUT_STRING_MID)
				.append(vals[0])
				.append(PARAM_INPUT_STRING_END);
			}
		}
		
		return sb.toString();
	}
	
	/**
	 * 将Request中的全部参数，以input隐藏HTML标签的形式输出，生成后的name将会附加指定的前缀。例如
	 * request中包含参数name:zhang，那么生成的input标签其name将为aReq_name<br/>
	 * 当Request参数中含有指定前缀的，将不再附加前缀。<br/>
	 * <br/>（注：所有值都已经被trim操作）
	 * @param request 请求对象
	 * @param prefixStr 前序字符
	 */
	public static String reqParamToHtmlStrWithPF(HttpServletRequest request,String prefixStr){
		return reqParamToHtmlStrWithPF(request, prefixStr,null);
	}
		
	
	/**
	 * 将Request中的全部参数，以input隐藏HTML标签的形式输出，生成后的name将会附加指定的前缀。例如
	 * request中包含参数name:zhang，那么生成的input标签其name将为aReq_name<br/>
	 * 当Request参数中含有指定前缀的，将不再附加前缀。<br/>
	 * <br/>（注：所有值都已经被trim操作）
	 * @param request 请求对象
	 * @param prefixStr 前序字符
	 * @param ignores 需忽略处理的参数名称
	 */
	public static String reqParamToHtmlStrWithPF(HttpServletRequest request,String prefixStr,String[] ignores){
		String pfStr=null;
		//如果为空，将使用默认
		if(StringUtils.isEmpty(prefixStr)){
			pfStr=DEF_PREFIX_STRING;
		}else{
			pfStr=prefixStr;
		}
		
		Map reqParamMap = trimParamVal(request,ignores);
		Iterator iter = reqParamMap.entrySet().iterator();
		
		String pfKey=null;//附加前缀的key
		StringBuffer sb = new StringBuffer();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			String key = (String) entry.getKey();
			String[] vals = (String[]) entry.getValue();
			
			//如果是以指定前缀开始，将不再附加前缀，否则加上
			if(!key.startsWith(pfStr)){
				pfKey=pfStr+key;
			}else{
				pfKey=key;
			}
			
			//如果值是数组，将转换为“a;b;c”形式的字符串
			if (vals.length > 1) {
				sb.append(PARAM_INPUT_STRING_START).append(pfKey)
						.append(PARAM_INPUT_STRING_MID)
						.append(StringComUtils.arrayToString(vals))
						.append(PARAM_INPUT_STRING_END);
			} else {
				sb.append(PARAM_INPUT_STRING_START).append(pfKey)
				.append(PARAM_INPUT_STRING_MID)
				.append(vals[0])
				.append(PARAM_INPUT_STRING_END);
			}
		}
		
		return sb.toString();
	}
	
	/**
	 * 将Request中的全部参数，以input隐藏HTML标签的形式输出，生成后的name将会附加指定的前缀。例如
	 * request中包含参数name:zhang，那么生成的input标签其name将为aReq_name(默认前缀)<br/>
	 * 当Request参数中含有指定前缀的，将不再附加前缀。<br/>
	 * <br/>（注：所有值都已经被trim操作）
	 * @param request 请求对象
	 * @param prefixStr 前序字符
	 */
	public static String reqParamToHtmlStrWithPF(HttpServletRequest request){
		return reqParamToHtmlStrWithPF(request,null);
	}
	
	public static String reqAttrToHtmlStr(HttpServletRequest request){
		Enumeration e=request.getAttributeNames();
		StringBuffer sb = new StringBuffer();
		String key;
		String val;
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
            val=request.getAttribute(key).toString();
			sb.append(PARAM_INPUT_STRING_START).append(key)
			.append(PARAM_INPUT_STRING_MID)
			.append(val)
			.append(PARAM_INPUT_STRING_END);
		}
		return sb.toString();
	}
	
	/**将Request中的Attribute参数，以input隐藏HTML标签的形式输出，但如果会排除与Parameter参数中同名的值
	 * @param request
	 * @return
	 */
	public static String reqAttrToHtmlStrExcParam(HttpServletRequest request){
		//获取Parameter参数
		Map reqParamMap=request.getParameterMap();
		
		Enumeration e=request.getAttributeNames();
		StringBuffer sb = new StringBuffer();
		String key;
		String val;
		while (e.hasMoreElements()) {
			key = (String) e.nextElement();
			//如果Parameter参数中已经包含相同的KEY，则不作处理
			if(reqParamMap.containsKey(key)){
				continue;
			}
            val=request.getAttribute(key).toString();
			sb.append(PARAM_INPUT_STRING_START).append(key)
			.append(PARAM_INPUT_STRING_MID)
			.append(val)
			.append(PARAM_INPUT_STRING_END);
		}
		return sb.toString();
	}
	
	/**Request中的全部参数(Parameter和Attribute)，全部以input隐藏HTML标签的形式输出。
	 * 但如果Attribute与Parameter包含相同的KEY，将只输出Parameter的
	 * @param request
	 * @return
	 */
	public static String reqParamAttrToHtmlStr(HttpServletRequest request){
		return reqParamToHtmlStr(request)+reqAttrToHtmlStrExcParam(request);
	}
	
	
	/**对参数Map进行trim操作
	 * @param request
	 * @return
	 */
	private static Map trimParamVal(HttpServletRequest request,String[] ignores){
		Map requestParamMap=request.getParameterMap();
		Set paramEntrySet=requestParamMap.entrySet();
		
		//需要忽略处理的参数名称，将跳过
		List iParamName=new ArrayList();
		//默认忽略的
		iParamName.addAll(DEF_IGNORE_PARAM_NAME);
		//加入传递进来的忽略名称
		if(ignores!=null&&ignores.length>0){
			List params=Arrays.asList(ignores);
			iParamName.addAll(params);
		}
		
		Map resultMap=new HashMap();
		Iterator iter=paramEntrySet.iterator();
		while(iter.hasNext()){
			Map.Entry entry=(Map.Entry) iter.next();	
			String key=(String)entry.getKey();
			//如果参数名称包含在内，将忽略
			if(iParamName.contains(key)){
				continue;
			}
			String[] vals=(String[]) entry.getValue();
			if(vals!=null||vals.length>0){
				String[] trimValArray=new String[vals.length];
				for(int i=0;i<vals.length;i++){
					trimValArray[i]=StringUtils.trimToEmpty(vals[i]);
				}
				resultMap.put(StringUtils.trim(key),trimValArray);
			}
		}
		
		return resultMap;
	}
	
	/**获取attribute和parameter的全部参数
	 * @param request
	 * @return
	 */
	public static Map getParamAttr(HttpServletRequest request){
		Map rsMap=new HashMap();
		int id=1;
		
		//处理ParameterMap
		Map reqParamMap=request.getParameterMap();
		Set paramEntrySet=reqParamMap.entrySet();
		Iterator iter=paramEntrySet.iterator();
		while(iter.hasNext()){
			Map.Entry entry=(Map.Entry) iter.next();	
			String key=(String)entry.getKey();
			String[] vals=(String[]) entry.getValue();
			
			if(vals!=null||vals.length>0){
				String[] trimValArray=new String[vals.length];
				for(int i=0;i<vals.length;i++){
					trimValArray[i]=StringUtils.trimToEmpty(vals[i]);
				}
				//将其转换为字符串存放
				rsMap.put(StringUtils.trim(key),StringComUtils.arrayToString(trimValArray));
				DebugUtils.log(request,"getP"+(id++)+" "+StringUtils.trim(key)+":"+StringComUtils.arrayToString(trimValArray));
			}else{
				rsMap.put(StringUtils.trim(key),"");
				DebugUtils.log(request,"getP"+(id++)+" "+StringUtils.trim(key)+":"+"");
			}
		}
		
		//处理Attribute
		Enumeration attrNames=request.getAttributeNames();
		while(attrNames.hasMoreElements()){
			String key=attrNames.nextElement().toString();
			String val=request.getAttribute(key).toString();
			rsMap.put(StringUtils.trim(key),StringUtils.trim(val));
			DebugUtils.log(request,"getA"+(id++)+" "+StringUtils.trim(key)+":"+StringUtils.trim(val));
		}
		
		return rsMap;
	}
}