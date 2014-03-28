<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	gzLog.Write("银旅通类缴费===="+"卡号："+cdno+"手机号："+sjNo+"\n yinLvTong1.jsp");
%>

<!-- 分行特色业务频道列表 -->
<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/yinLvTong/yinLvTong2.jsp'>
			<label>请选择银旅通业务</label>
			<br/>
			
			<select name="optType">
				<option value="0">电子门票</option>
				<option value="1">旅游缴费</option>
			</select>
			<br/>			
		    <br/>
			<br/>
			<br/>
			<input type='submit' value='确定'/>
			
				
		</form>
	</content>
</res>