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
	String uri = request.getRequestURI();
	gzLog.Write("进入["+uri+"]");

	String LotNum="";
	String forepart="";
	String rear="";
	int forepart_cnt=0;
	int rear_cnt=0;
	
	for(int i=1;i<=35;i++){
		if(request.getParameter("forepart"+i)!=null){
			forepart+=request.getParameter("forepart"+i);
			forepart_cnt++;
			gzLog.Write("前区号码为:"+i);
		}
	}
	
	for(int i=1;i<=12;i++){
		if(request.getParameter("rear"+i)!=null){
			rear+=request.getParameter("rear"+i);
			rear_cnt++;
			gzLog.Write("后区号码为:"+i);
		}
	}
	
	if(forepart_cnt>=5&&forepart_cnt<=18&&rear_cnt>=2){//合法的号码个数

		if(forepart_cnt==5&&rear_cnt==2){//单式
			SigDup="1";
			LotNum=forepart+rear;
		}else{//复式
			SigDup="2";
			LotNum=forepart+"*"+rear;
		}

	}else{//非法的号码个数
	%>
		<jsp:forward page="TicketSaleA41.jsp">
			<jsp:param name="ErrMsg" value="选择的号码个数不符合要求"/>
		</jsp:forward>
	<%
	}

	%>

	</content>
</res>