<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.TxnAmtFormat"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行卡号
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	String reportMessage = MessManTool.changeChar(request.getParameter("reponseMessage"));  //需要串来串去的信息
	
	String actNo = MessManTool.changeChar(request.getParameter("ActNo"));
	String tCusId = MessManTool.changeChar(request.getParameter("TCusId"));
	String lChkTm = MessManTool.changeChar(request.getParameter("LChkTm"));
	
	String mess = reportMessage + "ActNo,"+actNo+"|TCusId," + tCusId + "|LChkTm," + lChkTm + "|";	
	gzLog.Write("这是电力缴费的STPE3"+mess);
%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<%			
			String strTxnAmt = MessManTool.getValueByName(reportMessage, "TxnAmt");//金额
			String displayTxnAmt = TxnAmtFormat.format(strTxnAmt);
			
			gzLog.Write("这是电力缴费的STPE3" + "=======即将缴纳的金额是" + strTxnAmt);
		%>
		<form method='post' action='/GZMBank/ElectronicBill/BillPayment4.jsp'>
			<label>
				您现在的欠费金额是：
			</label>
			<br/>
			<%=displayTxnAmt%>
			<br/>
			<label>
				请输入你的银行卡密码:
			</label>
		<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
		<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
		
		<!-- test
		<input type='hidden'  name='MBK_VERIFY' value='true'></input>
		-->
		<input type='hidden' name='MESS' value="<%=mess%>"></input>
		
		<input type='submit' value='下一步'></input> 
		</form>
</content>
</res> 