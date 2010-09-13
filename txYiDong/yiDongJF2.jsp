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
	String sessionId = null;
	Cookie ckies[] = request.getCookies();
	if(ckies != null){
		for(int i=0;i<ckies.length;i++){
			if(ckies[i].getName().equals("JSESSIONID")){
		    	sessionId = ckies[i].getValue();
		    	int idx = sessionId.indexOf(":");
		    	if(idx != -1){
		    		sessionId = sessionId.substring(0,idx);
		   		}
		    	break;
		    }
		}
	}
  	String fwhm = request.getHeader("fwhm");
  	java.security.Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	String fwhm1 = MBSecurityUtil.decryptData(cdno,sessionId,fwhm);
	fwhm = fwhm1.substring(0,6);
	

	String sjhm = MessManTool.changeChar(request.getParameter("sjhm"));//手机号
	String sendContext = "biz_id,7|biz_step_id,1|CDNO,"+cdno+"|PSWD,"+fwhm+"|CTSQ,"+sjhm+"|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	String message = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	//String message = "0394|bocom_mid|biz_id,21|biz_no,00021|biz_step_id,1|display_zone,预定内容： 广之旅调试线路20090510 test <br>服务商： 广之旅国内游总部  <br>总金额： 1.00  <br>已付金额： 0.00  <br>欠费金额： 1.00  <br>|MGID,000000|Reserve_Code,4538477|Product_Name,广之旅调试线路20090510 test|Provide_Name,广之旅国内游总部|Trans_Toal_Amount,00000000000100|Paid_Amount,00000000000000|Arrearage_Amount,00000000000100|";
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
	<form method='post' action='/GZMBank/txYiDong/yiDongJF3.jsp'> 
		<input type='hidden' name='sjhm' value="<%=sjhm%>"/>
		<input type='hidden' name='fwhm' value="<%=fwhm%>"/>
		<input type='hidden' name='AMT1' value="<%=AMT1%>"/>
		<input type='submit' value='下一步'/>
	</form>
<%	
}else{
	String temp = MessManTool.getValueByName(bwResult.getContext(), "display_zone");
%>
<%=temp%>
<%
}
%>
</content>
</res> 