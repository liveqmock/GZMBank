<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	gzLog.Write("电卡缴费====Step1"+"卡号："+cdno+"手机号："+sjNo+"\n电费查询1");
%>

<!-- 分行特色业务频道列表 -->
<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/ElectronicBill/BillPayment2.jsp'>
		 
			<lable>缴费卡号：</lable>  
			<br/>
			<%=cdno%>
			<br/>
			
			<lable>客户编号</lable>
			<br/>
			
			<input type='text' name='TCusId' style="-wap-input-required:'true'" maxleng='21'/>
			<br/>
			<label>（请仔细核对客户编号的准确性，因客户编号信息录入错误导致缴费失败的，将不予退还缴费金额）</label>
			<br/>
			<br/>
			<lable>电费月份</lable>
			<br/>
			<lable>输入格式： </lable>
			<br/>
			<lable>1: 如果想查询特定年月的电费，请输入六位号码，前4位为年份，后2位为月份，如：201202</lable>
			<br/>
			<lable>2: 如果想查询所有电费账单，请输入9</lable>
			<input type='text' name='LChkTm' style="-wap-input-format:'N'; -wap-input-required:'true'" maxleng='8'/>
			<br/>
			
			<input type='submit' value='查询'/>		
				
		</form>
	</content>
</res>
