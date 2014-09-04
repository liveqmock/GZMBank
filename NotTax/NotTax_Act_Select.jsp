<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
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
		<form method='post' action='/GZMBank/NotTax/NotTax_Act_Redirect.jsp'>

		<lable>请选择缴费类别：</lable>
		out.println("<input type='radio' name='AdnKnd' value='3' >交通罚款</input>");
		out.println("<input type='radio' name='AdnKnd' value='1' >普通收缴</input>");

		<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res> 