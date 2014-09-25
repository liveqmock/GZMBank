<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	gzLog.Write("综合充值业务====Step1"+"卡号："+cdno+"手机号："+sjNo+"\n ChongZhi1.jsp");
%>

<!-- 分行特色业务频道列表 -->
<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/ChongZhi/ChongZhi2.jsp'>
			<label>请选择充值业务: </label>
			<br/>
			<label>(其中包含 移动、电信、联通)</label>
			<select name="optType">
				<option value="0">移动充值</option>
				<option value="1">电信充值</option>
				<option value="2">联通充值</option>
				</select>
			<br/>			
		    <br/>
			<br/>
			<br/>
			<input type='submit' value='确定'/>
			
				
		</form>
	</content>
</res>
