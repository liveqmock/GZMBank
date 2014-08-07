<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("############ChongZhi_check.jsp：\n");
	String TelNum = request.getParameter("TelNum");//联通手机号码
	
	int ydNumberLength = 0;
	ydNumberLength=TelNum.length();
	gzLog.Write("############ChongZhi_check.jsp：\n ##########LENGTH="+TelNum.length());	
%>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
	<%	
			
		//如果返回正确
		if(ydNumberLength!=11){

		gzLog.Write("############ChongZhi_check.jsp：\n ##########LENGTH="+TelNum.length());			
		
	%>
			<label>
			  输入数据有误：
			</label>
		    <br/>
			<label>
			  您输入的号码位数有错,请返回并重新输入.
			</label>
		    <br/>
			
		
	<%
		} else {
		gzLog.Write("############ChongZhi_check.jsp：\n ######要跳转咯=");	
		  
	%>  
	
			<jsp:forward page="ChongZhi_liantong_TxnAmt.jsp">
			</jsp:forward>
			
	<%
		}
	%>
	</content>
</res>