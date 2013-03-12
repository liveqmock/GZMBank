<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	
	
	
	gzLog.Write("移动充值业务第2个界面=====ChongZhi_A1.JSP：\n");
	
	String optAmount  = MessManTool.changeChar(request.getParameter("optAmount")); //充值金额 0--50yuan 1--100, 2--150, 3--200 4--500
	String ydNumber = MessManTool.changeChar(request.getParameter("ydNumber"));//移动手机号码
	
	
	int opt=Integer.parseInt(optAmount.trim());
	String amount="";
	String tranAmt="";
	String icsAmount="";//used for translate the amount number to ICS
	
	switch(opt){
	case 0:
		amount="50"; 
		tranAmt="000000000005000";
		break;
	case 1:
		amount="100";
		tranAmt="000000000010000";
		break;
	case 2:
		amount="150";
		tranAmt="000000000015000";
		break;
	case 3:
		amount="200";
		tranAmt="000000000020000";
		break;
	case 4:
		amount="500";
		tranAmt="000000000050000";
		break;
	default :
		amount="00"; 
		tranAmt="000000000000000";
		break;
			
	}
	gzLog.Write("电话号码:"+ydNumber+"\n"+"充值金额:"+amount+"||"+tranAmt);
	
	
	
	
	
	
	
	
	
	
	
	
%>


<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	

	    <form method='post' action='/GZMBank/ChongZhi/yidong/ChongZhi_A2.jsp'>
			<label>充值号码： <%=ydNumber%>	</label>
			<br/>
		    <label>充值金额:  <%=amount%> 元</label>
			<br/>
			<label>交易密码</label>
			<br/>
			<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			
			<input type='hidden' name='ydNumber' value="<%=ydNumber%>"/>
			<input type='hidden' name='tranAmt' value="<%=tranAmt%>"/>
			<br/>			
			<br/>
			<br/>
			<input type='submit' value='确定'/>
		</form> 
	</content>
</res>