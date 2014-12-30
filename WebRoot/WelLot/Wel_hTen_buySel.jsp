<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>

<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/WelLot/Wel_hTen_buyRed.jsp'>
		<label>请选择业务类别：</label>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.ONE%>' selected="selected">选一数投</input>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.ONE_RED%>' >选一红投</input>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.TWO%>' >任选二</input>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.TWO_LINE%>'>选二连直</input>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.TWO_GROUP%>'>选二连组</input>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.THREE%>'>任选三</input>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.THREE_LINE%>'>选三前直</input>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.THREE_GROUP%>'>选三前组</input>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.FOUR%>'>任选四</input>
		<input type='radio' name='buyMode' value='<%=WelLot.HpTenBuy.FIVE%>'>任选五</input>
		<a href="/GZMBank/WelLot/Wel_hTen_Sum.jsp">查看业务简介</a>
		<%=
			ReqParamUtil.reqParamAttrToHtmlStr(request)
		%>
		<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res>