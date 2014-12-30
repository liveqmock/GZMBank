<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	String cdno = request.getHeader("MBK_ACCOUNT");
	//设置正常情况需要跳转的页面
	String forwardPage = "Wel_Confirm.jsp";
	//设置出错情况需要跳转的页面
	String errPage = "errPage.jsp";
	//计算相关业务数据，并放入request的Attribute中
	HpTenBallCreater.processData(request,response);
	String showNum=ReqParamUtil.getParamAttr(request,"showNum");
	String BetAmtShow=ReqParamUtil.getParamAttr(request,"BetAmtShow");
%>

<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/WelLot/Wel_hTen_pwd.jsp'>
			<label>银行卡号：<%=cdno%></label><br/>
			<label>投注号码：<%=showNum%></label>
			<label>交易金额：<%=BetAmtShow%>元</label>
			<%=
				ReqParamUtil.reqParamAttrToHtmlStr(request)
			 %>
			<input type='submit' value='确认'/>
		</form>
    </content>
</res>