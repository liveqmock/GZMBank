<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	String optType = MessManTool.changeChar(request.getParameter("optType"));
	
	int opt=Integer.parseInt(optType.trim());
	
	gzLog.Write("###体彩业务第二个界面##====Step2"+"cardNumber:"+cdno+"   phoneNumber:"+sjNo+"\n");
	
	
	String action_next="";


	switch(opt){
	  //购买体育彩票
		case 0:{
			action_next="TicketSale1.jsp";
			break;
		}
		//查询体彩投注情况
		case 1:{
			action_next="TicketQuery1.jsp";
			break;
		}
		//联通缴费
		default:{
			action_next="SportsTicket2.jsp";
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