<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
%>
<%
    String feeType=MessManTool.changeChar(request.getParameter("feeType"));
    String busiType=MessManTool.changeChar(request.getParameter("busiType"));
	gzLog.Write("费用类型："+feeType+"业务类型"+busiType);
%>

<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>

<%

	String fwhm = "000" +  feeType + busiType ;//定义服务密码，由服务密码辨别费用类型
	

	String sjhm = MessManTool.changeChar(request.getParameter("sjhm"));//手机号
	String sendContext = "biz_id,8|biz_step_id,1|TXNSRC,MB441|CDNO,"+cdno+"|PSWD,"+fwhm+"|CTSQ,"+sjhm+"|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	String message = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	
	String AreBus = MessManTool.getValueByName(message, "passWord");
	String AMT1 = MessManTool.getValueByName(message, "AMT1");
	String MGID = MessManTool.getValueByName(message, "MGID");
	gzLog.Write("MGID:"+MGID);
	if ("000000".equals(MGID))
	{
		String display_zone = MessManTool.getValueByName(message, "display_zone");
		String tmp3[] = display_zone.split("<br>");
		for(int i=0;i<tmp3.length;i++)
		{
			String tmp5=tmp3[i].trim();
		%>
			<label><%=tmp5%></label>
			<br/>
		<%
		}
		%>	
		<form method='post' action='/GZMBank/JiaoFei/txLTong/LTongJF3.jsp'> 
		<%
		if (feeType.equals("1"))
		{
         %>
       
			
				<label> 请选择充值金额 </label>
				<input type='radio' name='fee_AMT1' value='000000000005000' /> 
				<label> 50 元</label>
			
				<input type='radio' name='fee_AMT1' value='000000000010000' /> 
				<label> 100 元</label>
			
				<input type='radio' name='fee_AMT1' value='000000000015000' /> 
				<label> 150 元</label>
			
				<input type='radio' name='fee_AMT1' value='000000000020000' /> 
				<label> 200 元</label>
		
		<label>
			请输入交易密码:
		</label>
		<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
		<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
		<!-- 更改加密方式此段程序封闭20110419
		<input type='hidden' name='MBK_SECURITY_PASSWORD'  value='password'></input>
		-->
		<input type='hidden'  name='MBK_VERIFY' value='true'></input>
		<input type='hidden' name='sjhm' value='<%=sjhm%>'/>
		<input type='hidden' name='fwhm' value='<%=fwhm%>"/>
		<input type='hidden' name='feeType' value='<%=feeType%>'/>
		<input type='hidden' name='busiType' value='<%=busiType%>'/>
		<input type='hidden' name='AMT1' value='<%=AMT1%>'/>
		<input type='hidden' name='AreBus' value='<%=AreBus%>'/>
		<input type='submit' value='下一步'/>
       
   </form>
	<%		
     } 
     }
     else 
     	{
     %>
	       <label>手机余额查询异常</label>
	      
	 <%
	 }
     %>


 
</content>
</res> 