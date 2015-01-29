<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
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
		<form method='post' action='/GZMBank/ChongZhi/liantong/ChongZhi_liantong_check.jsp'>
			<label>请输入充值的联通手机号:</label><br/>
			<input type='text' name='TelNum' /><br/>
			<input type='hidden' name='CrdNo' value="<%=CrdNo%>"/><br/>
			<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res> 