<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.PreAction" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	String uri = request.getRequestURI();
	gzLog.Write("进入["+uri+"]");

	//保存上一表单(交易)字段
	String preSaveKey = request.getParameter("preSaveKey");
	PreAction.savePreFormValue(pageContext, request, preSaveKey);
	gzLog.Write(PreAction.strOfPageContext(pageContext));


	int bus = Integer.parseInt((String)pageContext.getAttribute("Bus", PageContext.SESSION_SCOPE));

	String action_next;
	
	switch(bus){
	case(WelLot.ADDREG):
		action_next="Wel_Reg_Add.jsp";
		break;
	case(WelLot.ADDREG):
		action_next="Wel_Buy_Dou.jsp";
		break;
	case(WelLot.ADDREG):
		action_next="Wel_Fix_Dou.jsp";
		break;
	case(WelLot.ADDREG):
		action_next="Wel_Buy_Ten.jsp";
		break;
	default:
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
