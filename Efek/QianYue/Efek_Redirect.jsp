<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	String uri = request.getRequestURI();
	gzLog.Write("进入["+uri+"]");

	String action_next;

	String qdbz = request.getParameter("QDBZ").trim();
	if("1".equals(qdbz)){
		action_next="Efek_Upd_Input.jsp";
	}else if("0".equals(qdbz)){
		action_next="Efek_Add_Input.jsp";
	}else if("2".equals(qdbz)){
		action_next="Efek_460444.jsp";
	}else{
		action_next="Efek_Qry_Input.jsp";
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