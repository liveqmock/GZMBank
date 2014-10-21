<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.PreAction" %>
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

	String action_next;

	String adnKnd = (String)pageContext.getAttribute("AdnKnd", PageContext.SESSION_SCOPE);
	if("3".equals(adnKnd)){
		action_next="NotTax_Tra_Input.jsp";
	}else if("1".equals(adnKnd)){
		action_next="NotTax_N_Input.jsp";
	}else{
		action_next="NotTax_Act_Sel.jsp";
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
