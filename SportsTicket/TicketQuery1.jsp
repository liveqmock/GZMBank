<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票查询步骤1");
%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		
		<form method='post' action='/GZMBank/SportsTicket/TicketQuery2.jsp'>
		<label>请输入购彩流水号: </label>
		<br/>
		<input type='text' name='TLogNo' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/>
		<input type='submit' value='下一步'/>
		</form>
	</content>
</res>