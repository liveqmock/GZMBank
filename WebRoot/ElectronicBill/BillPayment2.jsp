<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.TxnAmtFormat"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	String tCusId = MessManTool.changeChar(request.getParameter("TCusId"));  
	String displayTime = "";
	String lChkTm = MessManTool.changeChar(request.getParameter("LChkTm"));  //前台用户输入的日期
	
	if(lChkTm == "" ||lChkTm == "9"||lChkTm.length()!=6){
		lChkTm = "99999999";   /*标示所有月份的查询*/
		displayTime = "所有欠费月份";
	}
	
	if(lChkTm.length() == 6){
		displayTime = lChkTm.substring(0,4)+"年"+(("0".equals(lChkTm.substring(4, 5)))?lChkTm.substring(5, 6):lChkTm.substring(4, 6))+"月";
		lChkTm = lChkTm + "99";
	}
	
	gzLog.Write("电力缴费====Step2"+"银行卡号"+cdno+"手机号码"+sjNo+"tCusId客户编号"+tCusId+"电费查询日期LChktm"+lChkTm);
%>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
	<% 		
		//拼装上传报文
		String sendContext = "biz_id,31|biz_step_id,1|TXNSRC,MB441|CDNO,"+cdno+"|TCusId,"+tCusId+"|LChkTm,"+lChkTm+"|";
		
		gzLog.Write("银行卡号"+cdno+"手机号码"+sjNo+"\n接收报文MESSAGE为："+sendContext);  //log
		
		MidServer midServer = new MidServer();
		
		//获取返回的报文
		BwResult bwResult = midServer.sendMessage(sendContext);
		String message = bwResult.getContext();
		gzLog.Write("银行卡号: "+cdno+"手机号码: "+sjNo+"\n接收报文MESSAGE为：" +message);
		
		String MGID = MessManTool.getValueByName(message, "MGID");
		//当返回成功
		if("000000".equals(MGID)){
	%>
	<%		
		String strTxnAmt = MessManTool.getValueByName(message, "TxnAmt");//金额
		String ChkTim = MessManTool.getValueByName(message, "ChkTim");//交易日期时间
		String DptTyp = MessManTool.getValueByName(message, "DptTyp");//配营部类型
		String UsrNam = MessManTool.getValueByName(message, "UsrNam");//用户姓名
		String UsrAdd = MessManTool.getValueByName(message, "UsrAdd");//用电地址	
		
		//用来将数字格式化
		String displayTxnAmt = TxnAmtFormat.format(strTxnAmt);
		
		String display_zone = MessManTool.getValueByName(message, "display_zone");//用电地址	
	%>
	
		<form method='post' action='/GZMBank/ElectronicBill/BillPayment3.jsp'>		
		
			<input type='hidden' name='reponseMessage' value="<%=message%>"/> <!-- 查询返回的信息 -->
			<input type='hidden' name='ActNo' value="<%=cdno%>"/>
			<input type='hidden' name='TCusId' value="<%=tCusId%>"/>
			<input type='hidden' name='LChkTm' value="<%=lChkTm%>"/>
			
		          <label>客户编号:<%=tCusId%></label>
		        	<label>缴费月份:<%=displayTime%></label>
		        	<label>应缴金额:<%=displayTxnAmt%></label>
		          <label>用户姓名:<%=UsrNam%></label>
		        	<label>用电地址:<%=UsrAdd%></label>
		       
			
			<input type='submit' value='下一步' />			
		</form>
		
	<%	
    }else{
	     String errorReport = MessManTool.getValueByName(message, "RspMsg");
	     gzLog.Write("错误信息是："+errorReport );
    %>
		<form method='post' action='/GZMBank/ElectronicBill/BillPayment1.jsp'>		
	    <label>查询错误，错误信息为： <%=errorReport%></label>   
		</form>
    <%
         }
    %>
	</content>
</res>
