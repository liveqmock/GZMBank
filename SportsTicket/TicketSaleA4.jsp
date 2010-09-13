<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");

	String workflow = request.getParameter("workflow");
	if("A3".equals(workflow)){//从TicketSalA3.jsp进入
	
		String TikMod = request.getParameter("TikMod");
		String NotNum = request.getParameter("NotNum");
		String SigDup;
		String LotNum;
		String LotTyp;
		String MulTip = request.getParameter("MulTip");
		String[] add_tag = (request.getParameterValues("add"));
		String ExtNum = request.getParameter("ExtNum");
		if(add_tag==null){
				LotTyp = "26";
		}else{
				LotTyp = "27";
		}
		if("02".equals(TikMod)){//机选
			SigDup = "1";
			LotNum = NotNum;
			gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤4(机选)：TikMod:"+TikMod
						+"|NotNum:"+NotNum
						+"|SigDup:"+SigDup
						+"|LotNum:"+LotNum
						+"|LotTyp:"+LotTyp
						+"|MulTip:"+MulTip
						+"|add_tag:"+add_tag
						+"|ExtNum:"+ExtNum
						+"|");
			%>
			<jsp:forward page="TicketSaleA5.jsp">
				<jsp:param name="SigDup" value="<%=SigDup%>"/>
				<jsp:param name="LotNum" value="<%=LotNum%>"/>
				<jsp:param name="LotTyp" value="<%=LotTyp%>"/>
			</jsp:forward>
			<%
		}else if("01".equals(TikMod)){//自选
			gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤4(机选)：TikMod:"+TikMod
						+"|LotTyp:"+LotTyp
						+"|MulTip:"+MulTip
						+"|add_tag:"+add_tag
						+"|ExtNum:"+ExtNum
						+"|");
		%>
			<jsp:forward page="TicketSaleA41.jsp">
				<jsp:param name="LotTyp" value="<%=LotTyp%>"/>
			</jsp:forward>
		<%
		}
	}else if("A41".equals(workflow)){//从TicketSalA41.jsp进入
		String SigDup="0";
		String LotNum="";
		String forepart="";
		String rear="";
		int forepart_cnt=0;
		int rear_cnt=0;
		
		for(int i=1;i<=35;i++){
			if(request.getParameter("forepart"+i)!=null){
				//out.println(request.getParameter("forepart"+i)+"<br/>");
				forepart+=request.getParameter("forepart"+i);
				forepart_cnt++;
			}
		}
		
		for(int i=1;i<=12;i++){
			if(request.getParameter("rear"+i)!=null){
				//out.println(request.getParameter("rear"+i)+"<br/>");
				rear+=request.getParameter("rear"+i);
				rear_cnt++;
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
			%>
			<jsp:forward page="TicketSaleA5.jsp">
				<jsp:param name="SigDup" value="<%=SigDup%>"/>
				<jsp:param name="NotNum" value=""/>
				<jsp:param name="LotNum" value="<%=LotNum%>"/>
			</jsp:forward>
			<%
		}else{//非法的号码个数
		%>
			<jsp:forward page="TicketSaleA41.jsp">
				<jsp:param name="ErrMsg" value="选择的号码个数不符合要求"/>
			</jsp:forward>
		<%
		}

	}

	%>

	</content>
</res>