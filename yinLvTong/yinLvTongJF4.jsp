<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<?xml version="1.0" encoding="utf-8"?> 
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
	//BEGIN 密码解密
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
  	String pwd = request.getHeader("password");
  	java.security.Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	String plantPwd = MBSecurityUtil.decryptData(cdno,sessionId,pwd);
	plantPwd = plantPwd.substring(0,6);
	//END 密码解密
	
	String MBK_ACCOUNT=request.getHeader("MBK_ACCOUNT");
	String Reserve_Code = request.getParameter("Reserve_Code");
	String Product_Name = MessManTool.changeChar(request.getParameter("Product_Name"));
	String Provide_Name = MessManTool.changeChar(request.getParameter("Provide_Name"));
	String Trans_Toal_Amount = request.getParameter("Trans_Toal_Amount");
	//String Paid_Amount = request.getParameter("Paid_Amount");
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
	//BEGIN 身份认证
	String verify = request.getHeader("MBK_VERIFY_RESULT");
//	if(verify!=null&&verify.equals("P")){
	   //通过身份认证，向后台发送交易
	   bwResult = midServer.sendMessage(sendContext);
	   message = bwResult.getContext();
	   gzLog.Write("            接收报文为："+message);
//  }else if(verify.equals("F")){
//		message = "|MGID,000333|display_zone,身份验证不通过|";
//	}else if(verify.equals("N")){
//	    message = "|MGID,000444|display_zone,身份未验证|";
//	}else {
//	    message = "|MGID,000555|display_zone,身份验证系统出错|";
//	}
	//END 身份认证
	//MidServer midServer = new MidServer();
	//BwResult bwResult = midServer.sendMessage(sendContext);
	//String message = bwResult.getContext();
	//System.out.println("message:"+message);
	
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {
	String tmp9 = message.substring(message.indexOf("会计流水："),message.length());
	tmp9 = tmp9.substring(5,tmp9.indexOf("<br>"));
	tmp9 = tmp9.trim();
%>
	<label>
		交费成功! 请及时查询结果
	</label>
	<br/>
	<form method='post' action='/GZMBank/yinLvTong/yinLvTongJF3.jsp'> 
		<table border="1">
			<tr>
				<td>
					定单号:
				</td>
				<td>
					<%=Reserve_Code%>
				</td>
			</tr>
			<tr>
				<td>
					银行流水号:
				</td>
				<td>
					<%=tmp9 %> 
				</td>
			</tr>
			<tr>
				<td>
					预定内容:
				</td>
				<td>
					<%=Product_Name%>
				</td>
			</tr>
			<tr>
				<td>
					服务商:
				</td>
				<td>
					<%=Provide_Name%>
				</td>
			</tr>
			<tr>
				<td>
					缴费金额:
				</td>
				<td>
					<%=MoneyUtils.FormatMoney(Double.parseDouble(Arrearage_Amount.trim()) / 100, "###0.00")%> 
				</td>
			</tr>
		</table>
	</form> 
<%
	} else {
%> 
		<%=MessManTool.getValueByName(message, "display_zone")%>
<%
	}
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n银旅通缴费结束");
%>
</content>
</res> 