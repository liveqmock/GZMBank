<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
    gzLog.Write("##################MobCharge2.jsp######");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
%>
<%	
	
	String signType = MessManTool.changeChar(request.getParameter("signType"));
	String IdTyp = MessManTool.changeChar(request.getParameter("IdTyp"));
	String IdNo = MessManTool.changeChar(request.getParameter("IdNo"));
	String cusNam = MessManTool.changeChar(request.getParameter("ActNam"));
	String mainNo = MessManTool.changeChar(request.getParameter("mainNo"));
	String signNo = MessManTool.changeChar(request.getParameter("signNo"));
	String plantPwd = request.getHeader("password"); //移植密码
	String signFlg=null;
	
	gzLog.Write("###signType="+signType+" idtype="+IdTyp+" cusNam="+cusNam+" idno="+IdNo+" mainNo="
							+mainNo+" signNo="+signNo+" planPwd="+plantPwd);
	
	if(signType.trim().equals("1")){
		signFlg="0";
	}
	else if(signType.trim().equals("2")){
		signFlg="1";
	}
	

	
	
	
%>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
		<%	
			//|签约类型|凭证号|账号类型|银行卡号|银行账号名称|证件类型|证件号码|客户姓名|主手机号|签约手机号|签约标记|银行交易密码|
			String sendContext = "biz_id,32|biz_step_id,1|TXNSRC,MB441|SigTyp,"+signType+
								 "|VchNO,"+"|ActTyp,4"+"|ActNo,"+cdno+"|ActNam,"+"|IdTyp,"+IdTyp+
								 "|IdNo,"+IdNo+"|CusNam,"+cusNam+"|MstTel,"+mainNo+
								 "|SigTel,"+signNo+"|SigFlg,"+signFlg+"|PINDat,"+plantPwd;
		
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
		
		<label>签约信息已经成功录入！感谢您的使用。</label>
		<br/>
		<br/>
		<label>请您保持签约手机通迅的畅通，该签约信息最后以移动公司发送的确认短信为准。如果您在48小时内未完成移动公司签约短信的确认，交通银行将自动取消您本次签约信息。</label>

        <a href='/GZMBank/SignAtOne/Gds_Pub_Agree.jsp'>返回</a>
		
		<%
			}else{
				String errorReport = MessManTool.getValueByName(message, "RspMsg");
				gzLog.Write("错误信息是："+errorReport );
		
		%>
		<label>交易出错，错误信息为</label>
		<br/>	
                <%=errorReport%>          
		  
		<%
				 }
		%>
	</content>
	
</res> 