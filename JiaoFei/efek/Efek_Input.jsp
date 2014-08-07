<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行卡号
	String sjNo = request.getHeader("MBK_MOBILE");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	gzLog.Write("进入["+uri+"]");

%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/Efek/JiaoFei/Efek_460410.jsp'>
			<lable>缴费卡号：</lable>
			<br/>
			<%=CrdNo%>
			<br/>
			<lable>缴费号：</lable>
			<br/>
			<input type='text' name='JFH' style="-wap-input-required:'true'" maxleng='20'/>
			<br/>
			<lable>电费年月</lable>
			<br/>
			<lable>输入格式为YYYYMM，如：201408 </lable>
			<br/>
			<input type='text' name='DFNY' style="-wap-input-required:'true'" maxleng='6'/>
			<br/>
			<lable>查询方式</lable>
			<br/>
			<select name='DFNY' >
				<option value='0'>所有</option>
				<option value='1'>单月欠费查询</option>
			</select>
			<br/>
			<input type='hidden' name='CrdNo' value="<%=CrdNo%>"/><br/>
			<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res> 