<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>

<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/WelLot/Wel_hTen_Red.jsp'>
		<label>请选择业务类别：</label>
		<input type='radio' name='Bus' value='<%=WelLot.HP_TEN_SUMMARY%>' checked>业务简介</input>
		<input type='radio' name='Bus' value='<%=WelLot.HP_TEN_BUY%>' >投注</input>
		<input type='radio' name='Bus' value='<%=WelLot.HP_TEN_QRY%>' >投注查询</input>
		<input type='radio' name='Bus' value='<%=WelLot.HP_TEN_WINQRY%>' >中奖查询</input>
		<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res>