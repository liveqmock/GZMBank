<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	gzLog.Write("#####MobCharge0.jsp====Step1"+"cardNumber:"+cdno+"phoneNumber:"+sjNo+"\n");
%>

<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/yiDongCharge/yiDongCharge1.jsp'>
		 
			<label> 请选择业务种类: </label>
			
			<select name="optType">
				<option value="0"> 移动划扣业务签约</option>
				<option value="1"> 移动划扣签约解除</option>
			</select>
			<br/>
			<br/>
			
		  <label> 业务介绍: </label>
			<br/>
			<label> 移动全品牌签约：广东移动客户可通过该业务将银行卡与手机号捆绑，捆绑成功后，系统默认绑定手机话费余额低于10元时，系统将自动从绑定银行账户内划扣50元充值至您的手机号内。</label>
			<br/>
			<label> 注意事项：</label>
			<br/>
			<label> 1.客户在进行签约时，首先绑定主号号码，其次在绑定副号号码，一个主号号码下可同时绑定5个副号号码。</label>
			<br/>
			<label> 2.如客户需要提高划扣伐值，可通过广东移动网站进行修改。</label>
			<br/>
			<input type='submit' value='确定'/>
				
		</form>
	</content>
</res>