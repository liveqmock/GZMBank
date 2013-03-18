<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤4");

	String SigDup="0";
	String LotNum="";
	int LotNum_cnt=0;
	
	for(int i=1;i<=12;i++){
		if(request.getParameter("LotNum"+i)!=null){
			LotNum+=request.getParameter("LotNum"+i);
			LotNum_cnt++;
		}
	}
	
	if(LotNum_cnt>=2){//合法的号码个数

		if(LotNum_cnt==2){//单式
			SigDup="1";
		}else{//复式
			SigDup="2";
		}
%>
		<jsp:forward page="TicketSaleA5.jsp">
			<jsp:param name="SigDup" value="<%=SigDup%>"/>
			<jsp:param name="LotNum" value="<%=LotNum%>"/>
		</jsp:forward>
<%
	}else{
%>
		<jsp:forward page="TicketSaleB3.jsp">
			<jsp:param name="ErrMsg" value="选择的号码个数不符合要求"/>
		</jsp:forward>
<%
	}


%>

	</content>
</res>