<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	String optType = MessManTool.changeChar(request.getParameter("optType"));  // 0 有线电视  1  珠江数码  2  珠江宽频
	gzLog.Write("有线电视交费====Step1"+"卡号："+cdno+"手机号："+sjNo+"\n交费查询1");
%>

<!-- 分行特色业务频道列表 -->
<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/JiaoFei/tv/tvBillPayment3.jsp'>
			
			<label>请选择查询类型: </label>
			
			<select name="checkType">
				<option value="0">有线电视月租查询(身份证)</option>
				<option value="1">有线电视月租查询(手册号码)</option>
			</select>
			<br/>
			
			<input type='submit' value='确定'/>
				
		</form>
	</content>
</res>
