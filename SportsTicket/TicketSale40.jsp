<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤3");

	String TikMod = request.getParameter("TikMod");
	String SigDup = request.getParameter("SigDup");
	String NotNum = request.getParameter("NotNum");
	String LotNum = request.getParameter("LotNum");
	String LotTyp = "26";
	String MulTip = request.getParameter("MulTip");
	String ExtNum = request.getParameter("ExtNum");

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
<%
	String sendContext = "|biz_id,29|biz_step_id,2"
						+ "|TikMod," + TikMod 
						+ "|SigDup," + SigDup 
						+ "|NotNum," + NotNum 
						+ "|LotNum," + LotNum 
						+ "|LotTyp," + LotTyp 
						+ "|MulTip," + MulTip 
						+ "|ExtNum," + ExtNum 
						+ "|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext);

	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	
	String message = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	//成功报文
	//message = "0394|bocom_mid|biz_id,21|biz_no,00021|biz_step_id,1|display_zone,预定内容： 广之旅调试线路20090510 test <br>服务商： 广之旅国内游总部  <br>总金额： 1.00  <br>已付金额： 0.00  <br>欠费金额： 1.00  <br>|MGID,000000|Reserve_Code,4538477|Product_Name,广之旅调试线路20090510 test|Provide_Name,广之旅国内游总部|Trans_Toal_Amount,00000000000100|Paid_Amount,00000000000000|Arrearage_Amount,00000000000100|";
	//失败报文
	//message = "0189|bocom_mid|biz_id,21|biz_no,00021|biz_step_id,1|display_zone,<font color=ff0000><b>--->订单号已缴清！<br>--->如有疑问或问题请咨询银旅通客户服务热线：4008-960-168</b></font><br>|MGID,482199|";
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {
%> 
<%
 	  String TRspCd = MessManTool.getValueByName(message, "TRspCd");
 		NotNum = MessManTool.getValueByName(message, "NotNum");
 		LotNum = MessManTool.getValueByName(message, "LotNum");
 		String TxnAmt = MessManTool.getValueByName(message, "TxnAmt");
 		MulTip = MessManTool.getValueByName(message, "MulTip");
 		String TrmCod = MessManTool.getValueByName(message, "TrmCod");
 %> 
		<table border="1">
			<tr>
				<td>
					状态:
				</td>
				<td>
					<%=TRspCd%>
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
					6个投注号码:
				</td>
				<td>
					<%=LotNum%>
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
			<tr>
				<td>
					倍数:
				</td>
				<td>
					<%=MulTip%>
				</td>
			</tr>
			<tr>
				<td>
					期号:
				</td>
				<td>
					<%=TrmCod%> 
				</td>
			</tr>
		</table>

    <form method='post' action='/GZMBank/SportsTicket/TicketSale50.jsp'>

		<label>卡号:</label><br/>
		<input type='text' name='CrdNo' value='<%=cdno%>' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>交易金额:</label><br/>
		<input type='text' name='TxnAmt' value='<%=TxnAmt%>' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>期号:</label><br/>
		<input type='text' name='TrmCod' value='<%=TrmCod%>' style="-wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>购票方式:</label><br/>
		<input type='text' name='TikMod' value='<%=TikMod%>' style="-wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>彩票类型:</label><br/>
		<input type='text' name='LotTyp' value='<%=LotTyp%>' style="-wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>单复式区分:</label><br/>
		<input type='text' name='SigDup' value='<%=SigDup%>' style="-wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>注数:</label><br/>
		<input type='text' name='NotNum' value='<%=NotNum%>' style="-wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>倍数:</label><br/>
		<input type='text' name='MulTip' value='<%=MulTip%>' style="-wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>扩展号码:</label><br/>
		<input type='text' name='ExtNum' value='<%=ExtNum%>' style="-wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>投注号码:</label><br/>
		<input type='text' name='LotNum' value='<%=LotNum%>' style="-wap-input-required: 'true'"  maxleng='20'/><br/>

		<label>手机号码:</label><br/>
		<input type='text' name='CntTel' value='<%=sjNo%>' style="-wap-input-required: 'true'"  maxleng='20'/><br/>

		<input type='submit' value='下一步'/>
    </form>

<%
 	}else{
%> 
		查询失败！ 
		<br/> 
		如有疑问，请及时与开户银行联系！ 
<%
	}
%>

	</content>
</res>