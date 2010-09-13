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
	String sendContext = "biz_id,8|biz_step_id,1|TXNSRC,MB441,CDNO,"+cdno+"|PSWD,"+fwhm+"|CTSQ,"+sjhm+"|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	String message = bwResult.getContext();
	//String message = "biz_id,8|biz_no,00008|biz_step_id,1|display_zone,电话号码： 14529011618                     <br>客户姓名： 郑##源                                                        <br>话费余额： 40.00  <br>温馨提示： 请仔细核对您的缴费号码，以免缴错后无法退款！ <br>|MGID,000000|AMT1,000000000004000|CTSQ,14529011618|passWord,A 14529011618         |";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	
	String AreBus = MessManTool.getValueByName(message, "passWord");
	String AMT1 = MessManTool.getValueByName(message, "AMT1");
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)){
		String display_zone = MessManTool.getValueByName(message, "display_zone");
		String tmp3[] = display_zone.split("<br>");
		for(int i=0;i<tmp3.length;i++){
			String tmp5=tmp3[i].trim();
		%>
			<label><%=tmp5%></label>
			<br/>
		<%
		}
		%>	
		<form method='post' action='/GZMBank/txLTong/LTongJF3.jsp'> 
		<%
		if (feeType.equals("1"))
		{
         %>
        <table border="1">
			<tr>
				<td> 选择 </td>
				<td> 充值金额</td>
			</tr>
			<tr>
				<td> <input type='radio' name='fee_AMT1' value='000000000005000' checked /> </td>
				<td> 50 元</td>
			</tr>
			<tr>
				<td> <input type='radio' name='fee_AMT1' value='000000000010000' /> </td>
				<td> 100 元</td>
			</tr>
			<tr>
				<td> <input type='radio' name='fee_AMT1' value='000000000015000' /> </td>
				<td> 150 元</td>
			</tr>
			<tr>
				<td> <input type='radio' name='fee_AMT1' value='000000000020000' /> </td>
				<td> 200 元</td>
			</tr>
		</table>
       <%
        }
       %>
		<label>
			请输入交易密码:
		</label>
		<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
		<input type='hidden' name='MBK_SECURITY_PASSWORD'  value='password'></input>
		<!-- 
		<input type='hidden'  name='MBK_VERIFY' value=' true'></input>
		-->
		<input type='hidden' name='sjhm' value="<%=sjhm%>"/>
		<input type='hidden' name='fwhm' value="<%=fwhm%>"/>
		<input type='hidden' name='feeType' value="<%=feeType%>"/>
		<input type='hidden' name='busiType' value="<%=busiType%>"/>
		<input type='hidden' name='AMT1' value="<%=AMT1%>"/>
		<input type='hidden' name='AreBus' value="<%=AreBus%>"/>
		<input type='submit' value='下一步'/>
        </form>

	<%		
     } else {
     %>
	       <label>手机余额查询异常</label>
	       </br>
	 <%
	 }
     %>



</content>
</res> 