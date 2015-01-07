<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.PreAction" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	//保存上一表单(交易)字段
	String preSaveKey = request.getParameter("preSaveKey");
	PreAction.savePreFormValue(pageContext, request, preSaveKey);

	int bus = Integer.parseInt((String)pageContext.getAttribute("Bus", PageContext.SESSION_SCOPE));

	String action_next;
	
	if(bus==WelLot.ADDREG){
		action_next="Wel_Reg_Add.jsp";

	}else if(bus==WelLot.UPDREG){
		action_next="Wel_Reg_Add.jsp";

	}else if(bus==WelLot.DOUBLEBUY){
		action_next="Wel_Dou_Sel.jsp";

	}else if(bus==WelLot.DOUBLEFIXBUY){
		action_next="Wel_Fix_Sel.jsp";

	}else if(bus==WelLot.TENBUY){
		action_next="Wel_hTen_Sel.jsp";
	}else{
		action_next="Wel_Bus_Sel.jsp";
	}
%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<jsp:forward page="<%=action_next%>">
		</jsp:forward>
	</content>
</res>
