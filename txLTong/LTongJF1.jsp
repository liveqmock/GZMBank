<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n联通缴费查询");
%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/txLTong/LTongJF2.jsp'>
		
		
		
		<label>联通手机号码: </label>
		<br/>
		<input type='text' name='sjhm' style="-wap-input-required: 'true'" minleng='8' maxleng='11'/>
		<br/>
		
		
		
		<label>费用类型: </label>
		
      
		<select name="feeType">
		  <option value="1">预付费</option>
		  <option value="0">欠缴费</option>
		</select>
		<br/>
		
		<label>业务类型: </label>
		
		<select name="busiType">
		  <option value="01">GSM(130/131)</option>
		  <option value="03">长途固话</option>
		</select>

		<br/>
		
		
		<input type='submit' value='提交'/>
		</form>
	</content>
</res>