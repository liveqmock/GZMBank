<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.sportticket.format.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票查询步骤2");
%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
<%
	String TLogNo = request.getParameter("TLogNo");

	String sendContext = "|biz_id,29|biz_step_id,1|TXNSRC,MB441|"
						+ "|TLogNo," + TLogNo
						+ "|";

	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	
	String message = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {
%> 
<%
		String TRspCd = MessManTool.getValueByName(message, "TRspCd");
 		String TrmCod = MessManTool.getValueByName(message, "TrmCod");
 		String SigDup = MessManTool.getValueByName(message, "SigDup");
 		String LotTyp = MessManTool.getValueByName(message, "LotTyp");
 		String TLogNo2 = MessManTool.getValueByName(message, "TLogNo");
 		String LotNum = MessManTool.getValueByName(message, "LotNum");
 		String NotNum = MessManTool.getValueByName(message, "NotNum");
 		String TxnAmt = MessManTool.getValueByName(message, "TxnAmt");
 %> 
		<label>购彩信息如下</label><br/>
		<table border="1">
			<!--tr>
				<td>
					状态:
				</td>
				<td>
					<%=TRspCd%>
				</td>
			</tr-->
			<tr>
				<td>
					期号:
				</td>
				<td>
					<%=TrmCod%>
				</td>
			</tr>
			<tr>
				<td>
					单复式类型:
				</td>
				<td>
					<%=new SigDupFormat().NtoC(SigDup)%>
				</td>
			</tr>
			<tr>
				<td>
					彩票类型:
				</td>
				<td>
					<%=new LotTypFormat().NtoC(LotTyp)%> 
				</td>
			</tr>
			<tr>
				<td>
					购彩流水号:
				</td>
				<td>
					<%=TLogNo2%>
				</td>
			</tr>
			<tr>
				<td>
					投注号码:
				</td>
				<td>
					<%=LotNumFormat.ReturnManyFormatedRecords(LotNum, LotTyp)%> 
				</td>
			</tr>
			<tr>
				<td>
					注数:
				</td>
				<td>
					<%=NotNum%> 
				</td>
			</tr>
			<tr>
				<td>
					金额:
				</td>
				<td>
					<%=MoneyUtils.FormatMoney(Double.parseDouble(TxnAmt.trim()) / 100, "###0.00")%> 
				</td>
			</tr>
		</table>
		<label>所有数据以广东省体育彩票发行中心数据为准</label>
<%
 	}else{
 		String RspCod = MessManTool.getValueByName(message, "RspCod");
 		String RspMsg = MessManTool.getValueByName(message, "RspMsg");
%>
		<label>错误码为:<%=RspCod%></label>
		<label>错误原因为:<%=RspMsg%></label>
<%
	}
%>
</content>
</res> 