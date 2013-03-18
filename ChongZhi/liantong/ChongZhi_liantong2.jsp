<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String CrdNo = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	gzLog.Write("进入liantong2");
	
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
	<%	
		//在这里开始拼装即将发往服务器的一串报文
		String requestContext = Context.createContext(request, "33", "1");
		
		gzLog.Write("请求报文："+requestContext);  //log
		
		//这里开始才会转到网关上啊
		MidServer midServer = new MidServer();
		BwResult bwResult = new BwResult();
		
		bwResult = midServer.sendMessage(requestContext);
		String responseContext = bwResult.getContext();
		gzLog.Write("返回报文："+responseContext);
		
		String MGID = MessManTool.getValueByName(responseContext, "RspCod");	
		gzLog.Write("这里是缴费Step4报文返回的第一站，检查RspCod:  "+MGID);
		
		//如果返回正确
		if(!"000000".equals(MGID)){
			String RspCod = MessManTool.changeChar(MessManTool.getValueByName(responseContext, "RspCod"));
			String RspMsg = MessManTool.changeChar(MessManTool.getValueByName(responseContext, "RspMsg")); 
			
			gzLog.Write("****错误码:"+RspCod+"错误信息"+RspMsg);
			out.println("<label>错误码为:"+RspCod+"</label><br/>");

			if("PD5012".equals(RspCod)){
				out.println("<label>错误原因为:密码错误</label><br/>");
			}

		} else {

			String AreCod = MessManTool.changeChar(MessManTool.getValueByName(responseContext, "AreCod"));
			if(!"".equals(AreCod)){
				out.println("<label>手机号输入不正确</label><br/>");
			}else{
				String TelNum = MessManTool.changeChar(request.getParameter("TelNum"));
		
	%>	 
		<form method='post' action='/GZMBank/ChongZhi/liantong/ChongZhi_liantong3.jsp'>
			<label>请选择充值金额</label><br/>
			<select name="TxnAmt">
				<option value="0" selected>50  元</option>
				<option value="1">100 元</option>
				<option value="2">150 元</option>
				<option value="3">200 元</option>
				<option value="4">500 元</option>
			</select><br/>
			
			<input type='hidden' name='TelNum' value="<%=TelNum%>"/><br/>
			<input type='hidden' name='CrdNo' value="<%=CrdNo%>"/><br/>
			<input type='submit' value='确定'/><br/>
		</form>
	<%
			}
	 	}
    %> 
		
    <%
	gzLog.Write("电力缴费完毕！！！！！");
    %>	
	</content>
</res>