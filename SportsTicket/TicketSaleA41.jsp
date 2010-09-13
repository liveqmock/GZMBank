<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");

	String TikMod = request.getParameter("TikMod");
	String LotTyp = request.getParameter("LotTyp");
	String MulTip = request.getParameter("MulTip");
	String ExtNum = request.getParameter("ExtNum");
	String ErrMsg = request.getParameter("ErrMsg")==null?"":request.getParameter("ErrMsg");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤41：TikMod:"+TikMod
				+"|LotTyp:"+LotTyp
				+"|MulTip:"+MulTip
				+"|ExtNum:"+ExtNum
				+"|");
%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<form method='post' action='/GZMBank/SportsTicket/TicketSaleA4.jsp'>
		<h1>大乐透</h1><br/>
		<%if(!ErrMsg.equals("")){out.println("<label>"+ErrMsg+"</label>");}%>
		<label>请选择前区号码(请任意选择5个或以上号码)</label>
		<%
			for(int i=1;i<=35;i++){
		%>
			<input type='checkbox' name='forepart<%=i%>' value='<%=this.formatnumber(i)%>'><%=i%></input>
		<%				
			}
		%>
		<label>*******************************</label>
		<label>请选择后区号码(请任意选择2个或以上号码)</label>
		<%
			for(int i=1;i<=12;i++){
		%>
				<input type='checkbox' name='rear<%=i%>' value='<%=this.formatnumber(i)%>'><%=i%></input>
		<%				
			}
		%>
		<!--购票方式-->
		<input type='hidden' name='TikMod' value='<%=TikMod%>'/>
		<!--彩票类型-->
		<input type='hidden' name='LotTyp' value='<%=LotTyp%>'/>
		<!--倍数-->
		<input type='hidden' name='MulTip' value='<%=MulTip%>'/>
		<!--扩展号码-->
		<input type='hidden' name='ExtNum' value='<%=ExtNum%>'/>
		<!-- 控制流程 -->
		<input type='hidden' name='workflow' value='A41'></input>
		<input type='submit' value='下一步'/>
	</form>
	</content>
</res>
<%!
	public String formatnumber(int inputstr){
		String outputstr;
		if(inputstr<=9){
			outputstr="0"+String.valueOf(inputstr);
		}else{
			outputstr = String.valueOf(inputstr);
		}
		return outputstr;
	}
%>