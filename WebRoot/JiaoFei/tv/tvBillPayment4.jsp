<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	String optType = MessManTool.changeChar(request.getParameter("optType"));
	String checkType = MessManTool.changeChar(request.getParameter("checkType"));
	String tCusId = MessManTool.changeChar(request.getParameter("TCusId"));  
	String cusNo = MessManTool.changeChar(request.getParameter("CusNo"));  //身份证号 或 用户手册号
	
	if(optType == "0"){
		RsFld2 = "0114";   /*有线电视*/
	}else if(optType == "1"){
		RsFld2 = "0100";   /*珠江数码*/
	}else{
		RsFld2 = "0112";   /*珠江宽频*/
	}
	
	gzLog.Write("有线电视====Step2"+"银行卡号"+cdno+"手机号码"+sjNo+"tCusId客户编号"+tCusId);
%>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
	<% 		
		//拼装上传报文
		String sendContext = "biz_id,31|biz_step_id,1|RsFld1,P001|RsFld2,|TCusID,"+tCusId+"|ActNo,"+cdno+"|IdTyp,|CusNo,"+cusNo+"|";
		
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
	  String TCusID = MessManTool.getValueByName(message, "TCusID");//代理代码
		String TCusNm = MessManTool.getValueByName(message, "TCusNm");//客户名称
		String FildCnt = MessManTool.getValueByName(message, "FildCnt");//添加域个数
		String Address = MessManTool.getValueByName(message, "Address");//附加域1,地址
		String CarNum = MessManTool.getValueByName(message, "CarNum");//附加域2,卡号个数		
		String TmpNam = MessManTool.getValueByName(message, "TmpNam");//单笔长度
		String IdCod = MessManTool.getValueByName(message, "IdCod");//附加域3,卡号(付费号码)
		String MacNo = MessManTool.getValueByName(message, "MacNo");//附加域4,设备号
		String CusNm = MessManTool.getValueByName(message, "CusNm");//附加域5,用户名
		String PayAmt = MessManTool.getValueByName(message, "PayAmt");//附加域6,应收金额
		String LefAmt = MessManTool.getValueByName(message, "LefAmt");//附加域7,剩余预存
		String TmpNam = MessManTool.getValueByName(message, "TmpNam");		
		
		//用来将数字格式化
		String displayTxnAmt = TxnAmtFormat.format(PayAmt);
		String displayTxnAmt1 = TxnAmtFormat.format(LefAmt);
	%>
	
		<form method='post' action='/GZMBank/JiaoFei/tv/tvBillPayment5.jsp'>		
		
			<input type='hidden' name='reponseMessage' value="<%=message%>"/> <!-- 查询返回的信息 -->
			<input type='hidden' name='ActNo' value="<%=cdno%>"/>
			<input type='hidden' name='TCusId' value="<%=tCusId%>"/>
			<input type='hidden' name='CusNo' value="<%=cusNo%>"/>
			
			<table border = '1'>
		        <tr>
		        	<td>付费号码</td>
		        	<td><%=IdCod%></td>
		        </tr>
		        <tr>
		        	<td>设备号</td>
		        	<td><%=MacNo%></td>
		        </tr>
		         <tr>
		        	<td>用户名</td>
		        	<td><%=CusNm%></td>
		        </tr>
		        <tr>
		        	<td>地址</td>
		        	<td><%=Address%></td>
		        </tr>
		        <tr>
		        	<td>应收金额</td>
		        	<td><%=displayTxnAmt%></td>
		        </tr>
		        <tr>
		        	<td>预存金额</td>
		        	<td><%=displayTxnAmt1%></td>
		        </tr>
			</table>
			<br/>
			
			<input type='submit' value='下一步' />			
		</form>
		
	<%	
    }else{
	     String errorReport = MessManTool.getValueByName(message, "RspMsg");
	     System.out.println("错误信息是："+errorReport );
    %>
    <lable>查询错误，错误信息为：</lable>
    <br/>
         <%=errorReport%>
    <%
         }
    %>
	</content>
</res>
