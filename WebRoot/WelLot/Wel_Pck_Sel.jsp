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
		<form method='post' action='/GZMBank/WelLot/Wel_Fix_Buy.jsp'>

		<label>请选择业务类别：</label>
		<input type='radio' name='Package' value='<%=WelLot.DOUBLE_FIX_PACKAGE_153%>' checked>153期套餐</input>
		<input type='radio' name='Package' value='<%=WelLot.DOUBLE_FIX_PACKAGE_72%>' >72期套餐</input>
		<input type='hidden' name='preSaveKey' value='Package' />

		<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res>
