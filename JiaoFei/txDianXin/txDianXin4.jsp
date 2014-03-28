<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n电信缴费开始");
%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<div id="ewp_back" class="clear"/>
<%
	//BEGIN 密码解密
	//更改加密方式此段程序封闭20110419
	//String sessionId = null;
	//Cookie ckies[] = request.getCookies();
	//if(ckies != null){
	//	for(int i=0;i<ckies.length;i++){
	//		if(ckies[i].getName().equals("JSESSIONID")){
	//	    	sessionId = ckies[i].getValue();
	//	    	int idx = sessionId.indexOf(":");
	//	    	if(idx != -1){
	//	    		sessionId = sessionId.substring(0,idx);
	//	   		}
	//	    	break;
	//	    }
	//	}
	//}
  //	String pwd = request.getHeader("password");
  //	java.security.Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	//String plantPwd = MBSecurityUtil.decryptData(cdno,sessionId,pwd);
	//plantPwd = plantPwd.substring(0,6);
	//END 密码解密
	String plantPwd = request.getHeader("password");
	
	String PhoneNum = MessManTool.changeChar(request.getParameter("PhoneNum"));//服务号码
	PhoneNum=PhoneNum.trim();
	String BusTyp = MessManTool.changeChar(request.getParameter("BusTyp"));//业务种类
	String CusNm = MessManTool.changeChar(request.getParameter("CusNm"));  //姓名
	String AMT1 = MessManTool.changeChar(request.getParameter("AMT1"));//金 额
	
	if (BusTyp.equals("CDMAprepay") ||  BusTyp.equals("XLTpay")) {
	  String PayTyp = MessManTool.changeChar(request.getParameter("PayTyp"));//预充金额
	  if (PayTyp.equals("pay50")) {
	    AMT1 = "000000000005000";
	  } else if (PayTyp.equals("pay100")) {
	    AMT1 = "000000000010000";
	  } if (PayTyp.equals("pay150")) {
	    AMT1 = "000000000015000";
	  } else if (PayTyp.equals("pay200")) {
	    AMT1 = "000000000020000";
	  }  
	}
	
	String biz_id = "0";
	if (BusTyp.equals("Phonepay")){
	  biz_id = "1";
	} else if (BusTyp.equals("XLTpay")) {
	  biz_id = "2";
	} else if (BusTyp.equals("CDMApay")) {
	  biz_id = "22";
	} else if (BusTyp.equals("CDMAprepay")) {
	  biz_id = "23";
	}
    String sendContext = "biz_id,"+biz_id+"|biz_step_id,2|TXNSRC,MB441|CDNO,"+cdno+"|PSWD,"+plantPwd+"|AMT1,"+AMT1+"|CTSQ,"+PhoneNum+"|CusNm,"+CusNm+"|";
	//gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext1);
	MidServer midServer = new MidServer();
	BwResult bwResult = new BwResult();
	String message = "";	
	//BEGIN 身份认证
	String verify = request.getHeader("MBK_VERIFY_RESULT");
	//gzLog.Write("验证结果标志："+ verify +"\n");
	if(verify!=null&&verify.equals("P")){
	   //通过身份认证，向后台发送交易
	   bwResult = midServer.sendMessage(sendContext);
	   message = bwResult.getContext();
	   gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	}else if(verify.equals("F")){
		message = "|MGID,000333|display_zone,身份验证不通过|";
	}else if(verify.equals("N")){
	    message = "|MGID,000444|display_zone,身份未验证|";
	}else {
	    message = "|MGID,000555|display_zone,身份验证系统出错|";
	}
	//END 身份认证
	
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {
%>
	<form method='post' action='/GZMBank/JiaoFei/txDianXin/txDianXin4.jsp'> 
	<label>
		交费成功! 请及时查询结果。
	</label>
	<br/>
	<%
		String display_zone = MessManTool.getValueByName(message, "display_zone");
		String tmp3[] = display_zone.split("<br>");
		for(int i=0;i<tmp3.length;i++){
			String tmp5=tmp3[i].trim();
	 gzLog.Write(tmp5);
	%>
		<label><%=tmp5%></label>
			<br/>
		<%
		}
	%>
	</form> 
<%
	} else {
%> 
	<form method='post' action='/GZMBank/JiaoFei/txDianXin/txDianXin4.jsp'> 
		<label>
		<%=MessManTool.getValueByName(message, "display_zone")%>
		</label>
	</form> 
<%
	gzLog.Write("display_zone"+MessManTool.getValueByName(message, "display_zone"));
	}
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n电信缴费结束");
%>
</content>
</res> 