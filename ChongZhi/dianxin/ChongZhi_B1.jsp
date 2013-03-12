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
	
	
	
	gzLog.Write("电信充值业务第2个界面=====ChongZhi_B1.JSP：\n");
	
	String optAmount  = MessManTool.changeChar(request.getParameter("optAmount")); //充值金额 0--50yuan 1--100, 2--150, 3--200 4--500
	String dxNumber   = MessManTool.changeChar(request.getParameter("dxNumber"));//移动手机号码
	String optType    = MessManTool.changeChar(request.getParameter("optType"));  //手机号码
	
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
	gzLog.Write("电话号码:"+dxNumber+"\n"+"充值金额:"+amount+"||"+tranAmt);
	
	
%>


<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
	    <form method='post' action='/GZMBank/ChongZhi/dianxin/ChongZhi_B2.jsp'>
			<label>
				充值号码：<%=dxNumber%>
			</label>
			<br/>
		    <label>
				充值金额: <%=amount%> 元
			</label>
		   
			<br/>
			<br/>
			<label> 交易密码 </label>
			<br/>
			<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			
			<input type='hidden' name='dxNumber' value="<%=dxNumber%>"/>
			<input type='hidden' name='optType'  value="<%=optType%>"/>
			<input type='hidden' name='tranAmt'  value="<%=tranAmt%>"/>
			<br/>			
			<br/>
			<br/>
			<input type='submit' value=' 确定 '/>
		</form>    
	</content>
</res>