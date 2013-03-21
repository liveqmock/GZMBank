package com.gdbocom.util;

import java.util.*;
import javax.servlet.http.*;

public class Context {

	private Map context = new HashMap();

	/**
	 * 用于将表单数据自动转换成<key,value>字符串,如:|biz_id,28|biz_step_id,1|TXNSRC,MB441|.已经测试过text、select、radio等控件，不过<b>checkbox</b>除外
	 * @param request 前一页面的请求对象
	 * @param biz_id 发送网关的交易类型
	 * @param biz_step_id 发送网关的交易步骤
	 * @return 格式化好的字符串
	 */
	public static String createContext(HttpServletRequest request, String biz_id, String biz_step_id){

		String context = "|biz_id,"+biz_id+"|biz_step_id,"+biz_step_id+"|TXNSRC,MB441|";
		Map form = request.getParameterMap(); //充值的联通手机号码

		Iterator itKeys = form.keySet().iterator();
		while(itKeys.hasNext()){
			String key = (String)itKeys.next();
			String[] values = ( (String[]) form.get(key) );
			if(1==values.length){
				context += key+","+values[0]+"|";
			}
		}
		return context;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
