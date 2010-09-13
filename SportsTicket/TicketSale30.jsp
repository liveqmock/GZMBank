<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤3");

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		
    <form method='post' action='/GZMBank/SportsTicket/TicketSale40.jsp'>

		<label>购票方式:</label><br/>
		<input type='text' name='TikMod' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>单复式区分:</label><br/>
		<input type='text' name='SigDup' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>机选注数:</label><br/>
		<input type='text' name='NotNum' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>投注号码:</label><br/>
		<input type='text' name='LotNum' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>彩票类型:</label><br/>
		<input type='text' name='LotTyp' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>倍数:</label><br/>
		<input type='text' name='MulTip' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>扩展号码:</label><br/>
		<input type='text' name='ExtNum' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/><br/>

		<input type='submit' value='下一步'/>
    </form>
	</content>
</res>