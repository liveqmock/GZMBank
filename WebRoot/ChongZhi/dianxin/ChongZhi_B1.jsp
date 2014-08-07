<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	String dxNumber = MessManTool.changeChar(request.getParameter("dxNumber"));//电信充值号码
	String numType  = MessManTool.changeChar(request.getParameter("numType"));//号码类型
	String optAmount  = MessManTool.changeChar(request.getParameter("optAmount"));//金额
	
	int opt=Integer.parseInt(optAmount.trim());
	String amount="";
	String tranAmt="";
	String icsAmount="";
	switch(opt){
	case 0:
		amount="50"; 
		tranAmt="000000000005000";
		break;
	case 1:
		amount="100";
		tranAmt="000000000010000";
		break;
	case 2:
		amount="150";
		tranAmt="000000000015000";
		break;
	case 3:
		amount="200";
		tranAmt="000000000020000";
		break;
	case 4:
		amount="500";
		tranAmt="000000000050000";
		break;
	default :
		amount="00"; 
		tranAmt="000000000000000";
		break;
			
	}
	gzLog.Write("电话号码+类型:"+dxNumber+"+"+numType+"\n"+"充值金额:"+amount+"||"+tranAmt);
	
	String sendContext = "biz_id,26|biz_step_id,1|TXNSRC,MB441|CDNO,"+cdno+"|CTSQ,"+dxNumber+"|DestAttr,"+numType  +  "|";
	
	
	
	gzLog.Write("ChongZhi_B.jsp the sendContext sent to server ==="+sendContext);
	
	//这里开始才会转到网关上啊
	MidServer midServer = new MidServer();
	BwResult bwResult = new BwResult();
	bwResult = midServer.sendMessage(sendContext);
	String info = "";
	info = bwResult.getContext();
	
	gzLog.Write("这是电信充值===ChongZhi_B1.jsp"+"\n服务器下行返回的报文内容："+info);
	
	String MGID = MessManTool.getValueByName(info, "MGID");	
	gzLog.Write("校验码MGID:  "+MGID);
	
	String display_zone = MessManTool.getValueByName(info, "display_zone");	
	gzLog.Write("返回信息:  "+display_zone);
	
	
	
%>


<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
<%
	//如果返回正确
	if("000000".equals(MGID)){
%>	
	    <form method='post' action='/GZMBank/ChongZhi/dianxin/ChongZhi_B2.jsp'>
			<label>充值号码：<%=dxNumber%></label>
			<br/>
		  <label>充值金额: <%=amount%>元</label>
			<br/>
			<label>交易密码</label>
			<br/>
			<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			<input type='hidden' name='dxNumber' value="<%=dxNumber%>"/>
			<input type='hidden' name='optType' value="<%=numType%>"/>
			<input type='hidden' name='tranAmt' value="<%=tranAmt%>"/>
			<br/>			
			<br/>
			<br/>
			<input type='submit' value=' 确定 '/>
			<br/>
			<label>请仔细核对充值手机号码的准确性,如因客户输入错误导致充值失败的,将不予退还充值金额.</label>
		</form>   
<%
	}else{
		String errorMsg="";
		String nubStat="";
		int k = 0;
		k=display_zone.indexOf("电信方");
		if(k!=0){
			nubStat=display_zone.substring(k, k+40).trim();
		}
	
	gzLog.Write("错误描述\n  "+nubStat);	
%>	
	

		<label>验证充值号码错误</label>
		<br/>
		<br/>
		<label>错误描述:</label>
		<br/>
		<label><%=nubStat%></label>
		<br/>
		<br/>
		<br/>
		<br/>
		<label>请您再次确认您输入的电话号码是否正确.</label>
		<br/>
		
<%
	}
%>			
	</content>
</res>