<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤3_1");
%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<label>大乐透</label><br/>
		
    <form method='post' action='/GZMBank/SportsTicket/TicketSaleA3_2.jsp'>


  <!-- 购票方式-->
	<label>请选择购票方式: </label>
	<br/>
		
	<select name="TikMod">
		<option value='01'  checked >自选</option>
    <option value='02'          >机选</option>
	</select>
	

	<input type='submit' value='下一步'/>
    </form>
	</content>
</res>