<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
<%
	String ddh = request.getParameter("ddh");
	String sendContext = "|biz_id,21|biz_step_id,1|TXNSRC,MB441|Reserve_Code,"
			+ ddh + "|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	
	String message = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	//String message = "0394|bocom_mid|biz_id,21|biz_no,00021|biz_step_id,1|TXNSRC,MB441|display_zone,预定内容： 广之旅调试线路20090510 test <br>服务商： 广之旅国内游总部  <br>总金额： 1.00  <br>已付金额： 0.00  <br>欠费金额： 1.00  <br>|MGID,000000|Reserve_Code,4538477|Product_Name,广之旅调试线路20090510 test|Provide_Name,广之旅国内游总部|Trans_Toal_Amount,00000000000100|Paid_Amount,00000000000000|Arrearage_Amount,00000000000100|";
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {
%> 
<%
 	String Reserve_Code = MessManTool.getValueByName(message,
 				"Reserve_Code");
 		String Product_Name = MessManTool.getValueByName(message,
 				"Product_Name");
 		String Provide_Name = MessManTool.getValueByName(message,
 				"Provide_Name");
 		String Trans_Toal_Amount = MessManTool.getValueByName(message,
 				"Trans_Toal_Amount");
 		String Paid_Amount = MessManTool.getValueByName(message,
 				"Paid_Amount");
 		String Arrearage_Amount = MessManTool.getValueByName(message,
 				"Arrearage_Amount");
 %> 
	<form method='post' action='/GZMBank/yinLvTong/yinLvTongJF3.jsp'> 
		<input type='hidden' name='Reserve_Code' value="<%=Reserve_Code%>"/>
		<input type='hidden' name='Product_Name' value="<%=Product_Name%>"/>
		<input type='hidden' name='Provide_Name' value="<%=Provide_Name%>"/>
		<input type='hidden' name='Trans_Toal_Amount' value="<%=Trans_Toal_Amount%>"/>
		<input type='hidden' name='Paid_Amount' value="<%=Paid_Amount%>"/>
		<input type='hidden' name='Arrearage_Amount' value="<%=Arrearage_Amount%>"/>
	
					<label>定单号:<%=Reserve_Code%></label>
				
					<label>预定内容:<%=Product_Name%></label>
			
					<label>服务商:<%=Provide_Name%></label>
				
					<label>总金额:<%=MoneyUtils.FormatMoney(Double.parseDouble(Trans_Toal_Amount.trim()) / 100, "###0.00")%></label> 
				
					<label>已付金额:<%=MoneyUtils.FormatMoney(Double.parseDouble(Paid_Amount.trim()) / 100, "###0.00")%></label>
				
					<label>欠费金额:<%=MoneyUtils.FormatMoney(Double.parseDouble(Arrearage_Amount.trim()) / 100, "###0.00")%></label>
		<input type='submit' value='下一步' /> 
	</form> 
<%
 	}else if ("482199".equals(MGID)) {
%>
	<form method='post' action='/GZMBank/yinLvTong/yinLvTongJF1.jsp'> 
		<label>订单号已缴清!如有疑问或问题请咨询银旅通客户服务热线：4008-960-168!</label>
	</form> 
		<%
	} else {
%> 
	<form method='post' action='/GZMBank/yinLvTong/yinLvTongJF1.jsp'> 
		<label>定单查询失败!如有疑问，请及时与开户银行联系!</label> 
	</form> 
<%
	}
%>
</content>
</res> 