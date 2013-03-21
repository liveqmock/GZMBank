package com.gdbocom.util;

import java.util.*;
import javax.servlet.http.*;

public class Context {

	private Map context = new HashMap();

	/**
	 * ���ڽ��������Զ�ת����<key,value>�ַ���,��:|biz_id,28|biz_step_id,1|TXNSRC,MB441|.�Ѿ����Թ�text��select��radio�ȿؼ�������<b>checkbox</b>����
	 * @param request ǰһҳ����������
	 * @param biz_id �������صĽ�������
	 * @param biz_step_id �������صĽ��ײ���
	 * @return ��ʽ���õ��ַ���
	 */
	public static String createContext(HttpServletRequest request, String biz_id, String biz_step_id){

		String context = "|biz_id,"+biz_id+"|biz_step_id,"+biz_step_id+"|TXNSRC,MB441|";
		Map form = request.getParameterMap(); //��ֵ����ͨ�ֻ�����

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
