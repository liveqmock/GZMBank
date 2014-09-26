<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	String optType = MessManTool.changeChar(request.getParameter("optType"));
	
	int opt=Integer.parseInt(optType.trim());
	
	gzLog.Write("###银旅通业务第二个界面##yinLvTong2.jsp====Step2"+"cardNumber:"+cdno+"   phoneNumber:"+sjNo+"\n");
	
	
	String action_next="";


	switch(opt){
	    //电子门票
		case 0:{
			action_next="yinLvTongMPYD1.jsp";
			break;
		}
		//旅游缴费
		case 1:{
			action_next="yinLvTongJF1.jsp";
			break;
		}
		//联通缴费
		default:{
			action_next="yinLvTong1.jsp";
		}
	}
%>
	
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<jsp:forward page="<%=action_next%>">
		</jsp:forward>
	</content>
</res>	