<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	gzLog.Write("进入liantong1");
	String CrdNo = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行卡号
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));

%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/ChongZhi/liantong/ChongZhi_liantong_460601.jsp'>
			<label>请输入充值的联通手机号:</label><br/>
			<input type='text' name='TelNum' /><br/>
			<input type='hidden' name='CrdNo' value="<%=CrdNo%>"/><br/>
			<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res> 