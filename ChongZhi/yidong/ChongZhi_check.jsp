<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	gzLog.Write("############ChongZhi_check.jsp：\n");
	String ydNumber = MessManTool.changeChar(request.getParameter("ydNumber"));//移动手机号码
	String optAmount = MessManTool.changeChar(request.getParameter("optAmount"));//移动手机号码
	int ydNumberLength = 0;
	ydNumberLength=ydNumber.length();
	gzLog.Write("############ChongZhi_check.jsp：\n ##########LENGTH="+ydNumber.length());	
%>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
	<%	
			
		//如果返回正确
		if(ydNumberLength!=11){

		gzLog.Write("############ChongZhi_check.jsp：\n ##########LENGTH="+ydNumber.length());			
		
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
	
			<jsp:forward page="ChongZhi_A1.jsp">
				<jsp:param name="ydNumber" value="<%=ydNumber%>"/>
				<jsp:param name="optAmount" value="<%=optAmount%>"/>
			</jsp:forward>
			
	<%
		}
	%>
	</content>
</res>