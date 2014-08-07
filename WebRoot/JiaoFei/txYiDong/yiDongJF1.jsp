<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n移动缴费查询");
%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/txYiDong/yiDongJF2.jsp'>
		<label>请输入手机号码（仅限全球通）: </label>
		<br/>
		<input type='text' name='sjhm' style="-wap-input-format: 'phone'; -wap-input-required: 'true'" minleng='11' maxleng='11'/>
		<label>请输入服务密码: </label>
		<br/>
		<br/>
		<br/>
		<label>该业务目前仅限广州市区号码缴费，如有不便敬请谅解。</label>
		<br/>
		<br/>
		<br/>
		<input type='password' name='fwhm' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
		<input type='hidden' name='MBK_SECURITY_PASSWORD'  value='fwhm'></input>
		<input type='submit' value='下一步'/>
		</form>
	</content>
</res>