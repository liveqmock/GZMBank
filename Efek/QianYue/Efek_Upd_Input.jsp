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

%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/Efek/JiaoFei/Efek_460444.jsp'>
			<lable>缴费号：</lable>
			<br/>
			<lable>缴费号：</lable>
			<input type='text' name='JFH' style="-wap-input-required:'true'" maxleng='20'/>
			<br/>
			<input type='hidden' name='CrdNo' value="<%=CrdNo%>"/><br/>
			<input type='hidden' name='QDBZ' value="3"/><br/>
<%
	Map form = request.getParameterMap();

	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(1==values.length){
			out.println("<input type='hidden' name='"+key+"' value=\""+values[0]+"\"/><br/>");
		}
	}


%>
			<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res> 