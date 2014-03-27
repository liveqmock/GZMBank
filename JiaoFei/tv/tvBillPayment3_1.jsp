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
		String IdNum = MessManTool.getValueByName(message, "IdNum");//附加域1,用户手册号个数
		String IdCod = MessManTool.getValueByName(message, "IdCod");//附加域2,用户手册号
		String Address = MessManTool.getValueByName(message, "Address");//附加域3,地址
		String TmpNam = MessManTool.getValueByName(message, "TmpNam");
		
	%>
	
		<form method='post' action='/GZMBank/JiaoFei/tv/tvBillPayment4.jsp'>		
		
		  <label>请选择地址: </label>
			
			<select name="optAddr">
				<option value="0">地址1</option>
				<option value="1">地址2</option>
				<option value="2">地址3</option>
			</select>
			<br/>
			
			<input type='submit' value='确定'/>
		  
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
