<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	String mainNo = MessManTool.changeChar(request.getParameter("mainNo"));
	String signType = MessManTool.changeChar(request.getParameter("signType"));
	String IdTyp = MessManTool.changeChar(request.getParameter("IdTyp"));
	String IdNo = MessManTool.changeChar(request.getParameter("IdNo"));
	String cusNam = MessManTool.changeChar(request.getParameter("ActNam"));
	String plantPwd = request.getHeader("password"); //移植密码
	
	
	gzLog.Write("#####MobCharge4.jsp===="+"cardNumber:"+cdno+" phoneNumber:"+sjNo+" mainNo"+mainNo+" signType"+signType+"\n");
%>


<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
		<%	
			//|签约类型|凭证号|账号类型|银行卡号|银行账号名称|证件类型|证件号码|客户姓名|主手机号|签约手机号|签约标记|银行交易密码|
			String sendContext = "biz_id,32|biz_step_id,2|TXNSRC,MB441|BisTyp,1"+"|ActTyp,4"+
			"|ActNo,"+cdno+"|ActNam,"+cusNam+"|VchNO,"+"|IdTyp,"+IdTyp+"|IdNo,"+IdNo+"|CusNam,"+cusNam+
			"|MstTel,"+mainNo+"|PINDat,"+plantPwd;
		
			gzLog.Write("银行卡号"+cdno+"手机号码"+sjNo+"\n接收报文MESSAGE为：>>>>>>>>sendMessage:  "+sendContext);  //log
		
			MidServer midServer = new MidServer();
		
			//发送报文，并且获取返回的报文
			BwResult bwResult = midServer.sendMessage(sendContext);
			String message = bwResult.getContext();
			gzLog.Write("<<<<<<<<<returnMessage:   "+message);
			gzLog.Write("银行卡号: "+cdno+"手机号码: "+sjNo+"\n接收报文MESSAGE为：" +message);
		
			String MGID = MessManTool.getValueByName(message, "MGID");
			//当返回成功
			if("000000".equals(MGID)){
		%>
		
		<label>解约数据已经成功发送给移动！感谢您的使用。</label>
		
		<%
			}else{
				String errorReport = MessManTool.getValueByName(message, "RspMsg");
				gzLog.Write("错误信息是："+errorReport );
		
		%>
		<label>交易出错，错误信息为</label>
		
    <label><%=errorReport%></label>          
		  
		<%
				 }
		%>
	</content>
	
</res> 