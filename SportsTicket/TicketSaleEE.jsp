<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String ErrMsg = request.getParameter("ErrMsg");
	gzLog.Write("!!!!!!!!:"+ErrMsg+"|");
	
	if(!ErrMsg.equals("")){
		out.println("<label>"+"选择的号码个数不符合要求"+"</label>");
	}
%>