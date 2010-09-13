<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n门票信息查询");
%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		
		<form method='post' action='/GZMBank/yinLvTong/yinLvTongJF2.jsp'>
		<label>请输入订单号: </label>
		<br/>
		<input type='text' name='ddh' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/>
		<input type='submit' value='下一步'/>
		</form>
	</content>
</res>