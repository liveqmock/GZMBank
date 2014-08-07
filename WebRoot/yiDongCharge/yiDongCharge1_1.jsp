<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	String optType = MessManTool.changeChar(request.getParameter("optType"));
	String signType = MessManTool.changeChar(request.getParameter("signType")); //1 主号签约  2  副号签约
	gzLog.Write("#####MobCharge1.jsp====Step1"+"cardNumber:"+cdno+"phoneNumber:"+sjNo+"\n");
%>


<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/yiDongCharge/yiDongCharge2.jsp'>
		
		<%
		   if(signType.equals("1")){
		%>  
		 
			
			
			<label>请输入主手机号：</label>
			<br/>
			<input type='text' name='mainNo' style="-wap-input-required: 'true'" minleng='11' maxleng='11'/>
			<br/>
			
			
	   <%
          }else {
       %>
	        <label>请输入主手机号：</label>
			<br/>
			<input type='text' name='mainNo' style="-wap-input-required: 'true'" minleng='11' maxleng='11'/>
			<br/>
			
			<label>请输入签约副号码：</label>
			<br/>
			<input type='text' name='signNo' style="-wap-input-required: 'true'" minleng='11' maxleng='11'/>
			<br/>
			
			
			
	   
	   
	   <%
	    }
	   %>
	   
	   
			<input type='hidden' name='optType' value="<%=optType%>"/> 
			<input type='hidden' name='signType' value="<%=signType%>"/> 
			
			<br/>
			<input type='submit' value='确定'/>
				
		</form>
	</content>
</res>