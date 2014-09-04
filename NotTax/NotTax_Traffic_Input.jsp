<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行卡号
	String sjNo = request.getHeader("MBK_MOBILE");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	gzLog.Write("进入["+uri+"]");
	//准备显示字段
	Map showE = new HashMap();

	//准备更新字段
	Map updateE = new HashMap();
	updateE.put("AdnCod", "文书编号");
	updateE.put("PBilTyp", "打印票据种类");
	updateE.put("PBilNo", "打印票据编号");
	updateE.put("HndFlg", "通知书填写方式");
	updateE.put("UpdAdnFg", "查询刷新标识");
	updateE.put("RipFlg", "撕定额票标志");


%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/NotTax/NotTax_461509.jsp'>
<%
	Map form = request.getParameterMap();

	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(showE.containsKey(key)){
			out.println("<lable>"+showE.get(key)+"</lable>");
			out.println("<lable>"+values[0]+"</lable>");
		}else if(updateE.containsKey(key)){
			out.println("<lable>"+showE.get(key)+"</lable>");
			out.println("<input type='text' name='"+key+"' value='"+values[0]+"'/>");
		}else if(1==values.length){
			out.println("<input type='hidden' name='"+key+"' value=\""+values[0]+"\"/><br/>");
		}
		
	}


%>
			<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res> 