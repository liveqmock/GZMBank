<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String sjNo = request.getHeader("MBK_MOBILE");  //注册手机号码
	gzLog.Write(sjNo+"进入["+uri+"]");
	
	//设置需要显示的值和名称,
	String agreeText = "--协议--";	
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
		<form method='post' action='/GZMBank/SignAtOne/Gds_469901_Qry.jsp'>
			<label>请确认协议条款:</label><br/>
			<label><%=agreeText%></label><br/>
<%
	Map form = request.getParameterMap();
	//设置隐藏表单值
	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(1==values.length){
			out.println("<input type='hidden' name='"+key+"' value=\""+values[0]+"\"/><br/>");
		}
	}

%>
			<input type='submit' value='同意'/><br/>
		</form>
	</content>
</res>
