<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	String optType = MessManTool.changeChar(request.getParameter("optType"));  // 0 签约  1  解约
	gzLog.Write("#####MobCharge1.jsp====Step1"+"cardNumber:"+cdno+"phoneNumber:"+sjNo+"\n");
%>


<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
	<%
    if(optType.equals("0")){
	%>  
	<form method='post' action='/GZMBank/yiDongCharge/yiDongCharge1_1.jsp'>
			<label>签约类型: </label>
			
			<select name="signType">
				<option value="1">主号签约</option>
				<option value="2">副号签约</option>
			</select>
			<br/>
			<input type='hidden' name='optType' value="<%=optType%>"/> 
			
			<br/>
			<input type='submit' value='确定'/>
				
	</form>
    <%
	  }else {
    %>
	<form method='post' action='/GZMBank/yiDongCharge/yiDongCharge2.jsp'>
	        <label>请输入签约主号码：</label>
			<br/>
			<input type='text' name='mainNo' style="-wap-input-required: 'true'" minleng='11' maxleng='11'/>
			<br/>
			<br/>
			
			<label>尊敬的客户，签约主号码与银行账户捆绑关系解除后，该主号码下绑定的所有副号码签约关系也同时解除。</label>
			<input type='hidden' name='optType' value="<%=optType%>"/> 
			
			<br/>
			<input type='submit' value='确定'/>
				
	</form> 
	   
   <%
	}
   %>
	   
	   
			
	</content>
</res>