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
  String YwLei = MessManTool.changeChar(request.getParameter("YwLei"));
	String displayTime = "";
	String lChkTm = MessManTool.changeChar(request.getParameter("LChkTm"));  //前台用户输入的日期
	String TxnAmt = MessManTool.changeChar(request.getParameter("TxnAmt"));
	String mess ="ActNo,"+cdno+"|TCusId," + tCusId + "|LChkTm," + lChkTm + "|YwLei,"+YwLei+"|TxnAmt,"+TxnAmt+"|";
	gzLog.Write("联通缴费====Step2"+"银行卡号"+cdno+"手机号码"+sjNo+"业务类型"+YwLei+"tCusId电话号码"+tCusId+"账单年月"+lChkTm);
%>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
	<% 		
		//拼装上传报文
		String sendContext = "biz_id,35|biz_step_id,1|TXNSRC,MB441|CDNO,"+cdno+"|YwLei,"+YwLei+"|TelNum,"+tCusId+"|"+"ZdanNy,"+lChkTm+"|";
		
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
		String strTxnAmt = MessManTool.getValueByName(message, "MonSum");//金额
		String FfNo = MessManTool.getValueByName(message, "FfNo");//
		gzLog.Write("FfNo:"+FfNo);
		//用来将数字格式化
		String displayTxnAmt = TxnAmtFormat.format(strTxnAmt);
	
	%>
	
		<form method='post' action='/GZMBank/LtJiaofei/LtJiaofei3.jsp'>		
		
			<input type='hidden' name='reponseMessage' value="<%=message%>"/> <!-- 查询返回的信息 -->
			<input type='hidden' name='ActNo' value="<%=cdno%>"/>
			<input type='hidden' name='TCusId' value="<%=tCusId%>"/>
			<input type='hidden' name='FfNo' value="<%=FfNo%>"/>
			<input type='hidden' name='LChkTm' value="<%=lChkTm%>"/>
　　　<input type='hidden' name='YwLei' value="<%=YwLei%>"/>　
      <input type='hidden' name='TxnAmt' value="<%=strTxnAmt%>"/>　
		
			<label>请确认您将要缴的账单信息：</label> 
		  <label>电话号码:<%=tCusId%></label>                
		  <label>账单年月:<%=lChkTm%></label>
		  <label>应缴金额:<%=displayTxnAmt%></label>
		 <label>请输入你的银行卡交易密码:</label>
　　 <input type='password' name='password' isRandomPass='true' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
		 <input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
     <input type='hidden' name='MBK_VERIFY' value='true'/>
		<label>温馨提示：请仔细核对输入信息的准确性，因客户信息录入错误导致缴费失败的，将不予退还缴费金额!</label>	
			<input type='submit' value='确定' />			
		</form>
		
	<%	
    }else{
	     String errorReport = MessManTool.getValueByName(message, "RspMsg");
	     gzLog.Write("错误信息是："+errorReport );
    %>
    <label>查询错误，错误信息为： <%=errorReport%></label>   
    <%
         }
    %>
	</content>
</res>
