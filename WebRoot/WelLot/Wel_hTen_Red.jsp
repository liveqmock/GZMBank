<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	int bus = Integer.parseInt(ReqParamUtil.reqParamTirm(request,"Bus"));
	request.setAttribute("Bus",ReqParamUtil.getParamAttr(request,"Bus"));
	String action_next;
	if(bus==WelLot.HP_TEN_SUMMARY){
		action_next="Wel_hTen_Sum.jsp";
	}else if(bus==WelLot.HP_TEN_BUY){
		action_next="Wel_hTen_buySel.jsp";
		//action_next="/ToHtml?url=/WelLot/Wel_hTen_buySel.jsp";
	}else if(bus==WelLot.HP_TEN_QRY||bus==WelLot.HP_TEN_WINQRY){
		action_next="Wel_hTen_Comm.jsp";
		request.setAttribute("BetTyp","0");
		request.setAttribute("BegDat","19990101");
		request.setAttribute("EndDat","29991231");
		//准备调用参数
		HpTenBallCreater.setDefuCallParam(request);
	}else{
		action_next="Wel_Bus_Sel.jsp";
	}
%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<jsp:forward page="<%=action_next%>">
		</jsp:forward>
	</content>
</res>
