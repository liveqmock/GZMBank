<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
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
		<form method='post' action='/GZMBank/WelLot/Wel_Pck_Red.jsp'>

		<label>请选择业务类别：</label>
		<input type='radio' name='BetPer' value='<%=WelLot.DOUBLE_FIX_PACKAGE_153%>' checked>153期套餐</input>
		<input type='radio' name='BetPer' value='<%=WelLot.DOUBLE_FIX_PACKAGE_76%>' >76期套餐</input>
		<label>定投购买在开奖日19:00前，则为当期双色球投注；若在开奖日19:00后，则为下一期双色球投注</label>
		<input type='hidden' name='preSaveKey' value='BetPer' />

		<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res>
