<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<div id="ewp_back" class="clear"/>
<%
	String sjhm = MessManTool.changeChar(request.getParameter("sjhm"));//手机号
	String fwhm = MessManTool.changeChar(request.getParameter("fwhm"));//服务号 
	String AMT1 = MessManTool.changeChar(request.getParameter("AMT1"));//金 额
%> 
	<form method='post' action='/GZMBank/txYiDong/yiDongJF4.jsp'> 
		<input type='hidden' name='sjhm' value="<%=sjhm%>"/>
		<input type='hidden' name='fwhm' value="<%=fwhm%>"/>
		<input type='hidden' name='AMT1' value="<%=AMT1%>"/>
		<label>
			请输入交易密码:
		</label>
		<br/>
		<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
		<input type='hidden' name='MBK_SECURITY_PASSWORD'  value='password'></input>
		<input type='hidden'  name='MBK_VERIFY' value=' true'></input>		
		<input type='submit' value='确定' /> 
	</form> 
</content>
</res> 