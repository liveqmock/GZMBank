<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	String optType = MessManTool.changeChar(request.getParameter("optType"));  //0-移动充值 1 -电信充值
	
	int opt=Integer.parseInt(optType.trim());
	
	gzLog.Write("###缴费业务第二个界面##JiaoFei2.jsp====Step2"+"cardNumber:"+cdno+"   phoneNumber:"+sjNo+"\n");
	
	
	String action_next="";
	
	switch(opt){
	    //移动缴费
		case 0:{
			action_next="yiDongJF1.jsp";
			break;
		}
		//电信缴费
		case 1:{
			action_next="txDianXin1.jsp";
			break;
		}
		//联通缴费
		case 2:{
			action_next="LTongJF1.jsp";
			break;
		}
		default:{
			action_next="JiaoFei1.jsp";
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