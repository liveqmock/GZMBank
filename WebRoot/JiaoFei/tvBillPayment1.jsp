<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	gzLog.Write("有线电视交费====Step1"+"卡号："+cdno+"手机号："+sjNo+"\n交费查询1");
%>

<!-- 分行特色业务频道列表 -->
<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/JiaoFei/tv/tvBillPayment2.jsp'>
			
			<label>请选择缴费类型: </label>
			
			<select name="optType">
				<option value="0">有线电视缴费</option>
				<option value="1">珠江数码</option>
				<option value="2">珠江宽频</option>
			</select>
			<br/>
			
			<input type='submit' value='确定'/>
				
		</form>
	</content>
</res>
