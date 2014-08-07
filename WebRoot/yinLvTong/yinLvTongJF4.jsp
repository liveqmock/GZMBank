<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n银旅通缴费开始");
%>
<res> 
	<content>
		<div id="ewp_back" class="clear"/>
<%
	
	String plantPwd = request.getHeader("password");
	
	String MBK_ACCOUNT=request.getHeader("MBK_ACCOUNT");
	String Reserve_Code = request.getParameter("Reserve_Code");
	String Product_Name = MessManTool.changeChar(request.getParameter("Product_Name"));
	String Provide_Name = MessManTool.changeChar(request.getParameter("Provide_Name"));
	String Trans_Toal_Amount = request.getParameter("Trans_Toal_Amount");

	String Arrearage_Amount = request.getParameter("Arrearage_Amount");
	String sendContext = "|biz_id,21|biz_step_id,2|CDNO,"+MBK_ACCOUNT+
	"|PSWD,"+plantPwd+
	"|Trans_Toal_Amount,"+Trans_Toal_Amount+
	"|Reserve_Code,"+Reserve_Code+
	"|Product_Name,"+Product_Name+
	"|Provide_Name,"+Provide_Name+"|TXNSRC,MB441|";
	String sendContext1 = "|biz_id,21|biz_step_id,2|CDNO,"+MBK_ACCOUNT+
	"|PSWD,******"+
	"|Trans_Toal_Amount,"+Trans_Toal_Amount+
	"|Reserve_Code,"+Reserve_Code+
	"|Product_Name,"+Product_Name+
	"|Provide_Name,"+Provide_Name+"|TXNSRC,MB441|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext1);
	MidServer midServer = new MidServer();
	BwResult bwResult = new BwResult();
	String message = "";	
	
	String verify = request.getHeader("MBK_VERIFY_RESULT");
	if(verify!=null&&verify.equals("P")){
	   
	   bwResult = midServer.sendMessage(sendContext);
	   message = bwResult.getContext();
	   gzLog.Write("            接收报文为："+message);
  }else if(verify.equals("F")){
		message = "|MGID,000333|display_zone,身份验证不通过|";
	}else if(verify.equals("N")){
	    message = "|MGID,000444|display_zone,身份未验证|";
	}else {
	    message = "|MGID,000555|display_zone,身份验证系统出错|";
	}
	
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {
	String tmp9 = message.substring(message.indexOf("会计流水："),message.length());
	tmp9 = tmp9.substring(5,tmp9.indexOf("<br>"));
	tmp9 = tmp9.trim();
%>
	
	
	<form method='post' action='/GZMBank/yinLvTong/yinLvTongJF1.jsp'> 
		
				<label>交费成功! 请及时查询结果</label>
					<label>定单号:<%=Reserve_Code%></label>
			
					<label>银行流水号:<%=tmp9 %></label> 
				
					<label>预定内容:<%=Product_Name%></label>
			
					<label>服务商:<%=Provide_Name%></label>
			
					<label>缴费金额:<%=MoneyUtils.FormatMoney(Double.parseDouble(Arrearage_Amount.trim()) / 100, "###0.00")%></label> 
				
	</form> 
<%
	} else {
 		String temp = MessManTool.getValueByName(message, "display_zone");
		
		String tmp3[] = temp.split("<br>");
		String rspStr = "";
		for(int i=0;i<tmp3.length;i++){
			rspStr =tmp3[i].trim();
	%>
 	<form method='post' action='/GZMBank/yinLvTong/yinLvTongMPYD1.jsp'>
		<label><%=rspStr%></label>
	</form> 
 <%
    }

	}
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n银旅通缴费结束");
%>
</content>
</res> 