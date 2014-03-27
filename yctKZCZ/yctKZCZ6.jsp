<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>

<%
   //System.out.println("羊城通自动充值yctKZCZ6.....");
   GzLog gzLog = new GzLog("c:/gzLog_sj");
   String strCDNO = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
   String strMBNO = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
   gzLog.Write("羊城通自动充值yctKZCZ6.....\n");
   gzLog.Write("卡号："+strCDNO+"手机号："+strMBNO+"\n"); 
 
   String sParam3  = MessManTool.changeChar(request.getParameter("param2"));
   String sInfo[] = sParam3.split("#:>");
%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
<%

 	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
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
	
	  String    sMobile     = request.getHeader("MBK_MOBILE");
	//[|bocom_mid|biz_id,25|biz_step_id,2|TXNSRC,MB441|sign_flag,0|inst_no,交通银行|live_flag,1|tran_flag,1|bank_acc,6222600710004835700|paper_no,1440103198503131815|cust_name,张嘉骏|sex_code,0|phone_no,|mobile_no,13632256848|post_no,|address,|email,|card1,0257407740|PSWD,509429|card2,|card3,|card4,|limite,000000005000|frequence,D001|
      String    sendContext = "biz_id,25|i_biz_step_id,2|TXNSRC,MB441|sign_flag,4|inst_no,交通银行|live_flag,1|tran_flag,1|bank_acc,"+ cdno.trim() + "|paper_no,"+sInfo[4].trim()+sInfo[1].trim() + "|cust_name,"+sInfo[0].trim()+"|sex_code,"+sInfo[2].trim()+"|phone_no,|mobile_no,"+sMobile+"|post_no,|address,|email,|card1,"+sInfo[3].trim()+"|PSWD,"+plantPwd+"|card2,|card3,|card4,|limite,000000005000|frequence,D001|";
      gzLog.Write("发送报文["+sendContext+"]");
      MidServer midServer   = new MidServer();
      //482138羊城通自动充值签约
      BwResult  bwResult    = midServer.sendMessage(sendContext);
      String    recvContext = bwResult.getContext();
      gzLog.Write("接收报文["+recvContext+"]");
      String    sMGID       = MessManTool.getValueByName(recvContext, "MGID");
      
      if ("000000".equals(sMGID)){
%>
         <div id="ewp_back" class="refresh"/>
         <label>签约成功</label>
         <label>首次使用可于一年内至市内各地铁入口处通过羊城通自动充值终端进行激活，并进行各种设置，完成后即可轻松充值。</label>
         <label>羊城通客服电话：96900</label>
<%
      } 
      else {
          String    sCodeMsg   = MessManTool.getValueByName(recvContext, "PB_Return_Code_Msg");
%>
          <div id="ewp_back" class="refresh"/>
          <label>签约失败</label>
          
             <label>错误代码:<%=sMGID%></label>
             <label>错误信息:<%=sCodeMsg%></label>
         
<%
      }
%>

	</content>
</res>