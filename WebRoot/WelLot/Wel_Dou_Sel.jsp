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
		<form method='post' action='/GZMBank/WelLot/Wel_Dou_Red.jsp'>

		<label>请选择业务类别：</label>
		<input type='radio' name='Bus' value='<%=WelLot.DOUBLE_SEL%>' checked>自选</input>
		<input type='radio' name='Bus' value='<%=WelLot.DOUBLE_BETSQRY%>' >投注查询</input>
		<input type='radio' name='Bus' value='<%=WelLot.DOUBLE_WINQRY%>' >中奖查询</input>
		<input type='hidden' name='preSaveKey' value='Bus' />

		<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res>
