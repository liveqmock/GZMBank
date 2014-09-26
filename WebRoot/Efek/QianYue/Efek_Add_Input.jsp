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
	updateE.put("JFH", "缴费号");
	updateE.put("JSHMC", "结算户名称");
	updateE.put("YDDZ", "结算户用电地址");
	updateE.put("XQYZH", "新签约帐户");
	updateE.put("XQYZHMC", "新签约账户名称");
	updateE.put("ZJLX", "证件类型");
	updateE.put("ZJHM", "证件号码");
	updateE.put("LXDH", "联系电话");
	updateE.put("SJHM", "手机号码");
	updateE.put("EMAIL", "电子邮件");


%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/Efek/QianYue/Efek_Confirm.jsp'>
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