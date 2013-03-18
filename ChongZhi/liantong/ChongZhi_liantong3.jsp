<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String CrdNo = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	gzLog.Write("进入liantong3");
	
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
	<%	
				String TelNum = MessManTool.changeChar(request.getParameter("TelNum"));
				String TxnAmt = MessManTool.changeChar(request.getParameter("TxnAmt"));
		
	%>	 
				<label>请确认充值信息</label><br/>
			    <table border='1'>
			    	<tr>
			        	<td>卡号</td>
			        	<td><%=CrdNo%></td>
			        </tr>
			        <tr>
			        	<td>充值号码</td>
			        	<td><%=TelNum%></td>
			        </tr>
			        <tr>
			        	<td>充值金额</td>
			        	<td><%=TxnAmt%></td>
			        </tr>
			    </table>
				
				<input type='hidden' name='TelNum' value="<%=TelNum%>"/><br/>
				<input type='hidden' name='CrdNo' value="<%=CrdNo%>"/><br/>
				<input type='submit' value='确定'/><br/>
	</content>
</res>