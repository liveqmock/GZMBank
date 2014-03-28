<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n银旅通订票开始");
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
	
 	String sightContext = MessManTool.changeChar(request
 			.getParameter("sightContext"));
 	String tmp8[] = sightContext.split("\\|");
 	String zsStr = tmp8[10];
 	int zs = Integer.parseInt(zsStr);
 	double dzyhj = Double.parseDouble(tmp8[5]);
 	double zjr = zs * dzyhj;
 	String syrq = tmp8[13];
 	String jsrq = tmp8[7];
 	String yxrq = tmp8[8];

	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	Date syrqD = new Date();
	if(syrq!=null&&syrq.length()==8){
 		syrqD = sdf.parse(syrq);
 	}
 	Date jsrqD = new Date();
	if(jsrq!=null&&jsrq.length()==8){
 		jsrqD = sdf.parse(jsrq);
 	}
 	
 	long tmp6 = jsrqD.getTime()-syrqD.getTime();
 	long tmp7=tmp6/60;
 	tmp7=tmp7/60;
 	tmp7=tmp7/24;
 	tmp7=tmp7/1000;
 	tmp7+=1;
 	
 	int tmp5=Integer.parseInt(yxrq);
	
	int tmp9=0;
	if(tmp7<tmp5){
		tmp9=(int)tmp7;
	}else{
		tmp9=tmp5;
	}
 	
 	
	String temp2=tmp8[9].substring(0,(tmp8[9].length()-6));
	
 	String zjrStr = MoneyUtils.FormatMoney(zjr, "###0.00");//总金额
 	
 	String ksrq=tmp8[13].substring(0,4)+"-"+tmp8[13].substring(4,6)+"-"+tmp8[13].substring(6,8);
 	String content = "biz_id,21|biz_step_id,5" + "|Product_Code,"
 			+ tmp8[2] + //门票代码
 			"|Retail_Price1," + tmp8[4] + //门市价
 			"|E_Discount_Price1," + tmp8[5] + //电子优惠价
 			"|Reserve_Amoun," + tmp8[10] + //购买张数
 			"|Mobile_Phone_Number," + tmp8[12] + //手机号
 			"|Begin_Date," + ksrq + //门票日期
 			"|Message_Type," + tmp8[11] + //手机类型
 			"|Amount1," + zjrStr + //总金额
 			"|CDNO," + cdno + //卡号
 			"|PSWD," + plantPwd + //交易密码
 			"|Scence_Code," + tmp8[0] + //景区代码
 			"|Scence_Name," + tmp8[1] + //景区名称
 			"|Product_Name," + tmp8[3] + //门票名称
 			"|Remark1," + temp2 + //备注
 			"|Valid_Days," + tmp9 + "|TXNSRC,MB441|";//有效日期
 	String content1 = "biz_id,21|biz_step_id,5" + "|Product_Code,"
 			+ tmp8[2] + //门票代码
 			"|Retail_Price1," + tmp8[4] + //门市价
 			"|E_Discount_Price1," + tmp8[5] + //电子优惠价
 			"|Reserve_Amoun," + tmp8[10] + //购买张数
 			"|Mobile_Phone_Number," + tmp8[12] + //手机号
 			"|Begin_Date," + ksrq + //门票日期
 			"|Message_Type," + tmp8[11] + //手机类型
 			"|Amount1," + zjrStr + //总金额
 			"|CDNO," + cdno + //卡号
 			"|PSWD,******" + //交易密码
 			"|Scence_Code," + tmp8[0] + //景区代码
 			"|Scence_Name," + tmp8[1] + //景区名称
 			"|Product_Name," + tmp8[3] + //门票名称
 			"|Remark1," + temp2 + //备注
 			"|Valid_Days," + tmp9 + "|TXNSRC,MB441|";//有效日期
 	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+content1);
 	MidServer midServer = new MidServer();
 	BwResult bwResult=new BwResult();
 	String tmp ="";
 	//BEGIN 身份认证
	String verify = request.getHeader("MBK_VERIFY_RESULT");
	if(verify!=null&&verify.equals("P")){
	    //通过身份认证，向后台发送交易
 		bwResult = midServer.sendMessage(content);
 		     tmp = bwResult.getContext();
 		     gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+tmp);
    }else if(verify.equals("F")){
		tmp = "|MGID,000333|display_zone,身份验证不通过|";
	}else if(verify.equals("N")){
	    tmp = "|MGID,000444|display_zone,身份未验证|";
	}else {
	    tmp = "|MGID,000555|display_zone,身份验证系统出错|";
	}
	//END 身份认证
 	String MGID = MessManTool.getValueByName(tmp, "MGID");
 	if ("000000".equals(MGID)) {
 %> 
 
 	<form method='post' action='/GZMBank/yinLvTong/yinLvTongMPYD1.jsp'>
	    <label> 电子门票订购成功 </label>
			<label>景区各称: <%=tmp8[1]%></label> 
		
			<label>门票名称:<%=tmp8[3]%> </label> 
	 
			<label>定单号:  <%=MessManTool.getValueByName(tmp, "TCUSNM")%> </label> 
		
			<label> 会计流水号: <%=MessManTool.getValueByName(tmp, "TckNo")%></label>
		 
			<label> 客户手机号码:  <%=tmp8[12]%> </label> 
		
			<label>电子优惠价格: <%=tmp8[5]%> </label>
		
			<label> 门票数量:  <%=tmp8[10]%></label> 
		 
			<label> 本次支付金额:  <%=zjrStr%> </label>
		
			<label>使用日期:<%=tmp8[13]%></label>
		
			<label>门票有效天数: <%=tmp9 %> </label> 
		
			<label>备注:<%=temp2%></label> 
		
	 <label>温馨提示：请在使用日期之后的有效天数内使用，以免过期！在景区售票处出示购票银行卡或收到手机二维码短信取票，银旅通客户服务热线4008-960-168!</label>
	 <input type="submit" value="确定" /> 
	</form> 
	<%
 	} else {
 		String temp = MessManTool.getValueByName(tmp, "display_zone");
		
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
 	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n订票结束");
 %>
</content>
</res>