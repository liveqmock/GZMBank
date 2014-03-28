<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	gzLog.Write("体彩类缴费===="+"卡号："+cdno+"手机号："+sjNo+"\n ");
%>

<!-- 分行特色业务频道列表 -->
<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/SportsTicket/SportsTicket2.jsp'>
			<label>请选择体彩业务</label>
			<br/>
			
			<select name="optType">
				<option value="0">购买体育彩票</option>
				<option value="1">查询体彩投注情况</option>
			</select>
			<br/>			
		    <br/>
			<br/>
			<br/>
			<input type='submit' value='确定'/>
			
				
		</form>
	</content>
</res>