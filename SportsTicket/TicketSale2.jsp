<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	char[] LotTyp2 = request.getParameter("LotTyp2").toCharArray();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤2，选择购彩类型为："+LotTyp2[0]);
	String action_next;

/** 根据购彩类型设置跳转页面 */	
	switch(LotTyp2[0]){
		case 'Z':{
			action_next="TicketSale30.jsp";
			break;
		}
		case 'A':{
			action_next="TicketSaleA3.jsp";
			break;
		}
		case 'B':{
			action_next="TicketSaleB3.jsp";
			break;
		}
		case 'C':{
			action_next="TicketSaleC3.jsp";
			break;
		}
		case 'D':{
			action_next="TicketSaleD3.jsp";
			break;
		}
		default:{
			action_next="TicketSale1.jsp";
		}
	}
	

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<jsp:forward page="<%=action_next%>"></jsp:forward>
	</content>
</res>